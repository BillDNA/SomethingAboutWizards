//
//  SAWGemView.m
//  Something About Wizards
//
//  Created by Dynamic New Algorithms on 7/17/16.
//  Copyright © 2016 Bozo Games. All rights reserved.
//

#import "SAWGemView.h"
#import "SAWEnums.h"
#import "UIColor+SAW.h"
@interface SAWGemView ()

@property (weak, nonatomic) IBOutlet UIView *view;
@property (nonatomic) NSInteger x;
@property (nonatomic) NSInteger y;
@property (nonatomic) NSInteger z;
@end
@implementation SAWGemView
#pragma mark - getters and setters
-(UIColor *)borderColor {
    if ([self.dataSource gemForSAWGemView:self].curentState == selectedGem) {
        return [UIColor gemBorderColorGivenState:selectedGem];
    }
    return  [UIColor gemBorderColorGivenState:normalGem];
}
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
    SAWGem *gem = [self.dataSource gemForSAWGemView:self];
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (![gem isKindOfClass:[NSNull class]]) {
        
        UIColor * gemColor = [UIColor gemColorGivenSchoolOfMagic:gem.school];
        
        CGMutablePathRef path = CGPathCreateMutable();
        CGPoint center = CGPointMake(rect.size.width / 2, rect.size.height / 2);
        CGFloat radius = rect.size.width / 2 - 1;
        CGPoint corner = [self getHexCornerPointFromCenter:center toPointIndexed:0 withRadius:radius];
        CGPathMoveToPoint(path, NULL, corner.x, corner.y);
        for (int i = 1; i < 6; i++) {
            corner = [self getHexCornerPointFromCenter:center toPointIndexed:i withRadius:radius];
            CGPathAddLineToPoint(path, NULL, corner.x, corner.y);
        }
        CGPathCloseSubpath(path);
        
        CGContextAddPath(context, path);
        CGContextSetFillColorWithColor(context, gemColor.CGColor);
        CGContextFillPath(context);
        
        CGContextAddPath(context, path);
        CGContextSetStrokeColorWithColor(context, [self borderColor].CGColor);
        CGContextSetLineWidth(context, 2.0);
        CGContextStrokePath (context);
    } else {
        CGContextClearRect(context, self.bounds);
    }

    
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
-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *hitView = [super hitTest:point withEvent:event];
    
    // If the hitView is THIS view, return nil and allow hitTest:withEvent: to
    // continue traversing the hierarchy to find the underlying view.
    if (hitView == self.view) {
        
        CGPoint p = point;
        CGFloat w = self.frame.size.width;
        CGFloat h = self.frame.size.height;
        CGFloat x = p.x - w / 2.0;
        CGFloat y = -1*(p.y - h / 2.0);
        CGFloat m = -2 * h / w;
        CGFloat b = 2*h/w *(w/2);
        BOOL inHex = NO;
        if (y <= 0 ) { //lower half
            if(x >= -w/4 && w <= w/4) {
                inHex = y >= -h/2;
            } else if(x >= 0) { //Right half
                inHex = (y >= -m * x - b);
            } else { //Left hal
                inHex = (y >= m * x - b);
            }
        } else { //upper half
            if(x >= -w/4 && w <= w/4) {
                inHex = y <= h/2;
            } else if(x >= 0) { //Right half
                inHex = (y <= m * x + b);
            } else { //Left half
                inHex = (y <= -m * x + b);
            }
        }
        if (inHex) {
            return self.view;
        }
        return nil;
    }
    // Else return the hitView (as it could be one of this view's buttons):
    return hitView;
}
- (IBAction)onTap:(UITapGestureRecognizer *)sender {
    [self.delegate didTapGemView:self];
    [self setNeedsDisplay];
}

@end
