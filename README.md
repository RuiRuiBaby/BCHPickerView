# BCHPickerView 
 
###功能介绍
    
    基于UIPickerView控件封装的简单易用k的控件;只需要一个api就能实现功能,避免以往麻烦冗余的代码.选择数据之后会以block回调的形式得到数据.

###用法

使用 
支持iOS8.0以上

pod 'BCHPickerView'

1.```默认实现效果```

代码:
```
[BCHPickerView bch_PickerViewInView:self.view
                                  items:self.items
                                options:@{BCHSelectedObject:self.selectedValue}
                             completion:^(BCHPickerView *view, NSInteger selectedIndex, NSString *selectedValue) {
                                 self.selectedValue = selectedValue;
                             }];
```
效果:

![image](https://github.com/Baichenghui/BCHAlertView/blob/master/images/a.png)


2.```自定义效果(传一个字典即可) ```

代码:
```
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

```
效果:

![image](https://github.com/Baichenghui/BCHAlertView/blob/master/images/b.png)

 
