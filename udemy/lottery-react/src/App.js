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
      const manager = await lottery.methods.manager().call();
      this.setState({manager});
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
