require('@nomicfoundation/hardhat-toolbox');
require('dotenv').config();

/** @type import('hardhat/config').HardhatUserConfig */
const INFURA_GOERLI_URL = process.env.INFURA_GOERLI_URL || 'https://eth-goerli';
const PRIVATE_KEY = process.env.PRIVATE_KEY || '0xkey';
module.exports = {
	solidity: '0.8.17',
	networks: {
		goerli: {
			url: INFURA_GOERLI_URL,
			accounts: [PRIVATE_KEY],
			chainId: 5,
		},
	},
};
