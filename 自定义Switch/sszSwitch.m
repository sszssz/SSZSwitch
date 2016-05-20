//
//  sszSwitch.m
//  SSZSwitch
//
//  Created by qijian on 16/4/26.
//  Copyright © 2016年 SSZ. All rights reserved.
//

/*
 
 @property(nullable, nonatomic, strong) UIColor *onTintColor NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
 @property(null_resettable, nonatomic, strong) UIColor *tintColor NS_AVAILABLE_IOS(6_0);
 @property(nullable, nonatomic, strong) UIColor *thumbTintColor NS_AVAILABLE_IOS(6_0) UI_APPEARANCE_SELECTOR;
 
 @property(nullable, nonatomic, strong) UIImage *onImage NS_AVAILABLE_IOS(6_0) UI_APPEARANCE_SELECTOR;
 @property(nullable, nonatomic, strong) UIImage *offImage NS_AVAILABLE_IOS(6_0) UI_APPEARANCE_SELECTOR;
 
 @property(nonatomic,getter=isOn) BOOL on;
 
 - (instancetype)initWithFrame:(CGRect)frame NS_DESIGNATED_INITIALIZER;      // This class enforces a size appropriate for the control, and so the frame size is ignored.
 - (nullable instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;
 
 - (void)setOn:(BOOL)on animated:(BOOL)animated; // does not send action
 */

#import "sszSwitch.h"


#define SSZSwitchMaxHeight 31.0f
#define SSZSwitchMinHeight 31.0f

#define SSZSwitchMinWidth 51.0f

//设置开关圆圈的大小
#define SSZSwitchThumbSize 28.0f

#define DEFAULT_DURATION 0.3f

@implementation sszSwitch



//这是 重写init初始化方法的时候 必须要写的 重写父类的初始化方法 自定义的东西 都是在系统的基础上修改的 所以就重写系统的方法了
//switch
-(id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:[self roundRect:frame]];
    if (self) {
        [self commonInit];
    }
    return self;
}
//
-(id)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}


//view
-(void)setBounds:(CGRect)bounds {
    [super setBounds:[self roundRect:bounds]];
    [self setNeedsLayout];
    
}
//
-(void)setFrame:(CGRect)frame {
    [super setFrame:[self roundRect:frame]];
    [self setNeedsLayout];
    
}
//定义view上的开关
-(void)layoutSubviews {
    
    [super layoutSubviews];
    
    //view尺寸
    self.containerView.frame = self.bounds;
    
    //圆角半径
    CGFloat r = CGRectGetHeight(self.containerView.bounds)/2.0;
    
    self.containerView.layer.cornerRadius = r;
    self.containerView.layer.masksToBounds = YES;
    
    //页边空白 1
    CGFloat margin = (CGRectGetHeight(self.bounds)-SSZSwitchThumbSize) / 2.0;
    
    if (!self.isOn) {
        
        //关闭时
        //从左到右出现
        self.onView.frame = CGRectMake(-1*CGRectGetWidth(self.containerView.bounds), 0, CGRectGetWidth(self.containerView.bounds), CGRectGetHeight(self.containerView.bounds));
        self.offView.frame = CGRectMake(0,0,CGRectGetWidth(self.containerView.bounds),CGRectGetHeight(self.containerView.bounds));
        //按钮在左边
        self.thumbView.frame = CGRectMake(margin,margin,SSZSwitchThumbSize,SSZSwitchThumbSize);
        
    } else {
        
        //开启时
        self.onView.frame = CGRectMake(0, 0, CGRectGetWidth(self.containerView.bounds), CGRectGetHeight(self.containerView.bounds));
        //从右到左出现
        self.offView.frame = CGRectMake(0,CGRectGetWidth(self.containerView.bounds),CGRectGetWidth(self.containerView.bounds),CGRectGetHeight(self.containerView.bounds));
        //在右边
        self.thumbView.frame = CGRectMake(CGRectGetWidth(self.containerView.bounds) - margin - SSZSwitchThumbSize,margin,SSZSwitchThumbSize,SSZSwitchThumbSize);
        
        
    }
    
    CGFloat lHeight = 20.0f;
    CGFloat lMargin = r - (sqrt(powf(r, 2) - powf(lHeight/2.0, 2))) + margin;/////???
    
    self.onLabel.frame = CGRectMake(lMargin, r - lHeight/2.0, CGRectGetWidth(self.onView.bounds)- lMargin - SSZSwitchThumbSize - 2 * margin, lHeight);
    self.offLabel.frame = CGRectMake(SSZSwitchThumbSize + 2 * margin, r - lHeight/2.0, CGRectGetWidth(self.onView.bounds)-lMargin - SSZSwitchThumbSize - 2*margin, lHeight);
    
    
}


//自定义
-(void)setOnText:(NSString *)onText {
    if (_onText != onText) {
        _onText = onText;
        _onLabel.text = onText;
    }
}
//
-(void)setOffText:(NSString *)offText {
    if (_offText != offText) {
        _offText = offText;
        _offLabel.text = offText;
    }
}
//
-(void)setOnTintColor:(UIColor *)onTintColor {
    if (_onTintColor != onTintColor) {
        
        _onTintColor = onTintColor;
        _onView.backgroundColor = onTintColor;
    }
}
//
-(void)setTintColor:(UIColor *)tintColor {
    if (_tintColor != tintColor) {
        
        _tintColor = tintColor;
        _offView.backgroundColor = tintColor;
    }
}
//
-(void)setThumbTintColor:(UIColor *)thumbTintColor {
    if (_thumbTintColor != thumbTintColor) {
        
        _thumbTintColor = thumbTintColor;
        _thumbView.backgroundColor = _thumbTintColor;
    }
}


//开关 getter方法
-(void)setOn:(BOOL)on {
    [self setOn:on animated:NO];
}
//
-(void)setOn:(BOOL)on animated:(BOOL)animated {
    if (_on == on) {
        
        return;
    }
    
    _on = on;
    
    //1
    CGFloat margin = (CGRectGetHeight(self.bounds) - SSZSwitchThumbSize) / 2.0;
    
    if (!animated) {//无动画时
        
        if (!self.isOn) {
            
            //关状态
            self.onView.frame = CGRectMake(-1*CGRectGetWidth(self.containerView.bounds), 0, CGRectGetWidth(self.containerView.bounds), CGRectGetHeight(self.containerView.bounds));
            
            self.offView.frame = CGRectMake(0, 0, CGRectGetWidth(self.containerView.bounds), CGRectGetHeight(self.containerView.bounds));
            
            
            self.thumbView.frame = CGRectMake(margin, margin, SSZSwitchThumbSize, SSZSwitchThumbSize);
            
        } else {
            //开状态
            self.onView.frame = CGRectMake(0, 0, CGRectGetWidth(self.containerView.bounds), CGRectGetHeight(self.containerView.bounds));
            
            self.offView.frame = CGRectMake(0, CGRectGetWidth(self.containerView.bounds), CGRectGetWidth(self.containerView.bounds), CGRectGetHeight(self.containerView.bounds));
            
            self.thumbView.frame = CGRectMake(CGRectGetWidth(self.containerView.bounds) - margin - SSZSwitchThumbSize, margin, SSZSwitchThumbSize, SSZSwitchThumbSize);
            
            
        }
    } else {
        //有动画
        if (self.isOn) {
            //开状态
            [UIView animateWithDuration:DEFAULT_DURATION
                             animations:^{
                                 self.thumbView.frame = CGRectMake(CGRectGetWidth(self.containerView.bounds) - margin - SSZSwitchThumbSize,margin,SSZSwitchThumbSize,SSZSwitchThumbSize);
                             }
                             completion:^(BOOL finished){
                                 
                                 self.onView.frame = CGRectMake(0,0,CGRectGetWidth(self.containerView.bounds),CGRectGetHeight(self.containerView.bounds));
                                 
                                 self.offView.frame = CGRectMake(0,CGRectGetWidth(self.containerView.bounds),CGRectGetWidth(self.containerView.bounds),CGRectGetHeight(self.containerView.bounds));
                             }];
        } else {
            //关状态
            [UIView animateWithDuration:DEFAULT_DURATION
                             animations:^{
                                 self.thumbView.frame = CGRectMake(margin,margin,SSZSwitchThumbSize,SSZSwitchThumbSize);
                             }
                             completion:^(BOOL finished){
                                 self.onView.frame = CGRectMake(-1 * CGRectGetWidth(self.containerView.bounds),0,CGRectGetWidth(self.containerView.bounds),CGRectGetHeight(self.containerView.bounds));
                                 
                                 self.offView.frame = CGRectMake(0,0,CGRectGetWidth(self.containerView.bounds),CGRectGetHeight(self.containerView.bounds));
                             }];
        }
    }
    
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}


#pragma mark -

- (void)commonInit
{
    self.backgroundColor = [UIColor clearColor];
    
    
    _onTintColor = [UIColor greenColor];
    _tintColor = [UIColor lightGrayColor];
    _thumbTintColor = [UIColor whiteColor];
    
    
    _textFont = [UIFont systemFontOfSize:14.0f];
    _textColor = [UIColor whiteColor];
    
    //_onText = @"on";
    //_offText = @"off";
    
    _containerView = [[UIView alloc] initWithFrame:self.bounds];
    _containerView.backgroundColor = [UIColor clearColor];
    [self addSubview:_containerView];
    
    _onView = [[UIView alloc] initWithFrame:self.bounds];
    _onView.backgroundColor = _onTintColor;
    [_containerView addSubview:_onView];
    
    _offView = [[UIView alloc] initWithFrame:self.bounds];
    _offView.backgroundColor = _tintColor;
    [_containerView addSubview:_offView];
    
    _thumbView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SSZSwitchThumbSize, SSZSwitchThumbSize)];
    _thumbView.backgroundColor = _thumbTintColor;
    _thumbView.layer.cornerRadius = SSZSwitchThumbSize / 2.0;
    [_containerView addSubview:_thumbView];
    
    _onLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _onLabel.backgroundColor = [UIColor clearColor];
    _onLabel.textAlignment = NSTextAlignmentCenter;
    _onLabel.textColor = _textColor;
    _onLabel.font = _textFont;
    _onLabel.text = _onText;
    [_onView addSubview:_onLabel];
    
    _offLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _offLabel.backgroundColor = [UIColor clearColor];
    _offLabel.textAlignment = NSTextAlignmentCenter;
    _offLabel.textColor = _textColor;
    _offLabel.font = _textFont;
    _offLabel.text = _offText;
    [_offView addSubview:_offLabel];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureRecognizer:)];
    [self addGestureRecognizer:tapGesture];
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognizer:)];
    [self addGestureRecognizer:panGesture];
}

- (CGRect)roundRect:(CGRect)frameOrBounds
{
    CGRect newRect = frameOrBounds;
    
    if (newRect.size.height > SSZSwitchMaxHeight) {
        newRect.size.height = SSZSwitchMaxHeight;
    }
    
    if (newRect.size.height < SSZSwitchMinHeight) {
        newRect.size.height = SSZSwitchMinHeight;
    }
    
    if (newRect.size.width < SSZSwitchMinWidth) {
        newRect.size.width = SSZSwitchMinWidth;
    }
    
    return newRect;
}

//响应事件
- (void)tapGestureRecognizer:(UITapGestureRecognizer *)recognizer
{
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        
        [self setOn:!self.isOn animated:YES];//保证有动画时运行情况YES
    }
}

- (void)panGestureRecognizer:(UIPanGestureRecognizer *)recognizer
{
    CGFloat margin = (CGRectGetHeight(self.bounds) - SSZSwitchThumbSize) / 2.0;
    CGFloat offset = 6.0f;///数是多少都无影响
    
    switch (recognizer.state) {
            
        case UIGestureRecognizerStateBegan:{//一个手势已经开始但尚未改变或者完成时
            if (!self.isOn) {
                //
                [UIView animateWithDuration:DEFAULT_DURATION
                                 animations:^{
                                     self.thumbView.frame = CGRectMake(margin,margin,SSZSwitchThumbSize + offset,SSZSwitchThumbSize);
                                 }];
            } else {
                //
                [UIView animateWithDuration:DEFAULT_DURATION
                                 animations:^{
                                     self.thumbView.frame = CGRectMake(CGRectGetWidth(self.containerView.bounds) - margin - (SSZSwitchThumbSize + offset),margin,SSZSwitchThumbSize + offset,SSZSwitchThumbSize);
                                 }];
            }
            break;
        }
            
        case UIGestureRecognizerStateCancelled:{
        }
            
        case UIGestureRecognizerStateFailed: {//手势失败
            
            if (!self.isOn) {
                //关状态时，还是关，拇指位置不变
                [UIView animateWithDuration:DEFAULT_DURATION
                                 animations:^{
                                     self.thumbView.frame = CGRectMake(margin,margin,SSZSwitchThumbSize,SSZSwitchThumbSize);
                                 }];
            } else {
                [UIView animateWithDuration:DEFAULT_DURATION
                                 animations:^{
                                     self.thumbView.frame = CGRectMake(CGRectGetWidth(self.containerView.bounds) - SSZSwitchThumbSize,margin,SSZSwitchThumbSize,SSZSwitchThumbSize);
                                 }];
            }
            break;
        }
            
        case UIGestureRecognizerStateChanged:{
            break;
        }
            
        case UIGestureRecognizerStateEnded:{
            
            [self setOn:!self.isOn animated:YES];
            break;
        }
            
        case UIGestureRecognizerStatePossible:{
            break;
        }
    }
}






/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
