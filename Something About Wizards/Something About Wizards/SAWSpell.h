//
//  SAWSpell.h
//  Something About Wizards
//
//  Created by Alexander.Agosta on 8/7/16.
//  Copyright © 2016 Bozo Games. All rights reserved.
//

#import "SAWBaseModel.h"
#import "SAWEnums.h"
#import "SAWGem.h"
#import "SAWGrid.h"
#import "SAWGemView.h"
@interface SAWSpell : SAWBaseModel <SAWGemViewDataSource>

-(NSInteger)rowSize;
-(NSInteger)colSize;

-(schoolOfMagic) school;
-(SAWGrid *)patern;

-(NSString *)name;

@end
