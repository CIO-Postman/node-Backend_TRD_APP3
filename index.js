'use strict';

const express = require('express');
const config = require('./config');
const cors = require('cors');
const bodyParser = require('body-parser');

const TB_MAS_PROVINCE = require('./routes/MAS/TB_MAS_PROVINCE');
const CHANGWAT_BRANCH = require('./routes/MAS/CHANGWAT_BRANCH');
const TB_MAS_AMPHUR = require('./routes/MAS/TB_MAS_AMPHUR');
const TB_MAS_TAMBOL = require('./routes/MAS/TB_MAS_TAMBOL.js');
const PROVINCE = require('./routes/MASTER/PROVINCE.js');
const AMPHUR = require('./routes/MASTER/AMPHUR.js');
const TAMBOL = require('./routes/MASTER/TAMBOL.js');
const MUNISAN = require('./routes/MASTER/MUNISAN.js');
const LOGIN = require('./routes/USER/LOGIN.js');
const app = express();

app.use(express.json());
app.use(cors());
app.use(bodyParser.json());

app.use('/MAS', TB_MAS_PROVINCE.routes);
app.use('/MAS', CHANGWAT_BRANCH.routes);
app.use('/MAS', TB_MAS_AMPHUR.routes);
app.use('/MAS', TB_MAS_TAMBOL.routes);
app.use('/MASTER', PROVINCE.routes);
app.use('/MASTER', AMPHUR.routes);
app.use('/MASTER', TAMBOL.routes);
app.use('/MASTER', TAMBOL.routes);
app.use('/MASTER', MUNISAN.routes);
app.use('/USER', LOGIN.routes);
app.listen(config.port, () => {
  console.log('Server listening on url http://127.0.0.1:' + config.port )
});