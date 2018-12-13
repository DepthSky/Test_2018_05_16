
#import <Foundation/Foundation.h>

@interface LXDateItem : NSObject
@property (nonatomic, assign) NSInteger day;
@property (nonatomic, assign) NSInteger hour;
@property (nonatomic, assign) NSInteger minute;
@property (nonatomic, assign) NSInteger second;
@end

@interface NSDate (Extension)
/**
 *  两个时间之间的时间间隔
 */
- (LXDateItem *)lx_timeIntervalSinceDate:(NSDate *)anotherDate;

/**
 *  是否为今天，昨天，明天
 */
- (BOOL)lx_isToday;
- (BOOL)lx_isYesterday;
- (BOOL)lx_isTomorrow;
- (BOOL)lx_isThisYear;

/**
 *  获取今天周几
 */
- (NSInteger)getNowWeekday;
@end
