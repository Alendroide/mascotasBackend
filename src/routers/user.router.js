const routerAB = require("express").Router();
const userController = require('../controllers/user.controller');

routerAB.post('/auth/register',userController.register);
routerAB.post('/auth/login',userController.login);

module.exports = routerAB;