//
//  SAWSpellBook.m
//  Something About Wizards
//
//  Created by Dynamic New Algorithms on 8/7/16.
//  Copyright © 2016 Bozo Games. All rights reserved.
//

#import "SAWSpellBook.h"
#import "SAWMissleSpell.h"
#import "SAWEnums.h"
@interface SAWSpellBook ()

@property (strong,nonatomic) NSArray *spells;
@end
@implementation SAWSpellBook

#pragma mark - init Methods 
-(id) init {
    self = [super init];
    if (self) {
        NSMutableArray *a = [[NSMutableArray alloc] init];
        for(int school = 0; school < schoolsOfMagicCount; school++) {
            [a addObject:[[SAWMissleSpell alloc] initWithSchool:school]];
        }
        self.spells = a;
    }
    return self;
}

@end
