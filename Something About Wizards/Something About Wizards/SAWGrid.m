//
//  SAWGrid.m
//  Something About Wizards
//
//  Created by Dynamic New Algorithms on 7/17/16.
//  Copyright © 2016 Bozo Games. All rights reserved.
//

#import "SAWGrid.h"
#import <UIKit/UIKit.h>
@interface SAWGrid ()
@property NSMutableArray *rows;

@end
@implementation SAWGrid
#pragma mark - getters and setters
-(NSInteger)rowCount {
    return self.rows.count;
}
-(NSInteger)colCount {
    if (self.rowCount > 0) {
        return ((NSMutableArray *)[self.rows objectAtIndex:0]).count;
    }
    return 0;
}
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
-(id)objectAtX:(NSInteger)x Y:(NSInteger)y Z:(NSInteger)z {
    CGPoint rc = [self convertToRCFromX:x Y:y Z:z];
    return  [self objectInRow:rc.x column:rc.y];
}
#pragma mark - setters
- (void)setObject:(id)obj inRow:(NSUInteger)row column:(NSUInteger)column {
    [[self.rows objectAtIndex:row] replaceObjectAtIndex:column withObject:obj];
}
- (void)setObject:(id)obj AtX:(NSInteger)x Y:(NSInteger)y Z:(NSInteger)z {
    CGPoint rc = [self convertToRCFromX:x Y:y Z:z];
    [self setObject:obj inRow:rc.x column:rc.y];
}
#pragma mark - Helpers 
-(CGPoint)convertToRCFromX:(NSInteger)x Y:(NSInteger)y Z:(NSInteger)z {
    NSUInteger r = x + [self rowCount] / 2;
    NSUInteger c = y + [self colCount] / 2;
    
    NSLog(@"(%d,%d) -> (%d,%d)",x,y,r,c);
    return CGPointMake(r, c);
}
#pragma mark - debug 
-(NSString *)description {
    NSString *s = [NSString stringWithFormat:@"SAWGrid <%p> (%d,%d)\n------------\n",self,self.rowCount,self.colCount];
    for (int r = 0; r < self.rowCount; r++) {
        for (int c = 0; c < self.colCount; c++) {
            NSObject *object = [self objectInRow:r column:c];
            s = [NSString stringWithFormat:@"%@ | %@",s,object];
        }
        s = [NSString stringWithFormat:@"%@ | \n",s];
    }
    return s;
}
@end
