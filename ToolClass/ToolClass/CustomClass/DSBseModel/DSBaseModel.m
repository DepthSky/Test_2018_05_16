//
//  BaseModel.m
//  llgj
//
//  Created by xcy on 14-10-8.
//  Copyright (c) 2014年 徐长远. All rights reserved.
//

#import "DSBaseModel.h"
#import <objc/runtime.h>
#import "DSFetchModelProperty.h"

static const char *QSFecthModelKeyMapperKey;
static const char *QSFetchModelPropertiesKey;


#pragma mark - NSArray+QSFetchModel

@interface NSArray (QSFetchModel)

- (NSArray *)modelArrayWithClass:(Class)modelClass;

@end

@implementation NSArray (QSFetchModel)

- (NSArray *)modelArrayWithClass:(Class)modelClass{
    NSMutableArray *modelArray = [NSMutableArray array];
    for (id object in self) {
        if ([object isKindOfClass:[NSArray class]]) {
            [modelArray addObject:[object modelArrayWithClass:modelClass]];
        } else if ([object isKindOfClass:[NSDictionary class]]){
            [modelArray addObject:[[modelClass alloc] initWithJSONDict:object]];
        } else {
            [modelArray addObject:object];
        }
    }
    return modelArray;
}
@end

#pragma mark - NSDictionary+QSFetchModel

@interface NSDictionary (QSFetchModel)

- (NSDictionary *)modelDictionaryWithClass:(Class)modelClass;

@end

@implementation NSDictionary (QSFetchModel)

- (NSDictionary *)modelDictionaryWithClass:(Class)modelClass{
    NSMutableDictionary *modelDictionary = [NSMutableDictionary dictionary];
    for (NSString *key in self) {
        id object = [self objectForKey:key];
        if ([object isKindOfClass:[NSDictionary class]]) {
            [modelDictionary setObject:[[modelClass alloc] initWithJSONDict:object] forKey:key];
        }else if ([object isKindOfClass:[NSArray class]]){
            [modelDictionary setObject:[object modelArrayWithClass:modelClass] forKey:key];
        }else{
            [modelDictionary setObject:object forKey:key];
        }
    }
    return modelDictionary;
}
- (NSDictionary *)modelToDictionaryWithClass:(Class)modelClass{
    NSMutableDictionary *modelDictionary = [NSMutableDictionary dictionary];
    for (NSString *key in self) {
        id object = [self objectForKey:key];
        if ([object isKindOfClass:[NSDictionary class]]) {
            [modelDictionary setObject:[[modelClass alloc] initWithJSONDict:object] forKey:key];
        }else if ([object isKindOfClass:[NSArray class]]){
            [modelDictionary setObject:[object modelArrayWithClass:modelClass] forKey:key];
        }else{
            [modelDictionary setObject:object forKey:key];
        }
    }
    return modelDictionary;
}

@end

@interface DSBaseModel ()
- (void)setupCachedKeyMapper;
- (void)setupCachedProperties;
@end

@implementation DSBaseModel

/**
 初始化

 @return self
 */
- (instancetype)init{
    
    self = [super init];
    if (self) {
        
        [self setupCachedKeyMapper];
        [self setupCachedProperties];
    }
    return self;
}


/**
 c初始化对象

 @param dict 请求数据
 @return self
 */
- (instancetype)initWithJSONDict:(id)dict{
    
    self = [self init];
    if (self) {
        
        [self injectJSONData:dict];
    }
    return self;
}


/**
 关联映射的冲突字段
 */
- (void)setupCachedKeyMapper{
    
    if (objc_getAssociatedObject(self.class, &QSFecthModelKeyMapperKey) == nil) {
        
        NSDictionary *dict = [self modelKeyJSONKeyMapper];
        if (dict.count) {
            objc_setAssociatedObject(self.class, &QSFecthModelKeyMapperKey, dict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
}


/**
 关联类中属性详细信息
 */
- (void)setupCachedProperties{
    if (objc_getAssociatedObject(self.class, &QSFetchModelPropertiesKey) == nil) {
        
        NSMutableDictionary *propertyMap = [NSMutableDictionary dictionary];
        Class class = [self class];
        
        while (class != [DSBaseModel class]) {
            unsigned int propertyCount;
            //获取所有属性
            objc_property_t *properties = class_copyPropertyList(class, &propertyCount);
            for (unsigned int i = 0; i < propertyCount; i++) {
                
                objc_property_t property = properties[i];
                //属性名
                const char *propertyName = property_getName(property);
                NSString *name = [NSString stringWithUTF8String:propertyName];
                //属性类型 model：T@"NSMutableArray<MRZTestShowPropertyModel>",&,N,V_testArr

                const char *propertyAttrs = property_getAttributes(property);
                NSString *typeString = [NSString stringWithUTF8String:propertyAttrs];
                DSFetchModelProperty *modelProperty = [[DSFetchModelProperty alloc] initWithName:name typeString:typeString];
                if (!modelProperty.isReadonly) {
                    [propertyMap setValue:modelProperty forKey:modelProperty.name];
                }
            }
            free(properties);
            
            class = [class superclass];
        }
        objc_setAssociatedObject(self.class, &QSFetchModelPropertiesKey, propertyMap, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

//-(void)dicFirstParse:(NSDictionary *)dic{
//    // 重置相关字段为默认值
//    self.isDataIsNull = NO;
//    self.isResult = NO;
//    
//    self.errorCode = [dic objectForKey:@"code"];
//    self.devErrorInfo = [dic objectForKey:@"error"];
//    self.userErrorInfo = [dic objectForKey:@"msg"];
//    id data = [dic objectForKey:@"data"];
//    
//    if (self.errorCode.integerValue == 200) {
//        
//        if ([data isKindOfClass:[NSArray class]] || [data isKindOfClass:[NSDictionary class]]) {
//            self.isResult = YES;
//            [self injectJSONData:data];
//        }else if ([data isKindOfClass:[NSNull class]]) {
//            self.isDataIsNull = YES;
//        }else if ([data isKindOfClass:[NSNumber class]]) {
//            
//            if ([NSStringFromClass([data class]) hasSuffix:@"CFBoolean"]) {
//                self.isResult = [data boolValue];
//            }
//        }
//    }
//}

/**
 json转model

 @param dataObject 数据
 */
- (void)injectJSONData:(id)dataObject{
    
    NSDictionary *keyMapper = objc_getAssociatedObject(self.class, &QSFecthModelKeyMapperKey);
    NSDictionary *properties = objc_getAssociatedObject(self.class, &QSFetchModelPropertiesKey);
    
    if ([dataObject isKindOfClass:[NSArray class]]) {
        
        DSFetchModelProperty *arrayProperty = nil;
        Class class = NULL;
        for (DSFetchModelProperty *property in [properties allValues]) {
            
            NSString *valueProtocol = [property.objectProtocols firstObject];
            class = NSClassFromString(valueProtocol);
            if ([valueProtocol isKindOfClass:[NSString class]] && [class isSubclassOfClass:[DSBaseModel class]]) {
                arrayProperty = property;
                break;
            }
        }
        
        if (arrayProperty && class) {
            id value = [(NSArray *)dataObject modelArrayWithClass:class];
            [self setValue:value forKey:arrayProperty.name];
        }
    }else if ([dataObject isKindOfClass:[NSDictionary class]]){
        
        for (DSFetchModelProperty *property in [properties allValues]) {
            
            NSString *jsonKey = property.name;
            NSString *mapperKey = [keyMapper objectForKey:jsonKey];
            jsonKey = mapperKey ?: jsonKey;
            
            id jsonValue = [dataObject objectForKey:jsonKey];
            id propertyValue = [self valueForProperty:property withJSONValue:jsonValue];
            
            if (propertyValue) {
                
                [self setValue:propertyValue forKey:property.name];
            }else{
                
                id resetValue = (property.valueType == QSClassPropertyTypeObject) ? nil : @(0);
                [self setValue:resetValue forKey:property.name];
            }
        }
    }
}
- (id)valueForProperty:(DSFetchModelProperty *)property withJSONValue:(id)value{
    
    id resultValue = value;
    if (value == nil || [value isKindOfClass:[NSNull class]]) {
        resultValue = nil;
    }else{
        if (property.valueType != QSClassPropertyTypeObject)
        {
            
            if ([value isKindOfClass:[NSString class]]) {
                if (property.valueType == QSClassPropertyTypeInt ||
                    property.valueType == QSClassPropertyTypeUnsignedInt||
                    property.valueType == QSClassPropertyTypeShort||
                    property.valueType == QSClassPropertyTypeUnsignedShort) {
                    resultValue = [NSNumber numberWithInt:[(NSString *)value intValue]];
                }
                if (property.valueType == QSClassPropertyTypeLong ||
                    property.valueType == QSClassPropertyTypeUnsignedLong ||
                    property.valueType == QSClassPropertyTypeLongLong ||
                    property.valueType == QSClassPropertyTypeUnsignedLongLong){
                    resultValue = [NSNumber numberWithLongLong:[(NSString *)value longLongValue]];
                }
                if (property.valueType == QSClassPropertyTypeFloat) {
                    resultValue = [NSNumber numberWithFloat:[(NSString *)value floatValue]];
                }
                if (property.valueType == QSClassPropertyTypeDouble) {
                    resultValue = [NSNumber numberWithDouble:[(NSString *)value doubleValue]];
                }
                if (property.valueType == QSClassPropertyTypeChar) {
                    //对于BOOL而言，@encode(BOOL) 为 c 也就是signed char
                    resultValue = [NSNumber numberWithBool:[(NSString *)value boolValue]];
                }
            }
        }else{
            Class valueClass = property.objectClass;
            if ([valueClass isSubclassOfClass:[DSBaseModel class]] &&
                [value isKindOfClass:[NSDictionary class]]) {
                resultValue = [[valueClass alloc] initWithJSONDict:value];
            }
            
            if ([valueClass isSubclassOfClass:[NSString class]] &&
                ![value isKindOfClass:[NSString class]]) {
                resultValue = [NSString stringWithFormat:@"%@",value];
            }
            
            if ([valueClass isSubclassOfClass:[NSNumber class]] &&
                [value isKindOfClass:[NSString class]]) {
                NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
                [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
                resultValue = [numberFormatter numberFromString:value];
            }
            
            NSString *valueProtocol = [property.objectProtocols lastObject];
            if ([valueProtocol isKindOfClass:[NSString class]]) {
                
                Class valueProtocolClass = NSClassFromString(valueProtocol);
                if (valueProtocolClass != nil) {
                    if ([valueProtocolClass isSubclassOfClass:[DSBaseModel class]]) {
                        //array of models
                        if ([value isKindOfClass:[NSArray class]]) {
                            resultValue = [(NSArray *)value modelArrayWithClass:valueProtocolClass];
                        }
                        //dictionary of models
                        if ([value isKindOfClass:[NSDictionary class]]) {
                            resultValue = [(NSDictionary *)value modelDictionaryWithClass:valueProtocolClass];
                        }
                    }
                }
            }
        }
    }
    return resultValue;
}

- (NSDictionary *)modelKeyJSONKeyMapper{
    return @{};
}


-(void)showObjInfo{
    unsigned int propertyCount = 0;
    objc_property_t *propertyList = class_copyPropertyList([self class], &propertyCount);
    for (int i = 0; i < propertyCount; i++ ) {
        objc_property_t *thisProperty = propertyList + i;
        NSString *propertyName = [NSString stringWithUTF8String:property_getName(*thisProperty)];
        id propertyValue = [self valueForKey:propertyName];
//        if ([QSTool isEmpty:propertyValue]) {
//            continue;
//        }
        
        NSLog(@"%@-%@",propertyName,propertyValue);
    }
}
-(NSString *)getAll{
    unsigned int propertyCount = 0;
    objc_property_t *propertyList = class_copyPropertyList([self class], &propertyCount);
    NSString *s = nil;
    for (int i = 0; i < propertyCount; i++ ) {
        objc_property_t *thisProperty = propertyList + i;
        NSString *propertyName = [NSString stringWithUTF8String:property_getName(*thisProperty)];
        id propertyValue = [self valueForKey:propertyName];
        NSLog(@"%@-%@",propertyName,propertyValue);
        if(!s){
            s = [NSString stringWithFormat:@"%@",propertyValue];
        }else{
            s = [NSString stringWithFormat:@"%@%@",s,propertyValue];
        }
    }
    return s;
}
-(NSMutableDictionary *)objToDictionary{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    unsigned int propertyCount = 0;
    objc_property_t *propertyList = class_copyPropertyList([self class], &propertyCount);
    for (int i = 0; i < propertyCount; i++ ) {
        objc_property_t *thisProperty = propertyList + i;
        NSString *propertyName = [NSString stringWithUTF8String:property_getName(*thisProperty)];
        id propertyValue = [self valueForKey:propertyName];
        if (propertyValue) {
            [dic setObject:propertyValue forKey:propertyName];
        }
        
    }
    return dic;
}
+(NSMutableDictionary *)multipleObjToDictionary:(DSBaseModel *)baseClass
{
    NSLog(@"class:%@,%@",[baseClass class],baseClass);
    NSMutableDictionary * propertyDic = [DSBaseModel getPropertyDic:[baseClass class]];
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    for(DSFetchModelProperty * property in [propertyDic allValues])
    {
        if (property.valueType != QSClassPropertyTypeObject)
        {
            id propertyValue = [baseClass valueForKey:property.name];
            if (propertyValue) {
                
                NSDictionary * keyMapperDic = [baseClass modelKeyJSONKeyMapper];
                for(NSString * key in [keyMapperDic allKeys])
                {
                    if([key isEqualToString:property.name])
                    {
                        property.name = @"id";
                        break;
                    }
                }
                [dic setObject:propertyValue forKey:property.name];
            }
            NSLog(@"NSString,int,%@",property.name);
        }
        else
        {
            Class valueClass = property.objectClass;
            
            if([valueClass isSubclassOfClass:[DSBaseModel class]])
            {
                NSLog(@"%@",property.objectClass);
                DSBaseModel * modelClass = [baseClass valueForKey:property.name];
                if(modelClass)
                {
                    NSMutableDictionary * nextdic = [DSBaseModel multipleObjToDictionary:modelClass];
                    [dic setObject:nextdic forKey:property.name];
                }
                NSLog(@"基类,%@",property.name);
            }
            else if ([valueClass isSubclassOfClass:[NSArray class]])
            {
                NSArray * arrayClass = [baseClass valueForKey:property.name];
                NSMutableArray * array = [NSMutableArray array];
                for(DSBaseModel * class in arrayClass)
                {
                    if(class)
                    {
                        NSMutableDictionary * nextdic = [DSBaseModel multipleObjToDictionary:class];
                        [array addObject:nextdic];
                    }
                }
                [dic setObject:array forKey:property.name];
                NSLog(@"数组,%@",property.name);
            }
            else if ([valueClass isSubclassOfClass:[NSString class]])
            {
                id propertyValue = [baseClass valueForKey:property.name];
                if (propertyValue) {
                    NSDictionary * keyMapperDic = [baseClass modelKeyJSONKeyMapper];
                    for(NSString * key in [keyMapperDic allKeys])
                    {
                        if([key isEqualToString:property.name])
                        {
                            property.name = @"description";
                            break;
                        }
                    }

                    [dic setObject:propertyValue forKey:property.name];
                }
                NSLog(@"字符串,%@",property.name);
            }
            //NSLog(@"等于对象");
        }
    }
    return dic;
}
+ (NSMutableDictionary *)getPropertyDic:(Class)classModle
{
    NSMutableDictionary *propertyMap = [NSMutableDictionary dictionary];
   // Class class = [self class];
    
    while (classModle != [DSBaseModel class]) {
        unsigned int propertyCount;
        objc_property_t *properties = class_copyPropertyList(classModle, &propertyCount);
        for (unsigned int i = 0; i < propertyCount; i++) {
            
            objc_property_t property = properties[i];
            const char *propertyName = property_getName(property);
            NSString *name = [NSString stringWithUTF8String:propertyName];
            const char *propertyAttrs = property_getAttributes(property);
            NSString *typeString = [NSString stringWithUTF8String:propertyAttrs];
            DSFetchModelProperty *modelProperty = [[DSFetchModelProperty alloc] initWithName:name typeString:typeString];
            if (!modelProperty.isReadonly) {
                [propertyMap setValue:modelProperty forKey:modelProperty.name];
            }
        }
        free(properties);
        
        classModle = [classModle superclass];
    }
    return propertyMap;
}
-(NSString *)objToJson:(id)obj{
    return nil;
}
-(NSMutableDictionary *)modelToDic
{
    if(!_modelToDic)
    {
        _modelToDic = [NSMutableDictionary dictionary];
    }
    return _modelToDic;
}
@end
