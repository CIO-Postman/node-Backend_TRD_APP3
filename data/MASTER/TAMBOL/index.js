'use strict';

const utils = require('../../utils');
const config = require('../../../config');
const sql = require('mssql'); 


const selByACCode = async (data) => {
    try {
        let pool = await sql.connect(config.sql);
        const sqlQueries = await utils.loadSqlQueries('MASTER/TAMBOL');
        const result = await pool.request()
        .input('CHANGWAT_CODE', sql.Char(2), data.CHANGWAT_CODE)
        .input('AMPHUR_CODE', sql.Char(2), data.AMPHUR_CODE)
        .query(sqlQueries.selByACCode);                            
        return result.recordset;
    } catch (error) {
        return error.message;
    }
}

const BoundaryTambol = async (data) => {
    try {
        let pool = await sql.connect(config.sql);
        const sqlQueries = await utils.loadSqlQueries('MASTER/TAMBOL');
        const result = await pool.request()
        .input('PRO_C', sql.Char(2), data.PRO_C)
        .input('DIS_C', sql.Char(2), data.DIS_C)
        .input('PRO_C', sql.Char(2), data.PRO_C)
        .query(sqlQueries.BoundaryTambol);                            
        return result.recordset;
    } catch (error) {
        return error.message;
    }
}

module.exports = {

    selByACCode,
    BoundaryTambol
}


