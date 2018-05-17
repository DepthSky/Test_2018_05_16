//
//  CustomScrollView.m
//  AudioTest
//
//  Created by shinyv on 2018/5/16.
//  Copyright © 2018年 shinyv. All rights reserved.
//

#import "CustomScrollView.h"
#import "UIImageView+WebCache.h"

#define DefaultImage @"2_1DefaultPic@2x"
#define kNumberOfImageView 3
#define kDefaultContentPffset 1

@interface CustomScrollView ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView *theScrollView;

@property(nonatomic,strong)UIView *bottomView;
@property(nonatomic,strong)UIView *gradientView;
@property(nonatomic,strong)CAGradientLayer *gradientLayer;
@property(nonatomic,strong)UILabel *descTextLabel;

@property(nonatomic,strong)UIPageControl *thePageControl;

@property(nonatomic,strong)UIImageView *imgViewLeft;
@property(nonatomic,strong)UIImageView *imgViewCenter;
@property(nonatomic,strong)UIImageView *imgViewRight;

@property(nonatomic,copy)NSArray *imagesArr;
@property(nonatomic,copy)NSArray *descTextArr;

@property(nonatomic,assign)NSInteger theCurrentPage;

@property(nonatomic,strong)NSTimer *scrollTimer;
@end

@implementation CustomScrollView

-(instancetype)initWithImageArr:(NSArray *)imageArr descTextArr:(NSArray *)descTextArr
{
    self = [super init];
    if(self)
    {
        _imagesArr = imageArr;
        _descTextArr = descTextArr;
        
        self.autoScrollTimeInterval = 5.0f;
        self.enableAutoScroll = YES;
        self.scrollViewSelectType = CustomScrollViewSelecttionTypeTap;
        self.scrollPageControlPositionType = ScrollPageControlPositionTypeRight;
        
        [self initCustomScrolViewUI];
        
    }
    return self;
}


#pragma mark - UI
//创建UI
-(void)initCustomScrolViewUI
{
    _theScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    _theScrollView.pagingEnabled = YES;
    _theScrollView.delegate = self;
    [self addSubview:_theScrollView];
    
    [self initImageViews];
    
    _bottomView = [[UIView alloc]init];
    _bottomView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    [self addSubview:_bottomView];
    
   // _gradientLayer.frame = _bottomView.bounds;
   // _gradientView.frame = _gradientLayer.bounds;
    
    _thePageControl = [[UIPageControl alloc]init];
    _thePageControl.numberOfPages = _imagesArr.count;
//  放弃  [_thePageControl addTarget:self action:@selector(selectPageScrollEvent:) forControlEvents:UIControlEventValueChanged];
    [_bottomView addSubview:_thePageControl];
    
    _descTextLabel = [[UILabel alloc]init];
    _descTextLabel.font = [UIFont systemFontOfSize:14];
    _descTextLabel.textColor = [UIColor whiteColor];
    [_bottomView addSubview:_descTextLabel];
}

//默认三个imageView
-(void)initImageViews
{
    NSString * left = _imagesArr[(_imagesArr.count - 1) % _imagesArr.count];
    NSString * center = _imagesArr[0 % _imagesArr.count];
    NSString * right = _imagesArr[1 % _imagesArr.count];
    UIImage * defaultImage  = [UIImage imageNamed:DefaultImage];
    
    _imgViewLeft = [[UIImageView alloc]init];
    [_imgViewLeft sd_setImageWithURL:[NSURL URLWithString:left] placeholderImage:defaultImage];
    _imgViewLeft.userInteractionEnabled = YES;
    [_imgViewLeft addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(scrollViewContentTap:)]];
    
    _imgViewCenter = [[UIImageView alloc]init];
    [_imgViewCenter sd_setImageWithURL:[NSURL URLWithString:center] placeholderImage:defaultImage];
    _imgViewCenter.userInteractionEnabled = YES;
    [_imgViewCenter addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(scrollViewContentTap:)]];
    
    _imgViewRight = [[UIImageView alloc]init];
    [_imgViewRight sd_setImageWithURL:[NSURL URLWithString:right] placeholderImage:defaultImage];
     _imgViewRight.userInteractionEnabled = YES;
    [_imgViewRight addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(scrollViewContentTap:)]];
    
    [_theScrollView addSubview:_imgViewLeft];
    [_theScrollView addSubview:_imgViewCenter];
    [_theScrollView addSubview:_imgViewRight];
    
    return;
}
//布局
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    _theScrollView.frame = self.bounds;
    
    CGFloat width = _theScrollView.bounds.size.width;
    CGFloat height = _theScrollView.bounds.size.height;
    
    _imgViewLeft.frame = CGRectMake(0, 0, width,height);
    _imgViewCenter.frame = CGRectMake(width, 0, width, height);
    _imgViewRight.frame = CGRectMake(width * 2, 0, width, height);
    
    if((_imagesArr.count == 1 && _canScrollWhenSingle == YES) || _imagesArr.count > 1)
    {
        _theScrollView.contentSize = CGSizeMake(kNumberOfImageView *width, 0);
        _theScrollView.contentOffset = CGPointMake(width, 0);
    }
    else
    {
        _theScrollView.contentSize = CGSizeZero;
    }
    
    
    _bottomView.frame = CGRectMake(0, height-30.0f, width, 30.0f);
    
//    _gradientLayer.frame = _bottomView.bounds;
//    _gradientView.frame = _gradientLayer.bounds;
    
    CGSize size = [_thePageControl sizeForNumberOfPages:_imagesArr.count];
    
    if(_pageIndicatorTintColor && _pageIndicatorTintColor != nil)
    {
        _thePageControl.pageIndicatorTintColor = _pageIndicatorTintColor;
    }
    if(_currentPageIndicatorTintColor && _currentPageIndicatorTintColor != nil)
    {
        _thePageControl.currentPageIndicatorTintColor = _currentPageIndicatorTintColor;
    }
    
    CGRect rectPageControl;
    CGRect rectDescText;
    CGFloat pageCtlWidth = size.width + 5;
    CGFloat pageCtlHeight = _bottomView.bounds.size.height;
    if(_scrollPageControlPositionType == ScrollPageControlPositionTypeRight)
    {
        rectPageControl = CGRectMake(_bottomView.bounds.size.width - size.width - 15.0f, 0, pageCtlWidth, pageCtlHeight);
        rectDescText = CGRectMake(15.0f, 0, rectPageControl.origin.x - 20, _bottomView.bounds.size.height);
        
        _descTextLabel.text = [_descTextArr firstObject];
    }
    else if (_scrollPageControlPositionType == ScrollPageControlPositionTypeCenter)
    {
        rectPageControl = CGRectMake((_bottomView.bounds.size.width - pageCtlWidth )/2, 0, pageCtlWidth, pageCtlHeight);
        rectDescText = CGRectMake(0, 0, 0, 0);
    }
    else
    {
        rectPageControl = CGRectMake(15, 0, pageCtlWidth, pageCtlHeight);
        rectDescText = CGRectMake(CGRectGetMaxX(rectPageControl)+5, 0, _bottomView.bounds.size.width-CGRectGetMaxX(rectPageControl)-15, _bottomView.bounds.size.height);
        
        _descTextLabel.textAlignment = NSTextAlignmentRight;
    }
    _thePageControl.frame = rectPageControl;
    
    _descTextLabel.frame = rectDescText;
    
    return;
}

#pragma mark - Event Handle
//滚动后重设数据，位置
-(void)calcimageWithScrollView:(UIScrollView *)scrollView
{
    int contentOffset = scrollView.contentOffset.x / scrollView.bounds.size.width;
    if(contentOffset == kDefaultContentPffset)
        return;
    
    _theCurrentPage += contentOffset - kDefaultContentPffset + _imagesArr.count;
    _thePageControl.currentPage = _theCurrentPage % _imagesArr.count;
    
    NSString * centerImgName =(NSString *)[_imagesArr objectAtIndex:(_theCurrentPage % _imagesArr.count)];
    [_imgViewCenter sd_setImageWithURL:[NSURL URLWithString:centerImgName] placeholderImage:[UIImage imageNamed:DefaultImage]];
    if(_scrollPageControlPositionType != ScrollPageControlPositionTypeCenter)
    {
        NSString * centerDescText = (NSString *)[_descTextArr objectAtIndex:_theCurrentPage % _descTextArr.count];
        _descTextLabel.text = centerDescText;
    }
    

    //同时更新左右image效果更好
//    if(contentOffset == 0)
//    {
        NSString * leftImgName = (NSString *)[_imagesArr objectAtIndex:(_theCurrentPage - 1) % _thePageControl.numberOfPages];
        [_imgViewLeft sd_setImageWithURL:[NSURL URLWithString:leftImgName] placeholderImage:[UIImage imageNamed:DefaultImage]];
//    }
//    else
//    {
        NSString * rightImgName = (NSString *)[_imagesArr objectAtIndex:(_theCurrentPage + 1) % _thePageControl.numberOfPages];
        [_imgViewRight sd_setImageWithURL:[NSURL URLWithString:rightImgName] placeholderImage:[UIImage imageNamed:DefaultImage]];
//    }
    [scrollView setContentOffset:CGPointMake(scrollView.bounds.size.width, 0)];
    
    return;
}

//定时器事件
-(void)scrollTimerEvent
{
    CGPoint point = CGPointMake(_theScrollView.bounds.size.width*2, 0);
    [_theScrollView setContentOffset:point animated:YES];
}

//点击内容事件
-(void)scrollViewContentTap:(UITapGestureRecognizer *)tap
{
    if(_scrollViewSelectType == CustomScrollViewSelecttionTypeTap)
    {
        if(_delegate && [_delegate respondsToSelector:@selector(scrollViewSelectContentIndex:)])
        {
            [_delegate scrollViewSelectContentIndex:_thePageControl.currentPage];
        }
    }
    else
    {
        //什么都不做
    }
    return;
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if(_scrollTimer && _scrollTimer.valid)
    {
        [_scrollTimer setFireDate:[NSDate distantFuture]];
    }
    return;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self calcimageWithScrollView:scrollView];

    if(_scrollTimer && _scrollTimer.valid)
    {
        [_scrollTimer setFireDate:[NSDate dateWithTimeIntervalSinceNow:_autoScrollTimeInterval]];
    }
    return;
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self calcimageWithScrollView:scrollView];
    return;
}

#pragma mark - Set&Get
//设置scrollview是否可以滚动，默认YES
-(void)setEnableAutoScroll:(BOOL)enableAutoScroll
{
    _enableAutoScroll = enableAutoScroll;
    
    if(_enableAutoScroll)
    {
        if(_scrollTimer != nil && _scrollTimer.valid)
        {
            [_scrollTimer setFireDate:[NSDate dateWithTimeIntervalSinceNow:_autoScrollTimeInterval]];
        }
        else
        {
            _scrollTimer = [NSTimer timerWithTimeInterval:_autoScrollTimeInterval target:self selector:@selector(scrollTimerEvent) userInfo:nil repeats:YES];
            [[NSRunLoop currentRunLoop]addTimer:_scrollTimer forMode:NSDefaultRunLoopMode];
        }
    }
    else
    {
        if(_scrollTimer != nil)
        {
            [_scrollTimer invalidate];
            _scrollTimer = nil;
        }
    }
    return;
}

//设置滚动间隔时长，默认5.0
-(void)setAutoScrollTimeInterval:(CGFloat)autoScrollTimeInterval
{
    _autoScrollTimeInterval = autoScrollTimeInterval;
    if(_enableAutoScroll)
    {
        if(_scrollTimer)
        {
            [_scrollTimer invalidate];
            _scrollTimer = [NSTimer scheduledTimerWithTimeInterval:_autoScrollTimeInterval target:self selector:@selector(scrollTimerEvent) userInfo:nil repeats:YES];
            [[NSRunLoop currentRunLoop] addTimer:_scrollTimer forMode:NSDefaultRunLoopMode];
        }
    }
    
    return;
}

-(void)dealloc
{
    if(_scrollTimer)
    {
        [_scrollTimer invalidate];
        _scrollTimer = nil;
    }
    
}

#pragma mark - Deprecated
-(void)selectPageScrollEvent:(UIPageControl *)pageControl
{
   // NSLog(@"----%d",pageControl.currentPage);
}

//-(void)setCanScrollWhenSingle:(BOOL)canScrollWhenSingle
//{
//    _canScrollWhenSingle = canScrollWhenSingle;
//
//    if(_canScrollWhenSingle == NO)
//    {
//        if()
//    }
//}

@end

