//
//  XLXButton.h
//  ToolClass
//
//  Created by shinyv on 2018/7/12.
//  Copyright © 2018年 MrZhang. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 按钮的样式
 
 - XLXButtonCustomStyleNomal:    普通样式
 - XLXButtonCustomStylePicTop:   图片在上文字在下
 - XLXButtonCustomStylePicLeft:  图片在左文字在右
 - XLXButtonCustomStylePicDown:  图片在下文字在上
 - XLXButtonCustomStylePicRight: 图片在右文字在左
 */
typedef NS_ENUM(NSUInteger, XLXButtonCustomStyle) {
    XLXButtonCustomStyleNomal = 0,
    XLXButtonCustomStylePicTop,
    XLXButtonCustomStylePicLeft,
    XLXButtonCustomStylePicDown,
    XLXButtonCustomStylePicRight,
};

@interface XLXButton : UIButton
/**
 自定义样式(nomal为系统原本的样式)
 */
@property (assign, nonatomic) XLXButtonCustomStyle xlx_customstyle;
///自定义间距(nomal下无效)
@property (assign, nonatomic) CGFloat xlx_customSpace;
@end
