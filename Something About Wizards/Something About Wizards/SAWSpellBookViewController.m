//
//  SAWSpellBookViewController.m
//  Something About Wizards
//
//  Created by Dynamic New Algorithms on 8/5/16.
//  Copyright © 2016 Bozo Games. All rights reserved.
//

#import "SAWSpellBookViewController.h"
#import "SAWSpellPageView.h"
#import "SAWSpellBook.h"
#import "SAWGemView.h"
@interface SAWSpellBookViewController ()

#pragma mark - Views
@property (weak, nonatomic) IBOutlet SAWSpellPageView *currentPage;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UIButton *previousButton;
#pragma mark - Models
@property (strong, nonatomic) SAWSpellBook *book;
@property (nonatomic) NSInteger currentPageNumber;
@end

@implementation SAWSpellBookViewController
#pragma mark - getters and setters
-(void)setCurrentPageNumber:(NSInteger)currentPageNumber {
    _currentPageNumber = currentPageNumber;
    [self.currentPage updateSpell:(SAWSpell *)[self.book.spells objectAtIndex:_currentPageNumber]];
    self.previousButton.hidden = NO;
    self.nextButton.hidden = NO;
    if (_currentPageNumber == 0) {
        self.previousButton.hidden = YES;
    }
    if (_currentPageNumber == self.book.spells.count -1) {
        self.nextButton.hidden = YES;
    }
}
-(SAWSpell *)currentSpell {
    return (SAWSpell *)[self.book.spells objectAtIndex:self.currentPageNumber];
}
#pragma mark - Controller Life Cycle Methods
-(void)viewDidLoad {
    [super viewDidLoad];
    self.book = [[SAWSpellBook alloc] init];
    self.currentPageNumber = 0;
}
#pragma mark - Update Methods
#pragma mark - Data Source Methods
#pragma mark - Delegate Methods
#pragma mark - Target Action Mehtods
- (IBAction)onNext:(id)sender {
    self.currentPageNumber++;
}
- (IBAction)onPrevious:(id)sender {
    self.currentPageNumber--;
}
@end
