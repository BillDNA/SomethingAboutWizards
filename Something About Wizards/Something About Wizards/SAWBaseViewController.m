//
//  SAWBaseViewController.m
//  Something About Wizards
//
//  Created by Dynamic New Algorithms on 7/6/16.
//  Copyright © 2016 Bozo Games. All rights reserved.
//

#import "SAWBaseViewController.h"
#import <objc/runtime.h>
@interface SAWBaseViewController ()
#pragma mark - Views

#pragma mark - Models

@end
@implementation SAWBaseViewController
#pragma mark - getters and setters

#pragma mark - Controller Life Cycle Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    for(UIView *v in self.view.subviews) {
        if ([v respondsToSelector:@selector(delegate)]) {
            NSString *delegateName = [NSString stringWithFormat:@"%@Delegate", NSStringFromClass([v class])];
            Protocol * delegateProtocal = objc_getProtocol([delegateName UTF8String]);
            if (class_conformsToProtocol([self class], delegateProtocal)) {
                [v setValue:self forKey:@"delegate"];
            }
        }
        if ([v respondsToSelector:@selector(dataSource)]) {
            NSString *dataSourceName = [NSString stringWithFormat:@"%@DataSource", NSStringFromClass([v class])];
            Protocol * dataSourceProtocal = objc_getProtocol([dataSourceName UTF8String]);
            if (class_conformsToProtocol([self class], dataSourceProtocal)) {
                [v setValue:self forKey:@"dataSource"];
            }
        }
    }
    // Do any additional setup after loading the view.
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - Update Methods
-(BOOL)prefersStatusBarHidden {
    return YES;
}
#pragma mark - Data Source Methods
#pragma mark - Delegate Methods
#pragma mark - Target Action Mehtods
@end