//
//  ViewController.m
//  BCHPickerViewDemo
//
//  博客地址:http://www.jianshu.com/users/87fa399169a8/latest_articles
//  微博地址:http://weibo.com/5612084818/profile?topnav=1&wvr=6&is_all=1
//  github地址:https://github.com/Baichenghui
//
//  Created by coderbai on 2016/11/9.
//  Copyright © 2016年 coderbai. All rights reserved.
//

#import "ViewController.h"
#import "BCHPickerView.h"
@interface ViewController ()
@property (nonatomic,strong) BCHPickerView *pickerView;
@property (nonatomic,copy) NSString *selectedValue;
@property (nonatomic,strong) NSMutableArray *items;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.selectedValue = self.items[0];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)showDefualtAction:(id)sender {
    [BCHPickerView bch_PickerViewInView:self.view
                                  items:self.items
                                options:@{BCHSelectedObject:self.selectedValue}
                             completion:^(BCHPickerView *view, NSInteger selectedIndex, NSString *selectedValue) {
                                 self.selectedValue = selectedValue;
                             }];
}

- (IBAction)showCustomAction:(id)sender {
    [BCHPickerView bch_PickerViewInView:self.view 
                                  items:self.items
                                options:@{
                                          BCHItemHeight:@"35",
                                          BCHToolBarHeight:@"35",
                                          BCHButtonFont:[UIFont systemFontOfSize:15],
                                          BCHButtonTextColor:[UIColor colorWithRed:51/255.0 green:219 /255.0 blue:172/255.0 alpha:1.0],
                                          BCHBackgroundColor: [UIColor blueColor],
                                          BCHToolBarBackgroundColor:[UIColor redColor],
                                          BCHToolBarTopBorderColor:[UIColor groupTableViewBackgroundColor],
                                          BCHToolBarBottomBorderColor:[UIColor groupTableViewBackgroundColor],
                                          BCHSelectedObject:self.selectedValue,
                                          BCHItemBackgroundColor:[UIColor orangeColor],
                                          BCHTextColor:[UIColor cyanColor],
                                          BCHTextFont:[UIFont systemFontOfSize:20],
                                          }
                             completion:^(BCHPickerView *view, NSInteger selectedIndex, NSString *selectedValue) {
                                 NSLog(@"view:%@",view);
                                 NSLog(@"selectedIndex:%ld",selectedIndex);
                                 NSLog(@"selectedValue:%@",selectedValue);
                                 self.selectedValue = selectedValue;
    }];
}

-(NSMutableArray *)items{
    if (_items == nil) {
        NSArray *array = @[@"A",@"B",
                           @"C",@"D",
                           @"E",@"F",
                           @"G",@"H"];
        _items = [NSMutableArray  arrayWithArray:array];
    }
    return _items;
}
@end
