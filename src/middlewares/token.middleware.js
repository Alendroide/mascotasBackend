const dotenvAB = require('dotenv');
dotenvAB.config();
const jwtAB = require('jsonwebtoken');

async function token(req,res,next){
    try{
        const tokenAB = req.header('authorization')?.split(" ")[1];
        if(!tokenAB) return res.status(401).json({status : 401, msg : "No token provided"});
        const verified = jwtAB.verify(tokenAB,process.env.SECRET);
        if(!verified) return res.status(401).json({status : 401, msg : "Invalid token"});
        req.user = verified;
        next();
    }
    catch(error){
        console.log(error);
        res.status(401).json({status : 401, msg : "Expired or malformed token"});
    }
}

module.exports = token;