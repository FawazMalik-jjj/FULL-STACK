const NFTDapp = artifacts.require('NFTDapp');
module.exports = async function (deployer) {
    const BASEURI = `https://bafybeidfpvjszubegtoomoknmc7zcqnay7noteadbwxktw46guhdeqohrm.ipfs.infura-ipfs.io/`;
    await deployer.deploy(NFTDapp, 'NFTDapp', 'NFT', BASEURI);
};

