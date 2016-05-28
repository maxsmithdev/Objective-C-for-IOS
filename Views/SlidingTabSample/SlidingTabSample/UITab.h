//
//  UIButton.h
//  SlidingTabSample
//
//  Created by vincent li on 27/5/2016.
//  Copyright © 2016年 Max Smith Dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UITabDelegate;
@interface UITab : UIControl{
    //Private Object
    NSDictionary *info;
    UIImageView *iconImageView;
    UILabel *titleLabel;
    
}

@property (assign, nonatomic) id<UITabDelegate> delegate;

- (CGFloat)init:(NSDictionary *)tagInfo;
- (void)showMessage:(NSString *)message withTitle:(NSString *)title;
- (void)onClickEvent:(id)sender;

@end

@protocol UITabDelegate <NSObject>

@optional
- (void)onTabClickEvent:(id)sender;

@end