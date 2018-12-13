
#import <UIKit/UIKit.h>

CGPoint CGRectGetCenter(CGRect rect);
CGRect  CGRectMoveToCenter(CGRect rect, CGPoint center);

@interface UIView (Extension)
/**
 *  快速设置控件的位置
 */
@property (nonatomic, assign) CGSize lx_size;
@property (nonatomic, assign) CGFloat lx_width;
@property (nonatomic, assign) CGFloat lx_height;
@property (nonatomic, assign) CGFloat lx_x;
@property (nonatomic, assign) CGFloat lx_y;
@property (nonatomic, assign) CGFloat lx_centerX;
@property (nonatomic, assign) CGFloat lx_centerY;

@property CGPoint origin;
@property CGSize size;

@property (readonly) CGPoint bottomLeft;
@property (readonly) CGPoint bottomRight;
@property (readonly) CGPoint topRight;

@property CGFloat height;
@property CGFloat width;

@property CGFloat top;
@property CGFloat left;

@property CGFloat bottom;
@property CGFloat right;


/**
 *  快速根据xib创建View
 */
+ (instancetype)lx_viewFromXib;

/**
 *  判断self和view是否重叠
 */
- (BOOL)lx_intersectsWithView:(UIView *)view;



- (void) moveBy: (CGPoint) delta;
- (void) scaleBy: (CGFloat) scaleFactor;
- (void) fitInSize: (CGSize) aSize;

/**
 绘制虚线

 @param lineFrame 虚线frame
 @param length 线长
 @param spacing 线间隔
 @param color 线颜色
 @return view
 */
+ (UIView *)createDashedLineWithFrame:(CGRect)lineFrame
                           lineLength:(int)length
                          lineSpacing:(int)spacing
                            lineColor:(UIColor *)color;
@end
