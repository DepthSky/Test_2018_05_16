//
//  UIView+Toast.m
//  CloudProduct
//
//  Created by shinyv on 2018/11/13.
//  Copyright © 2018年 zh. All rights reserved.
//

#import "UIView+Toast.h"
#import "MBProgressHUD.h"

@implementation UIView (Toast)

- (void)toast:(NSString *)message
{
    [self toast:message completion:nil];
}

-(void)toast:(NSString *)message completion:(dispatch_block_t)completion
{
    if (nil == message || [message isEqualToString:@""]) {
        return;
    }
    
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self];
    hud.detailsLabelFont = [UIFont systemFontOfSize:12];
    hud.detailsLabelText = message;
    //hud.yOffset = -80.0f;
    hud.margin = 10;
    hud.removeFromSuperViewOnHide = YES;
    hud.mode = MBProgressHUDModeCustomView;
    [self addSubview:hud];
    [hud show:YES];
    
    double delayInSeconds = 1.5;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [hud hide:YES];
        if (completion) {
            completion();
        }
    });
}
@end
