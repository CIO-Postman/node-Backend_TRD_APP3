'use strict';

const express = require('express');
const controllers = require('../../controllers/MAS/CHANGWAT_BRANCH');
const router = express.Router();

//router.post('/province', controllers.ins);
//router.put('/province/:id', controllers.upd);
//router.delete('/province/:id', controllers.del);

router.get('/branch', controllers.sel);
router.get('/branchByPK/:id', controllers.selByPK);
// router.get('/provinceByCountry/:id', controllers.selByCountry);
// router.get('/provinceByStatus/:id', controllers.selByStatus);

//router.post('/provinceByName', controllers.selSeqByName);

// router.put('/provinceStatus/:id', controllers.updStatus);

module.exports = {
    routes: router
}