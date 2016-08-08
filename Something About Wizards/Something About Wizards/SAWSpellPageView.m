//
//  SAWSpellPageView.m
//  Something About Wizards
//
//  Created by Dynamic New Algorithms on 8/7/16.
//  Copyright © 2016 Bozo Games. All rights reserved.
//

#import "SAWSpellPageView.h"
@interface SAWSpellPageView()

@property (weak, nonatomic) IBOutlet UILabel *SpellName;
@property (weak, nonatomic) IBOutlet UIView *patternPageView;

@property (strong, nonatomic) SAWGrid *gemViews;
@property (strong, nonatomic) SAWSpell *currentSpell;
@end
@implementation SAWSpellPageView
#pragma mark - getters and setters
@synthesize gemViews = _gemViews;
-(SAWGrid *)gemViews {
    if (_gemViews == nil) {
        _gemViews = [[SAWGrid alloc] initWithRows:[self.currentSpell rowSize] columns:[self.currentSpell colSize]];
    }
    return  _gemViews;
}
-(void)setGemViews:(SAWGrid *)gemViews {
    if (_gemViews != nil) {
        for(NSInteger X = 0; X < [self.currentSpell rowSize]; X++) {
            for(NSInteger Y = 0; Y < [self.currentSpell colSize]; Y++) {
                SAWGemView *gemView = [self.gemViews objectInRow:X column:Y];
                if (![gemView isKindOfClass:[NSNull class]]) {
                    [gemView removeFromSuperview];
                }
            }
        }
    }
    _gemViews = gemViews;
    if (_gemViews == nil && self.currentSpell != nil) {
        CGPoint center = CGPointMake((self.patternPageView.frame.size.width) / 2.0, (self.patternPageView.frame.size.height) / 2.0);
        CGFloat width = 43;
        CGFloat height = sqrt(3.0)/2.0 * width;
        for(NSInteger X = 0; X < [self.currentSpell rowSize]; X++) {
            for(NSInteger Y = 0; Y < [self.currentSpell colSize]; Y++) {
                NSLog(@"(%d,%d)",X,Y);
                NSInteger x = X-floor([self.currentSpell rowSize]/2.0);
                NSInteger y = Y-floor([self.currentSpell colSize]/2.0) + floor(ABS(x)/2);
                NSInteger z = 0 - x - y;
                CGFloat xOff = x * (0.75 * width);
                CGFloat yOff = y * height;
                if (ABS(x) % 2 == 1) {
                    yOff += height/2.0;
                }
                SAWGemView *gv = [[SAWGemView alloc] initWithFrame:CGRectMake(center.x + xOff - width/2.0, center.y + yOff - height / 2.0,width,height) andCoridinatesX:x Y:y Z:z ];
                [self.patternPageView addSubview:gv];
                [self.gemViews setObject:gv inRow:X column:Y];
                gv.dataSource = self.currentSpell;
            }
        }
    }
}
#pragma mark - Update methods
-(void)updateSpell:(SAWSpell *)spell {
    self.currentSpell = spell;
    self.gemViews = nil;
    [self.SpellName setText:[spell name]];
    
}
@end
