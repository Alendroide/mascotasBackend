const dotenvAB = require('dotenv');
dotenvAB.config();

const expressAB = require('express');
const appAB = expressAB();

const morganAB = require('morgan');
const corsAB = require('cors');
const pathAB = require('path');
const fsAB = require('fs');
const bodyParserAB = require('body-parser');

appAB.use(bodyParserAB.json());
appAB.use('/public',expressAB.static('public/'));
appAB.use(morganAB());
appAB.use(corsAB());

const routersDirectoryAB = pathAB.join(__dirname,'src/routers');
fsAB.readdirSync(routersDirectoryAB).map((file)=>{
    const routerAB = require(pathAB.join(routersDirectoryAB,file));
    appAB.use(routerAB);
})

appAB.listen(process.env.PORT,()=>{
    console.log("Server running on port",process.env.PORT);
});