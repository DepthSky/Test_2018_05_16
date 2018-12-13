
#import <Foundation/Foundation.h>

@interface NSDictionary (Extension)

/*
 1.根据字典快速生成Property属性
 使用场景：根据网络请求返回的字典数据，写对应的模型。当属性多时，用手写很费功夫，可用这个类快速打印出所有的模型属性，直接粘贴即可
 **/
// 生成所需要的属性代码
- (void)propertyCode;

@end
