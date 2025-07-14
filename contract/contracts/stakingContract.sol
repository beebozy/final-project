


// // import {IERC20ForSplFactory} from "../interfaces/IERC20ForSplFactory.sol";
// // import {IERC20ForSpl} from "../interfaces/IERC20ForSpl.sol";
// // import {ICallSolana} from '../precompiles/ICallSolana.sol';
// // import {SafeERC20} from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
// // import {ReentrancyGuard} from "@openzeppelin/contracts/utils/ReentrancyGuard.sol";
// // import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
// // import {BondingCurve} from "./BondingCurve.sol";
// // import {Constants} from "../libraries/Constants.sol";
// // import {LibAssociatedTokenData} from "../libraries/associated-token-program/LibAssociatedTokenData.sol";
// // import {LibRaydiumProgram} from "../libraries/raydium-program/LibRaydiumProgram.sol";
// // import {LibRaydiumData} from "../libraries/raydium-program/LibRaydiumData.sol";
// // import {LibSPLTokenData} from "../libraries/spl-token-program/LibSPLTokenData.sol";
// // import {SolanaDataConverterLib} from "../utils/SolanaDataConverterLib.sol";
// // import {CallSolanaHelperLib} from "../utils/CallSolanaHelperLib.sol";



// import {IERC20ForSpl} from "./interfaces/IERC20ForSpl.sol";
// import {SafeERC20} from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
// import {ReentrancyGuard} from "@openzeppelin/contracts/utils/ReentrancyGuard.sol";
// import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
// import {ICallSolana} from './precompiles/ICallSolana.sol';
// import {SolanaDataConverterLib} from "./utils/SolanaDataConverterLib.sol";
// import {CallSolanaHelperLib} from "./utils/CallSolanaHelperLib.sol";
// import {LibAssociatedTokenData} from "./libraries/associated-token-program/LibAssociatedTokenData.sol";
// import {LibSPLTokenData} from "./libraries/spl-token-program/LibSPLTokenData.sol";

// contract LiquidStaking is Ownable, ReentrancyGuard {
//     using SafeERC20 for IERC20ForSpl;


//     ICallSolana public constant CALL_SOLANA = ICallSolana(0xFF00000000000000000000000000000000000006);
//     IERC20ForSpl public immutable wsolToken;
//     IERC20ForSpl public immutable memeToken;

//     // Track user stakes
//     mapping(address => uint256) public amountStaked;
//     mapping(address => bool) public alreadyStaked;

//     // Events
//     event UserStaked(address indexed staker, uint256 amount, uint256 memeTokensReceived);
//     event UserUnstaked(address indexed unstaker, uint256 amount);
//     event PayoutReceived(address indexed receiver, uint256 amount);

//     // Errors
//     error InvalidStaker();
//     error IncorrectStakedAmount();
//     error AlreadyStaked();
//     error NothingToUnstake();

//     constructor(address _wsolToken, address _memeToken) Ownable(msg.sender) {
//         wsolToken = IERC20ForSpl(_wsolToken);
//         memeToken = IERC20ForSpl(_memeToken);
//     }

//     /// @notice Stake WSOL to receive memecoins (100x multiplier)
//     /// @param amount WSOL amount to stake (0.1 to 1 WSOL, must be power of two)
//     function stake(uint256 amount) external nonReentrant {
//         // Input validation
//         if (msg.sender == address(0)) revert InvalidStaker();
//         if (alreadyStaked[msg.sender]) revert AlreadyStaked();
//         if (!_isValidAmount(amount)) revert IncorrectStakedAmount();

//         // Transfer WSOL from user
//         wsolToken.transferFrom(msg.sender, address(this), amount);

//         // Calculate and mint memecoins (100x multiplier)
//         uint256 memeAmount = amount * 100;
//         memeToken.transfer(msg.sender, memeAmount);

//         // Update state
//         amountStaked[msg.sender] = amount;
//         alreadyStaked[msg.sender] = true;

//         emit UserStaked(msg.sender, amount, memeAmount);
//     }

//     /// @notice Unstake WSOL (no memecoins need to be returned)
//     function unstake() external nonReentrant {
//         uint256 amount = amountStaked[msg.sender];
//         if (amount == 0) revert NothingToUnstake();

//         // Reset state before transfer to prevent reentrancy
//         amountStaked[msg.sender] = 0;
//         alreadyStaked[msg.sender] = false;

//         // Return WSOL
//         wsolToken.transfer(msg.sender, amount);

//         emit UserUnstaked(msg.sender, amount);
//     }

//     /// @dev Check if amount is valid (0.1-1 WSOL and power of two)
//     function _isValidAmount(uint256 amount) internal pure returns (bool) {
//         // Convert to WSOL units (1 WSOL = 1e18 wei)
//         uint256 wsolAmount = amount / 1e17; // Convert to 0.1 WSOL units
        
//         // Valid amounts: 1 (0.1 WSOL), 2 (0.2 WSOL), 4 (0.4 WSOL), 8 (0.8 WSOL), 10 (1.0 WSOL)
//         return (wsolAmount == 1 || wsolAmount == 2 || 
//                 wsolAmount == 4 || wsolAmount == 8 || 
//                 wsolAmount == 10) && (amount % 2 == 0);
//     }

//     /// @notice Withdraw any accumulated fees (WSOL)
//     function withdrawFees() external onlyOwner {
//         uint256 balance = wsolToken.balanceOf(address(this));
//         wsolToken.transfer(owner(), balance);
//         emit PayoutReceived(owner(), balance);
//     }


//      // Helper function to get Associated Token Account (ATA) on Solana
//     // function _getAssociatedTokenAccount(bytes32 tokenMint, address evmOwner) internal view returns (bytes32) {
//     //     bytes32 ownerPDA = CALL_SOLANA.getSolanaPDA(
//     //         Constants.getAssociatedTokenProgramId(),
//     //         abi.encodePacked(
//     //             Constants.getNeonEvmProgramId(),
//     //             tokenMint,
//     //             bytes32(uint256(uint160(evmOwner)))
//     //     ),
//     //     return ownerPDA;
//     // }

//    // Neon EVM utility functions (same as in MemeLaunchpad)
//     function getNeonAddress(address _address) public view returns(bytes32) {
//         return CALL_SOLANA.getNeonAddress(_address);
//     }

//     function getPayer() public view returns(bytes32) {
//         return CALL_SOLANA.getPayer();
//     }
//     //  // Cross-chain withdrawal to Solana (owner only)
//     // function withdrawToSolana(bytes32 solanaRecipient, uint64 amount) external onlyOwner {
//     //     // bytes32 wsolATA = LibAssociatedTokenData.getAssociatedTokenAccount(wsolToken.tokenMint(), address(this));
//     //     // wsolToken.transferSolana(solanaRecipient, amount);

//     //     bytes32 tokenAMint = wsolToken.tokenMint();
        
//     //     bytes32 payerAccount = CALL_SOLANA.getPayer();
//     //     bytes32 tokenA_ATA = LibAssociatedTokenData.getAssociatedTokenAccount(tokenAMint, payerAccount);
//     //   //  bytes32 tokenB_ATA = LibAssociatedTokenData.getAssociatedTokenAccount(tokenBMint, payerAccount);


//     //     wsolToken.transferSolana(solanaRecipient, amount);
//     // }

//     //  // Cross-chain withdrawal to Solana (owner only)
//     // function withdrawToSolana(bytes32 solanaRecipient, uint64 amount) external onlyOwner {
//     //     bytes32 wsolATA = LibAssociatedTokenData.getAssociatedTokenAccount(wsolToken.tokenMint(), address(this));
//     //     wsolToken.transferSolana(solanaRecipient, amount);
//     // }


//     /**
    
    
//     This might also be the as a stake for cross chain interaction 
    
//       function stake(uint64 amount) external {
//         require(
//             amount >= 0.1 && amount <= 1,
//             "Amount must be between 0.1 and 1 WSOL"
//         );
//         require(
//             amount % STAKE_MULTIPLE == 0,
//             "Amount must be a multiple of 0.1 WSOL"
//         );

//         // Calculate memetokens to mint
//         uint256 memeTokens = (amount / STAKE_MULTIPLE) * TOKENS_PER_STAKE;

//         // Transfer WSOL to contract's associated token account (ATA) on Solana
//         bytes32 wsolATA = _getAssociatedTokenAccount(wsolToken.tokenMint(), address(this));
//         wsolToken.transferSolana(wsolATA, amount);

//         // Mint memetokens directly to user's Neon EVM address
//         memeToken.mint(msg.sender, memeTokens);

//         emit Staked(msg.sender, amount, memeTokens);
//     }
    
//      */
// }


// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.28;

import {IERC20ForSpl} from "./interfaces/IERC20ForSpl.sol";
import {SafeERC20} from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import {ReentrancyGuard} from "@openzeppelin/contracts/utils/ReentrancyGuard.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {ICallSolana} from './precompiles/ICallSolana.sol';
import {LibAssociatedTokenData} from "./libraries/associated-token-program/LibAssociatedTokenData.sol";

contract LiquidStaking is Ownable, ReentrancyGuard {
    using SafeERC20 for IERC20ForSpl;

    ICallSolana public constant CALL_SOLANA = ICallSolana(0xFF00000000000000000000000000000000000006);
    IERC20ForSpl public immutable wsolToken;
    IERC20ForSpl public immutable usdtToken;

uint256 public constant MIN_STAKE = 0.1 * 1e9;  // 0.1 WSOL (100,000,000 lamports)
uint256 public constant MAX_STAKE = 1 * 1e9;    // 1 WSOL (1,000,000,000 lamports)
uint256 public constant STAKE_MULTIPLE = 0.1 * 1e9; // 0.1 WSOL
uint256 public constant TOKENS_PER_STAKE = 1e5; // 0.1 USDT = 100,000 (6 decimals)
   
    // Vesting parameters (30 days total, 7 day cliff)
    uint256 public constant VESTING_PERIOD = 30 minutes;
    uint256 public constant VESTING_CLIFF = 7 minutes;

    struct Stake {
        uint256 wsolAmount;
        uint256 usdtTokensGranted;
        uint256 usdtTokensClaimed;
        uint256 startTime;
        bool unstaked;
    }

    mapping(address => Stake) public stakes;

    event Staked(address indexed user, uint256 wsolAmount, uint256 usdtTokensGranted);
    event Unstaked(address indexed user, uint256 wsolAmount);
    event TokensClaimed(address indexed user, uint256 amount);
    event PayoutReceived(address indexed receiver, uint256 amount);

    error InvalidStaker();
    error InvalidAmount();
    error AlreadyStaked();
    error NothingToUnstake();
    error NothingToClaim();
    error VestingCliffNotReached();
    error SolanaTransferFailed();

    constructor(address _wsolToken, address _usdtToken) Ownable(msg.sender) {
        wsolToken = IERC20ForSpl(_wsolToken);
        usdtToken = IERC20ForSpl(_usdtToken);
    }

    /// @dev Check if amount is valid (0.1-1 WSOL and multiple of 0.1)
    function _isValidAmount(uint256 amount) internal pure returns (bool) {
        return (amount >= MIN_STAKE && 
                amount <= MAX_STAKE && 
                amount % STAKE_MULTIPLE == 0);
    }

    /// @notice Stake WSOL with vesting
    function stake(uint256 amount) external nonReentrant {
        if (msg.sender == address(0)) revert InvalidStaker();
        if (stakes[msg.sender].wsolAmount > 0) revert AlreadyStaked();
        if (!_isValidAmount(amount)) revert InvalidAmount();

        // Transfer WSOL to Solana ATA
        bytes32 wsolATA = _getAssociatedTokenAccount(wsolToken.tokenMint(), address(this));
        if (!wsolToken.transferSolana(wsolATA, uint64(amount))) {
            revert SolanaTransferFailed();
        }

// The usdt token should be 0.1 per 0.1wsol 
        // Calculate memetokens (0.1 per 0.1 WSOL)
        uint256 usdtTokens = (amount / STAKE_MULTIPLE) * TOKENS_PER_STAKE;

        stakes[msg.sender] = Stake({
            wsolAmount: amount,
            usdtTokensGranted: usdtTokens,
            usdtTokensClaimed: 0,
            startTime: block.timestamp,
            unstaked: false
        });

        emit Staked(msg.sender, amount, usdtTokens);
    }

    /// @notice Claim vested memetokens
    function claim() external nonReentrant {
        Stake storage userStake = stakes[msg.sender];
        if (block.timestamp < userStake.startTime + VESTING_CLIFF) {
            revert VestingCliffNotReached();
        }

        uint256 claimable = _calculateVestedAmount(msg.sender) - userStake.usdtTokensClaimed;
        if (claimable == 0) revert NothingToClaim();

        userStake.usdtTokensClaimed += claimable;
        usdtToken.mint(msg.sender, claimable);
        emit TokensClaimed(msg.sender, claimable);
    }

    /// @notice Unstake WSOL (ends vesting)
    function unstake() external nonReentrant {
        Stake storage userStake = stakes[msg.sender];
        if (userStake.wsolAmount == 0 || userStake.unstaked) {
            revert NothingToUnstake();
        }

        // Transfer remaining WSOL back
        bytes32 userATA = _getAssociatedTokenAccount(wsolToken.tokenMint(), msg.sender);
        if (!wsolToken.transferSolana(userATA, uint64(userStake.wsolAmount))) {
            revert SolanaTransferFailed();
        }

        userStake.unstaked = true;
        emit Unstaked(msg.sender, userStake.wsolAmount);
    }

    /// @dev Calculate vested amount (linear vesting)
    function _calculateVestedAmount(address user) internal view returns (uint256) {
        Stake storage userStake = stakes[user];
        if (block.timestamp < userStake.startTime + VESTING_CLIFF) {
            return 0;
        }

        uint256 elapsed = block.timestamp - userStake.startTime;
        if (elapsed >= VESTING_PERIOD || userStake.unstaked) {
            return userStake.usdtTokensGranted;
        }

        return (userStake.usdtTokensGranted * elapsed) / VESTING_PERIOD;
    }

    /// @notice Withdraw fees to Solana address (owner only)
    function withdrawFeesToSolana(bytes32 solanaRecipient, uint64 amount) external onlyOwner {
        bytes32 wsolATA = _getAssociatedTokenAccount(wsolToken.tokenMint(), address(this));
        if (!wsolToken.transferSolana(solanaRecipient, amount)) {
            revert SolanaTransferFailed();
        }
        emit PayoutReceived(address(0), amount);
    }

    /// @notice Get Associated Token Account (ATA) on Solana
    function _getAssociatedTokenAccount(bytes32 tokenMint, address evmOwner) internal view returns (bytes32) {
        return LibAssociatedTokenData.getAssociatedTokenAccount(
            tokenMint,
            CALL_SOLANA.getNeonAddress(evmOwner)
        );
    }

    // Utility functions
    function getNeonAddress(address _address) public view returns (bytes32) {
        return CALL_SOLANA.getNeonAddress(_address);
    }

    function getPayer() public view returns (bytes32) {
        return CALL_SOLANA.getPayer();
    }
}




// import {IERC20ForSpl} from "./interfaces/IERC20ForSpl.sol";
// import {SafeERC20} from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
// import {ReentrancyGuard} from "@openzeppelin/contracts/utils/ReentrancyGuard.sol";
// import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
// import {ICallSolana} from './precompiles/ICallSolana.sol';
// import {LibAssociatedTokenData} from "./libraries/associated-token-program/LibAssociatedTokenData.sol";

// contract LiquidStaking is Ownable, ReentrancyGuard {
//     using SafeERC20 for IERC20ForSpl;

//     ICallSolana public constant CALL_SOLANA = ICallSolana(0xFF00000000000000000000000000000000000006);
//     IERC20ForSpl public immutable wsolToken;
//     IERC20ForSpl public immutable memeToken;

//     // Constants (using usdt's 9 decimals)
//     uint256 public constant MIN_STAKE = 0.1 * 1e9;  // 0.1 WSOL (100,000,000 lamports)
//     uint256 public constant MAX_STAKE = 1 * 1e9;     // 1 WSOL (1,000,000,000 lamports)
//     uint256 public constant STAKE_MULTIPLE = 0.1 * 1e9;
//     uint256 public constant TOKENS_PER_STAKE = 100 * 1e18; // 100 memetokens (18 decimals)

//     // Vesting parameters (30 days total, 7 day cliff)
//     uint256 public constant VESTING_PERIOD = 30 minutes;
//     uint256 public constant VESTING_CLIFF = 7 minutes;

//     struct Stake {
//         uint256 wsolAmount;
//         uint256 memeTokensGranted;
//         uint256 memeTokensClaimed;
//         uint256 startTime;
//         bool unstaked;
//     }

//     mapping(address => Stake) public stakes;

//     event Staked(address indexed user, uint256 wsolAmount, uint256 memeTokensGranted);
//     event Unstaked(address indexed user, uint256 wsolAmount);
//     event TokensClaimed(address indexed user, uint256 amount);
//     event PayoutReceived(address indexed receiver, uint256 amount);

//     error InvalidStaker();
//     error InvalidAmount();
//     error AlreadyStaked();
//     error NothingToUnstake();
//     error NothingToClaim();
//     error VestingCliffNotReached();
//     error SolanaTransferFailed();

//     constructor(address _wsolToken, address _memeToken) Ownable(msg.sender) {
//         wsolToken = IERC20ForSpl(_wsolToken);
//         memeToken = IERC20ForSpl(_memeToken);
//     }

//     /// @dev Check if amount is valid (0.1-1 WSOL and multiple of 0.1)
//     function _isValidAmount(uint256 amount) internal pure returns (bool) {
//         return (amount >= MIN_STAKE && 
//                 amount <= MAX_STAKE && 
//                 amount % STAKE_MULTIPLE == 0);
//     }

//     /// @notice Stake WSOL with vesting
//     function stake(uint256 amount) external nonReentrant {
//         if (msg.sender == address(0)) revert InvalidStaker();
//         if (stakes[msg.sender].wsolAmount > 0) revert AlreadyStaked();
//         if (!_isValidAmount(amount)) revert InvalidAmount();

//         // Transfer WSOL to Solana ATA
//         bytes32 wsolATA = _getAssociatedTokenAccount(wsolToken.tokenMint(), address(this));
//         if (!wsolToken.transferSolana(wsolATA, uint64(amount))) {
//             revert SolanaTransferFailed();
//         }

//         // Calculate memetokens (100 per 0.1 WSOL)
//         uint256 memeTokens = (amount / STAKE_MULTIPLE) * TOKENS_PER_STAKE;
        
//         stakes[msg.sender] = Stake({
//             wsolAmount: amount,
//             memeTokensGranted: memeTokens,
//             memeTokensClaimed: 0,
//             startTime: block.timestamp,
//             unstaked: false
//         });

//         emit Staked(msg.sender, amount, memeTokens);
//     }

//     /// @notice Claim vested memetokens
//     function claim() external nonReentrant {
//         Stake storage userStake = stakes[msg.sender];
//         if (block.timestamp < userStake.startTime + VESTING_CLIFF) {
//             revert VestingCliffNotReached();
//         }

//         uint256 claimable = _calculateVestedAmount(msg.sender) - userStake.memeTokensClaimed;
//         if (claimable == 0) revert NothingToClaim();

//         userStake.memeTokensClaimed += claimable;
//         memeToken.mint(msg.sender, claimable);
//         emit TokensClaimed(msg.sender, claimable);
//     }

//     /// @notice Unstake WSOL (ends vesting)
//     function unstake() external nonReentrant {
//         Stake storage userStake = stakes[msg.sender];
//         if (userStake.wsolAmount == 0 || userStake.unstaked) {
//             revert NothingToUnstake();
//         }

//         // Transfer remaining WSOL back
//         bytes32 userATA = _getAssociatedTokenAccount(wsolToken.tokenMint(), msg.sender);
//         if (!wsolToken.transferSolana(userATA, uint64(userStake.wsolAmount))) {
//             revert SolanaTransferFailed();
//         }

// userStake.unstaked = true;
//         emit Unstaked(msg.sender, userStake.wsolAmount);
//     }

//     /// @dev Calculate vested amount (linear vesting)
//     function _calculateVestedAmount(address user) internal view returns (uint256) {
//         Stake memory userStake = stakes[user];
//         if (block.timestamp < userStake.startTime + VESTING_CLIFF) {
//             return 0;
//         }
        
//         uint256 elapsed = block.timestamp - userStake.startTime;
//         if (elapsed >= VESTING_PERIOD || userStake.unstaked) {
//             return userStake.memeTokensGranted;
//         }
        
//         return (userStake.memeTokensGranted * elapsed) / VESTING_PERIOD;
//     }

//     /// @notice Withdraw fees to Solana address (owner only)
//     function withdrawFeesToSolana(bytes32 solanaRecipient, uint64 amount) external onlyOwner {
//         bytes32 wsolATA = _getAssociatedTokenAccount(wsolToken.tokenMint(), address(this));
//         if (!wsolToken.transferSolana(solanaRecipient, amount)) {
//             revert SolanaTransferFailed();
//         }
//         emit PayoutReceived(address(0), amount);
//     }

//     /// @notice Get Associated Token Account (ATA) on Solana
//     function _getAssociatedTokenAccount(bytes32 tokenMint, address evmOwner) internal view returns (bytes32) {
//         return LibAssociatedTokenData.getAssociatedTokenAccount(
//             tokenMint,
//             CALL_SOLANA.getNeonAddress(evmOwner)
//         );
//     }

//     // Utility functions
//     function getNeonAddress(address _address) public view returns(bytes32) {
//         return CALL_SOLANA.getNeonAddress(_address);
//     }

//     function getPayer() public view returns(bytes32) {
//         return CALL_SOLANA.getPayer();
//     }
// }