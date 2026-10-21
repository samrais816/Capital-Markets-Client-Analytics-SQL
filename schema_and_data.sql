-- ====================================================================
-- Capital Markets Trade & Client Analytics Database Schema
-- Description: Creates clients, desks, and trades tables and inserts sample data.
-- ====================================================================

-- 1. Create Tables
CREATE TABLE clients (
    client_id INT PRIMARY KEY,
    client_name VARCHAR(120),
    segment VARCHAR(50), -- 'Institutional', 'Hedge Fund', 'Corporate'
    region VARCHAR(50),   -- 'North America', 'Europe', 'Asia-Pacific', 'LATAM'
    relationship_manager VARCHAR(100)
);

CREATE TABLE desks (
    desk_id INT PRIMARY KEY,
    desk_name VARCHAR(50), -- 'Equities', 'Fixed Income', 'Foreign Exchange (FX)', 'Derivatives'
    head_trader VARCHAR(100)
);

CREATE TABLE trades (
    trade_id INT PRIMARY KEY,
    client_id INT,
    desk_id INT,
    trade_date DATE,
    asset_class VARCHAR(50),
    notional_amount DECIMAL(15, 2),      -- Total trade value
    commission_revenue DECIMAL(10, 2),   -- Bank revenue
    risk_score INT,                       -- Scale 1 (Low) to 5 (High)
    FOREIGN KEY (client_id) REFERENCES clients(client_id),
    FOREIGN KEY (desk_id) REFERENCES desks(desk_id)
);

-- 2. Insert Trading Desks
INSERT INTO desks VALUES 
(101, 'Equities', 'John Smith'),
(102, 'Fixed Income', 'Elena Rostova'),
(103, 'Foreign Exchange (FX)', 'Marcus Vance'),
(104, 'Derivatives', 'Aisha Patel');

-- 3. Insert 50 Institutional Clients
INSERT INTO clients VALUES 
(1, 'Apex Global Hedge Fund', 'Hedge Fund', 'North America', 'Michael Chang'),
(2, 'Vanguard Alpha Fund', 'Hedge Fund', 'North America', 'Michael Chang'),
(3, 'BluePeak Capital Management', 'Institutional', 'North America', 'Sarah Jenkins'),
(4, 'Northwind Asset Management', 'Institutional', 'North America', 'Sarah Jenkins'),
(5, 'Meridian Corporate Treasury', 'Corporate', 'Asia-Pacific', 'David Ross'),
(6, 'Blackstone Energy Partners', 'Corporate', 'North America', 'David Ross'),
(7, 'Quantum Systematic Trading', 'Hedge Fund', 'Europe', 'Michael Chang'),
(8, 'Bridgeport Pension Fund', 'Institutional', 'North America', 'Sarah Jenkins'),
(9, 'Eurasia Sovereign Wealth', 'Institutional', 'Europe', 'Elena Rostova'),
(10, 'Pacific Rim Enterprises', 'Corporate', 'Asia-Pacific', 'David Ross'),
(11, 'Highland Quantitative Strategies', 'Hedge Fund', 'North America', 'Michael Chang'),
(12, 'Starlight Global Capital', 'Institutional', 'Europe', 'Sarah Jenkins'),
(13, 'Atlas Energy Holdings', 'Corporate', 'North America', 'David Ross'),
(14, 'Beacon Hill Credit Fund', 'Hedge Fund', 'North America', 'Michael Chang'),
(15, 'Crestview Life Insurance Asset Trust', 'Institutional', 'North America', 'Sarah Jenkins'),
(16, 'Orion Macro Alpha Partners', 'Hedge Fund', 'Europe', 'Michael Chang'),
(17, 'Great Lakes Municipal Trust', 'Institutional', 'North America', 'Sarah Jenkins'),
(18, 'Nova Scotia Marine Logistics', 'Corporate', 'North America', 'David Ross'),
(19, 'Boreal Timber & Resources', 'Corporate', 'North America', 'David Ross'),
(20, 'Silverline Tech Growth Fund', 'Hedge Fund', 'North America', 'Michael Chang'),
(21, 'Redwood Real Estate Investment Trust', 'Corporate', 'North America', 'David Ross'),
(22, 'Caledonia Wealth Advisors', 'Institutional', 'Europe', 'Sarah Jenkins'),
(23, 'Horizon Fixed Income Fund', 'Institutional', 'North America', 'Sarah Jenkins'),
(24, 'Titan Global Mining Corp', 'Corporate', 'LATAM', 'David Ross'),
(25, 'Zephyr Arbitrage Fund', 'Hedge Fund', 'Europe', 'Michael Chang'),
(26, 'Monarch Life & Annuity Co', 'Institutional', 'North America', 'Sarah Jenkins'),
(27, 'Maple Leaf Pension Investment Board', 'Institutional', 'North America', 'Sarah Jenkins'),
(28, 'Apex Pacific Infrastructure', 'Corporate', 'Asia-Pacific', 'David Ross'),
(29, 'Vanguard Sovereign Reserve', 'Institutional', 'Europe', 'Sarah Jenkins'),
(30, 'Trident Commodities Fund', 'Hedge Fund', 'North America', 'Michael Chang'),
(31, 'Boreal Power Generation Group', 'Corporate', 'North America', 'David Ross'),
(32, 'Polaris Global Macro', 'Hedge Fund', 'Europe', 'Michael Chang'),
(33, 'Lombard Private Wealth Management', 'Institutional', 'Europe', 'Sarah Jenkins'),
(34, 'Cascade Technology Ventures', 'Corporate', 'North America', 'David Ross'),
(35, 'Evergreen Forestry Corp', 'Corporate', 'North America', 'David Ross'),
(36, 'Gideon High Yield Credit Fund', 'Hedge Fund', 'North America', 'Michael Chang'),
(37, 'Nordic Sovereign Asset Corp', 'Institutional', 'Europe', 'Sarah Jenkins'),
(38, 'Cross River Financial Holdings', 'Corporate', 'North America', 'David Ross'),
(39, 'Solaria Renewable Energy', 'Corporate', 'LATAM', 'David Ross'),
(40, 'Alpha Wave Volatility Trading', 'Hedge Fund', 'North America', 'Michael Chang'),
(41, 'Ontario Teachers Credit Allocation', 'Institutional', 'North America', 'Sarah Jenkins'),
(42, 'Zenith Life Insurance', 'Institutional', 'North America', 'Sarah Jenkins'),
(43, 'Pan-Asian Logistics & Trade', 'Corporate', 'Asia-Pacific', 'David Ross'),
(44, 'Summit Quantitative Partners', 'Hedge Fund', 'North America', 'Michael Chang'),
(45, 'Bluewater Offshore Energy', 'Corporate', 'Europe', 'David Ross'),
(46, 'Ironclad Municipal Bond Trust', 'Institutional', 'North America', 'Sarah Jenkins'),
(47, 'Valiant Convertible Arbitrage', 'Hedge Fund', 'Europe', 'Michael Chang'),
(48, 'Sovereign Wealth Fund of LATAM', 'Institutional', 'LATAM', 'Sarah Jenkins'),
(49, 'Kensington Private Equity Fund', 'Hedge Fund', 'Europe', 'Michael Chang'),
(50, 'CanAm Agriculture Holdings', 'Corporate', 'North America', 'David Ross');

-- 4. Insert Historical Trade Transactions
INSERT INTO trades VALUES 
(5001, 1, 104, '2026-01-05', 'Derivatives', 50000000.00, 125000.00, 4),
(5002, 3, 102, '2026-01-08', 'Fixed Income', 30000000.00, 60000.00, 1),
(5003, 4, 101, '2026-01-10', 'Equities', 15000000.00, 45000.00, 2),
(5004, 2, 104, '2026-01-12', 'Derivatives', 75000000.00, 210000.00, 5),
(5005, 5, 103, '2026-01-15', 'Foreign Exchange', 25000000.00, 37500.00, 2),
(5006, 7, 101, '2026-01-18', 'Equities', 20000000.00, 60000.00, 3),
(5007, 9, 102, '2026-01-20', 'Fixed Income', 45000000.00, 90000.00, 2),
(5008, 11, 104, '2026-01-25', 'Derivatives', 60000000.00, 160000.00, 5),
(5009, 15, 102, '2026-01-28', 'Fixed Income', 12000000.00, 24000.00, 1),
(5010, 27, 102, '2026-02-01', 'Fixed Income', 85000000.00, 170000.00, 1),
(5011, 6, 103, '2026-02-03', 'Foreign Exchange', 35000000.00, 52500.00, 2),
(5012, 1, 101, '2026-02-05', 'Equities', 18000000.00, 54000.00, 3),
(5013, 2, 104, '2026-02-08', 'Derivatives', 90000000.00, 250000.00, 5),
(5014, 16, 104, '2026-02-12', 'Derivatives', 40000000.00, 110000.00, 4),
(5015, 23, 102, '2026-02-15', 'Fixed Income', 50000000.00, 100000.00, 2),
(5016, 30, 103, '2026-02-18', 'Foreign Exchange', 15000000.00, 22500.00, 2),
(5017, 41, 102, '2026-02-22', 'Fixed Income', 100000000.00, 200000.00, 1),
(5018, 40, 104, '2026-02-26', 'Derivatives', 65000000.00, 180000.00, 5),
(5019, 4, 102, '2026-03-01', 'Fixed Income', 22000000.00, 44000.00, 2),
(5020, 2, 101, '2026-03-05', 'Equities', 35000000.00, 105000.00, 3),
(5021, 10, 103, '2026-03-08', 'Foreign Exchange', 18000000.00, 27000.00, 1),
(5022, 12, 101, '2026-03-12', 'Equities', 28000000.00, 84000.00, 2),
(5023, 25, 104, '2026-03-15', 'Derivatives', 55000000.00, 145000.00, 4),
(5024, 32, 104, '2026-03-19', 'Derivatives', 70000000.00, 195000.00, 5),
(5025, 48, 103, '2026-03-22', 'Foreign Exchange', 40000000.00, 60000.00, 3),
(5026, 3, 104, '2026-03-25', 'Derivatives', 48000000.00, 130000.00, 4),
(5027, 41, 102, '2026-03-28', 'Fixed Income', 60000000.00, 120000.00, 1);
