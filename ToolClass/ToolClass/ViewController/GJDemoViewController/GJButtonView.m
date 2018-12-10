//
//  GJButtonView.m
//  ToolClass
//
//  Created by shinyv on 2018/8/7.
//  Copyright © 2018年 MrZhang. All rights reserved.
//

#import "GJButtonView.h"
#import "XLXButton.h"

@implementation GJButtonView

-(instancetype)init
{
    self = [super init];
    if(!self) return nil;
    
    XLXButton * btn = [XLXButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 150, 45, 35);
    [btn setTitle:@"我在测试" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"test2"] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor blueColor];
    btn.xlx_customSpace = 5;
    btn.xlx_customstyle = XLXButtonCustomStylePicTop;
    [btn addTarget:self action:@selector(testClicker:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    
//    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(self);
//    }];
    
    return self;
}

-(void)testClicker:(UIButton *)sender
{
    NSLog(@"我点击了，我再测试");
}
@end
