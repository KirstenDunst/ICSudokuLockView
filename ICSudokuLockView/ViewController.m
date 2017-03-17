//
//  ViewController.m
//  ICSudokuLockView
//
//  Created by CSX on 2017/3/17.
//  Copyright © 2017年 宗盛商业. All rights reserved.
//

#import "ViewController.h"
#import "ICSudokuLockView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Home_refresh_bg"]];
    
    ICSudokuLockView *lockView = [[ICSudokuLockView alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 500)];
    lockView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:lockView];
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
