//
//  HYSegmentedControl.h
//  huiyao
//
//  Created by 雷永麟 on 2018/9/13.
//  Copyright © 2018年 雷永麟. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HYSegmentedControlDelegate<NSObject>

- (void)clickToChangeView:(NSInteger)index;

@end

@interface HYSegmentedControl : UIView

@property (nonatomic, strong) NSArray *titleArray;

@property (nonatomic, strong) UIView *indicator;

@property (nonatomic, assign) NSInteger selectIndex;

- (instancetype)initWithFrame:(CGRect)frame andSelectIndex:(NSInteger)index andTitle:(NSArray *)titles andData:(NSArray *)datas;

- (instancetype)initWithJuniorFrame:(CGRect)frame andSelectIndex:(NSInteger)index andTitle:(NSArray *)titles andData:(NSArray *)datas;

- (instancetype)initWithDialFrame:(CGRect)frame andSelectIndex:(NSInteger)index andTitle:(NSArray *)titles;

@property (nonatomic, weak) id<HYSegmentedControlDelegate> delegate;

@end
