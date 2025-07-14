import { useWallet } from '@solana/wallet-adapter-react'
import { useConnection } from '@solana/wallet-adapter-react'
import { LAMPORTS_PER_SOL, PublicKey, SystemProgram, Transaction } from '@solana/web3.js'




export default function Stake() {


const { connection } = useConnection()
const { publicKey, sendTransaction } = useWallet()

const handleStakeTransaction = async () => {
  if (!publicKey) {
    alert("Connect your wallet first")
    return
  }

  try {
    const transaction = new Transaction().add(
      SystemProgram.transfer({
        fromPubkey: publicKey,
        toPubkey: new PublicKey('FbcyK62bgPP78nLfeVkjVN12hZrYMgk6duwCgPWjMcD6'), // replace this
        lamports: 0.01 * LAMPORTS_PER_SOL, // 0.01 SOL
      })
    )

    const signature = await sendTransaction(transaction, connection)
    console.log("Transaction sent with signature:", signature)

    // Optional: wait for confirmation
    await connection.confirmTransaction(signature, 'processed')
    alert("Transaction confirmed!")
  } catch (err) {
    console.error("Transaction failed:", err)
    alert("Transaction failed: " + err.message)
  }
}

  const cardStyle = {
    display: 'flex',
    flexDirection: 'column',
    justifyContent: 'space-between',
    padding: '20px',
    borderRadius: '12px',
    background: '#fff',
    width: '45%',
  }

  const sectionStyle = {
    display: 'flex',
    justifyContent: 'space-between',
    alignItems: 'stretch', // Ensures both cards are same height
    marginTop: '20px',
    flexWrap: 'wrap',
    gap: '20px',
  }

  const connectBtnStyle = {
    marginTop: '16px',
    padding: '14px',
    width: '100%',
    border: 'none',
    borderRadius: '30px',
    fontSize: '16px',
    fontWeight: 'bold',
    backgroundColor: '#a855f7',
    color: 'white',
    cursor: 'pointer',
  }

  return (
    <div style={{ marginTop: '40px' }}>
      <h1 style={{ fontSize: '32px', fontWeight: 'bold' }}>Get memetoken</h1>

      {/* Main Card Row */}
      <div style={sectionStyle}>
        {/* Left Card */}
        <div style={cardStyle}>
          <div>
            <p style={{ marginBottom: '10px', color: '#555' }}>You're staking</p>
            <div style={{ display: 'flex', alignItems: 'center', gap: '8px' }}>
              <span style={{ fontWeight: 'bold' }}>WSOL</span>
            </div>
            <input
              type="number"
              defaultValue={0.0}
              style={{
                marginTop: '10px',
                width: '100%',
                padding: '10px',
                fontSize: '16px',
                borderRadius: '8px',
                border: '1px solid #ddd',
              }}
            />
          </div>
          <div></div>
        </div>

        {/* Right Card */}
        <div style={cardStyle}>
          <div>
            <p style={{ marginBottom: '10px', color: '#555' }}>To receive</p>
            <div style={{ display: 'flex', alignItems: 'center', gap: '8px' }}>
              <span style={{ fontWeight: 'bold' }}>memetoken</span>
            </div>
            <div style={{ marginTop: '10px', fontSize: '12px', color: '#888' }}>
              0% Price Impact
            </div>
          </div>

          <button style={connectBtnStyle} onClick={handleStakeTransaction}>
                       Stake 0.01 SOL
            </button>
            
        </div>
      </div>
    </div>
  )
}
