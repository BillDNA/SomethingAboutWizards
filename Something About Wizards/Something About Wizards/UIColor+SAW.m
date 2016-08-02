//
//  UIColor+SAW.m
//  Something About Wizards
//
//  Created by Dynamic New Algorithms on 7/6/16.
//  Copyright © 2016 Bozo Games. All rights reserved.
//

#import "UIColor+SAW.h"

@implementation UIColor (SAW)

+(UIColor *)gemColorGivenSchoolOfMagic:(schoolOfMagic)school {
    switch (school) {
        case EtherealMagic:
            return [UIColor colorWithRed:0.75 green:0.9 blue:0.8 alpha:1.0];
            break;
        case NatureMagic:
            return [UIColor colorWithRed:0.3 green:0.9 blue:0.15 alpha:1.0];
            break;
        case BloodMagic:
            return [UIColor colorWithRed:0.8 green:0.3 blue:0.15 alpha:1.0];
            break;
        case DevineMagic:
            return [UIColor colorWithRed:0.95 green:0.9 blue:0.1 alpha:1.0];
        case ArcanineMagic:
            return [UIColor colorWithRed:0.05 green:0.65 blue:0.7 alpha:1.0];
        default:
            return [UIColor redColor];
            break;
    }
}

+(UIColor *)gemBorderColorGivenState:(gemState)state {
    switch (state) {
        case normalGem:
            return [UIColor blackColor];
            break;
        case selectedGem:
            return [UIColor yellowColor];
            break;
        default:
            return [UIColor redColor];
            break;
    }
}
@end
