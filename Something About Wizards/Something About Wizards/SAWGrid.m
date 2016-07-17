//
//  SAWGrid.m
//  Something About Wizards
//
//  Created by Dynamic New Algorithms on 7/17/16.
//  Copyright © 2016 Bozo Games. All rights reserved.
//

#import "SAWGrid.h"

@interface SAWGrid ()

@end
@implementation SAWGrid
#pragma mark - init method
- (id)initWithRows:(NSUInteger)rows columns:(NSUInteger)columns {
    if ((self = [self init])) {
        self.rows = [[NSMutableArray alloc] initWithCapacity: rows];
        for (int i = 0; i < rows; i++) {
            NSMutableArray *column = [NSMutableArray arrayWithCapacity:columns];
            for (int j = 0; j < columns; j++) {
                [column setObject:[NSNull null] atIndexedSubscript:j];
            }
            [self.rows addObject:column];
        }
    }
    return self;
}
#pragma mark - getters
- (id)objectInRow:(NSUInteger)row column:(NSUInteger)column {
    return [[self.rows objectAtIndex:row] objectAtIndex:column];
}
#pragma mark - setters
- (void)setObject:(id)obj inRow:(NSUInteger)row column:(NSUInteger)column {
    [[self.rows objectAtIndex:row] replaceObjectAtIndex:column withObject:obj];
}
@end
