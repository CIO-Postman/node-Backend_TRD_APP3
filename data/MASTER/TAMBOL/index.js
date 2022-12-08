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
        console.log(result.recordset[0].CHANGWAT_CODE, 'ffffffffffffff')
        console.log(result.recordset[0].AMPHUR_CODE, 'nnnnnnnnnnnnnn')                               
        // return result.recordset;
        let output = {
            status: "200",
            message: "success",
            result: result.recordset,
            error : null
         } 
         return (output)
    } catch (error) {
        let data = {
            status: "404",
            message: "ไม่พบข้อมูล",
            result: "",
            error : ""  
        }
        return (data);
    }
}

// const BoundaryTambol = async (data) => {
//     try {
//         let pool = await sql.connect(config.sql);
//         const sqlQueries = await utils.loadSqlQueries('MASTER/TAMBOL');
//         const result = await pool.request()
//         .input('PRO_C', sql.Char(2), data.PRO_C)
//         .input('DIS_C', sql.Char(2), data.DIS_C)
//         .input('SUB_C', sql.Char(2), data.SUB_C)
//         .query(sqlQueries.BoundaryTambol);
//         console.log(result.recordset[0].PRO_C, 'ffffffffffffff')
//         console.log(result.recordset[0].DIS_C, 'nnnnnnnnnnnnnn')
//         console.log(result.recordset[0].SUB_C, 'jjjjjjjjjjjjjj')                               
//         // return result.recordset;
//         let output = {
//             status: "200",
//             message: "success",
//             result: result.recordset,
//             error : null
//          } 
//          return(output)
//     } catch (error) {
//         let data = {
//             status: "404",
//             message: "ไม่พบข้อมูล",
//             result: "",
//             error : ""  
//         }
//         return (data);
//     }
// }


module.exports = {

    selByACCode
    // ,BoundaryTambol 
}


