const multerAB = require('multer');
const pathAB = require('path');

const uploadAB = multerAB({
    storage : multerAB.diskStorage({
        destination : function ( req, file, cb){
            cb(null,'public/pets')
        },
        filename : function ( req, file, cb ){
            const uniqueNameAB = Date.now() + '-' + Math.round(Math.random() * 1E9)
            cb(null,uniqueNameAB+pathAB.extname(file.originalname));
        }
    })
});

module.exports = uploadAB;