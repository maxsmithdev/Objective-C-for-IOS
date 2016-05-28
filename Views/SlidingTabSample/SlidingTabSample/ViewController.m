//
//  ViewController.m
//  SlidingTabSample
//
//  Created by vincent li on 27/5/2016.
//  Copyright © 2016年 Max Smith Dev. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"viewDidLoad");
    
    NSMutableArray *tabs = [[NSMutableArray alloc] init];
    NSArray *titles = @[@"USA", @"Anguilla", @"Hong Kong", @"Japan",@"United Kingdom"];
    for(NSInteger i =0;i<10;i++){
        //C int index = rand()%10+1;
        int index = arc4random() % 4;
        [tabs addObject:@{@"iconDefault":@"ic_favroites",@"iconSelected": @"ic_bookmark", @"title": titles[index]}];
    }
    [_slidingTab init:tabs];
    
}

- (void)viewDidLayoutSubviews{
    NSLog(@"viewDidLayoutSubviews");
    
    //IOS 7 or above needed
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
