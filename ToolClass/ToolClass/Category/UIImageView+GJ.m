//
//  UIImageView+GJ.m
//  ToolClass
//
//  Created by shinyv on 2018/8/3.
//  Copyright © 2018年 MrZhang. All rights reserved.
//

#import "UIImageView+GJ.h"
#import "UIImage+LXExtension.h"

@implementation UIImageView (GJ)
+ (UIImageView *)imageViewWithImage:(UIImage *)image
                      imageViewSize:(CGSize)imageViewSize
                       cornerRadius:(CGFloat)cornerRadius
{
    if (image && cornerRadius > 0)
    {
        //cornerRadius是相对imageViewSize的圆角，需要转换成image的实际圆角
        CGFloat radis = cornerRadius / MIN(imageViewSize.width, imageViewSize.height) * MIN(image.size.width, image.size.height);
        image = [image roundedWithRadius:radis cornerMask:YKImageRoundedCornerCornerBottomLeft | YKImageRoundedCornerCornerBottomRight | YKImageRoundedCornerCornerTopLeft | YKImageRoundedCornerCornerTopRight];
    }
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    CGRect frame = imageView.frame;
    frame.size = imageViewSize;
    imageView.frame = frame;
    return imageView;
}

+ (UIImageView *)imageViewWithImage:(UIImage *)image
                      imageViewSize:(CGSize)imageViewSize
                       cornerRadius:(CGFloat)cornerRadius
                         horizontal:(CGFloat)horizontal
                           vertical:(CGFloat)vertical
                        shadowColor:(UIColor *)shadowColor
                      shadowOpacity:(float)shadowOpacity
                       shadowRadius:(CGFloat)shadowRadius
{
    UIImageView *imageView = [self imageViewWithImage:image imageViewSize:imageViewSize cornerRadius:cornerRadius];
    imageView.layer.shadowOffset = CGSizeMake(horizontal, vertical);
    imageView.layer.shadowColor = [shadowColor CGColor];
    imageView.layer.shadowOpacity = shadowOpacity;
    imageView.layer.shadowRadius = shadowRadius;
    imageView.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:imageView.bounds
                                                       byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(cornerRadius, cornerRadius)].CGPath;
    return imageView;
}

@end
