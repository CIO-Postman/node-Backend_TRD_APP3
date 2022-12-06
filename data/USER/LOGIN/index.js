'use strict';

const utils = require('../../utils');
const config = require('../../../config');
const sql = require('mssql'); 

const sel = async(data, arg) => {
    try {
        let pool = await sql.connect(config.sql);
        const sqlQueries = await utils.loadSqlQueries('USER/LOGIN');
        const result = await pool.request()
            .input('ID_CARD', sql.NVarChar(100), data.ID_CARD)
            .input('TEST_PASSWORD', sql.NVarChar(100), data.TEST_PASSWORD)
            // .input('PROVINCE_SEQ', sql.Numeric(3,0), arg)
        .query(sqlQueries.sel);
              return result.recordset
            // if(result = null){
            //     return false;
            // }else{
            //     return result.recordset;
            // }
    } catch (error) {
        return error.message;
    }
}

module.exports = {
    ins, 
    upd, 
    del, 
    sel, 
    selByPK, 
    selSeqByName 
}