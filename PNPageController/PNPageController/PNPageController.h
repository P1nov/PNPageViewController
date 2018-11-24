//
//  ViewController.h
//  PNPageController
//
//  Created by 雷永麟 on 2018/11/24.
//  Copyright © 2018 雷永麟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PNPageController : UIViewController

@property (nonatomic, strong, readonly) NSArray<UIViewController *> *controllers;

@property (nonatomic, strong) UIScrollView *backgroundScrollView;

- (instancetype)initWithControllers:(NSArray<UIViewController *> *)controllers;


@end

