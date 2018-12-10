//
//  Define.h
//  AudioTest
//
//  Created by shinyv on 2018/5/14.
//  Copyright © 2018年 shinyv. All rights reserved.
//

#ifndef Define_h
#define Define_h

#pragma mark ===================== 常用缩写 =====================
//一些常用的缩写
#define kApplication        [UIApplication sharedApplication]
#define kKeyWindow          [UIApplication sharedApplication].keyWindow
#define kAppDelegate        [UIApplication sharedApplication].delegate
#define kUserDefaults      [NSUserDefaults standardUserDefaults]
#define kNotificationCenter [NSNotificationCenter defaultCenter]

#define CreateMyCgrect(x,y,w,h)    CGRectMake(x,  y, w, h)

#define NotificationDidPost(postName,postObject) [[NSNotificationCenter defaultCenter] postNotificationName:postName object:postObject]
#define NotiAddObserver(SEL,NotiName)  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SEL) name:NotiName object:nil];

#define Push(A) [self.navigationController pushViewController:A animated:YES]

#define ALERT(tit,msg) [[[UIAlertView alloc] initWithTitle:tit message:msg delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil] show]
#define AlertShow(tit,msg) [[[UIAlertView alloc] initWithTitle:tit message:msg delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil] show]

#define CLEARCOLOR [UIColor clearColor] //设置透明色

#define ImageNamed(name) [UIImage imageNamed:name］//加载图片

#define VIEWWITHTAG(_OBJECT, _TAG)    [_OBJECT viewWithTag : _TAG] //设置View的tag属性

#pragma mark ===================== 判断 =====================
//系统判断
#define IOS7_OR_LATER  ( [[UIDevice currentDevice] systemVersion].floatValue>7.0 )
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
#define IOS7_SDK_AVAILABLE 1
#endif

//判断是不是iPhone
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

// 判断是否为iPhone 5/5s
#define iPhone5 [[UIScreen mainScreen] bounds].size.width == 320.0f && [[UIScreen mainScreen] bounds].size.height == 568.0f

// 判断是否为iPhone 6/6s
#define iPhone6 [[UIScreen mainScreen] bounds].size.width == 375.0f && [[UIScreen mainScreen] bounds].size.height == 667.0f

// 判断是否为iPhone 6Plus/6sPlus
#define iPhone6Plus [[UIScreen mainScreen] bounds].size.width == 414.0f && [[UIScreen mainScreen] bounds].size.height == 736.0f

//判断是真机还是模拟器
#if TARGET_OS_IPHONE
//真机
#endif
#if TARGET_IPHONE_SIMULATOR
//模拟器
#endif

//是否iPad
#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

//是否iPad
#define someThing (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)? ipad: iphone

//判断是否 Retina屏
#define isRetina ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), ［UIScreen mainScreen] currentMode].size) : NO)

//字符串是否为空
#define kStringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1) ? YES : NO

//数组是否为空
#define kArrayIsEmpty(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)? YES : NO

//字典是否为空
#define kDictIsEmpty(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0) ? YES : NO

//是否是空对象
#define kObjectIsEmpty(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))

//判断字符串是否相同
#define ISStringEqual(A,B)  [A isEqualToString:B]

#pragma mark ===================== 系统信息获取 =====================
//系统版本号
#define kSystemVersion [[UIDevice currentDevice] systemVersion]

//APP版本号
#define kAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

//获取当前语言
#define kCurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])

//判断是否为iPhone
#define kISiPhone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

//判断是否为iPad
#define kISiPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

//获取沙盒Document路径
#define kDocumentPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]

//获取沙盒temp路径
#define kTempPath NSTemporaryDirectory()

//获取沙盒Cache路径
#define kCachePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

#pragma mark ===================== iPhoneX =====================
// 判断是否为iPhoneX
#define iPhone_X ([[UIScreen mainScreen] bounds].size.width == 375.0f && [[UIScreen mainScreen] bounds].size.height == 812.0f)||([[UIScreen mainScreen] bounds].size.width == 812.0f && [[UIScreen mainScreen] bounds].size.height == 375.0f)

//是否是iPhoneX
#define isIphoneX (kScreenWidth >= 375.0f && kScreenHeight >= 812.0f && isIphone)

//iPhoneX 屏宽
#define Width_IphoneX 375

//iPhoneX 屏高
#define height_IphoneX 812

//底部 安全高度
#define Bottom_Safe_Height (isIphoneX?34:0)

//系统 手势高度
#define System_Gesture_Height (isIphoneX?13:0)

//tabBar高度
#define TabBar_Height (49 + Bottom_Safe_Height)

//状态栏高度
#define Status_Height (isIphoneX?44:20)

//导航栏高度
#define NavBar_Height 44

#define SafeAreaBottomHeight (SCREEN_HEIGHT == 812.0 ? 34 : 0) //iphoneX 底部安全距离
#define SafeAreaBottomOfList (SCREEN_HEIGHT == 812.0 ? -34 : 0) //iphoneX 底部安全距离（针对列表 可以不考虑安全距离  存在一个问题 如果正好等于view的底部 foot会在显示出来  必须超出屏幕34的距离才能完全显示整个列表）

#define NavgationBarHeight  (SCREEN_HEIGHT == 812.0 ? 88 : 64)

#define StatusBarHeightZH  (SCREEN_HEIGHT == 812.0 ? 44 : 20)

#define CustomContentHeightZH  (SCREEN_HEIGHT == 812.0 ? SCREEN_HEIGHT-88-34 : SCREEN_HEIGHT-64)

#define CustomContentHeightZHOfList  (SCREEN_HEIGHT == 812.0 ? SCREEN_HEIGHT-88 : SCREEN_HEIGHT-64)

#pragma mark ===================== 屏幕宽高 =====================
//获取屏幕宽度与高度 ( " \ ":连接行标志，连接上下两行 )
#define kScreenWidth \
([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)] ? [UIScreen mainScreen].nativeBounds.size.width/[UIScreen mainScreen].nativeScale : [UIScreen mainScreen].bounds.size.width)

#define kScreenHeight \
([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)] ? [UIScreen mainScreen].nativeBounds.size.height/[UIScreen mainScreen].nativeScale : [UIScreen mainScreen].bounds.size.height)

#define kScreenSize \
([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)] ? CGSizeMake([UIScreen mainScreen].nativeBounds.size.width/[UIScreen mainScreen].nativeScale,[UIScreen mainScreen].nativeBounds.size.height/[UIScreen mainScreen].nativeScale) : [UIScreen mainScreen].bounds.size)

//获取屏幕 宽度、高度
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#pragma mark ===================== 颜色 =====================
//颜色
#define RGB(R,G,B,A) [UIColor colorWithRed:R/255.0f green:G/255.0f blue:B/255.0f alpha:A/1.0]

#define kRGBColor(r, g, b)    [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#define kRGBAColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(r)/255.0 blue:(r)/255.0 alpha:a]

//随机色生成1
#define kRandomColor    KRGBColor(arc4random_uniform(256)/255.0,arc4random_uniform(256)/255.0,arc4random_uniform(256)/255.0)

//随机色生成2
#define random(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]
#define randomColor random(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

//rgb颜色转换（16进制->10进制）
#define kColorWithHex(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 \
green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0 \
blue:((float)(rgbValue & 0xFF)) / 255.0 alpha:1.0]

#pragma mark ===================== 强弱引用 =====================
//弱引用/强引用
#define kWeakSelf(type)  __weak typeof(type) weak##type = type;
#define kStrongSelf(type) __strong typeof(type) type = weak##type;

#pragma mark ===================== 角度弧度互换 =====================
//由角度转换弧度
#define kDegreesToRadian(x)      (M_PI * (x) / 180.0)
//由弧度转换角度
#define kRadianToDegrees(radian) (radian * 180.0) / (M_PI)

#pragma mark ===================== Time =====================
//获取一段时间间隔
#define kStartTime CFAbsoluteTime start = CFAbsoluteTimeGetCurrent();
#define kEndTime  NSLog(@"Time: %f", CFAbsoluteTimeGetCurrent() - start)

#pragma mark ===================== G-C_D =====================

#define BACK(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)

#define MAIN(block) dispatch_async(dispatch_get_main_queue(),block)

#pragma mark ===================== Debug打印 =====================
//开发的时候打印，但是发布的时候不打印的NSLog
#ifdef DEBUG
#define NSLog(...) NSLog(@"%s 第%d行 \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else
#define NSLog(...)
#endif

//DEBUG 模式下打印日志,当前行
#ifdef DEBUG
#  define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#  define DLog(...)
#endif

//重写NSLog,Debug模式下打印日志和当前行数
/*
 #if DEBUG
 #define NSLog(FORMAT, ...) fprintf(stderr,"\nfunction:%s line:%d content:%s\n", __FUNCTION__, __LINE__, ［NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
 #else
 #define NSLog(FORMAT, ...) nil
 #endif
 */

//DEBUG 模式下打印日志,当前行 并弹出一个警告
#ifdef DEBUG
#define ULog(fmt, ...) { UIAlertView *alert = [UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%s\n [Line %d]",__PRETTY_FUNCTION__,__LINE__] message:[NSString stringWithFormat:fmt, ##__VA_ARGS__] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil]; [alert show]; }
#else
#  define ULog(...)
#endif
#define ITTDEBUG
#define ITTLOGLEVEL_INFO 10
#define ITTLOGLEVEL_WARNING 3
#define ITTLOGLEVEL_ERROR 1
#ifndef ITTMAXLOGLEVEL
#ifdef DEBUG
#define ITTMAXLOGLEVEL ITTLOGLEVEL_INFO
#else
#define ITTMAXLOGLEVEL ITTLOGLEVEL_ERROR
#endif
#endif

//The general purpose logger. This ignores logging levels.
#ifdef ITTDEBUG
#define ITTDPRINT(xx, ...)  NSLog(@"%s(%d): " xx, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define ITTDPRINT(xx, ...)  ((void)0)
#endif

//打印当前方法的名称
#define ITTDPRINTMETHODNAME() ITTDPRINT(@"%s", __PRETTY_FUNCTION__)

//Log-level based logging macros.
#if ITTLOGLEVEL_ERROR <= ITTMAXLOGLEVEL
#define ITTDERROR(xx, ...)  ITTDPRINT(xx, ##__VA_ARGS__)
#else
#define ITTDERROR(xx, ...)  ((void)0)
#endif
#if ITTLOGLEVEL_WARNING <= ITTMAXLOGLEVEL
#define ITTDWARNING(xx, ...)  ITTDPRINT(xx, ##__VA_ARGS__)
#else
#define ITTDWARNING(xx, ...)  ((void)0)
#endif
#if ITTLOGLEVEL_INFO <= ITTMAXLOGLEVEL
#define ITTDINFO(xx, ...)  ITTDPRINT(xx, ##__VA_ARGS__)
#else
#define ITTDINFO(xx, ...)  ((void)0)
#endif
#ifdef ITTDEBUG
#define ITTDCONDITIONLOG(condition, xx, ...) { if ((condition)) { \
ITTDPRINT(xx, ##__VA_ARGS__); \
} \
} ((void)0)
#else
#define ITTDCONDITIONLOG(condition, xx, ...) ((void)0)
#endif
#define ITTAssert(condition, ...)                                      \
do {                                                                      \
if (!(condition)) {                                                    \
［NSAssertionHandler currentHandler]                                  \
handleFailureInFunction:[NSString                 stringWithUTF8String:__PRETTY_FUNCTION__] \
file:[NSString stringWithUTF8String:__FILE__]  \
lineNumber:__LINE__                                  \
description:__VA_ARGS__];                            \
}                                                                      \
} while(0)

//打印
#ifdef DEBUG
#define NSLog_(...) NSLog(__VA_ARGS__);
#define NSLog_METHOD NSLog(@"%s", __func__);
#else
#define NSLog_(...)
#define NSLog_METHOD
#endif

#endif /* Define_h */
