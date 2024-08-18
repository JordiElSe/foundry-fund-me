// SPDX-License_identifier: MIT

pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {FundMe} from "../src/FundMe.sol";
import {HelperConfig} from "./HelperConfig.s.sol";

contract DeployFundMe is Script {
    function run() external returns (FundMe) {
        //Before startBroadcast --> Not a "real" tx it's only a simulation on a simulated environment
        //Before the broadcast to not spend gas deploying on a real chain
        HelperConfig helperConfig = new HelperConfig();
        //Normally with parenthesis but since it's only one argument, solidity takes them away
        address ethUsdPriceFeed = helperConfig.activeNetworkConfig();

        //After startBroadcast --> "real" tx
        vm.startBroadcast();
        FundMe fundMe = new FundMe(ethUsdPriceFeed);
        vm.stopBroadcast();
        return fundMe;
    }
}
