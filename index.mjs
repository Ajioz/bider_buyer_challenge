import { loadStdlib } from '@reach-sh/stdlib';
import * as backend from './build/index.main.mjs';
const stdlib = loadStdlib();

const startingBalance = stdlib.parseCurrency(100);
const accPat = await stdlib.newTestAccount(startingBalance);
const accVanna = await stdlib.newTestAccount(startingBalance);

const ctcPat = accPat.contract(backend);                          //deploy application 
const ctcVanna = accVanna.contract(backend, ctcPat.getInfo());    //Attaching to the contract


const HAND = ['Rock', 'Paper', 'Scissors'];

const OUTCOME = ['Pat wins', 'Draw', 'Vanna wins'];

const Members = (Who) => ({

  getChallenge: () => {
    const challenge = Math.floor(Math.random() * 3);
    console.log(`${Who} played ${HAND[challenge]}`);
    return challenge;
  },

  seeResult: (result) => {
    console.log(`${Who} saw result ${OUTCOME[result]}`);
  },

});

await Promise.all([
  ctcPat.p.Pat({
    ...Members('Pat'),
  }),
  ctcVanna.p.Vanna({
    ...Members('Vanna'),
  }),
]);