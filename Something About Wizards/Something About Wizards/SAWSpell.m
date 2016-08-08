//
//  SAWSpell.m
//  Something About Wizards
//
//  Created by Alexander.Agosta on 8/7/16.
//  Copyright © 2016 Bozo Games. All rights reserved.
//

#import "SAWSpell.h"
#import "SAWGrid.h"
@interface SAWSpell ()

@property (strong, nonatomic) SAWGrid *patern;
@property (nonatomic) schoolOfMagic school;


@end
@implementation SAWSpell
#pragma mark - getters and setters
-(NSString *)name {
    return NSStringFromClass([self class]);
}
-(NSInteger)rowSize {
    return 0;
}
-(NSInteger)colSize {
    return 0;
}
#pragma mark - initMethods
-(id)init {
    self = [super init];
    if (self) {
        self.school = EtherealMagic;
        self.patern = [[SAWGrid alloc] initWithRows:0 columns:0];
    }
    return self;
}
#pragma makr - SAWGemView DataSource Methods
-(SAWGem *)gemForSAWGemView:(SAWGemView *)sender {
    return [self.patern objectAtX:sender.x Y:sender.y Z:sender.z];
}
@end
