//
//  NSFileManager+Expand.h
//  ToolClass
//
//  Created by shinyv on 2018/12/11.
//  Copyright © 2018年 MrZhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (Extension)
+ (CGFloat)diskOfAllSizeMBytes;
+ (CGFloat)diskOfFreeSizeMBytes;
+ (long long)fileSizeAtPath:(NSString *)filePath;
+ (long long)folderSizeAtPath:(NSString *)folderPath;
@end
