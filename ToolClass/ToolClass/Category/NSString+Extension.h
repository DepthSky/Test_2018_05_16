
#import <Foundation/Foundation.h>

@interface NSString (Extension)
/**
 *  md5加密
 */
+ (NSString*)md5HexDigest:(NSString*)input;
/**
 *  根据文件名计算出文件大小
 */
- (unsigned long long)lx_fileSize;
/**
 *  生成缓存目录全路径
 */
- (instancetype)cacheDir;
/**
 *  生成文档目录全路径
 */
- (instancetype)docDir;
/**
 *  生成临时目录全路径
 */
- (instancetype)tmpDir;

/**
 *  @brief 根据字数的不同,返回UILabel中的text文字需要占用多少Size
 *  @param size 约束的尺寸
 *  @param font 文本字体
 *  @return 文本的实际尺寸
 */
- (CGSize)textSizeWithContentSize:(CGSize)size font:(UIFont *)font;

/**
 *  @brief  根据文本字数/文本宽度约束/文本字体 求得text的Size
 *  @param width 宽度约束
 *  @param font  文本字体
 *  @return 文本的实际高度
 */
- (CGFloat)textHeightWithContentWidth:(CGFloat)width font:(UIFont *)font;

/**
 *  @brief  根据文本字数/文本宽度约束/文本字体 求得text的Size
 *  @param height 宽度约束
 *  @param font  文本字体
 *  @return 文本的实际长度
 */
- (CGFloat)textWidthWithContentHeight:(CGFloat)height font:(UIFont *)font;


/**
 获取字符串(或汉字)首字母

 @param string 字符
 @return 首字母
 */
+ (NSString *)firstCharacterWithString:(NSString *)string;

+ (BOOL)isHaveSpaceInString:(NSString *)string;
    
+ (BOOL)isHaveString:(NSString *)string1 InString:(NSString *)string2;
    
+ (BOOL)isHaveChineseInString:(NSString *)string;

+ (BOOL)isAllNum:(NSString *)string;

/**
 字符串是否为空

 @param aStr 字符串
 @return YES 空 NO不为空
 */
+ (BOOL)isBlankString:(NSString *)aStr;


/**
 获取安全的字符串

 @param string 字符串
 @return 安全字符串
 */
+ (NSString *)safelyString:(NSString *)string;
@end
