//
//  KamkarReduction.m
//  Combo Recovery
//
//  Created by srich on 7/25/15.
//  Copyright (c) 2015 Scott Richards. All rights reserved.
//

#import "KamkarReduction.h"

@implementation KamkarReduction : NSObject

#define debug 0

+ (NSArray *)zeroToTen {
    NSMutableArray *zToTen = [[NSMutableArray alloc] init];
    for (int i = 0; i < 11 ; i++) {
        [zToTen addObject:[NSString stringWithFormat:@"%d",i]];
    }
    if (debug == 1) {
        NSLog(@"Array: %@",zToTen);
    }
    return zToTen;
}

- (NSMutableArray *)firstLocked:(int)firLock SecondLockToGetArrayOfNums:(int)secLock {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i = 0; i < 4; i++) {
        if (secLock > 9) {
            [array addObject:[[NSNumber alloc] initWithInt:(10 * i)]];
            [array addObject:[[NSNumber alloc] initWithInt:(firLock + 10 * i)]];
        }
        else {
            [array addObject:[[NSNumber alloc] initWithInt:(firLock + 10 * i)]];
            [array addObject:[[NSNumber alloc] initWithInt:(secLock + 10 * i)]];
        }
    }
    if (debug == 1) {
        NSLog(@"Array of Lock Nums: %@",array);
    }
    return array;
}

- (int)convertResistancePointToFirstNumber:(double)resPoint {
    int firNum = ceil(resPoint + 5);
    if (debug == 1) {
        NSLog(@"First Number: %d",firNum);
    }
    return firNum;
}

- (NSMutableArray *)firstNumber:(int)firNum ThirdNumberArrayToPossibleThirdNums:(NSArray *)thirdNumArray {
    NSMutableArray *possibleThirdNums = [[NSMutableArray alloc] init];
    NSMutableArray *firstNumMods = [[NSMutableArray alloc] init];
    int firstMod = firNum % 4;
    for (int i = 0; i < 10; i++) {
        [firstNumMods addObject:[[NSNumber alloc] initWithInt:(firstMod + i * 4)]];
    }
    for (int i = 0; i < firstNumMods.count; i++) {
        for (int j = 0; j < thirdNumArray.count; j++) {
            if ([[firstNumMods objectAtIndex:i] intValue] == [[thirdNumArray objectAtIndex:j] intValue])
                [possibleThirdNums addObject:[thirdNumArray objectAtIndex:j]];
        }
    }
    if (debug == 1) {
        NSLog(@"Possible Third Nums: %@",possibleThirdNums);
    }
    return possibleThirdNums;
}

- (NSMutableArray *)thirdNumberToPossibleSecondNumbers:(int)thirdNum {
    NSMutableArray *possibleSecNums = [[NSMutableArray alloc] init];
    int thirdMod = thirdNum % 4;
    for (int j = 0; j < 10; j++) {
        NSNumber *possSecNum = [[NSNumber alloc] initWithInt:(thirdMod + (j * 4 + 2))];
        if (possSecNum.intValue < thirdNum) {
            if (thirdNum - possSecNum.intValue > 2)
                [possibleSecNums addObject:possSecNum];
        }
        else {
            if (possSecNum.intValue - thirdNum > 2)
                [possibleSecNums addObject:possSecNum];
        }
    }
    for (int i = 0; i < possibleSecNums.count; i++) {
        if ([[possibleSecNums objectAtIndex:i] intValue] >= 40)
            [possibleSecNums removeObjectAtIndex:i];
    }
    if (debug == 1) {
        NSLog(@"Possible Second Nums: %@",possibleSecNums);
    }
    return possibleSecNums;
}

- (void)findFirstAndSecondNumbers {
    NSArray *longList = [[NSArray alloc] initWithArray:[self firstLocked:self.firstLock
                                             SecondLockToGetArrayOfNums:self.secondLock]];
    self.firstNumber = [self convertResistancePointToFirstNumber:self.resistantPoint];
    self.possibleThirdNumbers = [self firstNumber:self.firstNumber ThirdNumberArrayToPossibleThirdNums:longList];
    self.thirdNumber = [[self.possibleThirdNumbers objectAtIndex:0] intValue];
    self.secondNumbers = [self thirdNumberToPossibleSecondNumbers:[[self.possibleThirdNumbers objectAtIndex:0] intValue]];
}

- (void)findCombinations {
    NSString *num1 = [NSString stringWithFormat:@"%i",self.firstNumber];
    NSString *num2;
    NSString *num3 = [NSString stringWithFormat:@"%i",self.thirdNumber];
    NSString *space = @" - ";
    NSString *str;
    
    for (int i = 0; i < self.secondNumbers.count; i++) {
        num2 = [NSString stringWithFormat:@"%@",[self.secondNumbers objectAtIndex:i]];
        str = [[[[num1 stringByAppendingString:space] stringByAppendingString:num2] stringByAppendingString:space] stringByAppendingString:num3];
        [self.combinations addObject:str];
    }
}

- (id) init {
    if (self = [super init]) {
        self.firstLock = -1;
        self.secondLock = -1;
        self.resistantPoint = -1.0;
        self.firstNumber = -1;
        self.thirdNumber = -1;
        self.possibleThirdNumbers = [[NSMutableArray alloc] init];
        self.secondNumbers = [[NSMutableArray alloc] init];
        self.thirdNumbers = [[NSMutableArray alloc] init];
        self.combinations = [[NSMutableArray alloc] init];
    }
    return self;
}

@end
