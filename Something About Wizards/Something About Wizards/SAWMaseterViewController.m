//
//  SAWMaseterViewController.m
//  Something About Wizards
//
//  Created by Dynamic New Algorithms on 7/6/16.
//  Copyright © 2016 Bozo Games. All rights reserved.
//

#import "SAWMaseterViewController.h"

@interface SAWMaseterViewController ()

#pragma mark - Views
@property (weak, nonatomic) IBOutlet UIView *storyViewContainer;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *storyViewContainerHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *storyViewContainerWidth;
@property (weak, nonatomic) IBOutlet UIView *gameViewContainer;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *gameViewContainerHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *gameViewContainerWidth;


#pragma mark - Models

@end

@implementation SAWMaseterViewController

#pragma mark - getters and setters
#pragma mark - Controller Life Cycle Methods
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.storyViewContainerWidth.constant = self.view.frame.size.width;
    self.storyViewContainerHeight.constant = self.view.frame.size.height / 2;
    self.gameViewContainerWidth.constant =  self.view.frame.size.width;
    self.gameViewContainerHeight.constant = self.view.frame.size.height / 2;
}
#pragma mark - Update Methods
#pragma mark - Data Source Methods
#pragma mark - Delegate Methods
#pragma mark - Target Action Mehtods
- (IBAction)onDebug:(id)sender {
    
    
}

@end
