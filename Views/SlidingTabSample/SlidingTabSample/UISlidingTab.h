//
//  UISlidingTab.h
//  SlidingTabSample
//
//  Created by vincent li on 27/5/2016.
//  Copyright © 2016年 Max Smith Dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITab.h"

@interface UISlidingTab : UIScrollView<UIScrollViewDelegate, UITabDelegate>{
    BOOL initialized;
    UITab *selectedTag;
}
@property (assign, nonatomic) NSMutableArray *info;
@property (retain, nonatomic) UIView *indicator;

- (void)init:(NSMutableArray *)tabInfo;

@end