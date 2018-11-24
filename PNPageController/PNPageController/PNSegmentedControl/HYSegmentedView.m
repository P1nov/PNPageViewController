//
//  HYSegmentedView.m
//  huiyao
//
//  Created by 雷永麟 on 2018/9/13.
//  Copyright © 2018年 雷永麟. All rights reserved.
//

#import "HYSegmentedView.h"

@interface HYSegmentedView()

@property (nonatomic, strong) NSMutableDictionary *colorDic;

@end

@implementation HYSegmentedView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame andTitle:(NSString *)title andData:(NSString *)data{
    self = [super initWithFrame:frame];
    if(self){
        self.type = HYNotSelected;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setSelectedShow:) name:@"isSelected" object:nil];
        self.colorDic = [NSMutableDictionary dictionary];
        self.tipLabel = [[UILabel alloc]init];
        self.tipLabel.text = title;
        self.tipLabel.font = [UIFont systemFontOfSize:14];
        self.tipLabel.textColor = colorWithRGBA(51, 51, 51, 1.0);
        self.tipLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.tipLabel];
        [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            if(data == nil){
                make.centerY.mas_equalTo(self.mas_centerY);
            }else{
                make.bottom.mas_equalTo(self.mas_centerY);
            }
            make.width.mas_equalTo(self.mas_width).multipliedBy(0.7);
            make.height.mas_equalTo(self.mas_height).multipliedBy(0.3);
        }];
        [self addSubview:self.dataLabel];
        [self.dataLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.tipLabel.mas_centerX);
            make.top.mas_equalTo(self.tipLabel.mas_bottom).offset(3);
        }];
        self.userInteractionEnabled = YES;
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clicked)]];
    }
    return self;
}

- (void)setSelectedShow:(NSNotification *)notification{
    if([notification.name isEqualToString:@"isSelected"]){
        if(![[notification.userInfo objectForKey:@"object"] isEqual:self]){
            self.tipLabel.textColor = colorWithRGBA(51, 51, 51, 1.0);
            self.dataLabel.textColor = colorWithRGBA(51, 51, 51, 1.0);
            self.type = HYNotSelected;
        }
    }
}

- (void)clicked{
    self.type = HYIsSelected;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"isSelected" object:nil userInfo:@{@"object": self}];
    [self.delegate clickedWithType:self.type andTag:self.tag];
    self.tipLabel.textColor = [self.colorDic objectForKey:[NSString stringWithFormat:@"%u", self.type]];
    self.dataLabel.textColor = [self.colorDic objectForKey:[NSString stringWithFormat:@"%u", self.type]];
}

- (UILabel *)dataLabel{
    if (!_dataLabel) {
        _dataLabel = [[UILabel alloc]init];
        _dataLabel.font = [UIFont systemFontOfSize:12];
    }
    return _dataLabel;
}

- (void)setSelectedColor:(UIColor *)color forType:(HYSelectedType)type{
    [self.colorDic setObject:color forKey:[NSString stringWithFormat:@"%ld", (long)type]];
}

- (void)setDataNum:(NSString *)dataNum{
    self.dataLabel.text = dataNum;
    [self.tipLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.bottom.mas_equalTo(self.mas_centerY);
        make.width.mas_equalTo(self.mas_width).multipliedBy(0.7);
        make.height.mas_equalTo(self.mas_height).multipliedBy(0.3);
    }];
}

@end
