//
//  CustomScrollView.h
//  AudioTest
//
//  Created by shinyv on 2018/5/16.
//  Copyright © 2018年 shinyv. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    CustomScrollViewSelecttionTypeTap = 100, //可点击，默认
    CustomScrollViewSelecttionTypeNone //不可点击
}CustomScrollViewSelectType;

typedef enum
{
    ScrollPageControlPositionTypeLeft = 200, //左，文字右
    ScrollPageControlPositionTypeCenter, //中 无文字显示
    ScrollPageControlPositionTypeRight //右 文字左 ，默认
}ScrollPageControlPositionType;


@protocol CustomScrollViewDelegate <NSObject>

@optional
-(void)scrollViewSelectContentIndex:(NSInteger)index;//选中内容index

@end

@interface CustomScrollView : UIView

@property(nonatomic,assign)BOOL canScrollWhenSingle;//多余
@property(nonatomic,assign)BOOL enableAutoScroll;//设置scrollview是否可以滚动，默认YES
@property(nonatomic,assign)CGFloat autoScrollTimeInterval;//设置滚动间隔时长，默认5.0
@property(nonatomic,assign)CustomScrollViewSelectType scrollViewSelectType;//设置点击类型
@property(nonatomic,assign)ScrollPageControlPositionType  scrollPageControlPositionType;//小点位

@property(nonatomic,strong)UIColor *pageIndicatorTintColor;//小小点默认颜色
@property(nonatomic,strong)UIColor *currentPageIndicatorTintColor;//小点选中颜色

@property(nonatomic,weak)id <CustomScrollViewDelegate> delegate;

-(instancetype)initWithImageArr:(NSArray *)imageArr descTextArr:(NSArray *)descTextArr;
@end
