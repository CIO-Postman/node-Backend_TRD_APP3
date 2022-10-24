'use strict';

const express = require('express');
const controllers = require('../../controllers/MAS/TB_MAS_PROVINCE');
const router = express.Router();

router.post('/province', controllers.ins);
router.put('/province/:id', controllers.upd);
router.delete('/province/:id', controllers.del);

router.get('/province', controllers.sel);
router.get('/provinceByPK/:id', controllers.selByPK);
// router.get('/provinceByCountry/:id', controllers.selByCountry);
// router.get('/provinceByStatus/:id', controllers.selByStatus);

router.post('/provinceByName', controllers.selSeqByName);

// router.put('/provinceStatus/:id', controllers.updStatus);

module.exports = {
    routes: router
}