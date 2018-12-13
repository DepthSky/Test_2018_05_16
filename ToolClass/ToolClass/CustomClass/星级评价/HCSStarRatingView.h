// HCSStarRatingView.h
//
// Copyright (c) 2015 Hugo Sousa
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

@import UIKit;

typedef BOOL(^HCSStarRatingViewShouldBeginGestureRecognizerBlock)(UIGestureRecognizer *gestureRecognizer);

IB_DESIGNABLE
@interface HCSStarRatingView : UIControl
@property (nonatomic) IBInspectable NSUInteger maximumValue;
@property (nonatomic) IBInspectable CGFloat minimumValue;
@property (nonatomic) IBInspectable CGFloat value;
@property (nonatomic) IBInspectable CGFloat spacing;
@property (nonatomic) IBInspectable BOOL allowsHalfStars;
@property (nonatomic) IBInspectable BOOL accurateHalfStars;
@property (nonatomic) IBInspectable BOOL continuous;

@property (nonatomic) BOOL shouldBecomeFirstResponder;

// Optional: if `nil` method will return `NO`.
@property (nonatomic, copy) HCSStarRatingViewShouldBeginGestureRecognizerBlock shouldBeginGestureRecognizerBlock;

@property (nonatomic, strong) IBInspectable UIColor *starBorderColor;
@property (nonatomic) IBInspectable CGFloat starBorderWidth;

@property (nonatomic, strong) IBInspectable UIColor *emptyStarColor;

@property (nonatomic, strong) IBInspectable UIImage *emptyStarImage;
@property (nonatomic, strong) IBInspectable UIImage *halfStarImage;
@property (nonatomic, strong) IBInspectable UIImage *filledStarImage;
@end

/*Model
 HCSStarRatingView *starRatingView = [HCSStarRatingView new];
 starRatingView.maximumValue = 10;
 starRatingView.minimumValue = 0;
 starRatingView.value = 4;
 starRatingView.tintColor = [UIColor redColor];
 starRatingView.allowsHalfStars = YES;
 starRatingView.emptyStarImage = [[UIImage imageNamed:@"heart-empty"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
 starRatingView.filledStarImage = [[UIImage imageNamed:@"heart-full"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
 [starRatingView addTarget:self action:@selector(didChangeValue:) forControlEvents:UIControlEventValueChanged];
 [self.view addSubview:starRatingView];
 
 // auto layout
 starRatingView.translatesAutoresizingMaskIntoConstraints = NO;
 [[NSLayoutConstraint constraintWithItem:starRatingView
 attribute:NSLayoutAttributeTop
 relatedBy:NSLayoutRelationEqual
 toItem:self.lastRatingTitleLabel
 attribute:NSLayoutAttributeBottom
 multiplier:1.f
 constant:8.f] setActive:YES];
 [[NSLayoutConstraint constraintWithItem:starRatingView
 attribute:NSLayoutAttributeCenterX
 relatedBy:NSLayoutRelationEqual
 toItem:self.view
 attribute:NSLayoutAttributeCenterX
 multiplier:1.f
 constant:0.f] setActive:YES];
 [[NSLayoutConstraint constraintWithItem:starRatingView
 attribute:NSLayoutAttributeWidth
 relatedBy:NSLayoutRelationLessThanOrEqual
 toItem:self.view
 attribute:NSLayoutAttributeWidth
 multiplier:.9f
 constant:0.f] setActive:YES];
 
 */
