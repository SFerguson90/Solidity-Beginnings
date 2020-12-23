// SPDX-License-Identifier: MIT
pragma solidity >= 0.5.0;

contract AssociateProfitSplitter {
    
    address payable employee_one;
    address payable employee_two;
    address payable employee_three;
    address payable HR;

    constructor(address payable _one, address payable _two, address payable _three) {
        employee_one = _one;
        employee_two = _two;
        employee_three = _three;
    }

    function balance() public view returns(uint) {
        return address(this).balance;
    }

    function deposit() public payable {
        // Split `msg.value` into three
        uint amount = uint(msg.value)/uint(3);

        // Transfer the amount to each employee
        employee_one.transfer(amount);
        employee_two.transfer(amount);
        employee_three.transfer(amount);

        // take care of a potential remainder by sending back to HR (`msg.sender`)
        (msg.sender).transfer(amount%3);
        
    }

    receive() external payable {
        // Enforce that the `deposit` function is called in the fallback function!
        deposit();
    }
}

