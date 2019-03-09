//菜品相关路由
const express=require('express');
const pool=require('../../pool');
var router=express.Router();
module.exports=router;


//API:GET   /admin/dish
//获取所有菜品(按类别进行分类)
//返回数据:
/*
 [
  {cid:1,cname:'xxx',dishList:[{},{},{},...]}
  {cid:2,cname:'xxx',dishList:[{},{},{},...]}
  ...
 ]
*/
router.get('/',(req,res)=>{
 //查询所有菜品类别
 pool.query('SELECT cid ,cname FROM ydd_category',(err,result)=>{
  if(err)throw err;
  var categoryList=result;
  console.log(categoryList)
  var count=0;

  for(var c of categoryList){
   //循环查询每个类别下有哪些菜品
   pool.query('SELECT * FROM ydd_dish WHERE categpryId=?',c.cid,(err,result)=>{
    c.dishList=result;
    count++;
    if(count==categoryList.length){
     res.send(categoryList)
    }
   })
  }
 })
})

