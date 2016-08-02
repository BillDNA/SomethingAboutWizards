//
//  SAWGameViewController.m
//  Something About Wizards
//
//  Created by Dynamic New Algorithms on 7/17/16.
//  Copyright © 2016 Bozo Games. All rights reserved.
//

#import "SAWGameViewController.h"

@interface SAWGameViewController ()
#pragma mark - Views
@property (weak, nonatomic) IBOutlet UIView *gemBoardContainer;
@property (weak, nonatomic) IBOutlet UIView *speelBookButtonBackGroundView;
@property (weak, nonatomic) IBOutlet UIImageView *spellBookButtonImageView;


#pragma mark - Models
@end

@implementation SAWGameViewController
#pragma mark - getters and setters
#pragma mark - Controller Life Cycle Methods
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.speelBookButtonBackGroundView.layer.cornerRadius = self.speelBookButtonBackGroundView.frame.size.height/2;
}
#pragma mark - Update Methods
#pragma mark - Data Source Methods
#pragma mark - Delegate Methods
#pragma mark - Target Action Mehtods
- (IBAction)onSpellbookIcon:(id)sender {
    NSLog(@"ok");
}
@end
