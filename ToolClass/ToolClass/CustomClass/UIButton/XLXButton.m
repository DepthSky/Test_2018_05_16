//
//  XLXButton.m
//  ToolClass
//
//  Created by shinyv on 2018/7/12.
//  Copyright © 2018年 MrZhang. All rights reserved.
//

#import "XLXButton.h"

@implementation XLXButton

/**
 重新布局button的内容
 */
-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    switch (self.xlx_customstyle) {
        case XLXButtonCustomStylePicTop:
        {
            [self setTitleEdgeInsets:UIEdgeInsetsZero];
            
            [self.titleLabel sizeToFit];
            CGRect labelFrame = self.titleLabel.frame;
            
            [self.imageView sizeToFit];
            CGRect imageFrame = self.imageView.frame;
            
            imageFrame.origin.x = (self.frame.size.width-imageFrame.size.width)*0.5;
            imageFrame.origin.y = (self.frame.size.height-imageFrame.size.height-labelFrame.size.height-self.xlx_customSpace)*0.5;
            self.imageView.frame = imageFrame;
            
            labelFrame.origin.x = (self.frame.size.width-labelFrame.size.width)*0.5;;
            labelFrame.origin.y = imageFrame.origin.y+imageFrame.size.height+self.xlx_customSpace;
            self.titleLabel.frame = labelFrame;
            
            break;
        }
        case XLXButtonCustomStylePicLeft:
        {
            [self.titleLabel sizeToFit];
            CGRect labelFrame = self.titleLabel.frame;
            
            [self.imageView sizeToFit];
            CGRect imageFrame = self.imageView.frame;
            
            imageFrame.origin.x = (self.frame.size.width-imageFrame.size.width-labelFrame.size.width-self.xlx_customSpace)*0.5;
            imageFrame.origin.y = (self.frame.size.height-imageFrame.size.height)*0.5;
            self.imageView.frame = imageFrame;
            
            labelFrame.origin.x = imageFrame.origin.x+imageFrame.size.width+self.xlx_customSpace;
            labelFrame.origin.y = (self.frame.size.height-labelFrame.size.height)*0.5;
            self.titleLabel.frame = labelFrame;
            
            break;
        }
        case XLXButtonCustomStylePicDown:
        {
            [self.titleLabel sizeToFit];
            CGRect labelFrame = self.titleLabel.frame;
            
            [self.imageView sizeToFit];
            CGRect imageFrame = self.imageView.frame;
            
            labelFrame.origin.x = (self.frame.size.width-labelFrame.size.width)*0.5;
            labelFrame.origin.y = (self.frame.size.height-labelFrame.size.height-imageFrame.size.height-self.xlx_customSpace)*0.5;
            self.titleLabel.frame = labelFrame;
            
            imageFrame.origin.x = (self.frame.size.width-imageFrame.size.width)*0.5;
            imageFrame.origin.y = labelFrame.origin.y+labelFrame.size.height+self.xlx_customSpace;
            self.imageView.frame = imageFrame;
            
            break;
        }
        case XLXButtonCustomStylePicRight:
        {
            [self.titleLabel sizeToFit];
            CGRect labelFrame = self.titleLabel.frame;
            
            [self.imageView sizeToFit];
            CGRect imageFrame = self.imageView.frame;
            
            labelFrame.origin.x = (self.frame.size.width-imageFrame.size.width-labelFrame.size.width-self.xlx_customSpace)*0.5;
            labelFrame.origin.y = (self.frame.size.height-labelFrame.size.height)*0.5;
            self.titleLabel.frame = labelFrame;
            
            imageFrame.origin.x = labelFrame.origin.x+labelFrame.size.width+self.xlx_customSpace;
            imageFrame.origin.y = (self.frame.size.height-imageFrame.size.height)*0.5;
            self.imageView.frame = imageFrame;
            
            break;
        }
        default:
            break;
    }
}
@end
