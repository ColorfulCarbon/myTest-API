/* 奶茶类型相关路由 */
const express=require('express');
const pool=require('../pool');
var router=express.Router();
module.exports=router;

/* 获取所有类别 */
router.get('/',(req,res)=>{
 pool.query('SELECT * FROM ')
})

