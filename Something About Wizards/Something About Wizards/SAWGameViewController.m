//
//  SAWGameViewController.m
//  Something About Wizards
//
//  Created by Dynamic New Algorithms on 7/17/16.
//  Copyright © 2016 Bozo Games. All rights reserved.
//

#import "SAWGameViewController.h"
#import "SAWSpellBookViewController.h"
#import "SAWGemBoardViewController.h"
#import "SAWGrid.h"
#import "SAWSpellBook.h"
#import "SAWSpell.h"
#import "SAWNotificationNames.h"
#define BG_ANIMATION_MAX_STEP 18
typedef enum {
    showGemBoard,
    showSpellBook
} showingState;
@interface SAWGameViewController () <SAWGemBoardViewControllerDelegate>
#pragma mark - Views
@property (weak, nonatomic) IBOutlet UIImageView *backGroundAnimationA;
@property (weak, nonatomic) IBOutlet UIImageView *backGroundAnimationB;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *backgroundAnimationXConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *backgorundAnimationYConstraint;

@property (weak, nonatomic) IBOutlet UIView *gemBoardContainer;
@property (weak, nonatomic) IBOutlet UIView *spellBookContainer;

@property (weak, nonatomic) IBOutlet UIView *speelBookButtonBackGroundView;
@property (weak, nonatomic) IBOutlet UIImageView *spellBookButtonImageView;

@property (weak, nonatomic) SAWGemBoardViewController *gemBoard;
@property (weak, nonatomic) SAWSpellBookViewController *spellBook;

#pragma mark - Models
@property (nonatomic) showingState currentlyShowing;
@property (strong, nonatomic) NSTimer *backgroundAnimationTimmer;
@property (nonatomic) NSInteger bacgroundAnimationStep;
@end

@implementation SAWGameViewController
#pragma mark - getters and setters
-(void)setCurrentlyShowing:(showingState)currentlyShowing {
    _currentlyShowing = currentlyShowing;
    switch (_currentlyShowing) {
        case showGemBoard: {
            self.gemBoardContainer.hidden = NO;
            self.spellBookContainer.hidden = YES;
        }break;
        case showSpellBook: {
            self.gemBoardContainer.hidden = YES;
            self.spellBookContainer.hidden = NO;
        }break;
        default:
            break;
    }
}
#pragma mark - Controller Life Cycle Methods
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //adjust views
    self.speelBookButtonBackGroundView.layer.cornerRadius = self.speelBookButtonBackGroundView.frame.size.height/2;
    //grab view controllers
    for (UIViewController *vc in self.childViewControllers) {
        if ([vc isKindOfClass:[SAWGemBoardViewController class]]) {
            self.gemBoard = (SAWGemBoardViewController *)vc;
            self.gemBoard.delegate = self;
        } else if ([vc isKindOfClass:[SAWSpellBookViewController class]]) {
            self.spellBook =(SAWSpellBookViewController *)vc;
        }
    }
    //start the animation
    self.bacgroundAnimationStep = 2;
    self.backgroundAnimationTimmer = [NSTimer scheduledTimerWithTimeInterval:1/30.0
                                     target:self
                                   selector:@selector(animateBackGround:)
                                   userInfo:nil
                                    repeats:YES];

    //default state
    self.currentlyShowing = showGemBoard;
}
-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.backgroundAnimationTimmer invalidate];
    self.backgroundAnimationTimmer = nil;
}
#pragma mark - Update Methods
-(void)animateBackGround:(NSTimer *)timer {
    CGFloat alphaShift = 0.02;
    if (self.bacgroundAnimationStep % 2 == 0) {
        self.backGroundAnimationA.alpha -= alphaShift;
        self.backGroundAnimationB.alpha += alphaShift;
        if (self.backGroundAnimationA.alpha <= 0) {
            [self.backGroundAnimationA setImage:[UIImage imageNamed:[NSString stringWithFormat:@"temp_magic_back_ground_animation%ld",self.bacgroundAnimationStep+1]]];
            self.bacgroundAnimationStep = (self.bacgroundAnimationStep + 1) %BG_ANIMATION_MAX_STEP;
        }
    } else {
        self.backGroundAnimationA.alpha += alphaShift;
        self.backGroundAnimationB.alpha -= alphaShift;
        if (self.backGroundAnimationB.alpha <= 0) {
            [self.backGroundAnimationB setImage:[UIImage imageNamed:[NSString stringWithFormat:@"temp_magic_back_ground_animation%ld",self.bacgroundAnimationStep+1]]];
            self.bacgroundAnimationStep = (self.bacgroundAnimationStep + 1) %BG_ANIMATION_MAX_STEP;
        }
    }
}
#pragma mark - Data Source Methods
#pragma mark - Delegate Methods
#pragma makr - SAW Gem Board Delegate Methods 
-(void)didSwapGems {
    SAWGrid *gems = self.gemBoard.gems;
    SAWSpellBook *book = self.spellBook.book;
    for (SAWSpell *spell in book.spells) {
        for(NSInteger r = 0; r < gems.rowCount; r++) {
            for(NSInteger c = 0; c < gems.colCount;c++) {
                SAWGem *gem = [gems objectInRow:r column:c];
                if (![gem isKindOfClass:[NSNull class]]) {
                    SAWGrid *pattern = spell.patern;
                    BOOL isMatch = YES;
                    for(NSInteger pr = 0; pr < pattern.rowCount; pr++) {
                        for(NSInteger pc = 0; pc < pattern.colCount; pc++) {
                            SAWGem *patternGem = [pattern objectInRow:pr column:pc];
                             if (![patternGem isKindOfClass:[NSNull class]]) {
                                 NSInteger row = r + pr;
                                 NSInteger col = c + pc;
                                 if (row >= gems.rowCount || col >= gems.colCount) {
                                     isMatch = isMatch && NO;
                                 } else {
                                     SAWGem *checkGem = [gems objectInRow:row column:col];
                                     if ([checkGem isKindOfClass:[NSNull class]]) {
                                         isMatch = isMatch && NO;
                                     } else {
                                         isMatch = isMatch && (patternGem.school == checkGem.school);
                                     }
                                 }
                             } else {
                                 isMatch = isMatch && YES;
                             }
                        } //pc loop
                    } //pr loop
                    if (isMatch) {
                        [[NSNotificationCenter defaultCenter] postNotificationName:NOTE_SPELL_WAS_CAST object:spell userInfo:nil];
                        for(NSInteger pr = 0; pr < pattern.rowCount; pr++) {
                            for(NSInteger pc = 0; pc < pattern.colCount; pc++) {
                                NSInteger row = r + pr;
                                NSInteger col = c + pc;
                                if (row < gems.rowCount && col < gems.colCount)  {
                                    [gems setObject:[NSNull null] inRow:row column:col];
                                }
                            }
                        }
                    }
                } // gem null check
            }// c loop
        } //r loop
    } // spell loop
    [self.gemBoard updateGems:gems];
}
#pragma mark - Target Action Mehtods
- (IBAction)onSpellbookIcon:(id)sender {
    if (self.currentlyShowing == showSpellBook) {
        self.currentlyShowing = showGemBoard;
    } else {
        self.currentlyShowing = showSpellBook;
    }
}
@end
