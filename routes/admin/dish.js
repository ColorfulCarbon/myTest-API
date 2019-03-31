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
 pool.query('SELECT cid ,cname FROM ydd_category ORDER BY cid',(err,result)=>{
  if(err)throw err;
  var categoryList=result;//类别列表
  console.log(categoryList)
  var count=0;

  for(let c of categoryList){
   //循环查询每个类别下有哪些菜品
   pool.query('SELECT * FROM ydd_dish WHERE categoryId=?',c.cid,(err,result)=>{
    if (err) throw err;
    c.dishList=result;
    count++;
    if(count==categoryList.length){
     res.send(categoryList)
    }
   })
  }
 })
})

/*
post /admin/dish/image
请求参数:
接收客户端上传的菜品图片,保存在服务器上,返回该图片在服务器上的随机名
*/
//引入multer中间件
const multer=require('multer');
const fs=require('fs');
var upload=multer({
 dest:'tmp/'  //制定客户端上传的文件临时存储路径
})
//定义路由,使用文件上传中间件
router.post('/image',upload.single('dishImg'),(req,res)=>{
 //console.log(req.file);//客户端上传的图片
 //console.log(req.body);//客户端 
 var tmpFile=req.file.path;
 var suffix=req.file.originalname.substring(
  req.file.originalname.lastIndexOf('.'));
 var newFile=randFileName(suffix);//目标文件名
 fs.rename(tmpFile,'img/dish/'+newFile,()=>{
  res.send({code:200,msg:'upoad succ',fileName:newFile})
 //把临时文件转移
 })
})

//生成一个随机文件名
//参数:suffix表示要生成的文件名中的后缀
function randFileName(suffix){
 var time=new Date().getTime(); //当前系统时间戳
 var num=Math.floor(Math.random()*(10000-1000)+1000);//4位随机数字
 return time+'-'+num+suffix;
}


/*
post /admin/dish
添加一个新的菜品
*/