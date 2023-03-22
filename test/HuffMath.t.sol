// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";

contract mathTest is Test {
	HuffMath public huffmath;

    function setUp() public {
        huffmath = HuffMath(HuffDeployer.deploy("HuffMath"));
    }

    function test_add() public {
    	uint256 result = huffmath.addNumbers(1, 2);
    	assertEq(result, 3);
    }

    function test_safeAdd() public {
    	vm.expectRevert();
    	huffmath.safeAdd(type(uint256).max, 5);
    }

    function test_noramlsafeAdd() public {
        uint256 result = huffmath.safeAdd(420, 5);
        assertEq(result, 425);
    }

    function test_normalMulti() public {
        uint256 result = huffmath.safeMulti(100, 5);
        assertEq(result, 500);
    }

    function test_safeMulti() public {
        vm.expectRevert();
        huffmath.safeMulti(type(uint256).max, 50);
    }

    function test_zeroMulti() public {
        uint256 result = huffmath.safeMulti(100, 0);
        assertEq(result, 0);
    }
}

interface HuffMath {
    function addNumbers(uint256, uint256) external pure returns (uint256);
    function safeAdd(uint256, uint256) external pure returns (uint256);
    function safeMulti(uint256, uint256) external pure returns (uint256);
}