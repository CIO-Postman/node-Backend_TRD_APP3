'use strict';

const express = require('express');
const controllers = require('../../controllers/MASTER/TAMBOL');
const router = express.Router();

//router.post('/province', controllers.ins);
//router.put('/province/:id', controllers.upd);
//router.delete('/province/:id', controllers.del);

//router.get('/SearchAllChangwat', controllers.sel);
router.post('/SearchTambol', controllers.selByACCode);
// router.post('/BoundaryTambol', controllers.BoundaryTambol);
//router.get('/Search/:id', controllers.selByCode);
// router.get('/SearchChangwatbystCode/:id', controllers.selByPK);
// router.get('/provinceByCountry/:id', controllers.selByCountry);
// router.get('/provinceByStatus/:id', controllers.selByStatus);

//router.post('/provinceByName', controllers.selSeqByName);

// router.put('/provinceStatus/:id', controllers.updStatus);

module.exports = {
    routes: router
}