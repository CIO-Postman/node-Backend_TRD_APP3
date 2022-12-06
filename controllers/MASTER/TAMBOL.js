'use strict';

const query = require('../../data/MASTER/TAMBOL');


const selByACCode = async (req, res, next) => {
    try {
        const data = req.body;
        const info = await query.selByACCode(data);
        res.send(info);
    } catch (error) {
        res.status(400).send(error.message);
    }
}

const BoundaryTambol = async (req, res, next) => {
    try {
        const data = req.body;
        const info = await query.BoundaryTambol(data);
        res.send(info);
    } catch (error) {
        res.status(400).send(error.message);
    }
}


module.exports = {

    selByACCode,
    BoundaryTambol
}
