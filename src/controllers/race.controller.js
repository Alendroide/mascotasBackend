const { PrismaClient } = require('@prisma/client');
const prismaAB = new PrismaClient();

async function getAllAB(req,res){
    try{
        const allRacesAB = await prismaAB.race.findMany();
        res.status(200).json({status : 200, msg : "Races searched successfully", data : allRacesAB});
    }
    catch(error){
        console.error(error);
        res.status(500).json({status : 500, msg: error.name});
    }
}

module.exports = { getAll : getAllAB}