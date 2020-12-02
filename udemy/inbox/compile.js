const path = require('path'); //cross platform compatibility
const fs = require('fs');
const solc = require('solc');

const inboxPath = path.resolve(__dirname, 'contracts', 'Inbox.sol'); //current working directory
const source = fs.readFileSync(inboxPath, 'utf8'); //read raw source file 

const input = {
  language: "Solidity",
  sources: {
    "Inbox.sol": {
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
let inbox = output.contracts["Inbox.sol"].Inbox;
module.exports = {
  bytecode: inbox.evm.bytecode.object,
  interface: inbox.abi
}