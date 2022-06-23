//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

error AlreadyVisited();

contract SwaprExpeditions is Ownable {
    using SafeMath for uint256;

    struct Visit {
        address user;
        /// @notice The time of the visit
        uint256 timestamp;
    }

    Visit[] getVisits;
    mapping(address => Visit[]) getVisitsByAddress;

    event NewVisit(address user);

    function submitVisit() public {
        addVisit(msg.sender);
    }

    function submitVisitOnBehalf(address _user) public onlyOwner {
        addVisit(_user);
    }

    function addVisit(address _user) internal {
        // Check if the user has already visited
        Visit[] memory visitsByAddress = getVisitsByAddress[_user];
        Visit memory lastVisit = visitsByAddress[visitsByAddress.length - 1];

        // Ensure 24 hours have passed since the last visit
        if (block.timestamp.sub(lastVisit.timestamp) < 60 * 60 * 24) {
            revert AlreadyVisited();
        }

        Visit memory visit = Visit({user: _user, timestamp: block.timestamp});

        getVisits.push(visit);

        getVisitsByAddress[_user].push(visit);

        emit NewVisit(_user);
    }
}
