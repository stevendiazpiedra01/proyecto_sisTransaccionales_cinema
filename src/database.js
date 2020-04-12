const mysql = require('mysql');
const { promisify } = require('util');
const { database } = require('./keys');

const pool = mysql.createPool(database);

pool.getConnection((err, connection) => {
    if (err) {
        if (err.code === 'PROTOCOL_CONNECTION_LOST') {
            console.error('LA BASE DE DATOS FUE DESCONECTADA');
        }
        if (err.code === 'ER_CON_COUNT_ERROR') {
            console.error('LA DB TIENE MUCHAS CONEXIONES');
        }
        if (err.code === 'ECONNREFUSED') {
            console.error('CONEXION A LA DB NEGADA');
        }

    }
    if (connection) connection.release();
    console.log('DB CONECTADA!');
    return;
});

pool.query = promisify(pool.query);

module.exports = pool;