export default class Web3Utils {
    static async isEthEnabled() {

        if (window.ethereum) {
            try {
                // Request account access
                await window.ethereum.enable();
                return true;
            } catch (error) {
                // User denied account access...
                alert("User denied account access");
            }
        }
        
        return false;
    }
}