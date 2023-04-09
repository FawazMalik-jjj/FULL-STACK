
// SPDX-License-Identifier: MIT
 
pragma solidity >=0.7.0 < 0.9.0;
 

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
 
contract NFTDapp is ERC721Enumerable, Ownable {
    using Strings for uint256;
 
    mapping(string => uint8) public existingURIs;
 
    uint256 public cost = 0.01 ether;
    uint256 public maxSupply = 100;
    uint256 public supply;
    string public baseURI;
 
    event Sale(
        uint256 id,
        address indexed from,
        address indexed to,
        uint256 cost,
        string metadataURI,
        uint256 timestamp
    );
 
    struct SaleStruct {
        uint256 id;
        address from;
        address to;
        uint256 cost;
        string title;
        string description;
        uint256 timestamp;
    }
 
    SaleStruct[] minted;
 
    constructor (
        string memory _name,
        string memory _symbol,
        string memory _baseURI
    ) ERC721(_name, _symbol) {
        supply = totalSupply();
        baseURI = _baseURI;
    }
 
    function payToMint(string memory _title, string memory _description) public payable {
        require(supply < maxSupply, "All NFTs have been minted.");
        require(msg.value > 0 ether, "Ether value too low for minting.");
        require(msg.sender != owner(), "Contract owner not allowed to mint NFTs.");
 
        supply += 1;
        string memory URI = concat("");
        existingURIs[URI] = 1;
 
        sendFundsTo(owner(), msg.value);
 
        minted.push(
            SaleStruct(
                supply,
                msg.sender,
                owner(),
                msg.value,
                _title,
                _description,
                block.timestamp
            )
        );
 
        emit Sale(supply, msg.sender, owner(), msg.value, URI, block.timestamp);
        _safeMint(msg.sender, supply);
    }
 
    function getAllNFTs() public view returns (SaleStruct[] memory) {
        return minted;
    }
 
    function getNFT(uint256 tokenId) public view returns (SaleStruct memory) {
        return minted[tokenId - 1];
    }
 
    function concat(string memory str) internal view returns (string memory) {
        return string(abi.encodePacked(baseURI, Strings.toString(supply), str));
    }
 
    function sendFundsTo(address _to, uint256 _amount) internal {
        (bool success, ) = payable(_to).call{value:_amount}("");
        require(success);
    }
} 

