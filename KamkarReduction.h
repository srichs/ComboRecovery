//
//  KamkarReduction.h
//  Combo Recovery
//
//  Created by srich on 7/25/15.
//  Copyright (c) 2015 Scott Richards. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KamkarReduction : NSObject

@property (nonatomic) int firstLock;
@property (nonatomic) int secondLock;
@property (nonatomic) double resistantPoint;
@property (nonatomic) int firstNumber;
@property (nonatomic) int thirdNumber;

@property (strong,nonatomic) NSMutableArray *possibleThirdNumbers;
@property (strong,nonatomic) NSMutableArray *secondNumbers;
@property (strong,nonatomic) NSMutableArray *thirdNumbers;
@property (strong,nonatomic) NSMutableArray *combinations;

+ (NSArray *)zeroToTen;
- (NSMutableArray *)firstLocked:(int)firLock SecondLockToGetArrayOfNums:(int)secLock;
- (int)convertResistancePointToFirstNumber:(double)resPoint;
- (NSMutableArray *)firstNumber:(int)firNum ThirdNumberArrayToPossibleThirdNums:(NSArray *)thirdNumArray;
- (NSMutableArray *)thirdNumberToPossibleSecondNumbers:(int)thirdNum;
- (void)findFirstAndSecondNumbers;
- (void)findCombinations;

@end
