//
//  MainHelpViewController.m
//  Combo Recovery
//
//  Created by srich on 7/6/15.
//  Copyright (c) 2015 Scott Richards. All rights reserved.
//

#import "MainHelpViewController.h"

@implementation MainHelpViewController : UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [scroll setScrollEnabled:YES];
    [scroll setContentSize:CGSizeMake(320,824)];
    [scroll setContentOffset:CGPointMake(scroll.contentOffset.x, 0) animated:YES];
}

@end
