/* 奶茶类型相关路由 */
const express=require('express');
const pool=require('../../pool');
var router=express.Router();
module.exports=router;

/* 获取所有类别 */

router.get('/',(req,res)=>{
 pool.query('SELECT * FROM ydd_category ORDER BY cid',(err,result)=>{
  if(err) throw err;
  res.send(result);
 })
})
 
/* API:DELETE  /admin/category/:cid*/
router.delete('/:cid',(req,res)=>{
 //注意:删除菜品类别前必须把属于该类别的菜品的类别编号设为NULL
  pool.query('UPDATE ydd_dish SET categoryId=NULL WHERE categoryId=?',req.params.cid,(err,result)=>{
   if(err) throw err;
   //至此指定类别的菜品已经修改完毕
  pool.query('DELETE FROM ydd_category WHERE cid=?',req.params.cid,(err,result)=>{
   if(err) throw err;
   if(result.affectedRows>0){
    res.send({code:200,msg:'1 category deleted'});
   }else{
    res.send({code:400,msg:'0 category deleted'});
   }
  })
 })
})
/* API:POST  /admin/category  非幂等
添加新的菜品类别
*/
router.post('/',(req,res)=>{
 var data=req.body;
 pool.query('INSERT INTO ydd_category SET ?',data,(err,result)=>{
  if(err) throw err;
  res.send({code:200,msg:'1 category added'})
 })
})

/* API:PUT /admin/category 
请求主体参数 {cid:xxx,cname:xx  }
*/
router.put('/',(req,res)=>{
 var data=req.body;//请求数据{cid:..,cname:xx}
 pool.query('UPDATE ydd_category SET? WHERE cid=?',[data,data.cid],(err,result)=>{
  if(err) throw err;
  if(result.changedRows>0){
   res.send({code:200,msg:'1 category modified'})
  }else if(result.affectedRows==0){
   res.send({code:400,msg:'0 category modified,not exists'})
  }else if(result.affectedRows==1 && result.changedRows==0){//影响了一行但是修改了0行-新值与旧值一样
   res.send({code:401,msg:'0 category modified no modified'})
  }
 })
})