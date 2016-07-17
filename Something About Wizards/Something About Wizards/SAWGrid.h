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

@property NSMutableArray *rows;

- initWithRows:(NSUInteger)rows columns:(NSUInteger)columns;
- objectInRow:(NSUInteger)row column:(NSUInteger)column;
- (void)setObject:(id)obj inRow:(NSUInteger)row column:(NSUInteger)column;

@end