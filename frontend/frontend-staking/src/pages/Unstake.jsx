export default function Unstake() {
  const cardStyle = {
    background: '#fff',
    borderRadius: '12px',
    padding: '20px',
    marginBottom: '20px',
  }

  const titleStyle = {
    fontSize: '32px',
    fontWeight: 'bold',
    marginBottom: '20px',
  }

  const sectionStyle = {
    display: 'flex',
    justifyContent: 'space-between',
    gap: '30px',
    marginTop: '30px',
    flexWrap: 'wrap',
  }

  const boxStyle = {
    background: '#ede9fe',
    borderRadius: '10px',
    padding: '16px',
    flex: 1,
    textAlign: 'left',
  }

  const connectButtonStyle = {
    background: '#a855f7',
    border: 'none',
    padding: '14px 30px',
    borderRadius: '30px',
    color: '#fff',
    fontWeight: 'bold',
    fontSize: '16px',
    marginTop: '20px',
    cursor: 'pointer',
    width: '100%',
  }

  const rightBoxStyle = {
    flex: 1,
    background: '#fff',
    padding: '20px',
    borderRadius: '12px',
    fontSize: '14px',
    color: '#333',
    lineHeight: '1.6',
  }

  return (
    <div style={{ marginTop: '40px' }}>
      <div style={titleStyle}>You're unstaking</div>

      <div style={sectionStyle}>
        {/* Left */}
        <div style={{ flex: 1 }}>
          <div style={cardStyle}>
            <div style={{ fontSize: '18px', fontWeight: 'bold' }}>JitoSOL</div>

            <div style={{ fontSize: '28px', fontWeight: 'bold', marginTop: '16px' }}>1</div>
            <div style={{ fontSize: '14px', color: '#888' }}>$197.32</div>
          </div>

          <div style={{ display: 'flex', gap: '10px' }}>
            <div style={boxStyle}>
              <div style={{ fontWeight: 'bold' }}>Immediately via Meonstake</div>
              <div style={{ fontSize: '12px', color: '#555' }}></div>
              <div style={{ fontSize: '18px', fontWeight: 'bold', marginTop: '8px' }}></div>
            </div>
            <div style={boxStyle}>
              <div style={{ fontWeight: 'bold' }}></div>
              <div style={{ fontSize: '12px', color: '#555' }}></div>
              <div style={{ fontSize: '18px', fontWeight: 'bold', marginTop: '8px' }}></div>
            </div>
          </div>

          <button style={connectButtonStyle}>Connect Wallet</button>
        </div>

        {/* Right */}
        <div style={rightBoxStyle}>
          <h2 style={{ fontSize: '18px', fontWeight: 'bold', marginBottom: '12px' }}>Instant Unstake</h2>
          <ol>
            <li>
              <strong>Swap WSOL for memetoken</strong><br />
            </li>
            <li style={{ marginTop: '12px' }}>
              <strong>Review price impact and slippage</strong><br />
              Price impact shows how your trade affects the market. Slippage protects you from price changes during transaction processing.
            </li>
            <li style={{ marginTop: '12px' }}>
              <strong>Receive memetoken instantly</strong><br />
              Once the swap is confirmed, token will be in your wallet ready to use.
            </li>
          </ol>

          <p style={{ marginTop: '12px', fontSize: '12px', color: '#777' }}>
            NOTE: Instant unstaking via this route
          </p>
        </div>
      </div>
    </div>
  )
}
