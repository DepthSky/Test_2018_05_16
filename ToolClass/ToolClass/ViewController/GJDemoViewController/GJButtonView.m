//
//  GJButtonView.m
//  ToolClass
//
//  Created by shinyv on 2018/8/7.
//  Copyright © 2018年 MrZhang. All rights reserved.
//

#import "GJButtonView.h"
#import "XLXButton.h"
#import "UIButton+LZCategory.h"

@implementation GJButtonView

-(instancetype)init
{
    self = [super init];
    if(!self) return nil;
    
    XLXButton * btn = [XLXButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 150, 100, 80);
    [btn setTitle:@"我在测试" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"test3"] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor blueColor];
    btn.xlx_customSpace = 5;
    btn.xlx_customstyle = XLXButtonCustomStylePicTop;
    [btn addTarget:self action:@selector(testClicker:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    
//    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self);
//        make.centerY.equalTo(self).offset(150);
//    }];
    
    UIButton * testBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [testBtn setTitle:@"我在测试2" forState:UIControlStateNormal];
    testBtn.frame = CGRectMake(100, 250, 100, 60);
    [testBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [testBtn setImage:[UIImage imageNamed:@"test3"] forState:UIControlStateNormal];
    testBtn.backgroundColor = [UIColor blueColor];
    [testBtn addTarget:self action:@selector(testClicker:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:testBtn];
//    [testBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(self);
//    }];
    [testBtn setbuttonType:LZCategoryTypeBottom ];

    return self;
}

-(void)testClicker:(UIButton *)sender
{
    NSLog(@"我点击了，我再测试");
}
@end
