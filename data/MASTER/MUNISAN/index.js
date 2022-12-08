'use strict';

const utils = require('../../utils');
const config = require('../../../config');
const sql = require('mssql'); 


const selByACCode = async (data) => {
    try {
        let pool = await sql.connect(config.sql);
        const sqlQueries = await utils.loadSqlQueries('MASTER/MUNISAN');
        const result = await pool.request()
        .input('CHANGWAT_CODE', sql.Char(2), data.CHANGWAT_CODE)
        .input('AMPHUR_CODE', sql.Char(2), data.AMPHUR_CODE)
        .query(sqlQueries.selByACCode);  
        console.log(result.recordset[0].CHANGWAT_CODE, 'ttttttttttttttttttttttttt') 
        console.log(result.recordset[0].AMPHUR_CODE, 'yyyyyyyyyyyyyyyyyyyyyyyyyy')                         
        // return result.recordset;
        let output = {
            status: "200",
            message: "success",
            result: result.recordset,
            error : null
         } 
         return(output)    
    } catch (error) {
        let data = {
            status: "404",
            message: "ไม่พบข้อมูล",
            result: "",
            error : error.message    
        }
        return (data);
    }
}

// const BoundaryMunisan = async (data) => {
//     try {
//         let pool = await sql.connect(config.sql);
//         const sqlQueries = await utils.loadSqlQueries('MASTER/MUNISAN');
//         const result = await pool.request()
//         .input('AD_CHANGWA', sql.Char(2), data.AD_CHANGWA)
//         .input('AD_AMPHOE', sql.Char(2), data.AD_AMPHOE)
//         .input('MUNISAN_ID', sql.Char(11), data.MUNISAN_ID)
//         .query(sqlQueries.BoundaryMunisan);  
//         console.log(result.recordset[0].AD_CHANGWA, 'ttttttttttttttttttttttttt') 
//         console.log(result.recordset[0].AD_AMPHOE, 'yyyyyyyyyyyyyyyyyyyyyyyyyy')
//         console.log(result.recordset[0].MUNISAN_ID, 'mmmmmmmmmmmmmmmmmmmmm')                              
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
//             error : error.message    
//         }
//         return (data);
//     }
// }



module.exports = {

    selByACCode
    // ,BoundaryMunisan
}


