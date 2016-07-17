//
//  SAWGemView.m
//  Something About Wizards
//
//  Created by Dynamic New Algorithms on 7/17/16.
//  Copyright © 2016 Bozo Games. All rights reserved.
//

#import "SAWGemView.h"

@implementation SAWGemView


-(void) drawRect: (CGRect) rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIColor * redColor = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:1.0];
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPoint center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
    CGFloat radius = self.frame.size.width / 2;
    CGPoint corner = [self getHexCornerPointFromCenter:center toPointIndexed:0 withRadius:radius];
    CGPathMoveToPoint(path, NULL, corner.x, corner.y);
    for (int i = 1; i < 6; i++) {
        corner = [self getHexCornerPointFromCenter:center toPointIndexed:i withRadius:radius];
        CGPathMoveToPoint(path, NULL, corner.x, corner.y);
        NSLog(@"C = %@",NSStringFromCGPoint(corner));
    }
    
    CGPathCloseSubpath(path);
    
    CGContextSetFillColorWithColor(context, redColor.CGColor);
    CGContextAddPath(context, path);
    CGContextFillPath(context);
    
}

-(CGPoint )getHexCornerPointFromCenter:(CGPoint )center toPointIndexed:(NSInteger )i withRadius:(CGFloat)size {
    CGFloat angleDeg = 60 * i;
    CGFloat angleRad = M_PI / 180 * angleDeg;
    return CGPointMake(center.x + size * cosf(angleRad), center.y + size * sinf(angleRad));
}

@end
