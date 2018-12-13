
#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)
/**
 *  快速自定义导航栏上的按钮
 */
+ (instancetype)lx_itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;
@end
