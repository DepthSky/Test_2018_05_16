//
//  GJLabelView.m
//  ToolClass
//
//  Created by shinyv on 2018/7/26.
//  Copyright © 2018年 MrZhang. All rights reserved.
//

#import "GJLabelView.h"

@implementation GJLabelView

-(instancetype)init
{
    self = [super init];
    if(!self) return nil;
    
    UILabel * label = [[UILabel alloc]init];
    
    label.text = @"2222222";
    label.textColor = [UIColor redColor];
    label.textAlignment = NSTextAlignmentCenter;
    
    label.font = [UIFont systemFontOfSize:14];
//    label.font = [UIFont boldSystemFontOfSize:14];//加粗
//    label.font = [UIFont italicSystemFontOfSize:14];//斜体
    
    label.numberOfLines = 0;//不限行
    label.lineBreakMode = NSLineBreakByCharWrapping;//换行方式
    
    [self addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
    
    return self;
}

@end
