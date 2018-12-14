
#import "NSString+Extension.h"
#import <objc/runtime.h>
#import <CommonCrypto/CommonDigest.h>

/*CC_MD5_DIGEST_LENGTH*/

#define  MD5_LENGTH   32
@implementation NSString (Extension)

+ (NSString*)md5HexDigest:(NSString*)input {
    const char* str = [input UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, strlen(str), result);
    
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH*2];
    for(int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02x",result[i]];
    }
    return ret;
}

- (unsigned long long)lx_fileSize
{
    // 计算self这个文件夹\文件的大小
    
    // 文件管理者
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    // 文件类型
    NSDictionary *attrs = [mgr attributesOfItemAtPath:self error:nil];
    NSString *fileType = attrs.fileType;
    
    if ([fileType isEqualToString:NSFileTypeDirectory]) { // 文件夹
        // 获得文件夹的遍历器
        NSDirectoryEnumerator *enumerator = [mgr enumeratorAtPath:self];
        
        // 总大小
        unsigned long long fileSize = 0;
        
        // 遍历所有子路径
        for (NSString *subpath in enumerator) {
            // 获得子路径的全路径
            NSString *fullSubpath = [self stringByAppendingPathComponent:subpath];
            fileSize += [mgr attributesOfItemAtPath:fullSubpath error:nil].fileSize;
        }
        
        return fileSize;
    }
    
    // 文件
    return attrs.fileSize;
}

//- (unsigned long long)lx_fileSize
//{
//    // 计算self这个文件夹\文件的大小
//    
//    // 文件管理者
//    NSFileManager *mgr = [NSFileManager defaultManager];
//    
//    // 文件类型
//    BOOL isDirectory = NO;
//    BOOL exists = [mgr fileExistsAtPath:self isDirectory:&isDirectory];
//    if (!exists) return 0;
//    
//    if (isDirectory) { // 文件夹
//        // 获得文件夹的遍历器
//        NSDirectoryEnumerator *enumerator = [mgr enumeratorAtPath:self];
//        
//        // 总大小
//        unsigned long long fileSize = 0;
//        
//        // 遍历所有子路径
//        for (NSString *subpath in enumerator) {
//            // 获得子路径的全路径
//            NSString *fullSubpath = [self stringByAppendingPathComponent:subpath];
//            fileSize += [mgr attributesOfItemAtPath:fullSubpath error:nil].fileSize;
//        }
//        
//        return fileSize;
//    }
//    
//    // 文件
//    return [mgr attributesOfItemAtPath:self error:nil].fileSize;
//}
- (instancetype)cacheDir
{
    NSString *dir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    return [dir stringByAppendingPathComponent:[self lastPathComponent]];
}
- (instancetype)docDir
{
    NSString *dir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    return [dir stringByAppendingPathComponent:[self lastPathComponent]];
}

- (instancetype)tmpDir
{
    NSString *dir = NSTemporaryDirectory();
    return [dir stringByAppendingPathComponent:[self lastPathComponent]];
}

- (CGSize)textSizeWithContentSize:(CGSize)size font:(UIFont *)font {
    return [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : font} context:nil].size;
}

- (CGFloat)textHeightWithContentWidth:(CGFloat)width font:(UIFont *)font {
    CGSize size = CGSizeMake(width, MAXFLOAT);
    return [self textSizeWithContentSize:size font:font].height;
}

- (CGFloat)textWidthWithContentHeight:(CGFloat)height font:(UIFont *)font {
    CGSize size = CGSizeMake(MAXFLOAT, height);
    return [self textSizeWithContentSize:size font:font].width;
}

//获取字符串(或汉字)首字母
+ (NSString *)firstCharacterWithString:(NSString *)string{
    NSMutableString *str = [NSMutableString stringWithString:string];
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformStripDiacritics, NO);
    NSString *pingyin = [str capitalizedString];
    return [pingyin substringToIndex:1];
}

//判断字符串中是否含有空格
+ (BOOL)isHaveSpaceInString:(NSString *)string{
    NSRange _range = [string rangeOfString:@" "];
    if (_range.location != NSNotFound) {
        return YES;
    }else {
        return NO;
    }
}

//判断字符串中是否含有某个字符串
+ (BOOL)isHaveString:(NSString *)string1 InString:(NSString *)string2{
    NSRange _range = [string2 rangeOfString:string1];
    if (_range.location != NSNotFound) {
        return YES;
    }else {
        return NO;
    }
}

//判断字符串中是否含有中文
+ (BOOL)isHaveChineseInString:(NSString *)string{
    for(NSInteger i = 0; i < [string length]; i++){
        int a = [string characterAtIndex:i];
        if (a > 0x4e00 && a < 0x9fff) {
            return YES;
        }
    }
    return NO;
}

//判断字符串是否全部为数字
+ (BOOL)isAllNum:(NSString *)string{
    unichar c;
    for (int i=0; i<string.length; i++) {
        c=[string characterAtIndex:i];
        if (!isdigit(c)) {
            return NO;
        }
    }
    return YES;
}

//判断字符串是否为空
+ (BOOL)isBlankString:(NSString *)aStr {
    if (!aStr)
    {
        return YES;
    }
    if([aStr isEqual:[NSNull null]])
    {
        return YES;
    }
    if([aStr isEqual:NULL])
    {
        return YES;
    }
    if([[aStr class] isSubclassOfClass:[NSNull class]])
    {
        return YES;
    }
    if ([aStr isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if (!aStr.length) {
        return YES;
    }
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmedStr = [aStr stringByTrimmingCharactersInSet:set];
    if (!trimmedStr.length) {
        return YES;
    }
    if([aStr isEqualToString:@"null"])
    {
        return YES;
    }
    if([aStr isEqualToString:@"NULL"])
    {
        return YES;
    }
    if([aStr isEqualToString:@"<null>"])
    {
        return YES;
    }
    if([aStr isEqualToString:@"(null)"])
    {
        return YES;
    }
    return NO;
}

//获取安全的字符串
+ (NSString *)safelyString:(NSString *)string
{
    if([[self class] isBlankString:string])
    {
        return @"";
    }
    else
    {
        return string;
    }
}
@end
