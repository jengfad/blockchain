const path = require('path');
const solc = require('solc');
const fs = require('fs-extra');

const buildPath = path.resolve(__dirname, 'build');
fs.removeSync(buildPath);

const campaignPath = path.resolve(__dirname, 'contracts', 'Campaign.sol');
const source = fs.readFileSync(campaignPath, 'utf-8');

const input = {
  language: "Solidity",
  sources: {
    "Contracts": {
      content: source,
    },
  },
  settings: {
    outputSelection: {
      "*": {
        "*": ["*"],
      },
    },
  },
};

const output = JSON.parse(solc.compile(JSON.stringify(input)));
fs.ensureDirSync(buildPath);

const theContracts = output.contracts.Contracts; 
for (let contract in theContracts) {
    fs.outputJsonSync(
        path.resolve(buildPath, contract + '.json'),
        theContracts[contract]
    );
}
