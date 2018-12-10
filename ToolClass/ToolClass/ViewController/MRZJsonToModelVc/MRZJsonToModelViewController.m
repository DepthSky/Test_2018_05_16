//
//  MRZJsonToModelViewController.m
//  ToolClass
//
//  Created by shinyv on 2018/7/10.
//  Copyright © 2018年 MrZhang. All rights reserved.
//

#import "MRZJsonToModelViewController.h"
#import "MRZTestArrayModel.h"
#import <objc/runtime.h>
@interface MRZJsonToModelViewController ()

@end

@implementation MRZJsonToModelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITextView * textView = [[UITextView alloc]initWithFrame:CGRectMake(10, 44, SCREEN_WIDTH-20, SCREEN_HEIGHT-44-34)];
    textView.backgroundColor = UIColor.blackColor;
    textView.textColor = [UIColor whiteColor];
    textView.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:textView];
    
    //Class class = [MRZTestArrayModel class];
    //textView.text = [self showPropertyWithClass:class];
    //name:testArr,atts:T@"NSMutableArray",&,N,V_testArr
    
    //    Class class = [MRZTestArrayModel class];
    //    textView.text = [self showPropertyWithClass:class];
    //name:testArr,atts:T@"NSMutableArray<MRZTestShowPropertyModel>",&,N,V_testArr
    
        Class class = [MRZTestShowPropertyModel class];
        textView.text = [self showPropertyWithClass:class];
    //name:pName,atts:T@"NSString",C,N,V_pName
    //name:createAt,atts:Tq,N,V_createAt
    
    //MRZTestArrayModel * array = [[MRZTestArrayModel alloc]initWithJSONDict:@{@"count":@"2"}];
}


/**
 显示类中所有属性（无协议）

 @return 返回属性info
 */
-(NSMutableString *)showPropertyWithClass:(Class)class
{
    NSMutableString * mutableString = [NSMutableString string];
    unsigned int propertyCount;
    objc_property_t *properties = class_copyPropertyList(class, &propertyCount);//属性数组
    for(unsigned int i=0;i<propertyCount;i++)
    {
        objc_property_t property = properties[i];
        
        const char *propertyName = property_getName(property);
        NSString * name = [NSString stringWithUTF8String:propertyName];
        
        const char *propertuAttrs = property_getAttributes(property);
        NSString * atts = [NSString stringWithUTF8String:propertuAttrs];
        
        [mutableString appendString:[NSString stringWithFormat:@"name:%@,atts:%@\n",name,atts]];
    }
    free(properties);
    NSLog(@"mutablestring:%@",mutableString);
    return mutableString;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
