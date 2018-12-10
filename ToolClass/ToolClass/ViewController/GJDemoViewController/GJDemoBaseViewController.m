//
//  GJDemoBaseViewController.m
//  ToolClass
//
//  Created by shinyv on 2018/7/26.
//  Copyright © 2018年 MrZhang. All rights reserved.
//

#import "GJDemoBaseViewController.h"

@interface GJDemoBaseViewController ()

@property(nonatomic,strong)Class viewClass;

@end

@implementation GJDemoBaseViewController
-(instancetype)initWithTitle:(NSString *)title viewClass:(Class)viewClass
{
    self = [super init];
    if(!self) return nil;
    
    self.title = title;
    self.viewClass = viewClass;
    
    return self;
}

-(void)loadView
{
    self.view = [self.viewClass new];
    self.view.backgroundColor = [UIColor whiteColor];
}

#ifdef __IPHONE_7_0
- (UIRectEdge)edgesForExtendedLayout {
    return UIRectEdgeNone;
}
#endif

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
