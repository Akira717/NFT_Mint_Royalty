// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
//0x5FbDB2315678afecb367f032d93F642f64180aa3

contract FirstMintNFT is ERC721, Ownable ,ReentrancyGuard{

    using Strings for string;
    using SafeMath for uint256;

    bool public paused;
    bool public stoped;
    bool public restarted;

    address payable private admin = payable(0xfd046d678588e3a0b714Bf1B1d0d22c8703Fd666);
    uint256 public max_cost = 5 ether;
    uint256 public min_cost = 1.5 ether;
    uint256 public NFT1_cost = 5 ether;
    uint256 public royality = 76;
    uint256 public nftID;
    uint256 public _num_nft1 = 1111;

    string public baseURI;
    string public baseExtension = ".json";

    uint256 public lastRun;
    uint256 public newRun;

    mapping (address => bool) public buyer;
    

    constructor(
        string memory _initBaseURI
    ) ERC721("NftMint1", "NFT1") {
        setBaseURI(_initBaseURI);
        lastRun = block.timestamp;
        newRun = block.timestamp;
    }

    function mintNFT() public payable nonReentrant{
        require(paused == false, "Mint is paused");
        require(stoped == false, "Mint is stoped");
        require(buyer[msg.sender] == false, "Already Minted NFT1");
        nftID = nftID.add(1);
        newRun = block.timestamp;
        NFT1_cost = NFT1_cost - (newRun - lastRun)/7200 *0.2 ether;
        if(NFT1_cost <= min_cost)
        { 
            NFT1_cost = min_cost;
        }
        uint256 amt = msg.value;
        require(amt >= NFT1_cost, "Not Enough Ether");
        buyer[msg.sender] == true;
        _safeMint(msg.sender, nftID);
        admin.transfer(amt);
    }

   function _baseURI() internal view virtual override returns (string memory) {
        return baseURI;
    }

    function setBaseURI (string memory _newBaseURI) public onlyOwner {
        baseURI =  _newBaseURI;
    }

    function pause(bool _state) public onlyOwner {
        paused = _state;
        newRun = block.timestamp;
        NFT1_cost = NFT1_cost - (newRun - lastRun)/120 *0.002 ether;
    }

    function stop(bool _state) public onlyOwner {
        stoped = _state;
        lastRun = block.timestamp;
        max_cost = 5 ether;
        min_cost = 1.5 ether;
        NFT1_cost = 5 ether;
    }

    function restart(bool _state) public onlyOwner {
        restarted = _state;
        paused = false;
        stoped = false;
        lastRun = block.timestamp;
    }

    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        string memory currentBaseURI = _baseURI();
        return bytes(currentBaseURI).length > 0 ? string(abi.encodePacked(currentBaseURI, Strings.toString(tokenId), baseExtension)): "";
    }

    function getPrice() external view returns (uint){
        return lastRun;
    }

    function getNftID() external view returns (uint){
        return  nftID;
    }
    function getResult(address _buyer) external view returns (bool){
        return buyer[_buyer];
    }

}
