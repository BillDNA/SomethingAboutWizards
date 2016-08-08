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

-(id)initWithRows:(NSInteger)rows columns:(NSInteger)columns;
-(id) objectInRow:(NSInteger)row column:(NSInteger)column;
- (void)setObject:(id)obj inRow:(NSInteger)row column:(NSInteger)column;
-(id)objectAtX:(NSInteger)x Y:(NSInteger)y Z:(NSInteger)z;
- (void)setObject:(id)obj AtX:(NSInteger)x Y:(NSInteger)y Z:(NSInteger)z;

@end