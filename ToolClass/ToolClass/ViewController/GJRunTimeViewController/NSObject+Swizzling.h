//
//  NSObject+Swizzling.h
//  ToolClass
//
//  Created by shinyv on 2018/8/6.
//  Copyright © 2018年 MrZhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Swizzling)

+(void)methodSwizzlingWithOriginalSelector:(SEL)originalSelector bySwizzledSelector:(SEL)swizzledSelector;

@end
