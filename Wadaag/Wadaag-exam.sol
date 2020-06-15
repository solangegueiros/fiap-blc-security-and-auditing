pragma solidity 0.5.4;

// Wadaag By Solange Gueiros

contract Wadaag {
    using SafeMath for uint256;

    string public name;

    uint256 internal constant decimalpercent = 10000;   //100.00 = precisão da porcentagem (2) + 2 casas para 100%
    uint8 public constant maxOwners = 201;             //Número máximo de owners

    address[] private owners;
    mapping (address => uint256) private indexOwner;     //posicao no array

    uint256 public totalDeposited;                    //total depositado
    mapping (address => uint256) public totalOwner;   //total depositado por address
    uint256 private _valueDeposited;                  //Valor que será dividido de acordo com o shareRatio
    mapping (address => uint256) private _balances;   //Saldo disponivel em USD que cada pessoa pode retirar


    constructor(string memory _name) public {
        name = _name;
        owners.push(address(0x0));  //posicao 0 zerada
    }

    function listOwners() public view returns (address[] memory) {
        return owners;
    }

    function isOwner(address _address) public view returns (bool) {
        if (totalOwner[_address] > 0)
            return true;
        else
            return false;
    }

    function countOwners() public view returns (uint256) {
        return owners.length-1;
    }

    function _addOwner(address account, uint256 shareRatio) internal returns (bool) {
        if (indexOwner[account] == 0) {
            indexOwner[account] = owners.push(account)-1;
            totalOwner[account] = shareRatio;
            emit AddOwner(account, shareRatio);
        }
        else {
            totalOwner[account] = totalOwner[account].add(shareRatio);
        }
        totalDeposited = totalDeposited.add(shareRatio);
        return true;
    }

    function _removeOwner(address _address) public returns (bool) {
        //Retirar do array Owner
        uint256 indexToDelete = indexOwner[_address];
        address addressToMove = owners[owners.length-1];
        indexOwner[addressToMove] = indexToDelete;
        owners[indexToDelete] = addressToMove;
        owners.length--;
        emit RemoveOwner(_address);
        return true;
    }

    event AddOwner (address indexed _address, uint256 shareRatio);
    event RemoveOwner (address indexed _address);

    event Deposit(address indexed _from, uint256 _value);

    function deposit() external payable {
        emit Deposit(msg.sender, msg.value);
        if (owners.length == 1) {
            //Só tem a primeira posicao zerada
            _balances[msg.sender] = _balances[msg.sender].add(msg.value);
        }
        else {
             _valueDeposited = msg.value;
            for (uint256 i = 1; i < owners.length; i++) {
                _receive(owners[i]);
            }
            _valueDeposited = 0;
        }
        _addOwner(msg.sender, msg.value);
    }

    event Receive(address indexed to, uint256 value);

    function _receive(address account) internal {
        uint256 payment = _valueDeposited.mul(totalOwner[account]).div(totalDeposited);
        _balances[account] = _balances[account].add(payment);
        emit Receive(account, payment);
    }

    //Balance in the contract in behalf of account
    function balanceOf(address account) public view returns (uint256) {
        return _balances[account];
    }

    //Withdrawal value in the contract in behalf of msg.sender
    function withdrawal() public {
        uint256 value = _balances[msg.sender];
        msg.sender.transfer(value);
        _balances[msg.sender] = 0;
        delete value;
    }

    //% da conta em relação ao total
    function percOf(address account) public view returns (uint256) {
        uint256 value = decimalpercent.mul(totalOwner[account]).div(totalDeposited);
        return value;
    }

    event TransferRatio(address indexed from, address indexed to, uint256 value);

    //Transfer a perc (based in total) in Border to another account
    function transferRatio(address account, uint256 perc) public {
        //Calcular a parte em relacao a perc
        uint256 part = totalOwner[msg.sender].mul(perc).div(percOf(msg.sender));
        uint256 newPart = totalOwner[msg.sender].sub(part);

        //Se totalOwner[msg.sender] = 0, retiro do array para não passar por ele sem necessidade
        if (newPart == 0) {
            require(_removeOwner(msg.sender), "removeOwner error");
        }

        totalOwner[msg.sender] = newPart;
        totalDeposited = totalDeposited.sub(part);
        _addOwner(account, part);
        emit TransferRatio (msg.sender, account, perc);
    }

}


library SafeMath {
    //By OpenZeppelin

    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b);
        return c;
    }

    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b > 0);
        uint256 c = a / b;
        return c;
    }

    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b <= a);
        uint256 c = a - b;
        return c;
    }

    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a);
        return c;
    }

    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b != 0);
        return a % b;
    }
}
