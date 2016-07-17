//
//  SAWGemBoardViewController.m
//  Something About Wizards
//
//  Created by Dynamic New Algorithms on 7/17/16.
//  Copyright © 2016 Bozo Games. All rights reserved.
//

#import "SAWGemBoardViewController.h"
#import "SAWGemView.h"
@interface SAWGemBoardViewController ()
#pragma mark - Views
@property (strong, nonatomic) NSMutableArray *gemViews;

#pragma mark - Models
@end

@implementation SAWGemBoardViewController
#pragma mark - getters and setters
-(NSMutableArray *)gemViews {
    if (_gemViews == nil) {
        _gemViews = [[NSMutableArray alloc] init];
    }
    return  _gemViews;
}
#pragma mark - Controller Life Cycle Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    SAWGemView *gv = [[SAWGemView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    [self.view addSubview:gv];
    [self.gemViews addObject:gv];
}
#pragma mark - Update Methods
#pragma mark - Data Source Methods
#pragma mark - Delegate Methods
#pragma mark - Target Action Mehtods

@end
