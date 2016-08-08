//
//  SAWSpellPageView.h
//  Something About Wizards
//
//  Created by Dynamic New Algorithms on 8/7/16.
//  Copyright © 2016 Bozo Games. All rights reserved.
//

#import "SAWBaseView.h"
#import "SAWSpell.h"
@class SAWSpellPageView;
@protocol SAWSpellPageViewDataSource

-(SAWSpell *)spellForSpellPage:(SAWSpellPageView *)view;

@end
@interface SAWSpellPageView : SAWBaseView
@property (weak, nonatomic) id<SAWSpellPageViewDataSource> dataSource;

-(UIView *)patternPageView;
-(void)updateSpell:(SAWSpell *)spell;
@end
