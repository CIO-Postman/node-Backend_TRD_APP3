'use strict';

const utils = require('../../utils');
const config = require('../../../config');
const sql = require('mssql'); 


const sel = async () => {
    try {
        let pool = await sql.connect(config.sql);
        const sqlQueries = await utils.loadSqlQueries('MASTER/AMPHUR');
        const result = await pool.request().query(sqlQueries.sel);
        return result.recordset;
    } catch (error) {
        console.log(error.message);
    }
}

const selByCode = async(arg) => {
    try {
        let pool = await sql.connect(config.sql);
        const sqlQueries = await utils.loadSqlQueries('MASTER/AMPHUR');
        const result = await pool.request()
            .input('CHANGWAT_CODE', sql.Char(2), arg)
        .query(sqlQueries.selByCode);
        return result.recordset;
    } catch (error) {
        return error.message;
    }
}


const selByCWCode = async (data) => {
    try {
        let pool = await sql.connect(config.sql);
        const sqlQueries = await utils.loadSqlQueries('MASTER/AMPHUR');
        const result = await pool.request()
        .input('CHANGWAT_CODE', sql.Char(2), data.CHANGWAT_CODE)
        .query(sqlQueries.selByCWCode);                            
        return result.recordset;
    } catch (error) {
        return error.message;
    }
}



module.exports = {
    sel, 
    selByCode, 
    selByCWCode 
}


