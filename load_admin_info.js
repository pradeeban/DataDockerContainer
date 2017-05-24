print("-- start script here --");

use quip;
var admin_records = db.userInfo.find({"userType":"admin"}).count();

if(admin_records == 0){
  db.userInfo.insert({ 
      "userType" : "admin", 
      "username" : "admin", 
      "password" : "$1$JvoSPkuO$koIXFbLOxXkS4qjfPkChc1"
 })
}
print("-- end of  script  --");
