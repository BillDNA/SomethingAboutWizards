//
//  SAWCombatViewController.m
//  Something About Wizards
//
//  Created by Alexander.Agosta on 7/17/16.
//  Copyright © 2016 Bozo Games. All rights reserved.
//

#import "SAWCombatViewController.h"
#import "SAWNotificationNames.h"
#import "SAWEnums.h"
#import "SAWSpell.h"
#import "SAWHelpers.h"

@interface SAWCombatViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *BackgroundImageView;
@property (weak, nonatomic) IBOutlet UIImageView *StoryView;
@property (weak, nonatomic) IBOutlet UIImageView *CharacterView;
@property (weak, nonatomic) IBOutlet UIImageView *AnimationView;


@end

@implementation SAWCombatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.BackgroundImageView setImage:[UIImage imageNamed: [NSString stringWithFormat:@"SceneBackground_%d",random_range(0,7)]]];
    [self.StoryView setImage:[UIImage imageNamed: @"story_bar"]];
    [self.CharacterView setImage:[UIImage imageNamed: [NSString stringWithFormat:@"knight_%d", random_range(0, 5)]]];
    
    
    //Listening for spell casts
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(spellCast:)
                                                 name:NOTE_SPELL_WAS_CAST
                                                    object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)spellCast:(NSNotification*)note{
    NSLog(@"Spell cast %d!",((SAWSpell *)note.object).school);

    [self.AnimationView setImage: [UIImage imageNamed:[NSString stringWithFormat:@"temp_spellcast_%d",((SAWSpell *)note.object).school]]];

    self.AnimationView.alpha = 1;

    [self.view layoutIfNeeded];
    
    [UIView animateWithDuration:0.5 delay:0.5 options:UIViewAnimationOptionCurveLinear animations:^{
        self.AnimationView.alpha = 0;
        [self.view layoutIfNeeded];

    } completion:^(BOOL finished) {
        
    }];

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
