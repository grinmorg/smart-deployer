# VestingLib
[Git Source](https://github.com/SolidityUniversity/smart-deployer/blob/c9dd3d1ffa736a4cdb7d35a22dc0947979fde8ba/src/Vesting/VestingLib.sol)

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


