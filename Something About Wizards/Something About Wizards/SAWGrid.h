//
//  SAWGrid.h
//  Something About Wizards
//
//  Created by Dynamic New Algorithms on 7/17/16.
//  Copyright © 2016 Bozo Games. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SAWBaseModel.h"


@interface SAWGrid : SAWBaseModel

-(NSInteger)rowCount;
-(NSInteger)colCount;

-(id)initWithRows:(NSUInteger)rows columns:(NSUInteger)columns;
-(id) objectInRow:(NSUInteger)row column:(NSUInteger)column;
- (void)setObject:(id)obj inRow:(NSUInteger)row column:(NSUInteger)column;
-(id)objectAtX:(NSInteger)x Y:(NSInteger)y Z:(NSInteger)z;
- (void)setObject:(id)obj AtX:(NSInteger)x Y:(NSInteger)y Z:(NSInteger)z;

@end