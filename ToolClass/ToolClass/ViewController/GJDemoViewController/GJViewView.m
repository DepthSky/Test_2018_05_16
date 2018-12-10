//
//  GJViewView.m
//  ToolClass
//
//  Created by shinyv on 2018/8/10.
//  Copyright © 2018年 MrZhang. All rights reserved.
//

#import "GJViewView.h"
#import "GJViewTwoView.h"
@implementation GJViewView
-(instancetype)init
{
    self = [super init];
    if(!self) return nil;
    
    [self test3];
    return self;
}

-(void)test1
{
    UIView * view1 = [[UIView alloc]init];
    view1.backgroundColor = [UIColor redColor];
    [self addSubview:view1];
    
    UIView * view2 = [[UIView alloc]init];
    view2.backgroundColor = [UIColor blueColor];
    [self addSubview:view2];
    
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self);
        make.width.equalTo(@30);
        make.height.equalTo(@150);
    }];
    [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view1.mas_bottom).offset(20);
        make.left.equalTo(view1);
        make.width.equalTo(view1).priority(999);
        make.width.mas_lessThanOrEqualTo(50).priority(1000);
        make.height.equalTo(view1);
    }];
    /*
     测试约束优先级：
     View2的width有两条约束，1.view2的宽度等于View1的宽度，优先级低，2.View2的宽度<=50优先度高。
     当View1的高度<=50时，view2的高度和view1相同
     当view1的高度>50时，两条约束发生冲突，通过优先级比较第二条高于第一条，使用第二条约束；
     */
}

-(void)test2
{
    UILabel * label1 = [[UILabel alloc]init];
    label1.text = @"label1";
    label1.backgroundColor = [UIColor redColor];
    [label1 setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    [self addSubview:label1];
    
    UILabel * label2 = [[UILabel alloc]init];
    label2.text = @"label2";
    label2.backgroundColor = [UIColor redColor];
    [label2 setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    [self addSubview:label2];
    
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(150);
        make.left.equalTo(self);
    }];
    
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(150);
        make.left.equalTo(label1.mas_right).offset(10);
        make.right.equalTo(self.mas_right);
    }];
    
}

-(void)test3
{
    GJViewTwoView *intrinsicView1 = [[GJViewTwoView alloc] init];
    intrinsicView1.extendSize = CGSizeMake(100, 100);
    intrinsicView1.backgroundColor = [UIColor greenColor];
    [self addSubview:intrinsicView1];
    [self addConstraints:@[
                                //距离superview上方100点
                                [NSLayoutConstraint constraintWithItem:intrinsicView1 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:100],
                                //距离superview左面10点
                                [NSLayoutConstraint constraintWithItem:intrinsicView1 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:10],
                                ]];
    
    
    GJViewTwoView *intrinsicView2 = [[GJViewTwoView alloc] init];
    intrinsicView2.extendSize = CGSizeMake(100, 30);
    intrinsicView2.backgroundColor = [UIColor redColor];
    [self addSubview:intrinsicView2];
    [self addConstraints:@[
                                //距离superview上方220点
                                [NSLayoutConstraint constraintWithItem:intrinsicView2 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:220],
                                //距离superview左面10点
                                [NSLayoutConstraint constraintWithItem:intrinsicView2 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:10],
                                ]];
    
    [self performSelector:@selector(testInvalidateIntrinsic:) withObject:intrinsicView2 afterDelay:2];
}

-(void) testInvalidateIntrinsic:(GJViewTwoView *)view{
    view.extendSize = CGSizeMake(100, 80);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
