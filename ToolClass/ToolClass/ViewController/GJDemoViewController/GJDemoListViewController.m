//
//  GJDemoViewController.m
//  ToolClass
//
//  Created by shinyv on 2018/7/26.
//  Copyright © 2018年 MrZhang. All rights reserved.
//

#import "GJDemoListViewController.h"
#import "GJDemoBaseViewController.h"

#import "GJLabelView.h"
#import "GJButtonView.h"
#import "GJViewView.h"
static NSString * const GJCellWithIdentifier = @"GJCellWithIdentifier";

@interface GJDemoListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)NSArray * uiDataArr;

@end

@implementation GJDemoListViewController
-(instancetype)init
{
    self = [super init];
    if(!self) return nil;
    
    self.title = @"Demo";
    
    _uiDataArr = @[
                   [[GJDemoBaseViewController alloc]initWithTitle:@"Label" viewClass:GJLabelView.class],
                   [[GJDemoBaseViewController alloc]initWithTitle:@"Button" viewClass:GJButtonView.class],
                   [[GJDemoBaseViewController alloc]initWithTitle:@"View" viewClass:GJViewView.class],
                   ];
    
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:GJCellWithIdentifier];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    [tableView setTableFooterView:[UIView new]];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _uiDataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController * viewController = _uiDataArr[indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:GJCellWithIdentifier forIndexPath:indexPath];
    cell.textLabel.text = viewController.title;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController * viewController = _uiDataArr[indexPath.row];
    [self.navigationController pushViewController:viewController animated:YES];
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
