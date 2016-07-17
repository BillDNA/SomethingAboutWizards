//
//  SAWGemView.h
//  Something About Wizards
//
//  Created by Dynamic New Algorithms on 7/17/16.
//  Copyright © 2016 Bozo Games. All rights reserved.
//

#import "SAWBaseView.h"

@interface SAWGemView : SAWBaseView
@property (nonatomic) BOOL isSelected;

-(id)initWithFrame:(CGRect)frame andCoridinatesX:(NSInteger)x Y:(NSInteger)y Z:(NSInteger)z;
@end
