import mysql from 'mysql2/promise';
import fs from 'node:fs';

const sslCaPath = process.env.DB_SSL_CA?.trim();

export const pool = mysql.createPool({
  host: process.env.DB_HOST,
  port: Number(process.env.DB_PORT || 3306),
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME || 'portfolio',
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0,
  charset: 'utf8mb4',
  ...(sslCaPath ? { ssl: { ca: fs.readFileSync(sslCaPath, 'utf8') } } : {}),
});
