//
//  UIButton+LZCategory.m
//  LZButtonCategory
//
//  Created by Artron_LQQ on 16/5/5.
//  Copyright © 2016年 Artup. All rights reserved.
//

#import "UIButton+LZCategory.h"

@implementation UIButton (LZCategory)

- (void)setbuttonType:(LZCategoryType)type {
    
    [self layoutIfNeeded];
    CGRect titleFrame = self.titleLabel.frame;
    CGRect imageFrame = self.imageView.frame;
    CGFloat space = titleFrame.origin.x - imageFrame.origin.x - imageFrame.size.width;
    if (type == LZCategoryTypeLeft) {
        [self setImageEdgeInsets:UIEdgeInsetsMake(0,titleFrame.size.width + 5, 0, -(titleFrame.size.width + 5))];
        [self setTitleEdgeInsets:UIEdgeInsetsMake(0, -(titleFrame.origin.x - imageFrame.origin.x), 0, titleFrame.origin.x - imageFrame.origin.x)];

    } else if(type == LZCategoryTypeBottom) {
        
        
        [self setImageEdgeInsets:UIEdgeInsetsMake(0,0, titleFrame.size.height + 10, -(titleFrame.size.width))];
        
        [self setTitleEdgeInsets:UIEdgeInsetsMake(imageFrame.size.height + 10, -(imageFrame.size.width), 0, 0)];
    }else if (type == LZCategoryTypeTitleleft){
         [self setTitleEdgeInsets:UIEdgeInsetsMake(0, -titleFrame.origin.x, 0, titleFrame.origin.x)];
    }else if (type == LZCategoryTypeTitleleftImageRight){
        [self setImageEdgeInsets:UIEdgeInsetsMake(0,self.frame.size.width - imageFrame.origin.x - imageFrame.size.width, 0, 0)];
        [self setTitleEdgeInsets:UIEdgeInsetsMake(0, - (self.frame.size.width - imageFrame.size.width), 0, 0)];
        
    }
}
@end
