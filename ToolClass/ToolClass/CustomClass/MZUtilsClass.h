//
//  MZUtilsClass.h
//  ToolClass
//
//  Created by shinyv on 2018/12/10.
//  Copyright © 2018年 MrZhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MZUtilsClass : NSObject

typedef void(^CheckVersionInfo)(id result);

//将字符串格式化为Date对象
+ (NSDate *)dateFromString:(NSString *)datestring formate:(NSString *)formate;

//将日期格式化为NSString对象
+ (NSString *)stringFromDate:(NSDate *)date formate:(NSString *)formate;

//计算目录下面所有文件的大小
+ (long long)countDirectorySize:(NSString *)directory;

//计算两经纬度之间的距离
//+ (double)distanceOfLocation:(CLLocationCoordinate2D)coordinate1 withCoordinate:(CLLocationCoordinate2D)coordinate2;

//筛选数组中重复的数据,elementArray为原数组，返回为筛选之后的数据
+ (NSMutableArray *)filterRepeatDataInArray:(NSArray *)elementArray;

//添加本地通知
+ (void)addLocationNotificationWithAlertBody:(NSString *)alertBody AlertAction:(NSString *)alertAction;

//将字典转化为json
+ (NSString *)dicTransformToJson:(NSDictionary *)data;

//数组转json
+(NSString*)arrToJson:(NSArray *)arr;

// 字符串 转dic
+(NSDictionary*)stringToDic:(NSString *)jsonString;

//计算某一时间与当前时间的差值
+ (double)intervalSinceNow:(NSString *)theDate;


//16进制颜色字符串转为UIColor
+(UIColor *) hexStringToColor: (NSString *) stringToConvert;

/**描述：将十六进制颜色值转化为rgb值
 参数：HEX，是十六进制值，不需要写#
 返回值：UIColor
 
 **/
+ (UIColor *)transferHEXToRGB:(NSString *)HEX;

/**
 描述：根据文本来计算高度
 参数：des是需要计算的文本高度,font是文本的字体，size是文本预定的大小
 返回值：文本的大小
 **/
+ (CGSize)getSizeWithLabel:(NSString *)des withFont:(UIFont *)font withSize:(CGSize)size;

/**
 描述：根据appId获取当前应用的版本信息
 参数：appid
 **/
+ (void)getVersionInfoWithAppid:(int)appid infoResult:(CheckVersionInfo)block;


/*
 描述：时间戳转换成日期
 参数：dateString:时间戳 formate：格式
 */
+ (NSString *)getDate:(NSString *)dateString formate:(NSString *)formate;


/**
 *  正则匹配邮箱
 */
+ (BOOL)isValidateEmail:(NSString *)email;

/**
 *  正则匹配手机号
 */
+ (BOOL)isValidatePhone:(NSString *)phone;

/**
 *  匹配搜索关键字算法
 */

+ (NSString *)matchSearchResultWithContent:(NSString *)content
                                    Search:(NSString *)search
                              resultLength:(NSInteger)length;
/**
 *  label显示不同的颜色
 */

+ (NSMutableAttributedString *)stringFromContent:(NSString *)content Search:(NSString *)search;

/**描述：将数组中元素进行排序
 参数：ascending:yes 正序 no为倒叙
 */
+ (NSArray *)sortArray:(NSArray *)dataArray withKey:(NSString *)key ascending:(BOOL)ascending;

/**
 获取沙盒根路径

 @param fileName 文件名
 @return 路径
 */

+ (NSString *)pathOfDocument:(NSString *)fileName;


/**
 删除指定路径文件

 @param path 路径
 @return 成功 YES 反之NO
 */
+ (BOOL)deleteFile:(NSString *)path;

/**
 随机字符

 @return 字符
 */
+(NSString *)getRandom;



/**
 手机号加密

 @param mobileNum 手机号
 @return 加密后手机号
 */
+(NSString *)returnMysteryMobile:(NSString *)mobileNum;

/**
 *  计算上次日期距离现在多久
 *
 *  @param lastTime    上次日期(需要和格式对应)
 *  @param format1     上次日期格式
 *  @param currentTime 最近日期(需要和格式对应)
 *  @param format2     最近日期格式
 *
 *  @return xx分钟前、xx小时前、xx天前
 */
+ (NSString *)timeIntervalFromLastTime:(NSString *)lastTime
                        lastTimeFormat:(NSString *)format1
                         ToCurrentTime:(NSString *)currentTime
                     currentTimeFormat:(NSString *)format2;
@end
