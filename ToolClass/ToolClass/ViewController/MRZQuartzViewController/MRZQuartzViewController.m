//
//  MRZQuartzViewController.m
//  ToolClass
//
//  Created by shinyv on 2018/7/19.
//  Copyright © 2018年 MrZhang. All rights reserved.
//

#import "MRZQuartzViewController.h"
#import "FillingView.h"

@interface MRZQuartzViewController ()

@end

@implementation MRZQuartzViewController

-(void)loadView
{
    [super loadView];
    
    self.view = [[FillingView alloc]init];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
