const routerAB = require("express").Router();
const genderControllerAB = require('../controllers/gender.controller');
const tokenAB = require("../middlewares/token.middleware");

routerAB.get('/genders/getAll',tokenAB,genderControllerAB.getAll);

module.exports = routerAB