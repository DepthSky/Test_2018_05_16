//
//	TestModel.h
//
//	Create by shinyv on 27/7/2018
//	Copyright © 2018. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>

@interface TestModel : NSObject

@property (nonatomic, strong) NSString * label;
@property (nonatomic, strong) NSString * mark;
@property (nonatomic, strong) NSString * title;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end