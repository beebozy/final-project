import { useState } from 'react'
import Stake from './pages/Stake'
import Unstake from './pages/Unstake'
import Header from './components/Header'
import Withdraw from './pages/Withdraw' //


export default function App() {
  const [tab, setTab] = useState('stake')

  const tabStyle = {
    padding: '10px 20px',
    cursor: 'pointer',
    borderBottom: tab === 'stake' ? '2px solid #A855F7' : '',
    marginRight: '10px',
    fontWeight: 'bold',
    fontSize: '16px',
    color: tab === 'stake' ? '#A855F7' : '#333',
  }

  const inactiveTabStyle = {
    ...tabStyle,
    borderBottom: tab === 'unstake' ? '2px solid #A855F7' : '',
    color: tab === 'unstake' ? '#A855F7' : '#333',
  }

  return (
    <div style={{ fontFamily: 'sans-serif', background: '#f5f3ff', minHeight: '100vh', padding: '20px' }}>
      <Header />

      {/* Tabs */}
      <div style={{ display: 'flex', borderBottom: '1px solid #ddd', marginTop: '20px' }}>
        <div style={tabStyle} onClick={() => setTab('stake')}>Stake</div>
        <div style={inactiveTabStyle} onClick={() => setTab('unstake')}>Unstake</div>
      </div>

      {/* Main Section */}
      <div style={{ marginTop: '30px' }}>
        {tab === 'stake' ? <Stake /> : <Unstake />}
      </div>

      {/* Claim Section */}
      <div style={{ marginTop: '40px' }}>
        <Withdraw />
      </div>
    </div>
  )
}
