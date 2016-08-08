//
//  SAWGemBoardViewController.h
//  Something About Wizards
//
//  Created by Dynamic New Algorithms on 7/17/16.
//  Copyright © 2016 Bozo Games. All rights reserved.
//

#import "SAWBaseViewController.h"
#import "SAWGrid.h"
@class SAWGemBoardViewController;
@protocol SAWGemBoardViewControllerDelegate
-(void)didSwapGems;
@end
@interface SAWGemBoardViewController : SAWBaseViewController
@property (weak, nonatomic) id<SAWGemBoardViewControllerDelegate> delegate;
-(SAWGrid *)gems;
-(void)updateGems:(SAWGrid *)newGems;
@end
