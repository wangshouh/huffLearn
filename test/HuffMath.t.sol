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

    function test_popCount() public {
        uint256 maxResult = huffmath.popCount(type(uint256).max);
        assertEq(maxResult, 256);
        uint256 minResult = huffmath.popCount(1);
        assertEq(minResult, 1);
        uint256 normalResult = huffmath.popCount(42);
        assertEq(normalResult, 3);
    }

    function test_nlzCount() public {
        uint256 maxResult = huffmath.nlzCount(type(uint256).max);
        assertEq(maxResult, 0);
        uint256 normalResult = huffmath.nlzCount(0x18160ddd);
        assertEq(normalResult, 227);
    }

    function test_ilog2() public {
        uint256 maxResult = huffmath.ilog2(type(uint256).max);
        assertEq(maxResult, 255);
        uint256 normalResult = huffmath.ilog2(0x18160ddd);
        assertEq(normalResult, 28);
        uint256 halfResult = huffmath.ilog2(0x10000000000000000);
        assertEq(halfResult, 64);
    }
}

interface HuffMath {
    function addNumbers(uint256, uint256) external pure returns (uint256);
    function safeAdd(uint256, uint256) external pure returns (uint256);
    function safeMulti(uint256, uint256) external pure returns (uint256);
    function popCount(uint256) external pure returns (uint256);
    function nlzCount(uint256) external pure returns (uint256);
    function ilog2(uint256) external pure returns (uint256);
}