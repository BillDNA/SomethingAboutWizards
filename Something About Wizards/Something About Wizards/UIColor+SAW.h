//
//  UIColor+SAW.h
//  Something About Wizards
//
//  Created by Dynamic New Algorithms on 7/6/16.
//  Copyright © 2016 Bozo Games. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SAWEnums.h"

@interface UIColor (NSObject)

+(UIColor *)gemBorderColorGivenState:(gemState)state;
+(UIColor *)gemColorGivenSchoolOfMagic:(schoolOfMagic)school;
@end
