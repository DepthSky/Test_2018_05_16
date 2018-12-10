//
//  GJDemoBaseViewController.h
//  ToolClass
//
//  Created by shinyv on 2018/7/26.
//  Copyright © 2018年 MrZhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GJDemoBaseViewController : UIViewController

@property(nonatomic,copy)NSString *test;/**< mark mark mark */

-(instancetype)initWithTitle:(NSString *)title viewClass:(Class)viewClass;
@end
