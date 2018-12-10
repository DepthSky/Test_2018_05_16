//
//  QSFetchModelProperty.h
//  QuicklyShop
//
//  Created by 梵天 on 14-7-15.
//  Copyright (c) 2014年 com. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 相关知识请参见Runtime文档
 Type Encodings https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtTypeEncodings.html#//apple_ref/doc/uid/TP40008048-CH100-SW1
 Property Type String https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtPropertyIntrospection.html#//apple_ref/doc/uid/TP40008048-CH101-SW6
 */
typedef NS_ENUM(NSUInteger, QSFetchModelPropertyValueType) {
    QSClassPropertyValueTypeNone = 0,
    QSClassPropertyTypeChar,
    QSClassPropertyTypeInt,
    QSClassPropertyTypeShort,
    QSClassPropertyTypeLong,
    QSClassPropertyTypeLongLong,
    QSClassPropertyTypeUnsignedChar,
    QSClassPropertyTypeUnsignedInt,
    QSClassPropertyTypeUnsignedShort,
    QSClassPropertyTypeUnsignedLong,
    QSClassPropertyTypeUnsignedLongLong,
    QSClassPropertyTypeFloat,
    QSClassPropertyTypeDouble,
    QSClassPropertyTypeBool,
    QSClassPropertyTypeVoid,
    QSClassPropertyTypeCharString,
    QSClassPropertyTypeObject,
    QSClassPropertyTypeClassObject,
    QSClassPropertyTypeSelector,
    QSClassPropertyTypeArray,
    QSClassPropertyTypeStruct,
    QSClassPropertyTypeUnion,
    QSClassPropertyTypeBitField,
    QSClassPropertyTypePointer,
    QSClassPropertyTypeUnknow
};

@interface DSFetchModelProperty : NSObject

@property (nonatomic, copy) NSString *name;//属性名称

@property (nonatomic, assign) QSFetchModelPropertyValueType valueType;//属性类型
@property (nonatomic, copy) NSString *typeName;//属性类型 Model:NSString
@property (nonatomic, assign) Class objectClass;//属性类 Model:NSString
@property (nonatomic, strong) NSArray *objectProtocols;//协议类：<MRZTestShowPropertyModel>
@property (nonatomic, assign) BOOL isReadonly;//是否是只读属性
@property(nonatomic,copy)NSString *errorCode;


/**
 初始化属性

 @param name 属性名称
 @param typeString 待处理属性字符串 Model:T@"NSMutableArray<MRZTestShowPropertyModel>",&,N,V_testArr
 @return id
 */
- (id)initWithName:(NSString *)name typeString:(NSString *)typeString;

@end
