const express = require('express');
const app = express();
const port = 3000;
const path = require('path');
app.get('/kakao/map', (req,res) => res.sendFile(path.join(__dirname, "./kakaoMap.html")));
app.listen(port , ()=> console.log('> Server is up and running on port : ' + port))