//
//  ViewController.m
//  SSZSwitch
//
//  Created by qijian on 16/4/26.
//  Copyright © 2016年 SSZ. All rights reserved.
//

#import "ViewController.h"

#import "sszSwitch.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    sszSwitch *switch0 = [[sszSwitch alloc] initWithFrame:CGRectMake(100, 100, 60, 31)];
    switch0.backgroundColor = [UIColor clearColor];
    [switch0 addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:switch0];
    
    sszSwitch *switch1 = [[sszSwitch alloc] initWithFrame:CGRectMake(100, 140, 60, 31)];
    switch1.backgroundColor = [UIColor clearColor];
    switch1.tintColor = [UIColor grayColor];
    [switch1 addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:switch1];
    
    sszSwitch *switch2 = [[sszSwitch alloc] initWithFrame:CGRectMake(100, 180, 65, 31)];
    switch2.backgroundColor = [UIColor clearColor];
    switch2.tintColor = [UIColor lightGrayColor];
    //[switch2 setOn:NO animated:YES];
    switch2.onText = @"ON";
    switch2.offText = @"OFF";
    [switch2 addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:switch2];
    
    
    
}

-(void)valueChanged:(id)switchChange {

    NSLog(@"%s", __FUNCTION__);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
