# AbstractUtilityContract
[Git Source](https://github.com/SolidityUniversity/smart-deployer/blob/85c11aeeaafc38269bb5a66ecafac729e84c7b17/src/UtilityContract/AbstractUtilityContract.sol)

**Inherits:**
[IUtilityContract](/src/UtilityContract/IUtilityContract.sol/interface.IUtilityContract.md), ERC165

**Author:**
Solidity University

This abstract contract provides a base implementation for utility contracts.

*Utility contracts should inherit from this contract and implement the initialize function.*


## State Variables
### initialized

```solidity
bool public initialized;
```


### deployManager

```solidity
address public deployManager;
```


## Functions
### notInitialized


```solidity
modifier notInitialized();
```

### initialize


```solidity
function initialize(bytes memory _initData) external virtual override returns (bool);
```

### setDeployManager


```solidity
function setDeployManager(address _deployManager) internal virtual;
```

### validateDeployManager


```solidity
function validateDeployManager(address _deployManager) internal view returns (bool);
```

### getDeployManager


```solidity
function getDeployManager() external view virtual override returns (address);
```

### supportsInterface


```solidity
function supportsInterface(bytes4 interfaceId) public view virtual override(IERC165, ERC165) returns (bool);
```

