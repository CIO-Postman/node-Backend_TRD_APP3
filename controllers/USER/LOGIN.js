'use strict';

const query = require('../../data/USER/LOGIN');


const sel = async (req, res, next) => {
    try {
        const data = req.body;
        const info = await query.sel(data);
        res.send(info);
    } catch (error) {
        res.status(400).send(error.message);
    }
}


module.exports = {
    sel
}

