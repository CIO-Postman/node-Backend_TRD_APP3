'use strict';

const query = require('../../data/MASTER/PROVINCE');


const sel = async (req, res, next) => {
    try {
        const info = await query.sel();
        res.send(info);        
    } catch (error) {
        res.status(400).send(error.message);
    }
}

const selByCode = async (req, res, next) => {
    try {
        const arg = req.params.id;
        const info = await query.selByCode(arg);
        res.send(info);
    } catch (error) {
        res.status(400).send(error.message);
    }
}


const selByCWCode = async (req, res, next) => {
    try {
        const data = req.body;
        const info = await query.selByCWCode(data);
        res.send(info);
    } catch (error) {
        res.status(400).send(error.message);
    }
}


module.exports = {

    sel, 
    selByCode, 
    selByCWCode
}

