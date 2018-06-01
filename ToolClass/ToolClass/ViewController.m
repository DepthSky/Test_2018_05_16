//
//  ViewController.m
//  ToolClass
//
//  Created by shinyv on 2018/5/17.
//  Copyright © 2018年 MrZhang. All rights reserved.
//

#import "ViewController.h"
#import "CustomScrollView.h"
#import "UIViewExt.h"
#import "UIColor+Hex.h"

@interface ViewController ()<CustomScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self collectionUI];
    //[self customScollView];
}

#pragma mark - CustomScrollView
-(void)customScollView
{
    /*
     @"zhang_1",@"zhang_2",@"zhang_3",@"zhang_4",@"zhang_5"
     */
    //@[@"0.jpg",@"1.jpg",@"2.jpg"]
    NSArray * imgArray = @[@"http://a.hiphotos.baidu.com/image/pic/item/10dfa9ec8a136327f216788d9d8fa0ec09fac791.jpg",
                           @"http://a.hiphotos.baidu.com/image/pic/item/503d269759ee3d6d453aab8b48166d224e4adef5.jpg",
                           @"http://a.hiphotos.baidu.com/image/pic/item/cf1b9d16fdfaaf519b4aa960875494eef11f7a47.jpg",
                           @"http://a.hiphotos.baidu.com/image/pic/item/503d269759ee3d6d453aab8b48166d224e4adef5.jpg",
                           @"http://a.hiphotos.baidu.com/image/pic/item/cf1b9d16fdfaaf519b4aa960875494eef11f7a47.jpg"];
    CustomScrollView * scrollView = [[CustomScrollView alloc]initWithImageArr:imgArray descTextArr:nil];
//    scrollView.frame = CGRectMake(0, 20, self.view.bounds.size.width, 250);
    scrollView.delegate = self;
    scrollView.scrollPageControlPositionType = ScrollPageControlPositionTypeLeft;
    [self.view addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(20);
        make.left.right.equalTo(self.view);
        make.height.equalTo(@250);
    }];
    
}

-(void)scrollViewSelectContentIndex:(NSInteger)index
{
    NSLog(@"选中的内容index:%d",(int) index);
}

#pragma mark  - UICollectionView
-(void)collectionUI
{
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.itemSize = CGSizeMake(SCREEN_WIDTH/4, SCREEN_WIDTH/4);
    
    UICollectionView * collectionVew = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    collectionVew.dataSource = self;
    collectionVew.delegate = self;
    collectionVew.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:collectionVew];
    
    [collectionVew registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCellID"];
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 5;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCellID" forIndexPath:indexPath];
    cell.contentView.backgroundColor = randomColor;
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Define
-(void)test
{
    UIColor * color = [UIColor colorWithHexString:@"ffffff"];
    
}
@end
