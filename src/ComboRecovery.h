//
//  ComboRecovery.h
//  Combo Recovery
//
//  Created by srich on 11/7/14.
//  Copyright (c) 2014 Scott Richards. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ComboRecovery : NSObject

@property (nonatomic) int magicNum;
@property (nonatomic) int diffNum;

@property (nonatomic) BOOL alert1;
@property (nonatomic) BOOL alert2;
@property (nonatomic) BOOL alert3;
@property (nonatomic) BOOL alert4;
@property (nonatomic) BOOL isFourNums;
@property (nonatomic) BOOL isFiveNums;

@property (nonatomic) double stickyOne;
@property (nonatomic) double stickyTwo;
@property (nonatomic) double stickyThree;
@property (nonatomic) double stickyFour;
@property (nonatomic) double stickyFive;
@property (nonatomic) double stickySix;
@property (nonatomic) double stickySeven;
@property (nonatomic) double stickyEight;
@property (nonatomic) double stickyNine;
@property (nonatomic) double stickyTen;
@property (nonatomic) double stickyEleven;
@property (nonatomic) double stickyTwelve;
@property (strong,nonatomic) NSMutableArray *stickyNums;

@property (nonatomic) int thirdNumber;
@property (nonatomic) NSMutableArray *fiveNums;
@property (nonatomic) NSMutableArray *firstNumberArray;
@property (nonatomic) NSMutableArray *secondNumberArray;
@property (nonatomic) NSMutableArray *combinationsArray;
@property (nonatomic) NSMutableArray *allCombosArray;

- (void)fillStickyNums;
- (void)findThirdNumber;
- (void)fillFirstNumberArray;
- (void)fillSecondNumberArray;
- (void)sortArrayForRP:(int)resPoint;
- (void)fillCombinationsArray;
- (BOOL)hasDecimal:(double)num;
- (void)numWithDifferentLastDigit:(NSMutableArray*)fiveNums;
- (void)fillAllCombosArray;

@end
