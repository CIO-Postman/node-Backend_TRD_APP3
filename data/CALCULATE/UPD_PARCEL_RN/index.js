'use strict';

const utils = require('../../utils');
const config = require('../../../config');
const sql = require('mssql'); 

const ins = async (data) => {
    try {
        let pool = await sql.connect(config.sql);
        const sqlQueries = await utils.loadSqlQueries('/CALCULATE/UPD_PARCEL_RN');
        const result = await pool.request()
            // .input('PROVINCE_SEQ', sql.Numeric(3,0), PROVINCE_SEQ)
            .input('PROVINCE_ID', sql.NVarChar(10), data.PROVINCE_ID)
            .input('PROVINCE_ABBR', sql.NVarChar(10), data.PROVINCE_ABBR)
            .input('PROVINCE_NAME_TH', sql.NVarChar(100), data.PROVINCE_NAME_TH)
            .input('PROVINCE_NAME_EN', sql.NVarChar(100), data.PROVINCE_NAME_EN)
            // .input('COUNTRY_SEQ', sql.Numeric(3,0), data.COUNTRY_SEQ)
            // .input('PROVINCE_NOTE', sql.NVarChar(100), data.PROVINCE_NOTE)
            // .input('RECORD_STATUS', sql.Char(1), data.RECORD_STATUS)
            // .input('CREATE_USER', sql.Char(13), data.CREATE_USER)
            // .input('CREATE_DTM', sql.DateTime, data.CREATE_DTM)
            // .input('LAST_UPD_USER', sql.Char(13), data.LAST_UPD_USER)
            // .input('LAST_UPD_DTM', sql.DateTime, data.LAST_UPD_DTM)
        .query(sqlQueries.ins);                            
        return result.recordset;
    } catch (error) {
        return error.message;
    }
}

const upd = async (data, arg) => {
    try {
        let pool = await sql.connect(config.sql);
        const sqlQueries = await utils.loadSqlQueries('CALCULATE/UPD_PARCEL_RN');
        const result = await pool.request()
            .input('STREET_RN', sql.NVarChar(20), data.STREET_RN)
            //.input('BRANCH_CODE', sql.NVarChar(20), data.BRANCH_CODE)
            //.input('PROVINCE_NAME_TH', sql.NVarChar(100), data.PROVINCE_NAME_TH)
            //.input('PROVINCE_NAME_EN', sql.NVarChar(100), data.PROVINCE_NAME_EN)
            // .input('COUNTRY_SEQ', sql.Numeric(3,0), data.COUNTRY_SEQ)
            // .input('PROVINCE_NOTE', sql.NVarChar(100), data.PROVINCE_NOTE)
            // .input('RECORD_STATUS', sql.Char(1), data.RECORD_STATUS)
            // .input('CREATE_USER', sql.Char(13), data.CREATE_USER)
            // .input('CREATE_DTM', sql.DateTime, data.CREATE_DTM)
            // .input('LAST_UPD_USER', sql.Char(13), data.LAST_UPD_USER)
            // .input('LAST_UPD_DTM', sql.DateTime, data.LAST_UPD_DTM)
            .input('PARCEL_RN', sql.Numeric(20,0), arg.id)
            .input('BRANCH_CODE', sql.Numeric(20,0), arg.ib)
        .query(sqlQueries.upd);
        return result.recordset;
    } catch (error) {
        return error.message;
    }
}

const del = async (arg) => {
    try {
        let pool = await sql.connect(config.sql);
        const sqlQueries = await utils.loadSqlQueries('CALCULATE/UPD_PARCEL_RN');
        const result = await pool.request()
            .input('PROVINCE_SEQ', sql.Numeric(3,0), arg)
        .query(sqlQueries.del);
        return result;
    } catch (error) {
        return error.message;
    }
}

const sel = async () => {
    try {
        let pool = await sql.connect(config.sql);
        const sqlQueries = await utils.loadSqlQueries('CALCULATE/UPD_PARCEL_RN');
        const result = await pool.request().query(sqlQueries.sel);
        return result.recordset;
    } catch (error) {
        console.log(error.message);
    }
}

const selByPK = async(arg) => {
    try {
        let pool = await sql.connect(config.sql);
        const sqlQueries = await utils.loadSqlQueries('CALCULATE/UPD_PARCEL_RN');
        const result = await pool.request()
            .input('BRANCH', sql.Numeric(10,0), arg)
        .query(sqlQueries.selByPK);
        return result.recordset;
    } catch (error) {
        return error.message;
    }
}

const selByCountry = async(arg) => {
    try {
        let pool = await sql.connect(config.sql);
        const sqlQueries = await utils.loadSqlQueries('CALCULATE/UPD_PARCEL_RN');
        const result = await pool.request()
            .input('COUNTRY_SEQ', sql.Numeric(3,0), arg)
        .query(sqlQueries.selByCountry);
        return result.recordset;
    } catch (error) {
        return error.message;
    }
}

const selByStatus = async(arg) => {
    try {
        let pool = await sql.connect(config.sql);
        const sqlQueries = await utils.loadSqlQueries('CALCULATE/UPD_PARCEL_RN');
        const result = await pool.request()
            .input('RECORD_STATUS', sql.Char(1), arg)
        .query(sqlQueries.selByStatus);
        return result.recordset;
    } catch (error) {
        return error.message;
    }
}

const selSeqByName = async (data) => {
    try {
        let pool = await sql.connect(config.sql);
        const sqlQueries = await utils.loadSqlQueries('CALCULATE/UPD_PARCEL_RN');
        const result = await pool.request()
        .input('BRANCH_CODE', sql.NVarChar(100), data.BRANCH_CODE)
        .input('PARCEL_RN', sql.NVarChar(100), data.PARCEL_RN)
        .input('STREET_RN', sql.NVarChar(100), data.STREET_RN)
        .query(sqlQueries.selSeqByName);                            
        return result.recordset;
    } catch (error) {
        return error.message;
    }
}

const updStatus = async(data, arg) => {
    try {
        let pool = await sql.connect(config.sql);
        const sqlQueries = await utils.loadSqlQueries('CALCULATE/UPD_PARCEL_RN');
        const result = await pool.request()
            .input('RECORD_STATUS', sql.Char(1), data.RECORD_STATUS)
            .input('LAST_UPD_USER', sql.Char(13), data.LAST_UPD_USER)
            .input('PROVINCE_SEQ', sql.Numeric(3,0), arg)
        .query(sqlQueries.updStatus);
            return result;
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