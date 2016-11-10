//
//  BCHPickerView.h
//  BCHPickerViewDemo
//
//  博客地址:http://www.jianshu.com/users/87fa399169a8/latest_articles
//  微博地址:http://weibo.com/5612084818/profile?topnav=1&wvr=6&is_all=1
//  github地址:https://github.com/Baichenghui
//
//  Created by coderbai on 2016/11/9.
//  Copyright © 2016年 coderbai. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BCHPickerView; 

extern NSString * const BCHItemHeight;
extern NSString * const BCHToolBarHeight;
extern NSString * const BCHTextColor;
extern NSString * const BCHTextFont;
extern NSString * const BCHBackgroundColor;
extern NSString * const BCHItemBackgroundColor;
extern NSString * const BCHToolBarBackgroundColor;
extern NSString * const BCHToolBarTopBorderColor;
extern NSString * const BCHToolBarBottomBorderColor;
extern NSString * const BCHButtonColor;
extern NSString * const BCHButtonFont;
extern NSString * const BCHButtonTextColor;
extern NSString * const BCHSelectedObject;
extern NSString * const BCHMaskViewBackgroundColor;

#pragma mark - BCHPickerView
@interface BCHPickerView : UIView
+(void)bch_PickerViewInView:(UIView *)view 
                              items:(NSArray *)items
                            options:(NSDictionary *)options
                         completion: (void(^)(BCHPickerView *view,NSInteger selectedIndex,NSString *selectedValue))completion;
@end

#pragma mark - BCHPickItemView
@interface BCHPickItemView : UIView
+(instancetype)pickItemView;
-(void)configTitle:(NSString *)title
        titleColor:(UIColor *)titleColor
         titleFont:(UIFont *)titleFont
   backgroundColor:(UIColor *)backgroundColor
            height:(CGFloat)height;
@end
