//
//  UIViewController+Swizzling.m
//  ToolClass
//
//  Created by shinyv on 2018/8/6.
//  Copyright © 2018年 MrZhang. All rights reserved.
//

#import "UIViewController+Swizzling.h"
#import "NSObject+Swizzling.h"

@implementation UIViewController (Swizzling)

+(void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [UIViewController methodSwizzlingWithOriginalSelector:@selector(viewDidAppear:) bySwizzledSelector:@selector(my_ViewDidAppera:)];
    });
}

-(void)my_ViewDidAppera:(BOOL)animated
{
    [self my_ViewDidAppera:animated];
    NSLog(@"===== %@ viewDidAppear ======",[self class]);
}
@end
