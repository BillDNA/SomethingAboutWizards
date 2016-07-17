//
//  SAWCombatViewController.m
//  Something About Wizards
//
//  Created by Alexander.Agosta on 7/17/16.
//  Copyright © 2016 Bozo Games. All rights reserved.
//

#import "SAWCombatViewController.h"

@interface SAWCombatViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *BackgroundImageView;

@end

@implementation SAWCombatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.BackgroundImageView setImage:[UIImage imageNamed: @"CombatBackground_1"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
