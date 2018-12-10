//
//  FillingView.m
//  ToolClass
//
//  Created by shinyv on 2018/7/19.
//  Copyright © 2018年 MrZhang. All rights reserved.
//

#import "FillingView.h"
#define radians(x) (x * M_PI/180)
@implementation FillingView
-(void)drawRect:(CGRect)rect
{
    UIBezierPath* p = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(100,100,100,100)];
    
    //描边
    [[UIColor blueColor] setFill];
    [p fill];
    
    //填充
//    [[UIColor redColor]setStroke];
//    [p stroke];
}
/* 平移，缩放，旋转 */
//-(void)drawRect:(CGRect)rect
//{
//    NSString * path = [[NSBundle mainBundle]pathForResource:@"testImage" ofType:@"png"];
//    UIImage * image = [UIImage imageWithContentsOfFile:path];
//    CGImageRef img = image.CGImage;
//
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSaveGState(context);
//
//
//    //需要转换坐标系
//    CGContextTranslateCTM(context, 0,image.size.height+200);
//    CGContextScaleCTM(context, 1, -1);
//
//    //平移变换
//    //CGContextTranslateCTM(context, 100,100);
//
//    //缩放变换 >1放大 <1缩小 =1不变
//    //CGContextScaleCTM(context, 2, 2);
//
//    //旋转变换 弧度转角度
////    CGContextRotateCTM(context, radians(45.0));
//
//    CGRect imgRect = CGRectMake(0, 100, image.size.width, image.size.height);
//    CGContextDrawImage(context, imgRect, img);
//
//    CGContextRestoreGState(context);
//}

/* 两个控制点弧形 */
//-(void)drawRect:(CGRect)rect
//{
//    CGPoint startPoint = CGPointMake(0, 300);//起始点
//    CGPoint endPoint = CGPointMake(400, 300);//结束点
//    CGPoint controlPoint1 = CGPointMake(100, 100);//控制点1
//    CGPoint controlPoint2 = CGPointMake(300, 400);//控制点2
//
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextMoveToPoint(context, startPoint.x, startPoint.y);
//    CGContextAddCurveToPoint(context, controlPoint1.x, controlPoint1.y, controlPoint2.x, controlPoint2.y, endPoint.x, endPoint.y);
//    [[UIColor redColor] setStroke];
//    CGContextStrokePath(context);
//
//}

/* 一个控制点弧形 */
//-(void)drawRect:(CGRect)rect
//{
//    CGPoint startPoint = CGPointMake(100, 300);//起始点
//    CGPoint endPoint = CGPointMake(250, 300);//结束点
//    CGPoint controlPoint = CGPointMake(100, 80);//控制点
//
//
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextMoveToPoint(context, startPoint.x, startPoint.y);
//    CGContextAddQuadCurveToPoint(context, controlPoint.x, controlPoint.y, endPoint.x, endPoint.y);
//    [[UIColor redColor] setStroke];
//    CGContextStrokePath(context);
//
//}

/* 绘制圆角矩形 */
//-(void)drawRect:(CGRect)rect
//{
//    CGRect testRect = CGRectMake(50, 100, 300, 150);
//    CGFloat radius = 10.0;
//
//    CGFloat minx = CGRectGetMinX(testRect);
//    CGFloat  midx = CGRectGetMidX(testRect);
//    CGFloat maxx = CGRectGetMaxX(testRect);
//
//    CGFloat minY = CGRectGetMinY(testRect);
//    CGFloat  midY = CGRectGetMidY(testRect);
//    CGFloat maxY = CGRectGetMaxY(testRect);
//
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextMoveToPoint(context, minx, midY);
//    CGContextAddArcToPoint(context, minx, minY, midx, minY, radius);
//    CGContextAddArcToPoint(context, maxx, minY, maxx, midY, radius);
//    CGContextAddArcToPoint(context, maxx, maxY, midx, maxY, radius);
//    CGContextAddArcToPoint(context, minx, maxY, minx, midY, radius);
//    CGPDFContextClose(context);
//
//    [[UIColor redColor]setStroke];
//    [[UIColor blueColor]setFill];
//    CGContextDrawPath(context, kCGPathFillStroke);
//
//}

/* 绘制圆形 */
//-(void)drawRect:(CGRect)rect
//{
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextAddEllipseInRect(context, CGRectMake(100,130,160,160));//画一个椭圆或者圆
//    [[UIColor redColor]setStroke];
//    [[UIColor blueColor]setFill];
//
//    CGContextStrokePath(context);
//
//}

/* 绘制圆形 -02 */
//-(void)drawRect:(CGRect)rect
//{
//    UIBezierPath* p = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(100,100,100,100)];
//
//    [[UIColor blueColor] setFill];
//    [p fill];

    //    [[UIColor redColor]setStroke];
    //    [p stroke];
//}

/* 绘制参数save和restore */
//-(void)drawRect:(CGRect)rect
//{
//    CGContextRef contextRef = UIGraphicsGetCurrentContext();
//    CGContextMoveToPoint(contextRef, 100, 150);
//    CGContextAddLineToPoint(contextRef, 50, 200);
//    CGContextAddLineToPoint(contextRef, 150, 200);
//    CGContextClosePath(contextRef);
//
//    [[UIColor redColor]setStroke];
//    [[UIColor blueColor]setFill];
//    CGContextSaveGState(contextRef);//保存之前设置
//
//    [[UIColor brownColor]setFill];
//    CGContextRestoreGState(contextRef);//恢复之前设置
//
//    CGContextDrawPath(contextRef, kCGPathFillStroke);
//
//    //CGContextSaveGState 保存之前设置的参数 ，如不调用 CGContextRestoreGState恢复则按之后设置的参数调用，反之还是按之前调用。Model:上例填充色先设填充色为blue->save->再设填充色为brown->恢复->绘制结果为blue else brown。
//}
/* 绘制三角形 */
//-(void)drawRect:(CGRect)rect
//{
//    CGContextRef contextRef = UIGraphicsGetCurrentContext();
//    CGContextMoveToPoint(contextRef, 100, 150);
//    CGContextAddLineToPoint(contextRef, 50, 200);
//    CGContextAddLineToPoint(contextRef, 150, 200);
//    CGContextClosePath(contextRef);
//
//    [[UIColor redColor]setStroke];
//    [[UIColor blueColor]setFill];
//    CGContextDrawPath(contextRef, kCGPathFillStroke);
//}

/* 两个正反三角 */
//-(void)drawRect:(CGRect)rect
//{
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextMoveToPoint(context, 100, 100);
//    CGContextAddLineToPoint(context, 180, 100);
//    CGContextAddLineToPoint(context, 100, 200);
//    CGContextAddLineToPoint(context, 180, 200);
//    CGPDFContextClose(context);
//
//    [[UIColor redColor]setFill];
//    CGContextDrawPath(context,kCGPathFillStroke);
//}

/* 绘制imageAndString */
//- (void)drawRect:(CGRect)rect {
//    NSString * path = [[NSBundle mainBundle]pathForResource:@"player_mini_pause@2x" ofType:@"png"];
//    UIImage * image = [UIImage imageWithContentsOfFile:path];
//    [image drawAtPoint:CGPointMake(100, 100)];
//    //[image drawInRect:rect];//图小于rect拉伸显示
//    //[image drawAsPatternInRect:rect];//图小于rect则会多个平铺
//
//    NSString * testStr = @"我在测试";
//    UIFont * font = [UIFont systemFontOfSize:20];
//    NSDictionary * attDic = @{NSFontAttributeName:font,NSForegroundColorAttributeName:[UIColor whiteColor]};
//    [testStr drawAtPoint:CGPointMake(100, 200) withAttributes:attDic];
//    //[testStr drawAtPoint:CGPointMake(100, 100) withAttributes:attDic];
//
//}

/* 简单矩形绘制 */
//- (void)drawRect:(CGRect)rect {
//    //填充图形+
//    [[UIColor redColor] setFill];
//    UIRectFill(rect);
//
//    //描边图形
//    [[UIColor whiteColor]setStroke];
//    UIRectFrame(CGRectMake(20,100 , 100, 180));
//
//}

#pragma mark -- API
/****************** API *********************/
//[[UIColor redColor] setFill];
//[[UIColor whiteColor]setStroke];
//CGContextSetRGBStrokeColor(context, 100, 10, 10, 1);//描边颜色
//CGContextSetRGBFillColor(context, 100, 1, 10, 1);//填充色
//CGContextSetLineWidth(context, 2);//线宽
//CGContextClosePath(contextRef); //闭合路径
//kCGPathFillStroke //填充描边处理
//kCGPathFill       //填充处理
//kCGPathStroke     //描边处理
@end
