const express=require('express');
const pool=require('../../pool');
var router=express.Router();
module.exports=router;


/*get请求可以有请求主体吗? 一般情况不行
API:GET /admin/login/:aname/:apwd
完成用户登录验证(有的选择POST)
*/
router.get('/login/:aname/:apwd',(req,res)=>{
  var aname=req.params.aname;
  var apwd=req.params.apwd;
  pool.query('SELECT aid FROM ydd_admin WHERE aname=? AND apwd=PASSWORD(?)',[aname,apwd],(err,result)=>{
   if(err) throw err;
   if(result.length>0){//查询到一行数据,登陆成功
    res.send({code:200,msg:'login success'})
   }else{//没有查询导数据
    res.send({code:400,msg:'aname or apwd err'})
   }
  });
})



/*
API:PUT修改所有属性(PATCH修改部分属性) /admin
根据管理员名和密码修改管理员密码
*/

router.patch('/',(req,res)=>{
  var data=req.body;
  //首先根据aname/oldPwd查询用户是否存在
  pool.query('SELECT aid FROM ydd_admin WHERE aname=? AND apwd=PASSWORD(?)',[data.aname,data.oldPwd],(err,result)=>{
   if(err) throw err;
   if(result.length==0){
    res.send({code:400,msg:'password err'});
    return
   }
   //如果查询到了用户,再修改 其密码
   pool.query('UPDATE ydd_admin SET apwd=PASSWORD(?) WHERE aname=?',[data.newPwd,data.aname],(err,result)=>{
    if(err) throw err;
    if(result.changedRows>0){//密码修改成功
     res.send({code:200,msg:'modify success'})
    }else{//新旧密码一样,未做修改
     res.send({code:401,msg:'pwd not modified'})
    }
   })
  })
})