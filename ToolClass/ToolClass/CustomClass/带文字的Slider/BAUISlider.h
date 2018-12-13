#import <UIKit/UIKit.h>

//title显示在滑块的上方或下方
typedef enum : NSUInteger{
    TopTitleStyle,
    BottomTitleStyle
}TitleStyle;

@interface BAUISlider : UISlider

//是否显示百分比
@property (nonatomic,assign) BOOL isShowTitle;
@property (nonatomic,assign)BOOL isResponseEvent;//是否可响应事件 yes不响应 no响应
@property (nonatomic,assign) TitleStyle titleStyle;
@property(nonatomic, strong) UILabel *sliderValueLabel;//滑块下面的值

-(NSString *)sliderStatWithValue:(float)value;
-(float)sliderStrWithValue:(NSString *)str;
@end

/*Model
 self.slider = [[BAUISlider alloc] init];
 self.slider.titleStyle = TopTitleStyle;
 self.slider.isShowTitle = YES;
 self.slider.isResponseEvent = YES;
 self.slider.minimumValue = 0;
 self.slider.maximumValue = 15;
 self.slider.minimumTrackTintColor = RGBColor(2, 175, 207);
 self.slider.maximumTrackTintColor = RGBColor(227, 227, 227);
 self.slider.userInteractionEnabled = NO;
 [self.slider setThumbImage:[UIImage imageNamed:@"resume_skill_thum"] forState:UIControlStateNormal];
 //    self.slider.thumbTintColor = [UIColor blueColor];///设置滑块按钮的颜色
 [self.contentView addSubview:self.slider];
 [self.slider mas_makeConstraints:^(MASConstraintMaker *make) {
 make.top.bottom.equalTo(self.contentView).offset(0);
 make.left.equalTo(self.titleLabel.mas_right).offset(15);
 make.right.equalTo(self.closeBtn.mas_left).offset(-15);
 }];
 
 -(void)sliderValueChanged:(UISlider *)sender
 {
 BAUISlider * slider = (BAUISlider *)sender;
 self.slider.sliderValueLabel.text = [self.slider sliderStatWithValue:sender.value];
 NSLog(@"熟练值：%@",slider.sliderValueLabel.text);
 }
 */
