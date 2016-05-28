//
//  UISlidingTab.m
//  SlidingTabSample
//
//  Created by vincent li on 27/5/2016.
//  Copyright © 2016年 Max Smith Dev. All rights reserved.
//

#import "UISlidingTab.h"
#import "UITab.h"

@implementation UISlidingTab

- (void)init:(NSMutableArray *)tabInfo{
    initialized = NO;
    [self setScrollEnabled:YES];
    [self setDelegate:self];
    [self setBounces:NO]; //no overscroll
    [self setShowsHorizontalScrollIndicator:NO];
    
    _indicator = [[UIView alloc] init];
    _indicator.backgroundColor = [[UIColor alloc] initWithRed:20/255.0 green:111/255.0 blue:222/255.0 alpha:1];

    if(tabInfo != nil){
        CGFloat width = 0;
        for(NSInteger i=0;i<[tabInfo count] - 1;i++){
            UITab *tab = [[UITab alloc] init];
            NSDictionary *info = [tabInfo objectAtIndex:i];
            [self addSubview:tab];
            
            [tab setDelegate:self];
            [tab setTag: i + 1];
            [tab init:info];
            [tab setFrame: CGRectMake(width + 5, 0, tab.frame.size.width, tab.frame.size.height)];
            
            width += tab.frame.size.width + 5;
        }
        
        [self addSubview:_indicator];
        [self setContentSize: CGSizeMake(width, self.frame.size.height)];
        
        CALayer *bottomBorder = [CALayer layer];
        bottomBorder.frame = CGRectMake(0, self.frame.size.height - 1, width, 1);
        bottomBorder.backgroundColor = [[UIColor alloc] initWithRed:222/255.0 green:21/255.0 blue:23/255.0 alpha:1].CGColor;
        
        [self.layer addSublayer:bottomBorder];
        initialized = YES;
        
        NSLog(@"ScrollView [Size :%f]", width);
        
    }

    [self setTabIndicator: 1];
    
}

- (void)setTabIndicator:(NSInteger)index{
    if(initialized){
        UIView *child = [self viewWithTag:index];
        //[UITab class] == [child class]
        if([child isKindOfClass:[UITab class]]){
            
            [selectedTag setSelected:NO];
            selectedTag = (UITab *)child;
            
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationBeginsFromCurrentState:0.2];
            
            [selectedTag setSelected:YES];
            _indicator.frame = CGRectMake(selectedTag.frame.origin.x, self.frame.size.height - 6 /* border + height*/, selectedTag.frame.size.width, 5);
            [self scrollRectToVisible:CGRectMake(selectedTag.frame.origin.x, 0, self.frame.size.width, self.frame.size.height) animated:YES];
            //[self setContentOffset:position animated:YES];
            NSLog(@"Button [Size: %f , Tag: %lu]", selectedTag.frame.size.width, selectedTag.tag);
            [UIView commitAnimations];
            
        }
    }else{
        NSLog(@"UISlidingTab subview not initialized.");
    }
}

- (void)onTabClickEvent:(id)sender{
    NSLog(@"onTabClickEvent");
    if([sender isKindOfClass:[UITab class]]){
        UITab *tab = (UITab *)sender;
        [self setTabIndicator: tab.tag];
    }
}

@end