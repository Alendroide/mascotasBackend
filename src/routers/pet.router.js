const routerAB = require("express").Router();
const petControllerAB = require('../controllers/pet.controller');
const tokenAB = require("../middlewares/token.middleware");
const uploadAB = require('../middlewares/multer.middleware');

routerAB.get('/pets/getAll',tokenAB,petControllerAB.getAll);
routerAB.post('/pets/create',tokenAB,uploadAB.single("photo"),petControllerAB.create);
routerAB.put('/pets/adopt/:id',tokenAB,petControllerAB.adopt);
routerAB.put('/pets/update/:id',tokenAB,uploadAB.single("photo"),petControllerAB.update);
routerAB.delete('/pets/delete/:id',tokenAB,petControllerAB.delete);

module.exports = routerAB;