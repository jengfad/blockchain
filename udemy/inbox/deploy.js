const HDWalletProvider = require('truffle-hdwallet-provider');
const Web3 = require('web3');
const { interface, bytecode } = require('./compile'); 

const provider = new HDWalletProvider(
    'method vibrant dignity simple joy glory clap motion ritual exhibit six decrease',
    'https://rinkeby.infura.io/v3/b93d312a577f4dc7a92ebdb2478c3fbb'
);

const web3 = new Web3(provider);

const deploy = async () => {
    const accounts = await web3.eth.getAccounts();
    console.log('Attempting to deploy from account', accounts[0]);
    const result = await new web3.eth.Contract(interface)
        .deploy({ data: bytecode, arguments: ['Hi there!'] })
        .send({ from: accounts[0], gas: '1000000' });
    console.log('Contract Deployed', result.options.address);
};

deploy();