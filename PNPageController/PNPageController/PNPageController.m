//
//  ViewController.m
//  PNPageController
//
//  Created by 雷永麟 on 2018/11/24.
//  Copyright © 2018 雷永麟. All rights reserved.
//

#import "PNPageController.h"
#import "HYSegmentedControl.h"

@interface PNPageController ()<HYSegmentedControlDelegate, UIScrollViewDelegate>{
    CGFloat _startContentOffsetX;
}

@property (nonatomic, strong) HYSegmentedControl *segmentedControl;



@end

@implementation PNPageController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (instancetype)initWithControllers:(NSArray<UIViewController *> *)controllers{
    _controllers = controllers;
    [self.view addSubview:self.segmentedControl];
}

#pragma mark delegate & datasource

- (void)clickToChangeView:(NSInteger)index{
    [UIView animateWithDuration:0.2 animations:^{
        [self.backgroundScrollView setContentOffset:CGPointMake(index * self.view.frame.size.width, 0)];
    }];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    _startContentOffsetX = scrollView.contentOffset.x;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x / self.view.frame.size.width;
    if(scrollView.contentOffset.y == 0 && scrollView.contentOffset.x != _startContentOffsetX){
        [UIView animateWithDuration:0.2 animations:^{
            [self.segmentedControl.indicator setFrame:CGRectMake(index * self.view.frame.size.width / self.controllers.count, self.segmentedControl.frame.size.height -2, self.view.frame.size.width / self.controllers.count, 2)];
            
        }];
        self.segmentedControl.selectIndex = index;
    }
}

#pragma mark getter

- (HYSegmentedControl *)segmentedControl{
    if (!_segmentedControl) {
        NSMutableArray *titleArray = [NSMutableArray array];
        for(UIViewController *controller in self.controllers){
            [titleArray addObject:controller.title];
        }
        _segmentedControl = [[HYSegmentedControl alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40) andSelectIndex:0 andTitle:titleArray andData:nil];
        _segmentedControl.delegate = self;
    }
}

- (UIScrollView *)backgroundScrollView{
    if (!_backgroundScrollView) {
        _backgroundScrollView = [[UIScrollView alloc]initWithFrame:UIEdgeInsetsInsetRect(self.view.bounds, UIEdgeInsetsMake(self.segmentedControl.frame.origin.y+self.segmentedControl.frame.size.height, 0, 0, 0))];
        _backgroundScrollView.pagingEnabled = YES;
        _backgroundScrollView.delegate = self;
        _backgroundScrollView.showsVerticalScrollIndicator = NO;
        _backgroundScrollView.showsHorizontalScrollIndicator = NO;
    }
    return _backgroundScrollView;
}


@end
