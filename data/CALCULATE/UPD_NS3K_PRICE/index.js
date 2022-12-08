'use strict';

const utils = require('../../utils');
const config = require('../../../config');
const sql = require('mssql'); 

const updns3k = async (data, arg) => {
    try {
        let pool = await sql.connect(config.sql);
        const sqlQueries = await utils.loadSqlQueries('CALCULATE/UPD_NS3K_PRICE');
        const result = await pool.request()
        .input('BRANCH_CODE', sql.NVarChar(20), data.BRANCH_CODE)
        .input('NS3K_RN', sql.NVarChar(20), data.NS3K_RN)
        .input('CHANGWAT_CODE', sql.NVarChar(20), data.CHANGWAT_CODE)
        .query(sqlQueries.updns3k);
        return result.recordset;
    } catch (error) {
        return error.message;
    }
}

const updns3k2 = async (data, arg) => {
    try {
        let pool = await sql.connect(config.sql);
        const sqlQueries = await utils.loadSqlQueries('CALCULATE/UPD_NS3K_PRICE');
        const result = await pool.request()
        .input('BRANCH_CODE', sql.NVarChar(20), data.BRANCH_CODE)
        .input('NS3K_RN', sql.NVarChar(20), data.NS3K_RN)
        .input('CHANGWAT_CODE', sql.NVarChar(20), data.CHANGWAT_CODE)
        .query(sqlQueries.updns3k2);
        return result.recordset;
    } catch (error) {
        return error.message;
    }
}

const updns3k3 = async (data, arg) => {
    try {
        let pool = await sql.connect(config.sql);
        const sqlQueries = await utils.loadSqlQueries('CALCULATE/UPD_NS3K_PRICE');
        const result = await pool.request()
        .input('BRANCH_CODE', sql.NVarChar(20), data.BRANCH_CODE)
        .input('NS3K_RN', sql.NVarChar(20), data.NS3K_RN)
        .input('CHANGWAT_CODE', sql.NVarChar(20), data.CHANGWAT_CODE)
        .query(sqlQueries.updns3k3);
        return result.recordset;
    } catch (error) {
        return error.message;
    }
}

const updns3k4 = async (data, arg) => {
    try {
        let pool = await sql.connect(config.sql);
        const sqlQueries = await utils.loadSqlQueries('CALCULATE/UPD_NS3K_PRICE');
        const result = await pool.request()
        .input('BRANCH_CODE', sql.NVarChar(20), data.BRANCH_CODE)
        .input('NS3K_RN', sql.NVarChar(20), data.NS3K_RN)
        .input('CHANGWAT_CODE', sql.NVarChar(20), data.CHANGWAT_CODE)
        .query(sqlQueries.updns3k4);
        return result.recordset;
    } catch (error) {
        return error.message;
    }
}

module.exports = { 
    updns3k,
    updns3k2,
    updns3k3,
    updns3k4
}