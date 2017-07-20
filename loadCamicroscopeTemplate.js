print("-- start script here --");
use caMicroscope_Templates;
var AnnotationTemplate_records = db.AnnotationTemplate.find().count();
if(AnnotationTemplate_records == 0){
db.AnnotationTemplate.insert({ 
     "region" : {
        "enum" : [
            "Good Segmentation",
            "Clump"
        ], 
        "title" : "Region:", 
        "type" : "string"
    }, 
    "additional_annotation" : {
        "title" : "Additional annotation for the region: ", 
        "type" : "textarea"
    }, 
    "additional_notes" : {
        "title" : "Additional notes: ", 
        "type" : "textarea"
    }, 
    "secret" : {
        "title" : "Secret: ", 
        "type" : "password"
    }
 })
}
print("-- end of  script  --");
