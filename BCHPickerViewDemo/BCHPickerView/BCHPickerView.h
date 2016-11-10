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

/**
 实现单列(lie)的pickerView选择

 @param view       显示在那个view上
 @param items      选择的数据数组
 @param options    定义字典控制样式
 @param completion 选择数据回调的block
 */
+(void)bch_PickerViewInView:(UIView *)view 
                              items:(NSArray *)items
                            options:(NSDictionary *)options
                         completion: (void(^)(BCHPickerView *view,NSInteger selectedIndex,NSString *selectedValue))completion;
@end

#pragma mark - BCHPickItemView
@interface BCHPickItemView : UIView


/**
 pickerView的item

 @return view
 */
+(instancetype)pickItemView;


/**
 给item属性设置值

 @param title           显示内容
 @param titleColor      内容颜色
 @param titleFont       内容字体
 @param backgroundColor 背景色
 @param height          高度
 */
-(void)configTitle:(NSString *)title
        titleColor:(UIColor *)titleColor
         titleFont:(UIFont *)titleFont
   backgroundColor:(UIColor *)backgroundColor
            height:(CGFloat)height;
@end
