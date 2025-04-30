const { PrismaClient } = require('@prisma/client');
const prismaAB = new PrismaClient();

async function getAllAB(req,res){
    try{
        const allGendersAB = await prismaAB.gender.findMany();
        res.status(200).json({status : 200, msg : "Genders searched successfully", data : allGendersAB});
    }
    catch(error){
        console.error(error);
        res.status(500).json({status : 500, msg: error.name});
    }
}

module.exports = { getAll : getAllAB}