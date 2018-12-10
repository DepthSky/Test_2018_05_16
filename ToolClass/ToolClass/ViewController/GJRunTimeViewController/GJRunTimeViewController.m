//
//  GJRunTimeViewController.m
//  ToolClass
//
//  Created by shinyv on 2018/8/6.
//  Copyright © 2018年 MrZhang. All rights reserved.
//

#import "GJRunTimeViewController.h"
#import "UIView+StringTag.h"

@interface GJRunTimeViewController ()

@end

@implementation GJRunTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blueColor];
    self.view.tagString = @"123-123";
    
    self.title = self.view.tagString;
    NSLog(@"==== %@ ====",self.view.tagString);
    
    UIView * view1 = [[UIView alloc]init];
    view1.backgroundColor = [UIColor redColor];
    [self.view addSubview:view1];
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    
    UILabel * label1 = [[UILabel alloc]init];
    label1.text = @"123";
    label1.textColor = [UIColor redColor];
    label1.font = [UIFont systemFontOfSize:14];
    label1.textAlignment = NSTextAlignmentLeft;
    label1.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(10, 10));
    }];
//    UIImageView * zangImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@""]];
//    [self];
//    [zangImg mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(view1).offset(0);
//        make.left.equalTo(view1).offset(0);
//        make.bottom.equalTo(view1).offset(0);
//        make.right.equalTo(view1).offset(0);
//    }];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
