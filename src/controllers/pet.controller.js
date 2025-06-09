const { PrismaClient } = require('@prisma/client');
const prismaAB = new PrismaClient();

async function getAllAB(req,res){
    try{
        const allPetsAB = await prismaAB.pet.findMany({
            include : {race : true}
        });
        res.status(200).json({status : 200, msg : "Pets searched successfully", data : allPetsAB});
    }
    catch(error){
        console.error(error);
        res.status(500).json({status : 500, msg: error.name});
    }
}

async function getByIdAB(req,res){
    try{
        const params = req.params;
        const id = parseInt(params.id);
        const petAB = await prismaAB.pet.findUnique({
            where : { id },
            include : {race : {include : {category : true}}, gender : true}
        });

        if(!petAB) return res.status(404).json({status: 404, msg: "Pet not found"});

        res.status(200).json({status : 200, msg : "Pet searched successfully", data : petAB});
    }
    catch(error){
        console.error(error);
        res.status(500).json({status : 500, msg: error.name});
    }
}

async function createAB(req,res){
    try{
        const { name, race_id, gender_id, lat, lng } = req.body;
        if(!name || !race_id || !gender_id || !lat || !lng) return res.status(400).json({status : 400, msg : "Missing data to create pet"});
        const fileAB = req.file || { filename : 'unknown.png'};

        const petAB = await prismaAB.pet.create({
            data : {
                photo : `pets/${fileAB.filename}`,
                name,
                race_id : parseInt(race_id),
                gender_id : parseInt(gender_id),
                latitude: parseFloat(lat),
                longitude: parseFloat(lng)
            }
        })

        res.status(200).json({status : 201, msg : "Pet created successfully", data : petAB});
    }
    catch(error){
        console.error(error);
        res.status(422).json({status : 422, msg : error.name});
    }
}

async function adoptAB(req,res){
    try{
        const params = req.params;
        const id = parseInt(params.id);
        const petAB = await prismaAB.pet.findUnique({
            where : { id }
        })

        if(!petAB) return res.status(404).json({status : 404, msg : 'Pet not found'});

        const { sub } = req.user;

        const adoptedPetAB = await prismaAB.pet.update({
            where : { id },
            data : {
                user_id : sub
            }
        });

        res.status(200).json({status : 200, msg : "Pet adopted successfully", data : adoptedPetAB});
    }
    catch(error){
        console.error(error);
        res.status(422).json({status : 422, msg : error.name});
    }
}

async function updateAB(req,res){
    try{
        const params = req.params;
        const id = parseInt(params.id)
        
        const petAB = await prismaAB.pet.findUnique({
            where : { id }
        })

        if(!petAB) return res.status(404).json({status : 404, msg : 'Pet not found'});
        
        const { name, race_id, gender_id } = req.body;
        const filenameAB = req.file?.filename;
        let fileAB;
        if(!filenameAB) fileAB = petAB.photo;
        else fileAB = `pets/${filenameAB}`;

        const updatedPetAB = await prismaAB.pet.update({
            where : { id },
            data : {
                photo : `${fileAB}`,
                name : name || petAB.name,
                race_id : parseInt(race_id) || petAB.race_id,
                gender_id : parseInt(gender_id) || petAB.gender_id
            }
        })

        res.status(200).json({status : 200, msg : "Pet updated successfully", data : updatedPetAB});
    }
    catch(error){
        console.error(error);
        res.status(422).json({status : 422, msg : error.name});
    }
}

async function deleteAB(req,res){
    try{
        const params = req.params;
        const id = parseInt(params.id)
        
        const petAB = await prismaAB.pet.findUnique({
            where : { id }
        })

        if(!petAB) return res.status(404).json({status : 404, msg : 'Pet not found'});
        
        const deletedPet = await prismaAB.pet.delete({
            where : { id }
        })

        res.status(200).json({status : 200, msg : "Pet deleted successfully", data : deletedPet});
    }
    catch(error){
        console.error(error);
        res.status(422).json({status : 422, msg : error.name});
    }
}

async function adoptionReportAB(req,res){
    try{
        const adoptedAB = await prismaAB.pet.findMany({where : {user_id : {not : null}}, include : {race : {include : {category : true}}, gender : true}});
        const notAdoptedAB = await prismaAB.pet.findMany({where : {user_id : null}, include : {race : {include : {category : true}}, gender : true}});
        const numberOfAdopted = adoptedAB.length;
        const numberOfNotAdopted = notAdoptedAB.length;

        const totalAB = numberOfAdopted + numberOfNotAdopted;

        const percentageAdopted = (numberOfAdopted / totalAB) * 100;
        const percentageNotAdopted = (numberOfNotAdopted / totalAB) * 100;

        res.status(200).json({status : 200, msg : "Adoption report", data : {
            totalPets: totalAB,
            totalAdopted: numberOfAdopted,
            totalNotAdopted: numberOfNotAdopted,
            percentageAdopted: percentageAdopted,
            percentageNotAdopted: percentageNotAdopted,
            adoptedPets: adoptedAB,
            notAdoptedPets: notAdoptedAB
        }});
    }
    catch(error){
        console.log(error);
    }
}

module.exports = {getAll: getAllAB, create: createAB, update: updateAB, delete : deleteAB, adopt : adoptAB, getById : getByIdAB,adoptionReport: adoptionReportAB};