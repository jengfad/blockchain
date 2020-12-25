import web3 from './web3';
import CampaignFactory from './build/CampaignFactory.json';

const instance = new web3.eth.Contract(
    CampaignFactory.abi,
    '0x458D4C73D5066f4F59c5dc2Fe44115fE7346555b'
);

export default instance;