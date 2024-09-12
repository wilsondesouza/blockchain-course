//dependências
import * as bip32 from 'bip32';
import * as bip39 from 'bip39';
import * as bitcoin from 'bitcoinjs-lib';

//network
const testnet = {
    messagePrefix: '\x18Bitcoin Signed Message:\n',
    bech32: 'tb',
    bip32: {
        public: 0x043587cf,  
        private: 0x04358394 
    },
    pubKeyHash: 0x6f,      
    scriptHash: 0xc4,     
    wif: 0xef             
};

//derivação de carteiras
const path = "m/49'/1'/0'/0"

//criação de mnemônico e seed
let mnemonic = bip39.generateMnemonic();
const seed = bip39.mnemonicToSeedSync(mnemonic);

//criação da raiz de carteira
let root = bip32.fromSeed(seed, testnet);

//derivação de carteira
let account = root.derivePath(path);
let node = account.derive(0).derive(0);

let bech32Address  = bitcoin.payments.p2wpkh({
    pubkey: node.publicKey,
    network: testnet,
}).address;

console.log("Endereço: ", bech32Address );
console.log("Chave Privada: ", node.toWIF());
console.log("Seed: ", mnemonic);