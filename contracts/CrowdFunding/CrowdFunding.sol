// SPDX-License-Identifier: MIT
pragma solidity ^0.8.29;

import "../IUtilityContract.sol";
import "../LiniarVesting/Vesting.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/proxy/Clones.sol";

contract CrowdFunding is IUtilityContract, Ownable {
    enum State { Active, Successful, Failed }

    address public fundraiser;
    uint256 public goal;
    uint256 public deadline;
    uint256 public totalRaised;
    uint256 public vestingDuration;
    uint256 public vestingCliff;
    address public vestingContract;
    bool private initialized;
    State public state;

    mapping(address => uint256) public contributions;

    event ContributionReceived(address contributor, uint256 amount);
    event FundingSuccessful(uint256 totalRaised, address vestingContract);
    event FundingFailed(uint256 totalRaised);
    event RefundIssued(address contributor, uint256 amount);

    modifier notInitialized() {
        require(!initialized, "Already initialized");
        _;
    }

    constructor() Ownable(msg.sender) {}

    function initialize(bytes memory _initData) external notInitialized returns(bool) {
        (
            address _fundraiser,
            uint256 _goal,
            uint256 _deadline,
            uint256 _vestingDuration,
            uint256 _vestingCliff
        ) = abi.decode(_initData, (address, uint256, uint256, uint256, uint256));

        require(_fundraiser != address(0), "Invalid fundraiser address");
        require(_goal > 0, "Goal must be greater than 0");
        require(_deadline > block.timestamp, "Deadline must be in the future");
        require(_vestingDuration > 0, "Vesting duration must be greater than 0");
        require(_vestingCliff < _vestingDuration, "Cliff cannot be longer than duration");

        fundraiser = _fundraiser;
        goal = _goal;
        deadline = _deadline;
        vestingDuration = _vestingDuration;
        vestingCliff = _vestingCliff;
        state = State.Active;
        Ownable.transferOwnership(_fundraiser);
        
        initialized = true;
        return true;
    }

    function getInitData(
        address _fundraiser,
        uint256 _goal,
        uint256 _deadline,
        uint256 _vestingDuration,
        uint256 _vestingCliff
    ) external pure returns(bytes memory) {
        return abi.encode(_fundraiser, _goal, _deadline, _vestingDuration, _vestingCliff);
    }

    function contribute() public payable {
        require(state == State.Active, "Fundraising not active");
        require(block.timestamp < deadline, "Deadline has passed");
        require(msg.value > 0, "Contribution must be greater than 0");

        contributions[msg.sender] += msg.value;
        totalRaised += msg.value;

        emit ContributionReceived(msg.sender, msg.value);

        if (totalRaised >= goal) {
            _finalizeSuccessful();
        }
    }

    function refund() external {
        require(state == State.Active, "Cannot refund after fundraising is complete");
        require(contributions[msg.sender] > 0, "No contribution found");

        uint256 amount = contributions[msg.sender];
        contributions[msg.sender] = 0;
        totalRaised -= amount;

        (bool success, ) = payable(msg.sender).call{value: amount}("");
        require(success, "Refund failed");

        emit RefundIssued(msg.sender, amount);

        // Если после возврата totalRaised < goal, можно перевести в Failed
        if (totalRaised < goal && block.timestamp >= deadline) {
            state = State.Failed;
            emit FundingFailed(totalRaised);
        }
    }

    function checkStatus() external {
        if (state == State.Active && block.timestamp >= deadline) {
            if (totalRaised >= goal) {
                _finalizeSuccessful();
            } else {
                state = State.Failed;
                emit FundingFailed(totalRaised);
            }
        }
    }

    receive() external payable {
        if (state == State.Active && block.timestamp < deadline) {
            contribute();
        } else {
            revert("Fundraising not active");
        }
    }

    function _finalizeSuccessful() internal {
        state = State.Successful;

        address vestingImplementation = address(new Vesting());
        address vestingClone = Clones.clone(vestingImplementation);
        
        require(
            IUtilityContract(vestingClone).initialize(abi.encode(address(0), fundraiser)),
            "Vesting initialization failed"
        );
        
        vestingContract = vestingClone;
        
        (bool success, ) = payable(vestingContract).call{value: totalRaised}("");
        require(success, "Transfer to vesting contract failed");

        Vesting(vestingContract).startVesting(
            fundraiser,
            totalRaised,
            block.timestamp,
            vestingCliff,
            vestingDuration,
            1 days,
            0
        );

        emit FundingSuccessful(totalRaised, vestingContract);
    }
}