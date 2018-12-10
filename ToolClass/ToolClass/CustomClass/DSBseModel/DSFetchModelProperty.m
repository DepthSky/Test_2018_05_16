//
//  QSFetchModelProperty.m
//  QuicklyShop
//
//  Created by 梵天 on 14-7-15.
//  Copyright (c) 2014年 com. All rights reserved.
//

#import "DSFetchModelProperty.h"

#define TypeIndicator @"T"
#define ReadonlyIndicator @"R"

static NSDictionary *encodedTypesMap = nil;

@implementation DSFetchModelProperty


/**
 根据字符返回对应属性类型（数字）

 @return 返回 Objective-C type encodings 字典
 */
+ (NSDictionary *)encodedTypesMap{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        encodedTypesMap = @{@"c":@1, @"i":@2, @"s":@3, @"l":@4, @"q":@5,
                            @"C":@6, @"I":@7, @"S":@8, @"L":@9, @"Q":@10,
                            @"f":@11,@"d":@12,@"B":@13,@"v":@14,@"*":@15,
                            @"@":@16,@"#":@17,@":":@18,@"[":@19,@"{":@20,
                            @"(":@21,@"b":@22,@"^":@23,@"?":@24};
    });
    return encodedTypesMap;
}

- (id)initWithName:(NSString *)name typeString:(NSString *)typeString{
    self = [super init];
    if (self != nil) {
        self.name = name;
        
        //分割属性字符串
        NSArray *typeStringComponents = [typeString componentsSeparatedByString:@","];
        
        //解析类型信息
        if ([typeStringComponents count] > 0) {
            //类型信息肯定是放在最前面的且以“T”打头 model:T@\"NSMutableArray<MRZTestShowPropertyModel>\"
            NSString *typeInfo = [typeStringComponents objectAtIndex:0];
            
            //扫描字符
            NSScanner *scanner = [NSScanner scannerWithString:typeInfo];
            [scanner scanUpToString:TypeIndicator intoString:NULL];
            [scanner scanString:TypeIndicator intoString:NULL];
            //获取code所在位置 ‘@’
            NSUInteger scanLocation = scanner.scanLocation;
            if ([typeInfo length] > scanLocation) {
                NSString *typeCode = [typeInfo substringWithRange:NSMakeRange(scanLocation, 1)];
                //获取属性类型
                NSNumber *indexNumber = [[self.class encodedTypesMap] objectForKey:typeCode];
                self.valueType = (QSFetchModelPropertyValueType)[indexNumber integerValue];
                
                //当当前的类型为对象的时候，解析出对象对应的类型的相关信息
                //T@"NSArray<QSMyModel>"
                if (self.valueType == QSClassPropertyTypeObject) {
                    scanner.scanLocation += 1;
                    if ([scanner scanString:@"\"" intoString:NULL]) {
                        NSString *objectClassName = nil;
                        //获取定义的属性class model:NSMutableArray
                        [scanner scanCharactersFromSet:[NSCharacterSet alphanumericCharacterSet]
                                            intoString:&objectClassName];
                        self.typeName = objectClassName;//字符串
                        self.objectClass = NSClassFromString(objectClassName);//class
                        
                        //获取协议中的class model:MRZTestShowPropertyModel
                        NSMutableArray *protocols = [NSMutableArray array];
                        while ([scanner scanString:@"<" intoString:NULL]) {
                            NSString* protocolName = nil;
                            [scanner scanUpToString:@">" intoString: &protocolName];
                            if (protocolName != nil) {
                                [protocols addObject:protocolName];
                            }
                            [scanner scanString:@">" intoString:NULL];
                        }
                        if ([protocols count] > 0) {
                            self.objectProtocols = protocols;
                        }
                    }
                }
            }
            
            //检查是否包含只读属性
            if ([typeStringComponents containsObject:ReadonlyIndicator]) {
                self.isReadonly = YES;
            }
        }
    }
    return self;
}

@end
