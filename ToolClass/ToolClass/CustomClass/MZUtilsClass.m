//
//  MZUtilsClass.m
//  ToolClass
//
//  Created by shinyv on 2018/12/10.
//  Copyright © 2018年 MrZhang. All rights reserved.
//

#import "MZUtilsClass.h"
#import <ifaddrs.h>
#import <arpa/inet.h>
#import <SystemConfiguration/CaptiveNetwork.h>

@implementation MZUtilsClass

#define PI 3.1415926

#pragma mark -- 时间
+ (NSString *)currentDateWithFormat:(NSString *)format{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    return [dateFormatter stringFromDate:[NSDate date]];
}

+ (NSDate *)dateFromString:(NSString *)datestring formate:(NSString *)formate {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formate];
    NSDate *date = [dateFormatter dateFromString:datestring];
    
    return date;
}

+ (NSString *)stringFromDate:(NSDate *)date formate:(NSString *)formate {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formate];
    NSString *datestring = [dateFormatter stringFromDate:date];
    
    return datestring;
}

+ (double)intervalSinceNow:(NSString *)theDate
{
    NSDateFormatter *date=[[NSDateFormatter alloc] init];
    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *d=[date dateFromString:theDate];
    
    NSTimeInterval late = [d timeIntervalSince1970]*1;
    
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval now=[dat timeIntervalSince1970]*1;
    
    NSTimeInterval cha = now-late;
    return cha;
}

+ (NSString *)getDate:(NSString *)dateString formate:(NSString *)formate
{
    //设置时间
    NSRange range = NSMakeRange(0, 10);
    dateString = [dateString substringWithRange:range];
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:dateString.longLongValue];
    NSString *timeStr = [MZUtilsClass stringFromDate:date formate:formate];
    return timeStr;
}

+ (NSString *)timeIntervalFromLastTime:(NSString *)lastTime
                        lastTimeFormat:(NSString *)format1
                         ToCurrentTime:(NSString *)currentTime
                     currentTimeFormat:(NSString *)format2{
    //上次时间
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc]init];
    dateFormatter1.dateFormat = format1;
    NSDate *lastDate = [dateFormatter1 dateFromString:lastTime];
    //当前时间
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc]init];
    dateFormatter2.dateFormat = format2;
    NSDate *currentDate = [dateFormatter2 dateFromString:currentTime];
    return [[self class] timeIntervalFromLastTime:lastDate ToCurrentTime:currentDate];
}

+ (NSString *)timeIntervalFromLastTime:(NSDate *)lastTime ToCurrentTime:(NSDate *)currentTime{
    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
    //上次时间
    NSDate *lastDate = [lastTime dateByAddingTimeInterval:[timeZone secondsFromGMTForDate:lastTime]];
    //当前时间
    NSDate *currentDate = [currentTime dateByAddingTimeInterval:[timeZone secondsFromGMTForDate:currentTime]];
    //时间间隔
    NSInteger intevalTime = [currentDate timeIntervalSinceReferenceDate] - [lastDate timeIntervalSinceReferenceDate];
    
    //秒、分、小时、天、月、年
    NSInteger minutes = intevalTime / 60;
    NSInteger hours = intevalTime / 60 / 60;
    NSInteger day = intevalTime / 60 / 60 / 24;
    NSInteger month = intevalTime / 60 / 60 / 24 / 30;
    NSInteger yers = intevalTime / 60 / 60 / 24 / 365;
    
    if (minutes <= 10) {
        return  @"刚刚";
    }else if (minutes < 60){
        return [NSString stringWithFormat: @"%ld分钟前",(long)minutes];
    }else if (hours < 24){
        return [NSString stringWithFormat: @"%ld小时前",(long)hours];
    }else if (day < 30){
        return [NSString stringWithFormat: @"%ld天前",(long)day];
    }else if (month < 12){
        NSDateFormatter * df =[[NSDateFormatter alloc]init];
        df.dateFormat = @"M月d日";
        NSString * time = [df stringFromDate:lastDate];
        return time;
    }else if (yers >= 1){
        NSDateFormatter * df =[[NSDateFormatter alloc]init];
        df.dateFormat = @"yyyy年M月d日";
        NSString * time = [df stringFromDate:lastDate];
        return time;
    }
    return @"";
}

#pragma mark -- 文件
+ (long long)countDirectorySize:(NSString *)directory {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //获取到目录下面所有的文件名
    NSArray *fileNames = [fileManager subpathsOfDirectoryAtPath:directory error:nil];
    
    long long sum = 0;
    for (NSString *fileName in fileNames) {
        NSString *filePath = [directory stringByAppendingPathComponent:fileName];
        
        NSDictionary *attribute = [fileManager attributesOfItemAtPath:filePath error:nil];
        
        //        NSNumber *filesize = [attribute objectForKey:NSFileSize];
        long long size = [attribute fileSize];
        
        sum += size;
    }
    
    return sum;
}

//获取沙盒的根路径
+ (NSString *)pathOfDocument:(NSString *)fileName
{
    
    NSString *p = [NSString stringWithFormat:@"Documents/%@",fileName];
    
    NSString *homePath = NSHomeDirectory(); //获取沙盒的根路径
    
    NSString *path = [homePath stringByAppendingPathComponent:p];
    
    NSLog(@"%@",path);
    
    return path;
    
}

//删除指定路径文件
+ (BOOL)deleteFile:(NSString *)path {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:path]) {
        
        return [fileManager removeItemAtPath:path error:nil];
        
    }
    return NO;
}

#pragma mark -- 数组
//筛选数组中重复的数据
+ (NSMutableArray *)filterRepeatDataInArray:(NSArray *)elementArray
{
    NSMutableArray *temArray = [NSMutableArray arrayWithCapacity:elementArray.count];
    for (int i = 0; i < elementArray.count; i++)
    {
        bool bExsit = false;
        for (int j = 0; j < i; j++) {
            if ([elementArray[i] isEqualToString:elementArray[j]]) {
                bExsit = true;
                break;
            }
        }
        if (bExsit == false) {
            [temArray addObject:elementArray[i]];
        }
    }
    return temArray;
}

/**描述：将数组中元素进行排序
 参数：ascending:yes 正序 no为倒叙
 */
+ (NSArray *)sortArray:(NSArray *)dataArray withKey:(NSString *)key ascending:(BOOL)ascending{
    if (!dataArray || !key) {
        return nil;
    }
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:key ascending:ascending] ;
    
    NSMutableArray *array = [[NSMutableArray alloc] initWithArray:dataArray];
    NSMutableArray *sortArray = [NSMutableArray arrayWithArray:[array sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]]];
    return sortArray;
}

#pragma mark -- 字符串
//将字典转化为json
+ (NSString *)dicTransformToJson:(NSDictionary *)data
{
    NSError *err = nil;
    //将字典转成json
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&err];
    NSString *jsonString = @"";
    if ([jsonData length] > 0 && err == nil){
        //把json数据转化为String类型
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        return jsonString;
    }
    return nil;
}

+ (NSString *)dicPrettyJsonStringEncoded:(NSDictionary *)dictionary{
    if ([NSJSONSerialization isValidJSONObject:dictionary ]) {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:&error];
        if (!error) {
            NSString *json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            return json;
        }
    }
    return nil;
}

//数组转json
+ (NSString*)arrToJson:(NSArray *)arr{
    
    NSError *parseError = nil;
    
    
    NSData * JSONData = [NSJSONSerialization dataWithJSONObject:arr
                                                        options:kNilOptions
                                                          error:&parseError];
    return [[NSString alloc] initWithData:JSONData encoding:NSUTF8StringEncoding];
    
}

+ (NSString *)arrayPrettyJsonStringEncoded:(NSArray *)array{
    if ([NSJSONSerialization isValidJSONObject:array]) {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:&error];
        if (!error) {
            NSString *json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            return json;
        }
    }
    return nil;
}


// 字符串 转dic
+(NSDictionary*)stringToDic:(NSString *)jsonString{
    
    if (jsonString == nil) {
        
        return nil;
        
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *err;
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                         
                                                        options:NSJSONReadingMutableContainers
                         
                                                          error:&err];
    
    if(err) {
        
        NSLog(@"json解析失败：%@",err);
        
        return nil;
        
    }
    
    return dic;
    
}

+ (NSMutableAttributedString *)stringFromContent:(NSString *)content Search:(NSString *)search
{
    NSMutableAttributedString* str = [[NSMutableAttributedString alloc] initWithString:content];
    NSRange range = [content rangeOfString:search];
    
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, range.location)];
    [str addAttribute:NSForegroundColorAttributeName value:[MZUtilsClass transferHEXToRGB:@"39c631"] range:range];
    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Courier-BoldOblique" size:30.0] range:range];
    NSRange tempRange = NSMakeRange(range.location+range.length, str.length-(range.location+range.length));
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:tempRange];
    
    return str;
    
}

//获取label的高度
+ (CGSize)getSizeWithLabel:(NSString *)des withFont:(UIFont *)font withSize:(CGSize)size
{
    if (![des isMemberOfClass:[NSNull class]]) {
        /** iOS6使用的方法
         CGSize size = [des sizeWithFont:font constrainedToSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];//MAXFLOAT
         NSLog(@"size.height:%f",size.height);
         return size;
         */
        NSDictionary *attribute = @{NSFontAttributeName: font};
        //iOS7中提供的计算文本尺寸的方法
        CGSize textSize1 = [des boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin |
                            NSStringDrawingTruncatesLastVisibleLine  attributes:attribute context:nil].size;
        return textSize1;
    }
    return CGSizeZero;
}

//手机号加密
+(NSString *)returnMysteryMobile:(NSString *)mobileNum;{
    
    if ([[self class] isValidatePhone:mobileNum]) {
        
        
        NSMutableString *str1 = [[NSMutableString alloc] initWithString:mobileNum];
        [str1 replaceCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        
        return str1;
        
    }
    return mobileNum;
}

//将字符串数组按照元素首字母顺序进行排序分组
+ (NSDictionary *)dictionaryOrderByCharacterWithOriginalArray:(NSArray *)array{
    if (array.count == 0) {
        return nil;
    }
    for (id obj in array) {
        if (![obj isKindOfClass:[NSString class]]) {
            return nil;
        }
    }
    UILocalizedIndexedCollation *indexedCollation = [UILocalizedIndexedCollation currentCollation];
    NSMutableArray *objects = [NSMutableArray arrayWithCapacity:indexedCollation.sectionTitles.count];
    //创建27个分组数组
    for (int i = 0; i < indexedCollation.sectionTitles.count; i++) {
        NSMutableArray *obj = [NSMutableArray array];
        [objects addObject:obj];
    }
    NSMutableArray *keys = [NSMutableArray arrayWithCapacity:objects.count];
    //按字母顺序进行分组
    NSInteger lastIndex = -1;
    for (int i = 0; i < array.count; i++) {
        NSInteger index = [indexedCollation sectionForObject:array[i] collationStringSelector:@selector(uppercaseString)];
        [[objects objectAtIndex:index] addObject:array[i]];
        lastIndex = index;
    }
    //去掉空数组
    for (int i = 0; i < objects.count; i++) {
        NSMutableArray *obj = objects[i];
        if (obj.count == 0) {
            [objects removeObject:obj];
        }
    }
    //获取索引字母
    for (NSMutableArray *obj in objects) {
        NSString *str = obj[0];
        NSString *key = [[self class] firstCharacterWithString:str];
        [keys addObject:key];
    }
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:objects forKey:keys];
    return dic;
}

//获取字符串(或汉字)首字母
+ (NSString *)firstCharacterWithString:(NSString *)string{
    NSMutableString *str = [NSMutableString stringWithString:string];
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformStripDiacritics, NO);
    NSString *pingyin = [str capitalizedString];
    return [pingyin substringToIndex:1];
}

#pragma mark -- 颜色
+ (UIColor *)transferHEXToRGB:(NSString *)HEX
{
    unsigned int red,green,blue;
    NSRange range;
    range.length = 2;
    range.location = 0;
    [[NSScanner scannerWithString:[HEX substringWithRange:range]]scanHexInt:&red];
    range.location =2;
    [[NSScanner scannerWithString:[HEX substringWithRange:range]]scanHexInt:&green];
    range.location =4;
    [[NSScanner scannerWithString:[HEX substringWithRange:range]]scanHexInt:&blue];
    UIColor *color = [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1];
    return color;
}

//16进制颜色字符串转为UIColor
+ (UIColor *) hexStringToColor: (NSString *) stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor blackColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}


#pragma mark -- 系统
// 产生随机数种子
+(NSString *)getRandom
{
    CFUUIDRef uuidObj = CFUUIDCreate(nil);
    NSString *random = (NSString*)CFBridgingRelease(CFUUIDCreateString(nil, uuidObj)); // 产生随机种子
    CFRelease(uuidObj);
    random =[random stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    return random ;
}

+ (void)getVersionInfoWithAppid:(int)appid infoResult:(CheckVersionInfo)block
{
    NSString *urlstring = [NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%d",appid];
    urlstring = [urlstring stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlstring]];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        if (block != nil) {
            block(result);
        }
    }];
}

//需要引入头文件:
//#import <SystemConfiguration/CaptiveNetwork.h>
//获取 WiFi 信息
- (NSDictionary *)fetchSSIDInfo {
    NSArray *ifs = (__bridge_transfer NSArray *)CNCopySupportedInterfaces();
    if (!ifs) {
        return nil;
    }
    NSDictionary *info = nil;
    for (NSString *ifnam in ifs) {
        info = (__bridge_transfer NSDictionary *)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
        if (info && [info count]) { break; }
    }
    return info;
}

//需要引入头文件:
//#import <ifaddrs.h>
//#import <arpa/inet.h>
//p.p1 {margin: 0.0px 0.0px 0.0px 0.0px; font: 14.0px Menlo; color: #ff4647}span.s1 {font-variant-ligatures: no-common-ligatures; color: #eb905a}span.s2 {font-variant-ligatures: no-common-ligatures}

//获取广播地址、本机地址、子网掩码、端口信息
- (NSMutableDictionary *)getLocalInfoForCurrentWiFi {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        //*/
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    //广播地址
                    NSString *broadcast = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_dstaddr)->sin_addr)];
                    if (broadcast) {
                        [dict setObject:broadcast forKey:@"broadcast"];
                    }
                    //                    NSLog(@"broadcast address--%@",broadcast);
                    //本机地址
                    NSString *localIp = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                    if (localIp) {
                        [dict setObject:localIp forKey:@"localIp"];
                    }
                    //                    NSLog(@"local device ip--%@",localIp);
                    //子网掩码地址
                    NSString *netmask = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_netmask)->sin_addr)];
                    if (netmask) {
                        [dict setObject:netmask forKey:@"netmask"];
                    }
                    //                    NSLog(@"netmask--%@",netmask);
                    //--en0 端口地址
                    NSString *interface = [NSString stringWithUTF8String:temp_addr->ifa_name];
                    if (interface) {
                        [dict setObject:interface forKey:@"interface"];
                    }
                    //                    NSLog(@"interface--%@",interface);
                    return dict;
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return dict;
}

//获取设备 IP 地址
+ (NSString *)getIPAddress {
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    success = getifaddrs(&interfaces);
    if (success == 0) {
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    freeifaddrs(interfaces);
    return address;
}

#pragma mark - 正则匹配
// 邮箱
+ (BOOL)isValidateEmail:(NSString *)email
{
    NSString *regex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:email];
}

// 手机
+ (BOOL)isValidatePhone:(NSString *)phone
{
    NSString *regex = @"^1[3458]{1}[\\d]{9}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:phone];
}

//判断手机号码格式是否正确
+ (BOOL)valiMobile:(NSString *)mobile{
    mobile = [mobile stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (mobile.length != 11)
    {
        return NO;
    }else{
        /**
         * 移动号段正则表达式
         */
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        /**
         * 联通号段正则表达式
         */
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        /**
         * 电信号段正则表达式
         */
        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:mobile];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:mobile];
        
        if (isMatch1 || isMatch2 || isMatch3) {
            return YES;
        }else{
            return NO;
        }
    }
}

#pragma mark -- Other
+ (NSString *)matchSearchResultWithContent:(NSString *)content
                                    Search:(NSString *)search
                              resultLength:(NSInteger)length
{
    NSMutableString* temp_Content = [NSMutableString stringWithString:content];
    NSRange range = [temp_Content rangeOfString:search];
    
    if (temp_Content.length > 0) {
        
        if ((range.location + range.length) < length)   // 搜索内容在字符串前方
        {
            return temp_Content;
        }
        else if ((temp_Content.length - (range.location + range.length)) < length)  // 搜索内容在字符串最后面位置
        {
            return [temp_Content substringFromIndex:(temp_Content.length - 20)];
        }
        else    // 在字符串中间
        {
            return [temp_Content substringFromIndex:(range.location - 3)];
        }
    }
    
    return nil;
    
}

+ (void)addLocationNotificationWithAlertBody:(NSString *)alertBody AlertAction:(NSString *)alertAction
{
    //创建本地通知对象
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    //设置本地通知触发的时间点
    localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:2];
    //设置通知提示的内容
    localNotification.alertBody = alertBody;
    //设置通知alert上的按钮
    localNotification.alertAction = alertAction;
    localNotification.soundName = @"msgcome.wav";
    
    //    localNotification.hasAction = YES;
    //设置图标上显示的标记值
    //    localNotification.applicationIconBadgeNumber = 2;
    
    UIApplication *application = [UIApplication sharedApplication];
    //注册本地通知
    [application scheduleLocalNotification:localNotification];
}

//+ (double)distanceOfLocation:(CLLocationCoordinate2D)coordinate1 withCoordinate:(CLLocationCoordinate2D)coordinate2
//{
//    double dd = M_PI/180;
//    double x1=coordinate1.latitude*dd,x2=coordinate2.latitude*dd;
//    double y1=coordinate1.longitude*dd,y2=coordinate2.longitude*dd;
//    double R = 6378137;
//    double distance = (2*R*asin(sqrt(2-2*cos(x1)*cos(x2)*cos(y1-y2) - 2*sin(x1)*sin(x2))/2));
//    return distance;
//}
@end
