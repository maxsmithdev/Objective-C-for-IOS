//
//  UIImageButton.m
//  SlidingTabSample
//
//  Created by vincent li on 27/5/2016.
//  Copyright © 2016年 Max Smith Dev. All rights reserved.
//

#import "UITab.h"
#ifdef __IPHONE_6_0
# define LINE_BREAK_WORD_WRAP NSLineBreakByWordWrapping
#else
# define LINE_BREAK_WORD_WRAP UILineBreakModeWordWrap
#endif

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)


@implementation UITab

- (CGFloat)init:(NSDictionary *)tagInfo{
    
    info = tagInfo;
    
    NSUInteger margin = 10;
    NSUInteger height = 0;
    UIImage *icon = [UIImage imageNamed:[info objectForKey:@"iconDefault"]];
    NSString *title = [info objectForKey:@"title"];
    
    UIView *parent = self.superview;
    height = parent != nil ? parent.frame.size.height : 40;
    
    iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(margin, height / 2 - icon.size.width / 2, icon.size.width, icon.size.height)];
    [iconImageView setImage:icon];
    
    //NSDictionary *attributes = @{NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:14]};
    //CGSize titleSize = [title boundingRectWithSize:CGSizeMake(1000, CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading attributes:attributes context:nil].size;
    //titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(icon.size.width, height / 2 - titleSize.height / 2, titleSize.width, icon.size.height)];
    
    titleLabel = [[UILabel alloc] init];
    titleLabel.numberOfLines = 0;
    //titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    titleLabel.textColor = [[UIColor alloc] initWithRed:20/255.0 green:222/255.0 blue:2/255.0 alpha:1];
    titleLabel.text = title;
    
    /*
     * auto calculator text width
     */
    [titleLabel sizeToFit];
    titleLabel.frame = CGRectMake(iconImageView.frame.size.width + margin + 5, height / 2 - titleLabel.frame.size.height / 2, titleLabel.frame.size.width, titleLabel.frame.size.height);
    
    //self.clipsToBounds = NO;
    [self addSubview:iconImageView];
    [self addSubview:titleLabel];
    [self setBackgroundColor:[[UIColor alloc] initWithRed:100/255.0 green:2/255.0 blue:2/255.0 alpha:0.2f]];
    
    CGFloat width = titleLabel.frame.size.width + iconImageView.frame.size.width + (margin * 2) + 5;
    self.frame = CGRectMake(0, 0, width, height); //2 for indicator
    
    [self addTarget:self action:@selector(onClickEvent:) forControlEvents:UIControlEventTouchDown];
    //[self targetForAction:@selector(onClickEvent:) withSender:self];
    //[self performSelector:@selector(onClickEvent:) withObject:data afterDelay:100];
    
    return width;
}

- (void)onClickEvent:(id)sender{
    NSLog(@"onClickEvent");
    
    if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0.0")){
        if([_delegate respondsToSelector:@selector(onTabClickEvent:)]){
            [_delegate onTabClickEvent:self];
        }
        //[self showMessage:@"You Clicked!" withTitle:@"Alert Dialog"];
    }else{
        //[[[UIAlertView alloc] initWithTitle:@"Alert Dialog"
        //                            message:@"You Clicked!"
        //                           delegate:self
        //                  cancelButtonTitle:@"Cancel"
        //                  otherButtonTitles:@"OK", "Other", "Other2"] show];
    }

}

- (void)setSelected:(BOOL)state{
    if(state == YES){
        [iconImageView setImage:[UIImage imageNamed:[info objectForKey:@"iconSelected"]]];
        titleLabel.textColor = [[UIColor alloc] initWithRed:220/255.0 green:33/255.0 blue:2/255.0 alpha:1];
    }else{
        [iconImageView setImage:[UIImage imageNamed:[info objectForKey:@"iconDefault"]]];
        titleLabel.textColor = [[UIColor alloc] initWithRed:20/255.0 green:222/255.0 blue:2/255.0 alpha:1];
    }
}

- (void)showMessage:(NSString*)message withTitle:(NSString *)title {
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:title
                                  message:message
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        
        //do something when click button
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        //do something when click button
        
    }];
    
    [alert addAction:okAction];
    [alert addAction:cancelAction];
    
    UIViewController *root = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    [root presentViewController:alert animated:YES completion:nil];
}

@end
