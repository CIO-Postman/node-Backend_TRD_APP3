'use strict';

const express = require('express');
const controllers = require('../../controllers/MAS/TB_MAS_TAMBOL');
const router = express.Router();

//router.post('/province', controllers.ins);
//router.put('/province/:id', controllers.upd);
//router.delete('/province/:id', controllers.del);

router.get('/tambol', controllers.sel);
router.get('/tambolByPK/:id', controllers.selByPK);
// router.get('/provinceByCountry/:id', controllers.selByCountry);
// router.get('/provinceByStatus/:id', controllers.selByStatus);

router.post('/tambolAmphur', controllers.selSeqByUTM);

// router.put('/provinceStatus/:id', controllers.updStatus);

module.exports = {
    routes: router
}