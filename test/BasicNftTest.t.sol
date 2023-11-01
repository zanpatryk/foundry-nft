//SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";
import {DeployBasicNft} from "../script/Deploy.s.sol";
import {BasicNFT} from "../src/BasicNFT.sol";

contract BasicNftTest is Test {
    string constant NFT_NAME = "Dog";
    string constant NFT_SYMBOL = "PUPPY";

    DeployBasicNft public deployer;
    BasicNFT public basicNFT;
    address public USER = makeAddr("user");
    string public constant PUG_URI =
        "ipfs://bafybeig371o1r76s7mgSoobetncojcm3c3hxasyd4rv id4j qhy4gkaheg4/?filename=0-PUG. json";

    function setUp() public {
        deployer = new DeployBasicNft();
        basicNFT = deployer.run();
    }

    function testNameIsCorrect() public view {
        assert(
            keccak256(abi.encodePacked(basicNFT.name())) ==
                keccak256(abi.encodePacked((NFT_NAME)))
        );
        assert(
            keccak256(abi.encodePacked(basicNFT.symbol())) ==
                keccak256(abi.encodePacked((NFT_SYMBOL)))
        );
    }

    function testCanMintAndHaveBalance() public {
        vm.prank(USER);
        basicNFT.mintNft(PUG_URI);

        assert(basicNFT.balanceOf(USER) == 1);
        assert(
            keccak256(abi.encodePacked(PUG_URI)) ==
                keccak256(abi.encodePacked(basicNFT.tokenURI(0)))
        );
    }
}
