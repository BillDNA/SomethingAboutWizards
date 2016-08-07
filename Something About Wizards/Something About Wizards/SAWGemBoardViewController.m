//
//  SAWGemBoardViewController.m
//  Something About Wizards
//
//  Created by Dynamic New Algorithms on 7/17/16.
//  Copyright © 2016 Bozo Games. All rights reserved.
//

#import "SAWGemBoardViewController.h"
#import "SAWGemView.h"
#import "SAWGrid.h"
#import "SAWGem.h"

@interface SAWGemBoardViewController () <SAWGemViewDataSource, SAWGemViewDelegate>
#pragma mark - Views
@property (strong, nonatomic) SAWGrid *gemViews;
@property (strong, nonatomic) SAWGrid *gems;

#pragma mark - Models
@property (nonatomic) NSInteger boardRadius;


@end

@implementation SAWGemBoardViewController
#pragma mark - getters and setters
-(NSInteger)boardRadius {
    if (_boardRadius <= 0) {
        _boardRadius = 3;
    }
    return _boardRadius;
}
-(NSInteger)gridRowsCount {
    return self.boardRadius * 2 + 1;
}
-(NSInteger)gridColumsCount {
    return self.boardRadius * 2 + 1;
}
-(SAWGrid *)gemViews {
    if (_gemViews == nil) {
        _gemViews = [[SAWGrid alloc] initWithRows:[self gridRowsCount] columns:[self gridColumsCount]];
    }
    return  _gemViews;
}
-(SAWGrid *)gems {
    if (_gems == nil) {
        _gems = [[SAWGrid alloc] initWithRows:[self gridRowsCount] columns:[self gridColumsCount]];
    }
    return _gems;
}
#pragma mark - Controller Life Cycle Methods
-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
-(void) viewWillAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    CGFloat width = 100.0;
    CGFloat height = sqrt(3.0)/2.0 * width;
    CGPoint center = CGPointMake(self.view.frame.origin.x + (self.view.frame.size.width) / 2.0,self.view.frame.origin.y +  (self.view.frame.size.height) / 2.0);
    NSInteger X = 0;
    NSInteger Y = 0;
    for(NSInteger x = 0-self.boardRadius; x < self.boardRadius+1; x++) {
        Y = 0;
        for(NSInteger y = 0-self.boardRadius + floor(ABS(x)/2); y < self.boardRadius+1 - (ceil(ABS(x)/2)) - (ABS(x)%2); y++) {
            NSInteger z = 0 - x - y;
            
            CGFloat xOff = x * (0.75 * width);
            CGFloat yOff = y * height;
            if (ABS(x) % 2 == 1) {
                yOff += height/2.0;
            }
            [self.gems setObject:[[SAWGem alloc] init] inRow:X column:Y];
            SAWGemView *gv = [[SAWGemView alloc] initWithFrame:CGRectMake(center.x + xOff - width/2.0, center.y + yOff - height / 2.0,width,height) andCoridinatesX:x Y:y Z:z ];
            [self.view addSubview:gv];
            [self.gemViews setObject:gv inRow:X column:Y];
            gv.dataSource = self;
            gv.delegate = self;
            Y++;
        }
        X++;
    }
}
#pragma mark - Update Methods
-(void)viewDidLayoutSubviews {
    CGPoint center = CGPointMake(self.view.frame.origin.x + (self.view.frame.size.width) / 2.0,self.view.frame.origin.y +  (self.view.frame.size.height) / 2.0);
    NSInteger X = 0;
    NSInteger Y = 0;
    CGFloat width = 43;
    CGFloat height = sqrt(3.0)/2.0 * width;
    for(NSInteger x = 0-self.boardRadius; x < self.boardRadius+1; x++) {
        Y = 0;
        for(NSInteger y = 0-self.boardRadius + floor(ABS(x)/2); y < self.boardRadius+1 - (ceil(ABS(x)/2)) - (ABS(x)%2); y++) {
            CGFloat xOff = x * (0.75 * width);
            CGFloat yOff = y * height;
            if (ABS(x) % 2 == 1) {
                yOff += height/2.0;
            }
            SAWGemView *gv = [self.gemViews objectInRow:X column:Y];
            [gv setFrame:CGRectMake(floor(center.x + xOff - width/2.0),floor(center.y + yOff - height / 2.0),width,height)];
            [self.gemViews setObject:gv inRow:X column:Y];
            Y++;
        }
        X++;
    }
}
#pragma mark - Data Source Methods
#pragma mark - SAW Gem View Data Source Methods
-(SAWGem *)gemForSAWGemView:(SAWGemView *)sender {
    return [self.gems objectInRow:(sender.x + floor([self.gems rowCount] / 2)) column:(sender.y+ floor([self.gems colCount] / 2))];
}
#pragma mark - Delegate Methods
#pragma mark - SAW Gem View Delegate Methods
-(void)didTapGemView:(SAWGemView *)sender {
    SAWGem *gem = [self.gems objectInRow:(sender.x + floor([self.gems rowCount] / 2)) column:(sender.y+ floor([self.gems colCount] / 2))];
    gem.curentState = ABS(gem.curentState - 1);
}
#pragma mark - Target Action Mehtods

@end
