const { PrismaClient } = require('@prisma/client');
const prismaAB = new PrismaClient();
const bcryptAB = require('bcrypt');
const jwtAB = require('jsonwebtoken');
const dotenvAB = require('dotenv');
dotenvAB.config();

async function registerAB(req,res) {
    try{
        const { fullname, email, password } = req.body;
        if(!fullname || !email || !password) return res.status(400).json({ status : 400, msg: "Missing data is necessary for user creation"});

        const hashAB = await bcryptAB.hash(password,10);

        const userAB = await prismaAB.user.create({
            data : {
                fullname,
                email,
                password : hashAB
            }
        })

        res.status(201).json({ status : 200, msg : "User created successfully", data : userAB});
    }
    catch(error){
        console.log(error);
        res.status(422).json({ status : 422, msg : error.name });
    }
}

async function loginAB(req,res) {
    try{
        const { email, password } = req.body;
        if( !email || !password ) return res.status(400).json({ status : 400, msg: "Missing data is necessary to login"});

        const userAB = await prismaAB.user.findUnique({
            where : {
                email
            }
        })

        if(!userAB) return res.status(404).json({status : 404, msg: "User not found in database"});

        const passwordMatchAB = await bcryptAB.compare(password,userAB.password);
        
        if(!passwordMatchAB) return res.status(401).json({status : 401, msg : "Wrong password"});

        const tokenAB = await jwtAB.sign({
            sub : userAB.id,
            fullname : userAB.fullname,
            email
        },process.env.SECRET,{expiresIn : process.env.EXPIRES});

        res.status(200).json({ status : 200, msg : "Logged in successfully", data : tokenAB});
    }
    catch(error){
        console.log(error);
        res.status(422).json({ status : 422, msg : error.name });
    }
}

module.exports = {register: registerAB, login: loginAB};