//
//  NSObject+Swizzling.m
//  ToolClass
//
//  Created by shinyv on 2018/8/6.
//  Copyright © 2018年 MrZhang. All rights reserved.
//

#import "NSObject+Swizzling.h"
#import <objc/runtime.h>
@implementation NSObject (Swizzling)

+(void)methodSwizzlingWithOriginalSelector:(SEL)originalSelector bySwizzledSelector:(SEL)swizzledSelector{
    Class class = [self class];
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzleMethod = class_getInstanceMethod(class, swizzledSelector);
    
    BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    
    if(didAddMethod)
    {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }
    else
    {
        method_exchangeImplementations(originalMethod, swizzleMethod);
    }
}

@end
