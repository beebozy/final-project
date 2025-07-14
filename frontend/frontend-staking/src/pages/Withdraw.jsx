
export default function Withdraw() {
  const cardStyle = {
    padding: '20px',
    borderRadius: '12px',
    background: '#fff',
    width: '100%',
    maxWidth: '500px',
    margin: '0 auto',
    boxShadow: '0 0 10px rgba(0,0,0,0.05)',
  }

  const buttonStyle = {
    marginTop: '16px',
    padding: '12px 24px',
    border: 'none',
    borderRadius: '8px',
    fontSize: '16px',
    fontWeight: 'bold',
    backgroundColor: '#10b981',
    color: 'white',
    cursor: 'pointer',
  }

  return (
    <div style={cardStyle}>
      <h2 style={{ fontSize: '24px', fontWeight: 'bold', marginBottom: '10px' }}>Claim Available</h2>
      <p style={{ color: '#555', fontSize: '14px' }}>
        Your tokens are fully vested. You can now claim after full vest.
      </p>
      <button style={buttonStyle}>Claim Now</button>
    </div>
  )
}
