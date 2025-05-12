# VestingLib
[Git Source](https://github.com/SolidityUniversity/smart-deployer/blob/c317992a2ee80ce05c7c36182238c87b8702d943/src/Vesting/VestingLib.sol)

Provides utility functions for calculating vested and claimable token amounts


## Functions
### vestedAmount

Calculates the total amount of tokens vested for a given vesting schedule at the current time


```solidity
function vestedAmount(IVesting.VestingInfo storage v) internal view returns (uint256);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`v`|`IVesting.VestingInfo`|The vesting information struct|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`uint256`|The total amount of tokens vested|


### claimableAmount

Calculates the amount of tokens currently claimable by the beneficiary


```solidity
function claimableAmount(IVesting.VestingInfo storage v) internal view returns (uint256);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`v`|`IVesting.VestingInfo`|The vesting information struct|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`uint256`|The amount of tokens that can be claimed|


