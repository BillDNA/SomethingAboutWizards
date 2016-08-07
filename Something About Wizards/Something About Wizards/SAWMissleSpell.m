//
//  SAWMissleSpell.m
//  Something About Wizards
//
//  Created by Dynamic New Algorithms on 8/7/16.
//  Copyright © 2016 Bozo Games. All rights reserved.
//

#import "SAWMissleSpell.h"
@interface SAWMissleSpell()

@property (strong, nonatomic) SAWGrid *patern;
@property (nonatomic) schoolOfMagic school;
@end
@implementation SAWMissleSpell
#pragma mark - getters and setters
-(NSString *)name {
    return [NSString stringWithFormat:@"%@ missle",SCHOOL_NAMES[self.school]];
}
-(NSInteger)rowSize {
    return 1;
}
-(NSInteger)colSize {
    return 3;
}
#pragma mark - init methods
-(id)initWithSchool:(schoolOfMagic)school {
    self = [super init];
    if (self) {
        self.school = school;
        self.patern = [[SAWGrid alloc] initWithRows:self.rowSize columns:self.colSize];
        SAWGem *gem = [[SAWGem alloc] initWithSchoolOfMagic:self.school];
        [self.patern setObject:gem AtX:0 Y:0 Z:0];
        gem = [[SAWGem alloc] initWithSchoolOfMagic:self.school];
        [self.patern setObject:gem AtX:0 Y:-1 Z:0];
        gem = [[SAWGem alloc] initWithSchoolOfMagic:self.school];
        [self.patern setObject:gem AtX:0 Y:1 Z:0];
    }
    return self;
}
@end
