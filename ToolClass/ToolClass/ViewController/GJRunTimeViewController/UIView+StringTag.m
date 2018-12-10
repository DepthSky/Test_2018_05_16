//
//  UIView+StringTag.m
//  ToolClass
//
//  Created by shinyv on 2018/8/7.
//  Copyright © 2018年 MrZhang. All rights reserved.
//

#import "UIView+StringTag.h"
#import <objc/runtime.h>

static char * const tagChar = "tagChar";

@implementation UIView (StringTag)

//替换view背景颜色(包括其子类) -Adopt
/*
+(void)load
{
    
    Class class = [self class];
    Method origMethod = class_getInstanceMethod(class, @selector(setBackgroundColor:));
    Method swizzMethod = class_getInstanceMethod(class, @selector(my_backgroundColor:));
    
    method_exchangeImplementations(origMethod, swizzMethod);
    
}

-(void)my_backgroundColor:(UIColor *)color
{
    NSLog(@"-----%s----",__FUNCTION__);
    [self my_backgroundColor:[UIColor orangeColor]];
}
*/

//为view及子类关联属性 -Adopt
-(void)setTagString:(NSString *)string
{
    objc_setAssociatedObject(self, tagChar, string, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(NSString *)tagString
{
    return objc_getAssociatedObject(self, tagChar);
}
@end
