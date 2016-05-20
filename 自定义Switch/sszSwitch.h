//
//  sszSwitch.h
//  SSZSwitch
//
//  Created by qijian on 16/4/26.
//  Copyright © 2016年 SSZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface sszSwitch : UIControl


//@property (nonatomic, assign) BOOL isOn;

//开关 getter方法
@property (nonatomic, assign, getter=isOn) BOOL on;


//onTintColor 开状态下的“背景”色
@property (nonatomic, strong)UIColor *onTintColor;
//tintColor 关状态下的“边框”颜色
@property (nonatomic, strong)UIColor *tintColor;


//UISwitch的背景图片设置无效
//onImage设置开启图片
//offImage设置关闭图片


//thumbTintColor 圆形按钮(拇指)颜色
@property (nonatomic, strong)UIColor *thumbTintColor;

//设置开关圆圈View
@property (nonatomic, strong)UIView *thumbView;


//设置开启View
@property (nonatomic, strong)UIView *onView;
//设置开启Label
@property (nonatomic, strong)UILabel *onLabel;
//设置开启字体
@property (nonatomic, strong)NSString *onText;

//设置关闭View
@property (nonatomic, strong)UIView *offView;
//设置关闭Label
@property (nonatomic, strong)UILabel *offLabel;
//设置关闭字体
@property (nonatomic, strong)NSString *offText;


//设置字体颜色
@property (nonatomic, strong)UIColor *textColor;
//设置字体大小
@property (nonatomic, strong)UIFont *textFont;


//设置容器的View
@property (nonatomic, strong)UIView *containerView;

//设置开启/关闭状态
//设置YES或NO，是否使用animated动画效果：
-(void)setOn:(BOOL)on animated:(BOOL)animated;

-(void)commonInit;

-(CGRect)roundRect:(CGRect )frameOrBoounds;

//添加动作事件
//tap 点击手势
-(void)tapGestureRecognizer:(UITapGestureRecognizer *)tapGestureRecognizer;
//pan 移动手势
-(void)panGestureRecognizer:(UIPanGestureRecognizer *)panGestureRecognizer;




@end
