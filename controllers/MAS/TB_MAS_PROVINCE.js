'use strict';

const query = require('../../data/MAS/TB_MAS_PROVINCE');

const ins = async (req, res, next) => {
    try {
        const data = req.body;
        const info = await query.ins(data);
        res.send(info);
    } catch (error) {
        res.status(400).send(error.message);
    }
}

const upd = async (req, res, next) => {
    try {
        const data = req.body;
        const arg =  req.params.id;
        const info = await query.upd(data, arg);
        res.send(info);
    } catch (error) {
        res.status(400).send(error.message);
    }
}

const del = async (req, res, next) => {
    try {
        const arg = req.params.id;
        const info = await query.del(arg);
        res.send(info);
    } catch (error) {
        res.status(400).send(error.message);
    }
}

const sel = async (req, res, next) => {
    try {
        const info = await query.sel();
        res.send(info);        
    } catch (error) {
        res.status(400).send(error.message);
    }
}

const selByPK = async (req, res, next) => {
    try {
        const arg = req.params.id;
        const info = await query.selByPK(arg);
        res.send(info);
    } catch (error) {
        res.status(400).send(error.message);
    }
}

const selByCountry = async (req, res, next) => {
    try {
        const arg = req.params.id;
        const info = await query.selByCountry(arg);
        res.send(info);
    } catch (error) {
        res.status(400).send(error.message);
    }
}

const selByStatus = async (req, res, next) => {
    try {
        const arg = req.params.id;
        const info = await query.selByStatus(arg);
        res.send(info);
    } catch (error) {
        res.status(400).send(error.message);
    }
}

const selSeqByName = async (req, res, next) => {
    try {
        const data = req.body;
        const info = await query.selSeqByName(data);
        res.send(info);
    } catch (error) {
        res.status(400).send(error.message);
    }
}

const updStatus = async (req, res, next) => {
    try {
        const data = req.body;
        const arg =  req.params.id;
        const info = await query.updStatus(data, arg);
        res.send(info);
    } catch (error) {
        res.status(400).send(error.message);
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