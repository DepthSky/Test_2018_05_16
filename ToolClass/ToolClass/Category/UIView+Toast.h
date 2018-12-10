//
//  UIView+Toast.h
//  CloudProduct
//
//  Created by shinyv on 2018/11/13.
//  Copyright © 2018年 zh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Toast)
/**
 *  @brief 通过Tost形式提示信息,2秒自动消失
 *
 *  @param message 提示内容
 *  @param type    提示类型
 */
-(void)toast:(NSString *)message;

/**
 *  @brief   通过Toast形式提示信息，通过block可获取结束事件
 *
 *  @param message    提示内容
 *  @param completion 完成事件
 */
- (void)toast:(NSString *)message completion:(dispatch_block_t)completion;

@end
