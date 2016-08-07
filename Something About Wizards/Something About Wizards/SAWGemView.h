//
//  SAWGemView.h
//  Something About Wizards
//
//  Created by Dynamic New Algorithms on 7/17/16.
//  Copyright © 2016 Bozo Games. All rights reserved.
//

#import "SAWBaseView.h"
#import "SAWEnums.h"
#import "SAWGem.h"
@class SAWGemView;
@protocol SAWGemViewDataSource
-(SAWGem *)gemForSAWGemView:(SAWGemView *)sender;
@end
@protocol SAWGemViewDelegate
-(void)didTapGemView:(SAWGemView *)sender;

@end
@interface SAWGemView : SAWBaseView
@property (weak, nonatomic) id<SAWGemViewDataSource> dataSource;
@property (weak, nonatomic) id<SAWGemViewDelegate> delegate;


-(NSInteger)x;
-(NSInteger)y;
-(NSInteger)z;

-(id)initWithFrame:(CGRect)frame andCoridinatesX:(NSInteger)x Y:(NSInteger)y Z:(NSInteger)z;
@end
