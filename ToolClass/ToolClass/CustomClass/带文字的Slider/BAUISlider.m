#import "BAUISlider.h"
#import <Masonry.h>

// 屏幕宽屏幕高 屏幕bounds
#define BASCREENWIDTH  [UIScreen mainScreen].bounds.size.width
#define BASCREENHEIGH  [UIScreen mainScreen].bounds.size.height
#define SCREEN_BOUNDS ([UIScreen mainScreen].bounds)

// 适配
#define BANEWWIDTH                     [UIScreen mainScreen].bounds.size.width/375
#define BANEWHEIGHT                    [UIScreen mainScreen].bounds.size.height/667

#define BAScale_WIDTH(a)               (a*BANEWWIDTH)
#define BAScale_HEIGHT(a)              (a*BANEWHEIGHT)

#define thumbBound_x 10
#define thumbBound_y 20

@interface BAUISlider ()

@property(nonatomic, assign) CGRect lastBounds;
@end

@implementation BAUISlider

//解决自定义滑块图片左右有间隙问题
- (CGRect)thumbRectForBounds:(CGRect)bounds trackRect:(CGRect)rect value:(float)value
{
    
    rect.origin.x = rect.origin.x-10;
    rect.size.width = rect.size.width + 20;
    CGRect result = [super thumbRectForBounds:bounds trackRect:rect value:value];
    
    _lastBounds = result;
    return result;
}

//解决滑块不灵敏
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    
    UIView *result = [super hitTest:point withEvent:event];
    if (point.x < 0 || point.x > self.bounds.size.width){
        
        return result;
        
    }
    
    if ((point.y >= -thumbBound_y) && (point.y < _lastBounds.size.height + thumbBound_y)) {
        float value = 0.0;
        value = point.x - self.bounds.origin.x;
        value = value/self.bounds.size.width;
        
        value = value < 0? 0 : value;
        value = value > 1? 1: value;
        
        value = value * (self.maximumValue - self.minimumValue) + self.minimumValue;
        if(self.isResponseEvent == NO)
        {
            [self setValue:value animated:YES];
        }
    }
    return result;
    
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    BOOL result = [super pointInside:point withEvent:event];
    if (!result && point.y > -10) {
        if ((point.x >= _lastBounds.origin.x - thumbBound_x) && (point.x <= (_lastBounds.origin.x + _lastBounds.size.width + thumbBound_x)) && (point.y < (_lastBounds.size.height + thumbBound_y))) {
            result = YES;
        }
        
    }
    return result;
}

-(void)setIsShowTitle:(BOOL)isShowTitle{
    _isShowTitle = isShowTitle;
    
    if (_isShowTitle == YES) {
        //滑块的响应事件
//        [self addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
        self.continuous = YES;// 设置可连续变化

        // 当前值label
        self.sliderValueLabel = [[UILabel alloc] init];
        self.sliderValueLabel.textAlignment = NSTextAlignmentCenter;
        self.sliderValueLabel.font = [UIFont systemFontOfSize:10];
        self.sliderValueLabel.textColor = [UIColor colorWithRed:162.0/255.0f green:162.0/255.0f blue:162.0/255.0f alpha:1.0];
        (162, 162, 162);
        self.sliderValueLabel.text = [NSString stringWithFormat:@"%@", [self sliderStatWithValue:self.value]];
        [self addSubview:self.sliderValueLabel];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            UIImageView *slideImage = (UIImageView *)[self.subviews lastObject];
            
            //滑块的值
            [self.sliderValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                if (self.titleStyle == TopTitleStyle) {
                    make.bottom.mas_equalTo(slideImage.mas_top).offset(-1);
                }else{
                    make.top.mas_equalTo(slideImage.mas_bottom).offset(1);
                }
                
                make.centerX.equalTo(slideImage);
            }];
        });
    }
}

- (void)sliderAction:(UISlider*)slider{
    NSString * title = [self sliderStatWithValue:slider.value];
    self.sliderValueLabel.text = title;
//    //滑块的值
//    self.sliderValueLabel.text = [NSString stringWithFormat:@"%.f%%", self.value];
}

-(NSString *)sliderStatWithValue:(float)value
{
    NSString * title;
    if(value >= 0  && value <= 3)
    {
        title = @"了解";
    }
    if(value > 3  && value <= 6)
    {
        title = @"良好";
    }
    if(value > 6  && value <= 9)
    {
        title = @"熟练";
    }
    if(value > 9  && value <= 12)
    {
        title = @"精通";
    }
    if(value > 12  && value <= 15)
    {
        title = @"专家";
    }
    return title;
}

-(float)sliderStrWithValue:(NSString *)str
{
    if([str isEqualToString:@"了解"])
    {
        return 3;
    }
    else if([str isEqualToString:@"良好"])
    {
        return 6;
    }
    else if([str isEqualToString:@"熟练"])
    {
        return 9;
    }
    else if([str isEqualToString:@"精通"])
    {
        return 12;
    }
    else if([str isEqualToString:@"专家"])
    {
        return 15;
    }
    return 0;
}
//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    NSLog(@"------slider");
//}
@end
