import React, {Component} from 'react';
import './App.css';
import web3 from './web3';
import Web3Utils from './web3utils';
import lottery from './lottery';

class App extends Component {
  constructor(props) {
    super(props);
    this.state = {manager: ''}
  }

  async componentDidMount() {
    const isEthEnabled = await Web3Utils.isEthEnabled();
    if (isEthEnabled) {
      const network = await web3.eth.net.getNetworkType();
      console.log('network', network)
      const accounts = await web3.eth.getAccounts();
      console.log('accounts 0', accounts[0])

      lottery.methods.manager().call((data) => {
        console.log('callback', data);
      });
      
      // console.log('manager', manager)
      // this.setState({manager});
    }
  }

  render() {
    return (
      <div>
        <h2>Lottery Contract</h2>
        <p>This contract is managed by {this.state.manager}</p>
      </div>
    );
  }
}

export default App;
