//
//  SAWGem.m
//  Something About Wizards
//
//  Created by Dynamic New Algorithms on 8/7/16.
//  Copyright © 2016 Bozo Games. All rights reserved.
//

#import "SAWGem.h"
#import "SAWHelpers.h"
@interface SAWGem ()

@property (nonatomic) schoolOfMagic school;

@end
@implementation SAWGem
#pragma mark - init
-(id)init {
    self = [super init];
    if (self) {
        self.curentState = normalGem;
        self.school =  arc4random() % schoolsOfMagicCount;
    }
    return self;
}
-(id)initWithSchoolOfMagic:(schoolOfMagic)school {
    self = [super init];
    if (self) {
        self.curentState = normalGem;
        self.school = school;
    }
    return self;
}
#pragma mark - debug methods
-(NSString *)description {
    return [NSString stringWithFormat:@"SAWGem <%p> school - %d, state - %d",self,self.school,self.curentState];
}
@end
