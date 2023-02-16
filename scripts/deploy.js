const hre = require('hardhat');

async function main() {
	const BertToken = await hre.ethers.getContractFactory('BertToken');
	const bertToken = await BertToken.deploy(100_000_000, 50);

	await bertToken.deployed();

	console.log('Bert Token deployed: ', bertToken.address);
}

main().catch((error) => {
	console.error(error);
	process.exitCode = 1;
});
