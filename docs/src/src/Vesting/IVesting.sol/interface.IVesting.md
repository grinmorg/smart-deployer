# IVesting
[Git Source](https://github.com/SolidityUniversity/smart-deployer/blob/85c11aeeaafc38269bb5a66ecafac729e84c7b17/src/Vesting/IVesting.sol)

Provides a standard interface for token vesting contracts


## Functions
### claim

Claims all tokens currently available for the caller according to their vesting schedule


```solidity
function claim() external;
```

### startVesting

Creates a new vesting schedule for a beneficiary


```solidity
function startVesting(VestingParams calldata params) external;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`params`|`VestingParams`|Struct containing the parameters for the new vesting schedule|


### vestedAmount

Returns the total amount of tokens vested for a beneficiary at the current time


```solidity
function vestedAmount(address _claimer) external view returns (uint256);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_claimer`|`address`|Address of the beneficiary|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`uint256`|Amount of tokens vested|


### claimableAmount

Returns the amount of tokens that can currently be claimed by a beneficiary


```solidity
function claimableAmount(address _claimer) external view returns (uint256);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_claimer`|`address`|Address of the beneficiary|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`uint256`|Amount of tokens claimable|


### withdrawUnallocated

Withdraws all unallocated tokens from the contract to the specified address


```solidity
function withdrawUnallocated(address _to) external;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_to`|`address`|Address to receive the withdrawn tokens|


### getVestingInfo

Returns the information about a vesting schedule for a beneficiary


```solidity
function getVestingInfo(address _claimer) external view returns (VestingInfo memory);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_claimer`|`address`|Address of the beneficiary|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`VestingInfo`|VestingInfo struct containing the vesting information|


### getInitData

Returns the ABI-encoded initialization data for the contract


```solidity
function getInitData(address _deployManager, address _token, address _owner) external view returns (bytes memory);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_deployManager`|`address`|Address of the deploy manager|
|`_token`|`address`|Address of the ERC20 token|
|`_owner`|`address`|Address of the contract owner|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`bytes`|ABI-encoded initialization data|


## Events
### VestingCreated
Emitted when a new vesting schedule is created


```solidity
event VestingCreated(address indexed beneficiary, uint256 amount, uint256 creationTime);
```

**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`beneficiary`|`address`|Address of the beneficiary|
|`amount`|`uint256`|Total number of tokens to be vested|
|`creationTime`|`uint256`|Timestamp when the vesting schedule was created|

### TokensWithdrawn
Emitted when tokens are withdrawn from the contract


```solidity
event TokensWithdrawn(address indexed to, uint256 amount);
```

**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`to`|`address`|Address receiving the withdrawn tokens|
|`amount`|`uint256`|Number of tokens withdrawn|

### Claim
Emitted when a beneficiary claims vested tokens


```solidity
event Claim(address indexed beneficiary, uint256 amount, uint256 timestamp);
```

**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`beneficiary`|`address`|Address of the beneficiary|
|`amount`|`uint256`|Number of tokens claimed|
|`timestamp`|`uint256`|Timestamp when the claim was made|

## Errors
### VestingNotFound
Reverts if the vesting schedule does not exist for the beneficiary


```solidity
error VestingNotFound();
```

### ClaimNotAvailable
Reverts if the claim is not yet available


```solidity
error ClaimNotAvailable(uint256 blockTimestamp, uint256 availableFrom);
```

**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`blockTimestamp`|`uint256`|Current block timestamp|
|`availableFrom`|`uint256`|Timestamp when the claim becomes available|

### NothingToClaim
Reverts if there are no tokens available to claim


```solidity
error NothingToClaim();
```

### InfsufficientBalance
Reverts if the contract does not have enough tokens to allocate


```solidity
error InfsufficientBalance(uint256 availableBalance, uint256 totalAmount);
```

**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`availableBalance`|`uint256`|Number of tokens currently available in the contract|
|`totalAmount`|`uint256`|Number of tokens required for vesting|

### VestingAlreadyExist
Reverts if a vesting schedule already exists for the beneficiary


```solidity
error VestingAlreadyExist();
```

### AmountCantBeZero
Reverts if the specified amount is zero


```solidity
error AmountCantBeZero();
```

### StartTimeShouldBeFuture
Reverts if the vesting start time is not in the future


```solidity
error StartTimeShouldBeFuture(uint256 startTime, uint256 blockTimestamp);
```

**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`startTime`|`uint256`|The specified start time|
|`blockTimestamp`|`uint256`|The current block timestamp|

### DurationCantBeZero
Reverts if the vesting duration is zero


```solidity
error DurationCantBeZero();
```

### CooldownCantBeLongerThanDuration
Reverts if the claim cooldown period is longer than the vesting duration


```solidity
error CooldownCantBeLongerThanDuration();
```

### InvalidBeneficiary
Reverts if the beneficiary address is invalid


```solidity
error InvalidBeneficiary();
```

### BelowMinimalClaimAmount
Reverts if the claimable amount is less than the minimum claim amount


```solidity
error BelowMinimalClaimAmount(uint256 minClaimAmount, uint256 claimable);
```

**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`minClaimAmount`|`uint256`|The minimum claimable amount|
|`claimable`|`uint256`|The actual claimable amount|

### CooldownNotPassed
Reverts if the required cooldown period between claims has not passed


```solidity
error CooldownNotPassed(uint256 blockTimestamp, uint256 lastClaimTime);
```

**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`blockTimestamp`|`uint256`|The current block timestamp|
|`lastClaimTime`|`uint256`|The timestamp of the last claim|

### NothingToWithdraw
Reverts if there are no tokens available to withdraw


```solidity
error NothingToWithdraw();
```

## Structs
### VestingInfo
Information about a beneficiary's vesting schedule


```solidity
struct VestingInfo {
    uint256 totalAmount;
    uint256 startTime;
    uint256 cliff;
    uint256 duration;
    uint256 claimed;
    uint256 lastClaimTime;
    uint256 claimCooldown;
    uint256 minClaimAmount;
    bool created;
}
```

**Properties**

|Name|Type|Description|
|----|----|-----------|
|`totalAmount`|`uint256`|Total number of tokens to be vested|
|`startTime`|`uint256`|Timestamp when vesting begins|
|`cliff`|`uint256`|Duration of the cliff period in seconds|
|`duration`|`uint256`|Total duration of the vesting period in seconds|
|`claimed`|`uint256`|Amount of tokens already claimed|
|`lastClaimTime`|`uint256`|Timestamp of the last claim|
|`claimCooldown`|`uint256`|Minimum time interval between claims in seconds|
|`minClaimAmount`|`uint256`|Minimum amount that can be claimed in a single transaction|
|`created`|`bool`|Indicates whether the vesting schedule has been created|

### VestingParams
Parameters for creating a new vesting schedule in startVesting function


```solidity
struct VestingParams {
    address beneficiary;
    uint256 totalAmount;
    uint256 startTime;
    uint256 cliff;
    uint256 duration;
    uint256 claimCooldown;
    uint256 minClaimAmount;
}
```

**Properties**

|Name|Type|Description|
|----|----|-----------|
|`beneficiary`|`address`|Address that will receive vested tokens|
|`totalAmount`|`uint256`|Total number of tokens to be vested|
|`startTime`|`uint256`|Timestamp when vesting begins|
|`cliff`|`uint256`|Duration of the cliff period in seconds|
|`duration`|`uint256`|Total duration of the vesting period in seconds|
|`claimCooldown`|`uint256`|Minimum time interval between claims in seconds|
|`minClaimAmount`|`uint256`|Minimum amount that can be claimed in a single transaction|

