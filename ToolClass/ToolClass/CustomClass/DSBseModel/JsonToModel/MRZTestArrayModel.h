//
//  MRZTestArrayModel.h
//  ToolClass
//
//  Created by shinyv on 2018/7/10.
//  Copyright © 2018年 MrZhang. All rights reserved.
//

#import "DSBaseModel.h"

@protocol MRZTestShowPropertyModel <NSObject>
@end
@interface MRZTestShowPropertyModel : DSBaseModel
@property(nonatomic,copy)NSString * picture;
@property(nonatomic,copy)NSString * pName;
@property(nonatomic,copy)NSString * guest;
@property(nonatomic,assign)NSInteger uid;
@property(nonatomic,assign)NSInteger loveId;
@property(nonatomic,assign)NSInteger periods;
@property(nonatomic,assign)NSInteger createAt;
@property(nonatomic,assign)NSInteger pid;
@property(nonatomic,assign)NSInteger listenCount;
@end

@interface MRZTestArrayModel : DSBaseModel
@property(nonatomic,assign)NSInteger listenCount;

@property(nonatomic,strong)NSMutableArray <MRZTestShowPropertyModel>* testArr;
@end
