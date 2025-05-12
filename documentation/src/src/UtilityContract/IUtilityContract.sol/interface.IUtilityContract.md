# IUtilityContract
[Git Source](https://github.com/SolidityUniversity/smart-deployer/blob/c317992a2ee80ce05c7c36182238c87b8702d943/src/UtilityContract/IUtilityContract.sol)

**Inherits:**
IERC165

**Author:**
Solidity University

This interface defines the functions and events for utility contracts.

*Utility contracts should implement this interface to be compatible with the DeployManager.*


## Functions
### initialize

Initializes the utility contract with the provided data

*This function should be called by the DeployManager after deploying the contract*


```solidity
function initialize(bytes memory _initData) external returns (bool);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_initData`|`bytes`|The initialization data for the utility contract|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`bool`|True if the initialization was successful|


### getDeployManager


```solidity
function getDeployManager() external view returns (address);
```

## Errors
### DeployManagerCannotBeZero
*Reverts if the deploy manager is not set or is invalid*


```solidity
error DeployManagerCannotBeZero();
```

### NotDeployManager

```solidity
error NotDeployManager();
```

### FailedToDeployManager

```solidity
error FailedToDeployManager();
```

### AlreadyInitialized

```solidity
error AlreadyInitialized();
```

