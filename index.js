'use strict';

const express = require('express');
const config = require('./config');
const cors = require('cors');
const bodyParser = require('body-parser');

const TB_MAS_PROVINCE = require('./routes/MAS/TB_MAS_PROVINCE');
const CHANGWAT_BRANCH = require('./routes/MAS/CHANGWAT_BRANCH');
const TB_MAS_AMPHUR = require('./routes/MAS/TB_MAS_AMPHUR');
const TB_MAS_TAMBOL = require('./routes/MAS/TB_MAS_TAMBOL.js');
const app = express();

app.use(express.json());
app.use(cors());
app.use(bodyParser.json());

app.use('/MAS', TB_MAS_PROVINCE.routes);
app.use('/MAS', CHANGWAT_BRANCH.routes);
app.use('/MAS', TB_MAS_AMPHUR.routes);
app.use('/MAS', TB_MAS_TAMBOL.routes);
app.listen(config.port, () => {
  console.log('Server listening on url http://127.0.0.1:' + config.port )
});