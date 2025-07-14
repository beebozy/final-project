# Sample Hardhat Project

This project demonstrates a basic Hardhat use case. It comes with a sample contract, a test for that contract, and a Hardhat Ignition module that deploys that contract.

Try running some of the following tasks:

```shell
npx hardhat help
npx hardhat test
REPORT_GAS=true npx hardhat test
npx hardhat node
npx hardhat ignition deploy ./ignition/modules/Lock.js
```



 npx hardhat ignition deploy ignition/modules/stakinContract.js --network neondevnet --reset
[dotenv@17.2.0] injecting env (3) from .env (tip: ⚙️  enable debug logging with { debug: true })
✔ Confirm deploy to network neondevnet (245022926)? … yes
✔ Confirm reset of deployment "chain-245022926" on chain 245022926? … yes
Hardhat Ignition 🚀

Deploying [ LiquidStakingModule ]

Batch #1
  Executed LiquidStakingModule#LiquidStaking

[ LiquidStakingModule ] successfully deployed 🚀

Deployed Addresses

LiquidStakingModule#LiquidStaking - 0xf91590aBfF74B67Ea8350870A5C1B71b6e927cA8

