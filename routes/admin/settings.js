const express=require('express');
const pool=require('../../pool');
var router=express.Router();
module.exports=router;


/* GET  /admin/settings */
router.get('/',(req,res)=>{
  pool.query('SELECT * FROM ydd_settings LIMIT 1',(err,result)=>{
   if(err) throw err;
   res.send(result[0]);
  })
})
router.put('/',(req,res)=>{
  pool.query('UPDATE ydd_settings SET ?',req.body,(err,result)=>{
   if(err) throw err;
   res.send({code:200,msg:'settings updated succ'});
  })
})
