//
//  ViewController.m
//  ToolClass
//
//  Created by shinyv on 2018/5/17.
//  Copyright © 2018年 MrZhang. All rights reserved.
//

#import "ViewController.h"
#import "MRZUICollectionViewController.h"
#import "MRZUIScrollViewViewcontroller.h"

#import "UIViewExt.h"
#import "UIColor+Hex.h"

#import "DSBaseModel.h"
typedef NS_ENUM(NSUInteger,TestType )
{
    Test1,
    Test2,
};

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)NSMutableArray * dataArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArr = [@[@"MRZUIScrollViewViewcontroller",@"MRZUICollectionViewController",@"MRZJsonToModelViewController",@"MRZQuartzViewController",@"GJDemoListViewController",@"GJRunTimeViewController"]mutableCopy];
    UITableView * tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    tableView.tableFooterView = [UIView new];
    
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    //[self customScollView];
}

#pragma mark - UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    cell.textLabel.text = _dataArr[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * vcName = _dataArr[indexPath.row];
   
    UIViewController * viewControll = [[NSClassFromString(vcName) alloc]init];
    [self.navigationController pushViewController:viewControll animated:YES];
}

-(void)test2
{
    
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initLabel
{
}


#pragma mark - Define
-(void)test
{
    UIColor * color = [UIColor colorWithHexString:@"ffffff"];
    
}
@end
