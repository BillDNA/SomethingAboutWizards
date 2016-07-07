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
@property (weak, nonatomic) IBOutlet UIView *gameViewContainer;

#pragma mark - Models

@end

@implementation SAWMaseterViewController

#pragma mark - getters and setters
#pragma mark - Controller Life Cycle Methods
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onOrientationChange:)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:[UIDevice currentDevice]];
}
- (NSUInteger) supportedInterfaceOrientations {
    // Return a bitmask of supported orientations. If you need more,
    // use bitwise or (see the commented return).
    return UIInterfaceOrientationMaskPortrait;
    // return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskPortraitUpsideDown;
}

- (UIInterfaceOrientation) preferredInterfaceOrientationForPresentation {
    // Return the orientation you'd prefer - this is what it launches to. The
    // user can still rotate. You don't have to implement this method, in which
    // case it launches in the current orientation
    return UIInterfaceOrientationPortrait;
}
- (BOOL)shouldAutorotate {
    return NO;
}
#pragma mark - Update Methods
-(void)onOrientationChange:(NSNotification *)note {
    UIDevice * device = note.object;
    CGAffineTransform rotation = CGAffineTransformMakeRotation(0);
    switch(device.orientation) {
        case UIDeviceOrientationPortrait:
            rotation = CGAffineTransformMakeRotation(0);
            break;
        case UIDeviceOrientationLandscapeLeft:
            rotation = CGAffineTransformMakeRotation(90);
            break;
        case UIDeviceOrientationPortraitUpsideDown:
            rotation = CGAffineTransformMakeRotation(M_PI);
            break;
        case UIDeviceOrientationLandscapeRight:
            rotation = CGAffineTransformMakeRotation(270);
            break;
        default:
            break;
    };
    [UIView animateWithDuration:0.4 animations:^{
        //self.storyViewContainer.transform = rotation;
        self.gameViewContainer.transform = rotation;
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
}
#pragma mark - Data Source Methods
#pragma mark - Delegate Methods
#pragma mark - Target Action Mehtods
- (IBAction)onDebug:(id)sender {
    CGAffineTransform rotation = CGAffineTransformMakeRotation(M_PI_2);
    [UIView animateWithDuration:0.4 animations:^{
        //self.storyViewContainer.transform = rotation;
        self.gameViewContainer.transform = rotation;
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
    
}

@end
