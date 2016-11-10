//
//  BCHPickerView.m
//  BCHPickerViewDemo
//
//  博客地址:http://www.jianshu.com/users/87fa399169a8/latest_articles
//  微博地址:http://weibo.com/5612084818/profile?topnav=1&wvr=6&is_all=1
//  github地址:https://github.com/Baichenghui
//
//  Created by coderbai on 2016/11/9.
//  Copyright © 2016年 coderbai. All rights reserved.
//

#import "BCHPickerView.h"
NSString * const BCHItemHeight = @"itemHeight";
NSString * const BCHToolBarHeight = @"toolBarHeight";
NSString * const BCHTextColor = @"textColor";
NSString * const BCHTextFont = @"font";
NSString * const BCHBackgroundColor = @"backgroundColor";
NSString * const BCHItemBackgroundColor = @"itemBackgroundColor";
NSString * const BCHToolBarBackgroundColor = @"toolBarBackgroundColor";
NSString * const BCHToolBarTopBorderColor = @"toolBarTopBorderColor";
NSString * const BCHToolBarBottomBorderColor = @"toolBarBottomBorderColor";
NSString * const BCHButtonColor = @"buttonColor";
NSString * const BCHButtonFont = @"buttonFont"; 
NSString * const BCHButtonTextColor = @"buttonTextColor";
NSString * const BCHSelectedObject = @"selectedObject";
NSString * const BCHMaskViewBackgroundColor = @"maskViewBackgroundColor";

typedef void(^BCHPickerViewClickConfirmCompletionBlock)(BCHPickerView *view,NSInteger selectedIndex,NSString *selectedValue);

@interface BCHPickerView()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic, strong) BCHPickerViewClickConfirmCompletionBlock completionBlock;
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIView *toolBarView;
@property (nonatomic, strong) UIButton *cancleButton;
@property (nonatomic, strong) UIButton *confirmButton;
@property (nonatomic,copy) NSString *selectValue;
@property (nonatomic,strong) NSDictionary *options;

@end

@implementation BCHPickerView

static BCHPickerView* sharedView;
+ (BCHPickerView*)sharedView {
    if (!sharedView) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            sharedView = [[self alloc] init];
        });
    }
    return sharedView;
}

+(void)bch_PickerViewInView:(UIView *)view
                      items:(NSArray *)items
                    options:(NSDictionary *)options
                 completion: (void(^)(BCHPickerView *view,NSInteger selectedIndex,NSString *selectedValue))completion{
    [self sharedView].completionBlock = completion;
    [[self sharedView] initializePickerViewInView:view 
                                            items:items
                                          options:options];
    [view addSubview:[self sharedView]];
} 
-(void)initializePickerViewInView:(UIView *)view
                            items:(NSArray *)items
                          options:(NSDictionary *)options{
    _items = items;
    _options = options;
    self.frame = view.bounds;
    id selectedObject = _options[BCHSelectedObject];
    NSInteger selectedRow;
    if (selectedObject != nil) {
        selectedRow = [_items indexOfObject:selectedObject];
    }else{
        selectedRow = [[_items objectAtIndex:0] integerValue];
    }
    //_maskView
    _maskView = [[UIView alloc] initWithFrame:view.bounds];
    _maskView.userInteractionEnabled = YES;
    _maskView.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5];
    [self addSubview:_maskView];
    UIColor *maskViewBackgroundColor = (UIColor *)_options[BCHMaskViewBackgroundColor];
    if (maskViewBackgroundColor != nil) {
        _maskView.backgroundColor = maskViewBackgroundColor;
    }
    //_pickerContainerView
    _contentView = [[UIView alloc] initWithFrame:CGRectMake(0.0, _maskView.bounds.size.height, view.bounds.size.width, 260.0)];
    _contentView.userInteractionEnabled = YES;
    [_maskView addSubview:_contentView];
    
    //toolBar
    CGFloat toolBarHeight = (_options[BCHToolBarHeight] != nil) ? [_options[BCHToolBarHeight] floatValue] : 44;
    _toolBarView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, view.bounds.size.width, toolBarHeight)];
    _toolBarView.userInteractionEnabled = YES;
    [_contentView addSubview:_toolBarView];
    _toolBarView.backgroundColor = [UIColor whiteColor];
    UIColor *toolBarBackgroundColor = _options[BCHToolBarBackgroundColor];
    if (toolBarBackgroundColor != nil) {
        _toolBarView.backgroundColor = toolBarBackgroundColor;
    }
    //取消
    _cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_toolBarView addSubview:_cancleButton];
    _cancleButton.frame = CGRectMake(0, 0, 60, toolBarHeight);
    [_cancleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_cancleButton setTitle:@"取消" forState:UIControlStateNormal];
    _cancleButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [_cancleButton addTarget:self action:@selector(cancleClick) forControlEvents:UIControlEventTouchUpInside];
    _cancleButton.titleLabel.font = [UIFont systemFontOfSize:16];
    //确定
    _confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_toolBarView addSubview:_confirmButton];
    _confirmButton.frame = CGRectMake(view.bounds.size.width - 60, 0, 60, toolBarHeight);
    [_confirmButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_confirmButton setTitle:@"确定" forState:UIControlStateNormal];
    _confirmButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [_confirmButton addTarget:self action:@selector(confirmClick) forControlEvents:UIControlEventTouchUpInside];
    _confirmButton.titleLabel.font = [UIFont systemFontOfSize:16];
    UIColor *buttonTextColor = _options[BCHButtonTextColor];
    if (buttonTextColor != nil) {
        [_cancleButton setTitleColor:buttonTextColor forState:UIControlStateNormal];
        [_confirmButton setTitleColor:buttonTextColor forState:UIControlStateNormal];
    }
    UIColor *buttonColor = _options[BCHButtonColor];
    if (buttonColor != nil) {
        [_cancleButton setBackgroundColor:buttonColor];
        [_confirmButton setBackgroundColor:buttonColor];
    }
    UIFont *buttonFont = _options[BCHButtonFont];
    if (buttonFont != nil) {
       _confirmButton.titleLabel.font = buttonFont;
       _cancleButton.titleLabel.font = buttonFont;
    }
    UIColor *toolBarTopBorderColor = options[BCHToolBarTopBorderColor];
    if (toolBarBackgroundColor != nil) {
        [self addTopBorderForView:_toolBarView Height:0.5 color:toolBarTopBorderColor];
    }else{
        [self addTopBorderForView:_toolBarView Height:0.5 color:[UIColor groupTableViewBackgroundColor]];
    }
    UIColor *toolBarBottomBorderColor = options[BCHToolBarBottomBorderColor];
    if (toolBarBottomBorderColor != nil) {
        [self addBottomBorderForView:_toolBarView Height:0.5 color:toolBarBottomBorderColor];
    }else{
        [self addBottomBorderForView:_toolBarView Height:0.5 color:[UIColor groupTableViewBackgroundColor]];
    }
    //_pickerView
    _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, toolBarHeight, view.bounds.size.width, 260 - toolBarHeight)];
    _pickerView.dataSource = self;
    _pickerView.delegate = self;
    [_contentView addSubview:_pickerView];
    _pickerView.backgroundColor = (_options[BCHBackgroundColor] != nil) ? _options[BCHBackgroundColor]: [UIColor whiteColor];
    [self pickerView:self.pickerView didSelectRow:selectedRow inComponent:0];
    [_pickerView selectRow:selectedRow inComponent:0 animated:YES];
    //gesture
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bch_remove)];
    [self addGestureRecognizer:gestureRecognizer];
    UITapGestureRecognizer *toolBarGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bch_toolBarClick)];
    [_toolBarView addGestureRecognizer:toolBarGestureRecognizer];
    //show
    [self bch_show];
}
-(void)bch_toolBarClick{}
-(void)bch_show{
    [UIView animateWithDuration:0.25 animations:^{
        self.contentView.transform = CGAffineTransformMakeTranslation(0,-260);
    }];
}
-(void)bch_remove{
    [UIView animateWithDuration:0.25 animations:^{
        self.contentView.transform = CGAffineTransformMakeTranslation(0,260);
    } completion:^(BOOL finished) {
        [self.maskView removeFromSuperview];
        [self.contentView removeFromSuperview];
        [self  removeFromSuperview];
    }];
}
#pragma mark - Events
-(void)cancleClick{
    [self bch_remove];
}
-(void)confirmClick{
    [self bch_remove];
    if (_completionBlock) {
        _completionBlock(self,[_items indexOfObject:self.selectValue],self.selectValue);
    }
}
#pragma mark - UIPickerViewDelegate,UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.items.count;
}
#pragma mark - UIPickerViewDelegate
-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    BCHPickItemView *itemView = [BCHPickItemView pickItemView];
    UIColor *titleColor = (_options[BCHTextColor] != nil) ? _options[BCHTextColor] :[UIColor blackColor];
    UIFont *titleFont = (_options[BCHTextFont] != nil) ? _options[BCHTextFont]: [UIFont systemFontOfSize:16];
    UIColor *itemColor = (_options[BCHItemBackgroundColor] != nil) ? _options[BCHItemBackgroundColor]: [UIColor whiteColor];
    CGFloat itemHeight = (_options[BCHItemHeight] != nil) ? [_options[BCHItemHeight] floatValue] : 44;
    [itemView configTitle:self.items[row] titleColor:titleColor titleFont:titleFont backgroundColor:itemColor height:itemHeight];
    return itemView;
}
-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return (_options[BCHItemHeight] != nil) ? [_options[BCHItemHeight] floatValue] : 44;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return self.items[row];
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    self.selectValue = [_items objectAtIndex:row];
    self.completionBlock(self,row,self.selectValue);
}
#pragma mark - utils
-(void)addTopBorderForView:(UIView *)view Height: (CGFloat)height color:(UIColor*)color{
    [self addBorderForView:view frame:CGRectMake(0, 0, view.frame.size.width, height) color:color];
}
-(void)addBottomBorderForView:(UIView *)view Height: (CGFloat)height color:(UIColor*)color{
    [self addBorderForView:view frame:CGRectMake(0, view.frame.size.height - height, view.frame.size.width, height) color:color];
}
-(void)addBorderForView:(UIView *)view frame:(CGRect)frame color:(UIColor*)color{
    CALayer *border = [CALayer layer];
    border.frame = frame;
    [border setBackgroundColor:color.CGColor];
    [view.layer addSublayer:border];
}
@end

#pragma mark - BCHPickItemView
@interface BCHPickItemView()
@property (strong, nonatomic) UILabel *txtLable;
@end
@implementation BCHPickItemView
+(instancetype)pickItemView{
    return [[self alloc]init];
}
- (instancetype)init{
    self = [super init];
    if (self) {
        if (!_txtLable) {
            _txtLable = [[UILabel alloc] init];
            _txtLable.numberOfLines = 0;
            _txtLable.textAlignment = NSTextAlignmentCenter;
            [self addSubview:_txtLable];
        }
    }
    return self;
}
-(void)configTitle:(NSString *)title
        titleColor:(UIColor *)titleColor
         titleFont:(UIFont *)titleFont
   backgroundColor:(UIColor *)backgroundColor
            height:(CGFloat)height{
    
    _txtLable.text = title;
    _txtLable.textColor = titleColor;
    _txtLable.font = titleFont;
    _txtLable.backgroundColor = backgroundColor;
    _txtLable.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width , height);
}
@end

