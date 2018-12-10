//
//  BaseModel.h
//  llgj
//
//  Created by xcy on 14-10-8.
//  Copyright (c) 2014年 徐长远. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DSBaseModel : NSObject

@property (nonatomic, assign) BOOL isDataIsNull;//
@property (nonatomic, assign) BOOL isResult;//

@property(nonatomic,retain)NSNumber * errorCode;//错误代码
@property(nonatomic,copy)NSString * userErrorInfo;//错误信息（用户）
@property(nonatomic,copy)NSString * devErrorInfo;//错误信息 (开发者)
@property(nonatomic,strong)NSMutableDictionary * modelToDic;


/**
 *  @description:将NSDictionary转换为model
 *  @parameter:nil
 *  @return:nil
 */
@property(nonatomic,retain)NSDictionary *dic;

/**
 *  @description:打印对象所有属性
 *  @parameter:nil
 *  @return:nil
 */
-(void)showObjInfo;

/**
 *  @description:拼接所有的属性
 *  @parameter:nil
 *  @return:nil
 */
-(NSString *)getAll;

/**
 *  @description:将对象转换为字典
 *  @parameter:nil
 *  @return:nil
 */
-(NSMutableDictionary *)objToDictionary;

/**
 *  @description:将对象转换为json
 *  @parameter:nil
 *  @return:nil
 */
-(NSString *)objToJson:(id)obj;

/*
 *  @description:模型和字典不匹配的KEY
 *  @parameter:nil
 *  @return:nil
 */
- (NSDictionary *)modelKeyJSONKeyMapper;

+(NSMutableDictionary *)multipleObjToDictionary:(DSBaseModel *)baseClass;
/*
 *  @description:使用字典出事化模型
 *  @parameter:数据字典
 *  @return:self
 */
- (instancetype)initWithJSONDict:(id)dict;
@end
