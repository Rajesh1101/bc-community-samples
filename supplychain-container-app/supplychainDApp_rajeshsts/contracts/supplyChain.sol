pragma solidity ^0.4.24;

contract Owned {
    address public owner;

    event OwnershipTransferred(address indexed _from, address indexed _to);

    function Owned() public {
        owner = msg.sender;
    }

    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }

    function transferOwnership(address _newOwner) public onlyOwner {
        emit OwnershipTransferred(owner,_newOwner);
        owner = _newOwner;
    }
}

contract supplyChain is Owned {
    
    enum existence {NO,YES}
    struct handler {
        bytes32 name;
        bytes32 addInfo;
        bytes32 role;
    	existence exists;
    }
    mapping(address => handler) handlerIndex;
    address[] handlerKeys;
    struct checkpoint {
        address handler;
        uint256[2] coord;
        bytes32 addInfo;
        uint256 timestamp;
    }    

    struct product {
        
        bytes32 uid;
        bytes32 addInfo;
        mapping(uint256 => checkpoint) checkpointArray;
        uint256 numOfCheckpoints;
    	existence exists;        
    }
    mapping(bytes32 => product) productIndex;
    bytes32[] productKeys;

    function addHandler(address handlerAddress,bytes32 handlerName,bytes32 handlerInfo,bytes32 handlerRole) public onlyOwner {
    	require(handlerIndex[handlerAddress].exists != existence.YES);
	        
    	handler memory currentHandler;
        currentHandler.name  = handlerName;
        currentHandler.addInfo  = handlerInfo;
        currentHandler.role = handlerRole;
    	currentHandler.exists = existence.YES;
        
        handlerIndex[handlerAddress] = currentHandler;
    
        handlerKeys.push(handlerAddress);
    }

    function addProduct(bytes32 uid,bytes32 productInfo,bytes32 checkpointInfo,uint256 lat,uint256 lon) public {
        
    	require(handlerIndex[msg.sender].exists == existence.YES);        

        bytes32 productAddress = keccak256(abi.encode(uid));        

    	require(productIndex[productAddress].exists != existence.YES);
        
        product memory currentProduct;
        checkpoint memory currentCheckpoint;
        currentProduct.uid  = uid;
        currentProduct.addInfo  = productInfo;
        currentProduct.numOfCheckpoints = 0;
        currentProduct.exists = existence.YES;
        
        currentCheckpoint.handler = msg.sender;
        currentCheckpoint.addInfo = checkpointInfo;
        currentCheckpoint.coord[0] = lat;
        currentCheckpoint.coord[1] = lon;
        currentCheckpoint.timestamp = now;        
    
        productIndex[productAddress] = currentProduct;
        
        productKeys.push(productAddress);
        
        product storage tmpProduct = productIndex[productAddress];
        
        tmpProduct.checkpointArray[tmpProduct.numOfCheckpoints] = currentCheckpoint;
        tmpProduct.numOfCheckpoints++;

    }

    function addCheckpoint(bytes32 uid,bytes32 checkpointInfo,uint256 lat,uint256 lon) public {
        
        require(handlerIndex[msg.sender].exists == existence.YES);
        bytes32 tmpIndex = keccak256(abi.encode(uid));
        require(productIndex[tmpIndex].exists == existence.YES); 
        checkpoint memory currentCheckpoint;
        currentCheckpoint.handler = msg.sender;
        currentCheckpoint.addInfo = checkpointInfo;
        currentCheckpoint.coord[0] = lat;
        currentCheckpoint.coord[1] = lon;
        currentCheckpoint.timestamp = now;
        product storage tmpProduct = productIndex[tmpIndex];
        tmpProduct.checkpointArray[tmpProduct.numOfCheckpoints] = currentCheckpoint;
        tmpProduct.numOfCheckpoints++;
        
    }
    
    function getProduct(bytes32 uid) public view returns(bytes32,address[],bytes32[],uint256[],uint256[],uint256[]) {
       
        bytes32 tmpIndex = keccak256(abi.encode(uid));
        
        require(productIndex[tmpIndex].exists == existence.YES);
        
        product storage tmpProduct = productIndex[tmpIndex];
        
        address[] memory handlers = new address[](tmpProduct.numOfCheckpoints);
        bytes32[] memory checkpointInfos = new bytes32[](tmpProduct.numOfCheckpoints);
        uint256[] memory lats = new uint256[](tmpProduct.numOfCheckpoints);
        uint256[] memory lons = new uint256[](tmpProduct.numOfCheckpoints);
        uint256[] memory timestamps = new uint256[](tmpProduct.numOfCheckpoints);
        
        for(uint i = 0; i < tmpProduct.numOfCheckpoints; i++) {
            handlers[i] = tmpProduct.checkpointArray[i].handler;
            checkpointInfos[i] = tmpProduct.checkpointArray[i].addInfo;
            lats[i] = tmpProduct.checkpointArray[i].coord[0];
            lons[i] = tmpProduct.checkpointArray[i].coord[1];
            timestamps[i] = tmpProduct.checkpointArray[i].timestamp;
        }
        
        return (tmpProduct.addInfo,handlers,checkpointInfos,lats,lons,timestamps);
        
    }
    

    function getHandler(address addressOfHandler) public view returns(bytes32,bytes32,bytes32) {

        require(handlerIndex[addressOfHandler].exists == existence.YES);
        
        return(handlerIndex[addressOfHandler].name,handlerIndex[addressOfHandler].addInfo,handlerIndex[addressOfHandler].role);
    }
    

    function getAllProducts() public view returns(bytes32[],bytes32[],uint256[]) {
        require(productKeys.length > 0);
        bytes32[] memory uids = new bytes32[](productKeys.length);
        bytes32[] memory addInfos = new bytes32[](productKeys.length);
        uint256[] memory numsOfCheckpoints = new uint256[](productKeys.length);
        for(uint i = 0; i < productKeys.length; i++) {
            uids[i] = productIndex[productKeys[i]].uid;
            addInfos[i] = productIndex[productKeys[i]].addInfo;
            numsOfCheckpoints[i] = productIndex[productKeys[i]].numOfCheckpoints;
        }
        return(uids,addInfos,numsOfCheckpoints);
    }


    function getAllHandlers() public view returns(address[],bytes32[],bytes32[],bytes32[]) {
        require(handlerKeys.length > 0);
        address[] memory addresses = new address[](handlerKeys.length);
        bytes32[] memory names = new bytes32[](handlerKeys.length);
        bytes32[] memory addInfos = new bytes32[](handlerKeys.length);
        bytes32[] memory role = new bytes32[](handlerKeys.length);
        for(uint i = 0; i < handlerKeys.length; i++) {
            addresses[i] = handlerKeys[i];
            names[i] = handlerIndex[handlerKeys[i]].name;
            addInfos[i] = handlerIndex[handlerKeys[i]].addInfo;
            role[i] = handlerIndex[handlerKeys[i]].role;
        }
        return(addresses,names,addInfos,role);
    }
}