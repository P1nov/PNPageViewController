//
//  HYSegmentedView.h
//  huiyao
//
//  Created by 雷永麟 on 2018/9/13.
//  Copyright © 2018年 雷永麟. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum{
    HYIsSelected = 0,
    HYNotSelected = 1
} HYSelectedType;

@protocol HYSegmentedViewDelegate<NSObject>

- (void)clickedWithType:(HYSelectedType)type andTag:(NSInteger)tag;

@end

@interface HYSegmentedView : UIView

@property (nonatomic, strong) UILabel *tipLabel;

@property (nonatomic, strong) UILabel *dataLabel;

@property (nonatomic, copy) NSString *dataNum;

@property (nonatomic) HYSelectedType type;

@property (nonatomic, weak) id<HYSegmentedViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame andTitle:(NSString *)title andData:(NSString *)data;

- (void)setSelectedColor:(UIColor *)color forType:(HYSelectedType)type;

@end
