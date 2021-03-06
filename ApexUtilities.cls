global class ApexUtilities{
    
    /**************************************************** Object Fields Related Methods****************************************************/
    
    /*
*	@methodName = getAllFields
*	@return = Set of field Names
*	@params = object name (both custom and standard)
*	@description = Method takes object name as an argument and return all (both custom and standard) fields
*/
    global static Set<String> getAllFields(String objectName){
        Map<String, Schema.SObjectType> completeSchema = Schema.getGlobalDescribe(); 
        Schema.SObjectType requiredObject = completeSchema.get(objectName);
        return requiredObject.getDescribe().fields.getMap().keySet();
    }
    
    /*
*	@methodName = getAllFields
*	@return = Map of object names and their field Names
*	@params = List of object name (both custom and standard)
*	@description = Method takes object name as an argument and return Map of object name and their (both custom and standard) fields
*/
    global static Map<String, Set<String>> getAllFields(List<String> objectNames){
        Map<String, Schema.SObjectType> completeSchema = Schema.getGlobalDescribe(); 
        Map<String, Set<String>> objectVsFieldMap = new Map<String, Set<String>>();
        for(String objectName : objectNames){
            Schema.SObjectType requiredObject = completeSchema.get(objectName);
            objectVsFieldMap.put(objectName,requiredObject.getDescribe().fields.getMap().keySet());
        }
        return objectVsFieldMap;
    }
    
    /*
*	@methodName = getAllCustomFields
*	@return = Set of field Names
*	@params = object name (both custom and standard)
*	@description = Method takes object name as an argument and return all Custom fields
*/
    global static Set<String> getAllCustomFields(String objectName){
        Map<String, Schema.SObjectType> completeSchema = Schema.getGlobalDescribe(); 
        Schema.SObjectType requiredObject = completeSchema.get(objectName);
        Set<String> customFields = new Set<String>(); 
        for(String field : requiredObject.getDescribe().fields.getMap().keySet()){
            if(field.endsWithIgnoreCase('__c')){
                customFields.add(field);
            }
        }
        return customFields;
    }
    
    /*
*	@methodName = getAllCustomFields
*	@return = Map of object names and their field Names
*	@params = List of object name (both custom and standard)
*	@description = Method takes object name as an argument and return Map of object name and their (custom) fields
*/
    global static Map<String, Set<String>> getAllCustomFields(List<String> objectNames){
        Map<String, Schema.SObjectType> completeSchema = Schema.getGlobalDescribe(); 
        Map<String, Set<String>> objectVsFieldMap = new Map<String, Set<String>>();
        for(String objectName : objectNames){
            Schema.SObjectType requiredObject = completeSchema.get(objectName);
            Set<String> customFields = new Set<String>(); 
            for(String field : requiredObject.getDescribe().fields.getMap().keySet()){
                if(field.endsWithIgnoreCase('__c')){
                    customFields.add(field);
                }
            }
            objectVsFieldMap.put(objectName,customFields);
        }
        return objectVsFieldMap;
    }
    
    /*
*	@methodName = getAllStandardFields
*	@return = Set of field Names
*	@params = object name (both custom and standard)
*	@description = Method takes object name as an argument and return all Standard fields
*/
    global static Set<String> getAllStandardFields(String objectName){
        Map<String, Schema.SObjectType> completeSchema = Schema.getGlobalDescribe(); 
        Schema.SObjectType requiredObject = completeSchema.get(objectName);
        Set<String> standardFields = new Set<String>(); 
        for(String field : requiredObject.getDescribe().fields.getMap().keySet()){
            if(!field.endsWithIgnoreCase('__c')){
                standardFields.add(field);
            }
        }
        return standardFields;
    }
    
    /*
*	@methodName = getAllStandardFields
*	@return = Map of object names and their field Names
*	@params = List of object name (both custom and standard)
*	@description = Method takes object name as an argument and return Map of object name and their (standard) fields
*/
    global static Map<String, Set<String>> getAllStandardFields(List<String> objectNames){
        Map<String, Schema.SObjectType> completeSchema = Schema.getGlobalDescribe(); 
        Map<String, Set<String>> objectVsFieldMap = new Map<String, Set<String>>();
        for(String objectName : objectNames){
            Schema.SObjectType requiredObject = completeSchema.get(objectName);
            Set<String> sFields = new Set<String>(); 
            for(String field : requiredObject.getDescribe().fields.getMap().keySet()){
                if(!field.endsWithIgnoreCase('__c')){
                    sFields.add(field);
                }
            }
            objectVsFieldMap.put(objectName,sFields);
        }
        return objectVsFieldMap;
    }
    
    /*
*	@methodName = getAllFieldsInNameSpace
*	@return = Set of field Names
*	@params = object name (both custom and standard), namespace
*	@description = Method takes object name as an argument and return all Standard fields
*/
    global static Set<String> getAllFieldsInNameSpace(String objectName,String namespace){
        Map<String, Schema.SObjectType> completeSchema = Schema.getGlobalDescribe(); 
        Schema.SObjectType requiredObject = completeSchema.get(objectName);
        Set<String> requiredFields = new Set<String>(); 
        for(String field : requiredObject.getDescribe().fields.getMap().keySet()){
            if(field.startsWithIgnoreCase(namespace+'__')){
                requiredFields.add(field);
            }
        }
        return requiredFields;
    }
    
    /*
*	@methodName = getAllFieldsInNameSpace
*	@return = Map of object names and their field Names
*	@params = list of object name (both custom and standard), namespace
*	@description = Method takes object name as an argument and return Map of object name and their fields
*/
    global static Map<String, Set<String>> getAllFieldsInNameSpace(List<String> objectNames,String namespace){
        Map<String, Schema.SObjectType> completeSchema = Schema.getGlobalDescribe(); 
        Map<String, Set<String>> objectVsFieldMap = new Map<String, Set<String>>();
        for(String objectName : objectNames){
            Schema.SObjectType requiredObject = completeSchema.get(objectName);
            Set<String> requiredFields = new Set<String>(); 
            for(String field : requiredObject.getDescribe().fields.getMap().keySet()){
                if(field.startsWithIgnoreCase(namespace+'__')){
                    requiredFields.add(field);
                }
            }
            objectVsFieldMap.put(objectName,requiredFields);
        }
        return objectVsFieldMap;
    }
    
    /*
*	@methodName = getAllFieldsOfType
*	@return = Set of field Names
*	@params = object name (both custom and standard), and field type like String,Boolean etc
*	@description = Method takes object name as an argument and return all (both custom and standard) fields of specific type
*/
    global static Set<String> getAllFieldsOfType(String objectName,String fieldType){
        Map<String, Schema.SObjectType> completeSchema = Schema.getGlobalDescribe(); 
        Schema.SObjectType requiredObject = completeSchema.get(objectName);
        Set<String> requiredFields = new Set<String>();
        for(Schema.SObjectField field : requiredObject.getDescribe().fields.getMap().values()){
            Schema.DescribeFieldResult fieldDetails = field.getDescribe();
            Schema.DisplayType fType = fieldDetails.getType();
            if(fType.name().toLowerCase() == fieldType.toLowerCase()){
                requiredFields.add(fieldDetails.getName());
            }
        }
        return requiredFields;
    }
    
    /*
*	@methodName = getAllFieldsOfType
*	@return = Map of object name vs Fields of required type
*	@params = list of object name (both custom and standard), and field type like String,Boolean etc
*	@description = Method takes object name as an argument and return all (both custom and standard) fields of specific type
*/
    global static Map<String, Set<String>> getAllFieldsOfType(List<String> objectNames, String fieldType){
        Map<String, Schema.SObjectType> completeSchema = Schema.getGlobalDescribe(); 
        Map<String, Set<String>> objectVsFieldMap = new Map<String, Set<String>>();
        for(String objectName : objectNames){
            Schema.SObjectType requiredObject = completeSchema.get(objectName);            
            Set<String> requiredFields = new Set<String>();
            for(Schema.SObjectField field : requiredObject.getDescribe().fields.getMap().values()){
                Schema.DescribeFieldResult fieldDetails = field.getDescribe();
                Schema.DisplayType fType = fieldDetails.getType();
                if(fType.name().toLowerCase() == fieldType.toLowerCase()){
                    requiredFields.add(fieldDetails.getName());
                }
                objectVsFieldMap.put(objectName,requiredFields);
            }
        }
        return objectVsFieldMap;
    }
    
    /**************************************************** Object Related Methods****************************************************/
    
    
    /*
*	@methodName = getObjectNameById
*	@return = Object Name
*	@params = Salesforce Id
*	@description = Method takes SF Id and returns Object name
*/
    global static String getObjectNameById(Id objectId){
        return objectId.getSObjectType().getDescribe().getName();
    }
    
    /*
*	@methodName = getObjectNameById
*	@return = Map of Id vs Object Name
*	@params = Set of Salesforce Id
*	@description = Method takes SF Ids and returns Map of Id vs Object name
*/
    global static Map<Id,String> getObjectNameById(Set<Id> objectIds){
        Map<Id,String> objectIdVsName = new Map<Id,String>();
        for(Id objectId : objectIds){
            objectIdVsName.put(objectId,objectId.getSObjectType().getDescribe().getName());
        }
        return objectIdVsName;
    }
    
    /*
*	@methodName = getAllParentOfAnObject
*	@return = List of parent objects
*	@params = object names
*	@description = Method takes object names and returns list of parent object names
*/
    global static List<String> getAllParentOfAnObject(String objectName){
        Map<String, Schema.SObjectType> completeSchema = Schema.getGlobalDescribe(); 
        Schema.SObjectType requiredObject = completeSchema.get(objectName);
        List<String> parentObjectName = new List<String>();
        for(Schema.SobjectField strFld: requiredObject.getDescribe().fields.getMap().Values()){
            if(strFld.getDescribe().getType() == Schema.DisplayType.REFERENCE){
                for(Schema.SObjectType obj : strFld.getDescribe().getReferenceTo()){
                    parentObjectName.add(obj.getDescribe().getName());
                }
            }
        }
        return parentObjectName;
    }
    
    /*
*	@methodName = getAllParentOfAnObject
*	@return = List of parent objects
*	@params = object names
*	@description = Method takes object names and returns Map of object name vs parent object names
*/
    global static Map<String,List<String>> getAllParentOfAnObject(List<String> objectNames){
        Map<String, Schema.SObjectType> completeSchema = Schema.getGlobalDescribe();
        Map<String,List<String>> objectNameVsParentObjectNames = new Map<String,List<String>>();
        for(String objectName : objectNames){
            Schema.SObjectType requiredObject = completeSchema.get(objectName);
            List<String> parentObjectNames = new List<String>();
            for(Schema.SobjectField strFld: requiredObject.getDescribe().fields.getMap().Values()){
                if(strFld.getDescribe().getType() == Schema.DisplayType.REFERENCE){
                    for(Schema.SObjectType obj : strFld.getDescribe().getReferenceTo()){
                        parentObjectNames.add(obj.getDescribe().getName());
                    }
                }
            }
            objectNameVsParentObjectNames.put(objectName,parentObjectNames);
        }
        return objectNameVsParentObjectNames;
    }
    
    /*
*	@methodName = getAllChildrenOfAnObject
*	@return = List of parent objects
*	@params = object names
*	@description = Method takes object names and returns list of child object names
*/
    global static List<String> getAllChildrenOfAnObject(String objectName){
        Map<String, Schema.SObjectType> completeSchema = Schema.getGlobalDescribe(); 
        Schema.SObjectType requiredObject = completeSchema.get(objectName);
        List<String> childObjectName = new List<String>();
        Schema.DescribeSObjectResult result = requiredObject.getDescribe();
        for (Schema.ChildRelationship cr: result.getChildRelationships()) {
            childObjectName.add(cr.getChildSObject().getDescribe().getName());
        }
        return childObjectName;
    }
    
    /*
*	@methodName = getAllChildrenOfAnObject
*	@return = List of parent objects
*	@params = object names
*	@description = Method takes object names and returns Map of object name vs parent object names
*/
    global static Map<String,List<String>> getAllChildrenOfAnObject(List<String> objectNames){
        Map<String, Schema.SObjectType> completeSchema = Schema.getGlobalDescribe();
        Map<String,List<String>> objectNameVsChildObjectNames = new Map<String,List<String>>();
        for(String objectName : objectNames){
            Schema.SObjectType requiredObject = completeSchema.get(objectName);
            Schema.DescribeSObjectResult result = requiredObject.getDescribe();
            List<String> childObjectNames = new List<String>();
            for (Schema.ChildRelationship cr: result.getChildRelationships()) {
                childObjectNames.add(cr.getChildSObject().getDescribe().getName());
            }
            objectNameVsChildObjectNames.put(objectName,childObjectNames);
        }
        return objectNameVsChildObjectNames;
    }
    
    
}
