
#import <UIKit/UIKit.h>

// 圆角
typedef NS_ENUM(NSInteger, YKImageRoundedCornerCorner) {
    YKImageRoundedCornerCornerTopLeft = 1,
    YKImageRoundedCornerCornerTopRight = 1 << 1,
    YKImageRoundedCornerCornerBottomRight = 1 << 2,
    YKImageRoundedCornerCornerBottomLeft = 1 << 3
};

@interface UIImage (Extension)
- (instancetype)lx_circleImage;
// 生成一个圆形图片
+ (instancetype)lx_circleImageNamed:(NSString *)name;

// 给定一个不要渲染的图片名称,生成一个最原始的图片
+ (UIImage *)imageWithOriginalImageName:(NSString *)imageName;

// 模糊效果(渲染很耗时间,建议在子线程中渲染)
- (UIImage *)blurImage;
- (UIImage *)blurImageWithMask:(UIImage *)maskImage;
- (UIImage *)blurImageWithRadius:(CGFloat)radius;
- (UIImage *)blurImageAtFrame:(CGRect)frame;

// 灰度效果
- (UIImage *)grayScale;

// 固定宽度与固定高度
- (UIImage *)scaleWithFixedWidth:(CGFloat)width;
- (UIImage *)scaleWithFixedHeight:(CGFloat)height;

// 平均的颜色
- (UIColor *)averageColor;

// 裁剪图片的一部分
- (UIImage *)croppedImageAtFrame:(CGRect)frame;

// 将自身填充到指定的size
- (UIImage *)fillClipSize:(CGSize)size;


/**
 高性能绘圆形图片
 
 @return 圆形图片
 */
- (UIImage *)rounded;

/**
 高性能绘制圆角图片(默认绘制4个圆角)
 
 @param radius 圆角
 @return 圆角图片
 */
- (UIImage *)roundedWithRadius:(CGFloat)radius;

/**
 高性能绘制圆角图片
 
 @param radius 圆角
 @param cornerMask 要绘制的圆角
 @return 圆角图片
 */
- (UIImage *)roundedWithRadius:(CGFloat)radius cornerMask:(YKImageRoundedCornerCorner)cornerMask;

/**
 高性能绘制带圆角图片
 
 @param image 原始图片
 @param imageViewSize UIImageView的size，绘制必须先确定size
 @param cornerRadius 圆角
 @return UIImageView
 */
+ (UIImageView *)imageViewWithImage:(UIImage *)image
                      imageViewSize:(CGSize)imageViewSize
                       cornerRadius:(CGFloat)cornerRadius;

/**
 高性能绘制带圆角+阴影图片
 
 @param image 原始图片
 @param imageViewSize UIImageView的size，绘制必须先确定size
 @param cornerRadius 圆角
 @param horizontal 水平阴影
 @param vertical 垂直阴影
 @param shadowColor 阴影颜色
 @param shadowOpacity shadowOpacity
 @param shadowRadius shadowRadius
 @return UIImageView
 */
+ (UIImageView *)imageViewWithImage:(UIImage *)image
                      imageViewSize:(CGSize)imageViewSize
                       cornerRadius:(CGFloat)cornerRadius
                         horizontal:(CGFloat)horizontal
                           vertical:(CGFloat)vertical
                        shadowColor:(UIColor *)shadowColor
                      shadowOpacity:(float)shadowOpacity
                       shadowRadius:(CGFloat)shadowRadius;

/**
 根据URL获取第一帧图片

 @param videoURL 视频地址
 @return 图片
 */
+(UIImage *)getVideoFrame:(NSURL *)videoURL;


/**
 修正图片方向

 @param aImage 图片
 @return 修正后图片
 */
+(UIImage *)fixOrientation:(UIImage *)aImage;

+ (UIImage *)blurWithOriginalImage:(UIImage *)image blurName:(NSString *)name radius:(NSInteger)radius;

+ (UIImage *)colorControlsWithOriginalImage:(UIImage *)image
                                 saturation:(CGFloat)saturation
                                 brightness:(CGFloat)brightness
                                   contrast:(CGFloat)contrast;

+ (UIVisualEffectView *)effectViewWithFrame:(CGRect)frame;

+ (UIImage *)shotScreen;

+ (UIImage *)shotWithView:(UIView *)view;

+ (UIImage *)shotWithView:(UIView *)view scope:(CGRect)scope;

+ (UIImage *)compressOriginalImage:(UIImage *)image toSize:(CGSize)size;

+ (NSData *)compressOriginalImage:(UIImage *)image toMaxDataSizeKBytes:(CGFloat)size;
@end
