import Web3 from 'Web3';

let web3;

if (typeof window !== 'undefined' && typeof window.web3 !== 'undefined') {
    // we are in the browser and metamask is running
    web3 = new Web3(window.web3.currentProvider);
} else {
    // we are on the browser OR the use is ont running metamask
    const provider = new Web3.providers.HttpProvider(
        'https://rinkeby.infura.io/v3/b93d312a577f4dc7a92ebdb2478c3fbb'
    );

    web3 = new Web3(provider);
}

export default web3;