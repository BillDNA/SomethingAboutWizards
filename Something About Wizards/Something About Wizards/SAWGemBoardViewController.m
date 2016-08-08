//
//  SAWGemBoardViewController.m
//  Something About Wizards
//
//  Created by Dynamic New Algorithms on 7/17/16.
//  Copyright © 2016 Bozo Games. All rights reserved.
//

#import "SAWGemBoardViewController.h"
#import "SAWGemView.h"
#import "SAWGem.h"
#import "SAWSpell.h"
#import "SAWNotificationNames.h"
#import "SAWHelpers.h"

const int64_t kDefaultTimeoutLengthInNanoSeconds = 10000000000; // 10 Seconds
@interface SAWGemBoardViewController () <SAWGemViewDataSource, SAWGemViewDelegate>
#pragma mark - Views
@property (strong, nonatomic) SAWGrid *gemViews;

#pragma mark - Models
@property (strong, nonatomic) SAWGrid *gems;
@property (strong, nonatomic) SAWGemView *selectedGemView;
@property (nonatomic) CGPoint selectedGemLocation; //
@property (nonatomic) NSInteger boardRadius;


@property (nonatomic, strong) dispatch_semaphore_t animatingSemaphore;
@property (nonatomic, strong) dispatch_queue_t     animatingQueue;
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
-(void)viewDidLoad {
    [super viewDidLoad];
    self.animatingSemaphore   = dispatch_semaphore_create(1);
    self.animatingQueue       = dispatch_queue_create("com.SAWGemBoard.animatingQueue", DISPATCH_QUEUE_SERIAL);
    
}
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
        Y = 0 + floor(ABS(x)/2);
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
        Y = 0 + floor(ABS(x)/2);
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
-(void)updateGems:(SAWGrid *)newGems {


    __block BOOL doseNeedRepeat = NO;
    dispatch_async(self.animatingQueue, ^{
         self.gems = newGems;
         for(NSInteger x = 0-self.boardRadius; x < self.boardRadius+1; x++) {
             for(NSInteger y = 0-self.boardRadius + floor(ABS(x)/2); y < self.boardRadius+1 - (ceil(ABS(x)/2)) - (ABS(x)%2); y++) {
                NSInteger z = 0 - x - y;
                 SAWGem *gem = [self.gems objectAtX:x Y:y Z:z];
                 if ([gem isKindOfClass:[NSNull class]]) {
                     CGRect xp = CGRectMake(x+1, y, z,0);
                     CGRect xm = CGRectMake(x-1, y, z,0);
                     CGRect yp = CGRectMake(x, y+1, z,0);
                     CGRect ym = CGRectMake(x, y-1, z,0);
                     CGRect zp = CGRectMake(x, y, z+1,0);
                     CGRect zm = CGRectMake(x, y, z-1,0);
                     NSMutableArray *posiblSliders = [[NSMutableArray alloc] init];
                     NSArray *originalPosibilaties =@[[NSValue valueWithCGRect:xp],
                                                      [NSValue valueWithCGRect:xm],
                                                      [NSValue valueWithCGRect:yp],
                                                      [NSValue valueWithCGRect:ym],
                                                      [NSValue valueWithCGRect:zp],
                                                      [NSValue valueWithCGRect:zm]];
                     
                     for (int i = 0; i < originalPosibilaties.count; i++ ) {
                         if (posiblSliders.count == 0) {
                             [posiblSliders addObject:[originalPosibilaties objectAtIndex:i]];
                         } else {
                             CGRect max = [[posiblSliders objectAtIndex:0] CGRectValue];
                             NSInteger currentMaxDistance =  MAX(MAX(ABS(0 - max.origin.x), ABS(0 - max.origin.y)), ABS(0 - max.size.width));
                             CGRect posible = [[originalPosibilaties objectAtIndex:i] CGRectValue];
                             NSInteger posibleMaxDistance =  MAX(MAX(ABS(0 - posible.origin.x), ABS(0 - posible.origin.y)), ABS(0 - posible.size.width));
                             if (posibleMaxDistance > currentMaxDistance) {
                                 posiblSliders = [[NSMutableArray alloc] init];
                                 [posiblSliders addObject:[originalPosibilaties objectAtIndex:i]];
                             } else if (posibleMaxDistance == currentMaxDistance) {
                                 [posiblSliders addObject:[originalPosibilaties objectAtIndex:i]];
                             }
                             
                         }
                     }
                     //now we have posibilities
                     BOOL shouldDropInRando = NO;
                     NSInteger indexToSlide = -1;
                     for (NSInteger i = 0; i < posiblSliders.count; i++ ) {
                          CGRect loc = [[posiblSliders objectAtIndex:i] CGRectValue];
                          if ((loc.origin.x < 0-self.boardRadius || loc.origin.x > self.boardRadius) ||
                              (loc.origin.y < 0-self.boardRadius || loc.origin.y > self.boardRadius) ||
                              (loc.size.width < 0-self.boardRadius || loc.size.width > self.boardRadius)) {
                              //this at the edge of the board and we can just po in a rando
                              indexToSlide = i;
                              shouldDropInRando = YES;
                              break;
                          }
                     }
                     if (shouldDropInRando) {
                         [self.gems setObject:[[SAWGem alloc] init] AtX:x Y:y Z:z];
                         dispatch_time_t timeoutTime = dispatch_time(DISPATCH_TIME_NOW, kDefaultTimeoutLengthInNanoSeconds);
                         if (dispatch_semaphore_wait(self.animatingSemaphore, timeoutTime)) {
                             
                         } else {
                             dispatch_async(dispatch_get_main_queue(), ^{
                                 SAWGemView *gv = [self.gemViews objectAtX:x Y:y Z:z];
                                 gv.alpha = 0;
                                 [gv setNeedsDisplay];
                                 [UIView animateWithDuration:0.4 animations:^{
                                     gv.alpha = 1;
                                 } completion:^(BOOL finished) {
                                     dispatch_semaphore_signal(self.animatingSemaphore);
                                 }];
                             });
                         }
                     } else {
                         dispatch_time_t timeoutTime = dispatch_time(DISPATCH_TIME_NOW, kDefaultTimeoutLengthInNanoSeconds);
                         if (dispatch_semaphore_wait(self.animatingSemaphore, timeoutTime)) {
                             
                         } else {
                             doseNeedRepeat = YES;
                             dispatch_async(dispatch_get_main_queue(), ^{
                                 NSInteger pick = random_range(0,(int)posiblSliders.count);
                                 CGRect loc = [[posiblSliders objectAtIndex:pick] CGRectValue];
                                 SAWGemView *selectedGemView  = [self.gemViews objectAtX:loc.origin.x Y:loc.origin.y Z:loc.size.width];
                                 SAWGemView *gemView =  [self.gemViews objectAtX:x Y:y Z:z];
                                 NSLog(@"(%ld,%ld,%ld) sliding to (%0.1f,%0.1f,%0.1f)",x,y,z,loc.origin.x,loc.origin.y,loc.size.width);
                                 [gemView bringSubviewToFront:self.view];
                                 [selectedGemView bringSubviewToFront:self.view];
                                 CGRect newSelectedFrame = gemView.frame;
                                 CGRect newGemFrame = selectedGemView.frame;
                                 gemView.alpha = 0;
                                 [gemView setNeedsDisplay];
                                 [UIView animateWithDuration:0.4 animations:^{
                                     [selectedGemView setFrame:newSelectedFrame];
                                     [gemView setFrame:newGemFrame];
                                     gemView.alpha = 1;
                                 } completion:^(BOOL finished) {
                                     [selectedGemView setFrame:newGemFrame];
                                     [gemView setFrame:newSelectedFrame];
                                     SAWGem *selectedGem = [self.gems objectAtX:loc.origin.x Y:loc.origin.y Z:loc.size.width];
                                     [self.gems setObject:gem AtX:loc.origin.x Y:loc.origin.y Z:loc.size.width];
                                     [self.gems setObject:selectedGem AtX:x Y:y Z:z];
                                     dispatch_semaphore_signal(self.animatingSemaphore);
                                 }];
                             });
                         }
                         
                     }
                 }
             }
         }
     });
    if (doseNeedRepeat) {
        [self updateGems:self.gems];
    }
}
#pragma mark - Data Source Methods
#pragma mark - SAW Gem View Data Source Methods
-(SAWGem *)gemForSAWGemView:(SAWGemView *)sender {
    return [self.gems objectAtX:sender.x Y:sender.y Z:sender.z];
}
#pragma mark - Delegate Methods
#pragma mark - SAW Gem View Delegate Methods
-(void)didTapGemView:(SAWGemView *)sender {
    SAWGem *gem = [self.gems objectAtX:sender.x Y:sender.y Z:sender.z];
    BOOL wasSelected = gem.curentState == selectedGem;
    gem.curentState = abs((int)gem.curentState - 1);
    if (gem.curentState == selectedGem) {
        if (self.selectedGemView == nil) {
            self.selectedGemView = sender;
        } else {
            SAWGemView *selectedGemView = [self.gemViews objectAtX:self.selectedGemView.x Y:self.selectedGemView.y Z:self.selectedGemView.z];
            SAWGemView *gemView =  [self.gemViews objectAtX:sender.x Y:sender.y Z:sender.z];
            [gemView bringSubviewToFront:self.view];
            [selectedGemView bringSubviewToFront:self.view];
            CGRect newSelectedFrame = gemView.frame;
            CGRect newGemFrame = selectedGemView.frame;
            [UIView animateWithDuration:0.4 animations:^{
                [selectedGemView setFrame:newSelectedFrame];
                [gemView setFrame:newGemFrame];
                
            } completion:^(BOOL finished) {
                [selectedGemView setFrame:newGemFrame];
                [gemView setFrame:newSelectedFrame];
                
                SAWGem *selectedGem = [self.gems objectAtX:self.selectedGemView.x Y:self.selectedGemView.y Z:self.selectedGemView.z];
                [self.gems setObject:gem AtX:self.selectedGemView.x Y:self.selectedGemView.y Z:self.selectedGemView.z];
                gem.curentState = normalGem;
                [self.gems setObject:selectedGem AtX:sender.x Y:sender.y Z:sender.z];
                selectedGem.curentState = normalGem;
                [self.selectedGemView setNeedsDisplay];
                self.selectedGemView = nil;
                [self.delegate didSwapGems];
            }];

        }
    } else if (wasSelected) {
        [self.selectedGemView setNeedsDisplay];
        self.selectedGemView = nil;
    }
    
}
#pragma mark - Target Action Mehtods

@end
