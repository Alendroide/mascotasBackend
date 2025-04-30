const routerAB = require("express").Router();
const raceControllerAB = require('../controllers/race.controller');
const tokenAB = require("../middlewares/token.middleware");

routerAB.get('/races/getAll',tokenAB,raceControllerAB.getAll);

module.exports = routerAB