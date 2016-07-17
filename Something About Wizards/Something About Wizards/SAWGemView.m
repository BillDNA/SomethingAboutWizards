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
#pragma mark - getters and setters
-(void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [self setNeedsDisplay];
}
#pragma mark - init method
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
#pragma mark - update / animation methods
-(void) drawRect: (CGRect) rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIColor * redColor = [UIColor colorWithRed:ABS(self.x) / 5.0 green:ABS(self.y) / 5.0 blue:ABS(self.z) / 5.0 alpha:1.0];
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPoint center = CGPointMake(rect.size.width / 2, rect.size.height / 2);
    CGFloat radius = rect.size.width / 2 - 0.5;
    CGPoint corner = [self getHexCornerPointFromCenter:center toPointIndexed:0 withRadius:radius];
    CGPathMoveToPoint(path, NULL, corner.x, corner.y);
    for (int i = 1; i < 6; i++) {
        corner = [self getHexCornerPointFromCenter:center toPointIndexed:i withRadius:radius];
        CGPathAddLineToPoint(path, NULL, corner.x, corner.y);
    }
    CGPathCloseSubpath(path);
    
    CGContextAddPath(context, path);
    CGContextSetFillColorWithColor(context, redColor.CGColor);
    CGContextFillPath(context);
    
    CGContextAddPath(context, path);
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextSetLineWidth(context, 2.0);
    CGContextStrokePath (context);

    
}
#pragma mark - helpers
-(CGPoint )getHexCornerPointFromCenter:(CGPoint )center toPointIndexed:(NSInteger )i withRadius:(CGFloat)size {
    CGFloat angleDeg = 60 * i;
    CGFloat angleRad = M_PI / 180 * angleDeg;
    return CGPointMake(center.x + size * cosf(angleRad), center.y + size * sinf(angleRad));
}
-(CGPoint)pointToHex:(CGPoint)point {
    CGFloat q = point.x * 2.0/3.0 / (self.frame.size.width / 2 - 0.5);
    CGFloat r = (-point.x / 3.0 + sqrt(3.0)/3.0 * point.y ) /  (self.frame.size.width / 2 - 0.5);
    return CGPointMake(q, r);
}
#pragma mark - event handlers
-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    for (UIView *view in self.subviews) {
        
        if (!view.hidden && view.alpha > 0 && view.userInteractionEnabled && [view pointInside:[self convertPoint:point toView:view] withEvent:event])
            return YES;
    }
    return NO;
}
- (IBAction)onTap:(UITapGestureRecognizer *)sender {
}

@end
