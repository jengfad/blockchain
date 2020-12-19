import web3 from './web3';
import CampaignFactory from './build/CampaignFactory.json';

const instance = new web3.eth.Contract(
    CampaignFactory.abi,
    '0x6DE9E91fa5bd08d8b36eFCACa3F954a7809cB4EA'
);

export default instance;