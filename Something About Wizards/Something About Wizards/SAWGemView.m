//
//  SAWGemView.m
//  Something About Wizards
//
//  Created by Dynamic New Algorithms on 7/17/16.
//  Copyright © 2016 Bozo Games. All rights reserved.
//

#import "SAWGemView.h"
@interface SAWGemView ()

@property (weak, nonatomic) IBOutlet UIView *view;
@property (nonatomic) NSInteger x;
@property (nonatomic) NSInteger y;
@property (nonatomic) NSInteger z;
@end
@implementation SAWGemView
-(id)initWithFrame:(CGRect)frame andCoridinatesX:(NSInteger)x Y:(NSInteger)y Z:(NSInteger)z{
    self = [super initWithFrame:frame];
    if (self) {
        [self.view setBackgroundColor:[UIColor clearColor]];
        self.opaque = NO;
        self.x = x;
        self.y = y;
        self.z = z;
    }
    return self;
}

-(void) drawRect: (CGRect) rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextFillRect(context, rect);
    
    UIColor * redColor = [UIColor colorWithRed:ABS(self.x) / 5.0 green:ABS(self.y) / 5.0 blue:ABS(self.z) / 5.0 alpha:1.0];
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPoint center = CGPointMake(rect.size.width / 2, rect.size.height / 2);
    CGFloat radius = rect.size.width / 2;
    CGPoint corner = [self getHexCornerPointFromCenter:center toPointIndexed:0 withRadius:radius];
    CGPathMoveToPoint(path, NULL, corner.x, corner.y);
    for (int i = 1; i < 6; i++) {
        corner = [self getHexCornerPointFromCenter:center toPointIndexed:i withRadius:radius];
        CGPathAddLineToPoint(path, NULL, corner.x, corner.y);
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
