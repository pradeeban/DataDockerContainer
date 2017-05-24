print("-- start script here --");

use quip;
var admin_records = db.userInfo.find({"userType":"admin"}).count();

if(admin_records == 0){
  db.userInfo.insert({ 
      "userType" : "admin", 
      "username" : "admin:", 
      "password" : "quip2017"
 })
}
print("-- end of  script  --");
