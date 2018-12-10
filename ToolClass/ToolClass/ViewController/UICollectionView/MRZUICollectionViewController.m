//
//  UICollectionViewController.m
//  ToolClass
//
//  Created by shinyv on 2018/7/9.
//  Copyright © 2018年 MrZhang. All rights reserved.
//

#import "MRZUICollectionViewController.h"
static NSString * const cellId = @"UICollectionViewCellID";
static NSString * const headerId = @"UICollectionElementKindSectionHeaderId";
static NSString * const footerId = @"UICollectionElementKindSectionFooterId";
@interface MRZUICollectionViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    CGFloat cellWidth;
}
@end

@implementation MRZUICollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    cellWidth = (SCREEN_WIDTH-2-3)/4;
    
    [self collectionUI];
    // Do any additional setup after loading the view.
}

#pragma mark  - UICollectionView
-(void)collectionUI
{
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
//    layout.minimumLineSpacing = 0;
//    layout.minimumInteritemSpacing = 0;
//    layout.itemSize = CGSizeMake(width,width);
//    layout.sectionInset = UIEdgeInsetsMake(10, 10, 0, 10)
    ;
    
    UICollectionView * collectionVew = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    collectionVew.dataSource = self;
    collectionVew.delegate = self;
    collectionVew.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:collectionVew];
    
    [collectionVew registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellId];
    [collectionVew registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerId];
    [collectionVew registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerId];
    
    //    [collectionVew registerClass:[UIView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header"];
    //    [collectionVew registerClass:[UIView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"Footer"];
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
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor colorWithRed:((10 * indexPath.row) / 255.0) green:((20 * indexPath.row)/255.0) blue:((30 * indexPath.row)/255.0) alpha:1.0f];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 20)];
    label.textColor = [UIColor redColor];
    label.text = [NSString stringWithFormat:@"%d",(int) indexPath.row];
    
    for (id subView in cell.contentView.subviews) {
        [subView removeFromSuperview];
    }
    [cell.contentView addSubview:label];
    
    // cell.contentView.backgroundColor = randomColor;
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(cellWidth, cellWidth);
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 1.0f;
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 1.0f;
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(1, 1, 1, 1);
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        UICollectionReusableView * headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerId forIndexPath:indexPath];
        if(headView == nil)
        {
            headView = [[UICollectionReusableView alloc]init];
        }
        headView.backgroundColor = [UIColor grayColor];
        return headView;
    }
    else if([kind isEqualToString:UICollectionElementKindSectionFooter])
    {
        UICollectionReusableView * footView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerId forIndexPath:indexPath];
        if(footView == nil)
        {
            footView = [[UICollectionReusableView alloc]init];
        }
        footView.backgroundColor = [UIColor redColor];
        return footView;
    }
    return nil;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(SCREEN_WIDTH, 30);
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake(SCREEN_WIDTH, 15);
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
