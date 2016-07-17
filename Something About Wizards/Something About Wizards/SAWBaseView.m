//
//  SAWBaseView.m
//  Something About Wizards
//
//  Created by Dynamic New Algorithms on 7/17/16.
//  Copyright © 2016 Bozo Games. All rights reserved.
//

#import "SAWBaseView.h"
@interface SAWBaseView ()
@property (strong, nonatomic) IBOutlet UIView *view;

@end
@implementation SAWBaseView
#pragma mark - getters and setters
-(void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    self.view.frame = CGRectMake(0,0,frame.size.width, frame.size.height);
}
-(void)setBounds:(CGRect)bounds {
    [super setBounds:bounds];
}
#pragma mark - init methods
- (id) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self loadNibAndAddView];
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self loadNibAndAddView];
    }
    return self;
}
-(void)loadNibAndAddView {
    [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil];
    [self addSubview:self.view];
    self.frame = self.frame;
    self.bounds = self.bounds;
}
#pragma mark - Event Handlers

#pragma mark - Target Action Outlets

@end