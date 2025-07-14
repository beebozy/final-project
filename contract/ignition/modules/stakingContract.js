

const { buildModule } = require("@nomicfoundation/hardhat-ignition/modules");

const wsolAddress= "0xc7Fc9b46e479c5Cb42f6C458D1881e55E6B7986c";
const usdtAddress="0xeF435b46900707b883C15b71B53f34957ce85acD";




module.exports = buildModule("LiquidStakingModule",(m)=>{

    const wsolToken = m.getParameter("wsolToken",wsolAddress);
    const usdtToken =m.getParameter("memeToken",usdtAddress);

    const stakingContract = m.contract("LiquidStaking",[wsolToken,usdtToken]);

    return {stakingContract};
})