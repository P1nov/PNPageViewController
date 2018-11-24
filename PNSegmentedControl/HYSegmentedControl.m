//
//  HYSegmentedControl.m
//  huiyao
//
//  Created by 雷永麟 on 2018/9/13.
//  Copyright © 2018年 雷永麟. All rights reserved.
//

#import "HYSegmentedControl.h"
#import "HYSegmentedView.h"

#define colorWithRGBA(r, g, b, a) [UIColor colorWithRed:r/255.f green:g/255.f blue:b/255.f alpha:a]

@interface HYSegmentedControl()<HYSegmentedViewDelegate>{
    NSArray *dataArray;
}

@end

@implementation HYSegmentedControl

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame andSelectIndex:(NSInteger)index andTitle:(NSArray *)titles andData:(NSArray *)datas{
    self = [super initWithFrame:frame];
    if(self){
        self.titleArray = titles;
        dataArray = datas;
        [self addObserver:self forKeyPath:@"selectIndex" options:NSKeyValueObservingOptionNew context:NULL];
        [self setTitleInit:titles andIndex:index];
    }
    return self;
}

- (instancetype)initWithJuniorFrame:(CGRect)frame andSelectIndex:(NSInteger)index andTitle:(NSArray *)titles andData:(NSArray *)datas{
    self = [super initWithFrame:frame];
    if(self){
        self.titleArray = titles;
        dataArray = datas;
        [self addObserver:self forKeyPath:@"selecIndex" options:NSKeyValueObservingOptionNew context:NULL];
        [self setJuniorTitleInit:nil andIndex:0];
    }
    return self;
}

- (instancetype)initWithDialFrame:(CGRect)frame andSelectIndex:(NSInteger)index andTitle:(NSArray *)titles{
    self = [super initWithFrame:frame];
    if(self){
        self.titleArray = titles;
        [self addObserver:self forKeyPath:@"selectIndex" options:NSKeyValueObservingOptionNew context:NULL];
        [self setDialTitleInit:titles andIndex:0];
    }
    return self;
}

- (void)setDialTitleInit:(NSArray *)titleArray andIndex:(NSInteger)index{
    NSInteger titleNumber = titleArray.count;
    for (int i=0; i<titleNumber; i++) {
        HYSegmentedView *view = [[HYSegmentedView alloc]initWithFrame:CGRectMake(i*self.frame.size.width/titleNumber, 0, self.frame.size.width/titleNumber, self.frame.size.height) andTitle:titleArray[i] andData:dataArray[i]];
        view.delegate = self;
        if(dataArray != nil){
            view.dataLabel.text = dataArray[i];
        }
        [view setSelectedColor:colorWithRGBA(59, 193, 108, 1.0) forType:HYIsSelected];
        [view setSelectedColor:colorWithRGBA(51, 51, 51, 1.0) forType:HYNotSelected];
        if(i == index){
            view.type = HYIsSelected;
            view.tipLabel.textColor = colorWithRGBA(59, 193, 108, 1.0);
            view.dataLabel.textColor = colorWithRGBA(59, 193, 108, 1.0);
        }
        view.tag = i + 50;
        [self addSubview:view];
        if(i == index){
            self.indicator = [[UIView alloc]initWithFrame:CGRectMake(i*self.frame.size.width/titleNumber, self.frame.size.height - 2, self.frame.size.width/(titleNumber*3), 2)];
            [self.indicator setCenter:CGPointMake(view.center.x, self.frame.size.height - 2)];
            self.indicator.backgroundColor = colorWithRGBA(59, 193, 108, 1.0);
            [self addSubview:self.indicator];
        }
    }
}

- (void)setJuniorTitleInit:(NSArray *)titleArray andIndex:(NSInteger)index{
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if([keyPath isEqualToString:@"selectIndex"]){
        for(HYSegmentedView *view in self.subviews){
            if(view.tag == ((HYSegmentedControl *)object).selectIndex + 50){
                if(view.tag){
                    [view.dataLabel setTextColor:colorWithRGBA(16, 142, 233, 1.0)];
                    [view.tipLabel setTextColor:colorWithRGBA(16, 142, 233, 1.0)];
                    view.type = HYIsSelected;
                }
            }else{
                if(view.tag){
                    [view.dataLabel setTextColor:colorWithRGBA(51, 51, 51, 1.0)];
                    [view.tipLabel setTextColor:colorWithRGBA(51, 51, 51, 1.0)];
                    view.type = HYNotSelected;
                }
                
            }
        }
    }
}

- (void)clickedWithType:(HYSelectedType)type andTag:(NSInteger)tag{
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.2 animations:^{
        UIViewController *currentController = [UIApplication sharedApplication].keyWindow.rootViewController;
        [weakSelf.indicator setFrame:CGRectMake((tag - 50)*weakSelf.frame.size.width/self.titleArray.count , weakSelf.frame.size.height - 2, weakSelf.frame.size.width/self.titleArray.count, 2)];
    }];
    [self.delegate clickToChangeView:tag-50];
}


- (void)setTitleInit:(NSArray *)titleArray andIndex:(NSInteger)index{
    NSInteger titleNumber = titleArray.count;
    for(int i=0;i<titleNumber;i++){
        HYSegmentedView *view = [[HYSegmentedView alloc]initWithFrame:CGRectMake(i*self.frame.size.width/titleNumber, 0, self.frame.size.width/titleNumber, self.frame.size.height) andTitle:titleArray[i] andData:dataArray[i]];
        view.delegate = self;
        if(dataArray != nil){
            view.dataLabel.text = dataArray[i];
        }
        [view setSelectedColor:colorWithRGBA(16, 142, 233, 1.0) forType:HYIsSelected];
        [view setSelectedColor:colorWithRGBA(51, 51, 51, 1.0) forType:HYNotSelected];
        if(i == index){
            view.type = HYIsSelected;
            view.tipLabel.textColor = colorWithRGBA(16, 142, 233, 1.0);
            view.dataLabel.textColor = colorWithRGBA(16, 142, 233, 1.0);
        }
        view.tag = i + 50;
        [self addSubview:view];
        if(i == index){
            self.indicator = [[UIView alloc]initWithFrame:CGRectMake(i*self.frame.size.width/titleNumber, self.frame.size.height - 2, self.frame.size.width/titleNumber, 2)];
            self.indicator.backgroundColor = colorWithRGBA(16, 142, 233, 1.0);
            [self addSubview:self.indicator];
        }
    }
}

- (void)dealloc{
    [self removeObserver:self forKeyPath:@"selectIndex"];
}

@end
