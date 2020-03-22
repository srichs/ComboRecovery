//
//  ComboRecovery.m
//  Combo Recovery
//
//  Created by srich on 11/7/14.
//  Copyright (c) 2014 Scott Richards. All rights reserved.
//

#import "ComboRecovery.h"

@implementation ComboRecovery

- (void)fillStickyNums {
    NSMutableArray *unsorted = [[NSMutableArray alloc] init];
    NSNumber *num = [NSNumber numberWithDouble:self.stickyOne];
    [unsorted addObject:num];
    num = [NSNumber numberWithDouble:self.stickyTwo];
    [unsorted addObject:num];
    num = [NSNumber numberWithDouble:self.stickyThree];
    [unsorted addObject:num];
    num = [NSNumber numberWithDouble:self.stickyFour];
    [unsorted addObject:num];
    num = [NSNumber numberWithDouble:self.stickyFive];
    [unsorted addObject:num];
    num = [NSNumber numberWithDouble:self.stickySix];
    [unsorted addObject:num];
    num = [NSNumber numberWithDouble:self.stickySeven];
    [unsorted addObject:num];
    num = [NSNumber numberWithDouble:self.stickyEight];
    [unsorted addObject:num];
    num = [NSNumber numberWithDouble:self.stickyNine];
    [unsorted addObject:num];
    num = [NSNumber numberWithDouble:self.stickyTen];
    [unsorted addObject:num];
    num = [NSNumber numberWithDouble:self.stickyEleven];
    [unsorted addObject:num];
    num = [NSNumber numberWithDouble:self.stickyTwelve];
    [unsorted addObject:num];
    
    NSMutableArray *sorted = [[unsorted sortedArrayUsingSelector:@selector(compare:)] mutableCopy];
    self.stickyNums = sorted;
}

- (void)findThirdNumber {
    for (int i = 0; i < [self.stickyNums count]; i++) {
        double num = [[self.stickyNums objectAtIndex:i] doubleValue];
        if ([self hasDecimal:num] == NO)
            [self.fiveNums addObject:[self.stickyNums objectAtIndex:i]];
    }
    if ([self.fiveNums count] < 4 || [self.fiveNums count] > 5) {
        self.alert1 = YES;
        [self setIsFiveNums:NO];
        [self setIsFourNums:NO];
    }
    else if ([self.fiveNums count] == 5) {
        [self setIsFiveNums:YES];
        [self setIsFourNums:NO];
        [self numWithDifferentLastDigit:self.fiveNums];
        self.alert1 = NO;
    }
    else {
        [self setIsFourNums:YES];
        [self setIsFiveNums:NO];
        [self numWithDifferentLastDigit:self.fiveNums];
        self.alert1 = NO;
    }
}

- (void)fillFirstNumberArray {
    if (self.thirdNumber < 4)
        self.magicNum = self.thirdNumber;
    else
        self.magicNum = self.thirdNumber % 4;
    
    for (int i = self.magicNum; i < 40; i += 4) {
        if (i < self.thirdNumber - 2 || i > self.thirdNumber + 2)
            [self.firstNumberArray addObject:[NSNumber numberWithInt:i]];
    }
}

- (void)fillSecondNumberArray {
    int specialNum;
    if (self.magicNum < 2)
        specialNum = self.magicNum + 2;
    else
        specialNum = self.magicNum - 2;
    
    for (int i = specialNum; i < 40; i += 4) {
        if (i < self.thirdNumber - 2 || i > self.thirdNumber + 2)
            [self.secondNumberArray addObject:[NSNumber numberWithInt:i]];
    }
    
}

- (void)sortArrayForRP:(int)resPoint {
    NSMutableArray *firstArray = [[NSMutableArray alloc] init];
    NSMutableArray *tempArray = [self.firstNumberArray mutableCopy];
    int num;
    int lowDiff = 100;
    int currDiff;
    int index = -1;
    int firstNum = resPoint + 5;
    int actualFirstNum = -1;
    for (int i = 0; i < tempArray.count; i++) {
        num = [[tempArray objectAtIndex:i] intValue];
        if (firstNum > num)
            currDiff = firstNum - num;
        else
            currDiff = num - firstNum;
        if (currDiff < lowDiff) {
            index = i;
            lowDiff = currDiff;
        }
    }
    
    if (index > -1) {
        actualFirstNum = [[tempArray objectAtIndex:index] intValue];
        [firstArray addObject:[tempArray objectAtIndex:index]];
        [tempArray removeObjectAtIndex:index];
    }
    NSLog(@"%d",actualFirstNum);
    int interval;
    int otherNum = -1;
    BOOL dontAdd = NO;
    for (int i = 0; i < 10; i++) {
        interval = (i + 1) * 4;
        if ((actualFirstNum + interval) > 40) {
            otherNum = interval - (40 - actualFirstNum);
        }
        else if ((actualFirstNum - interval) < 0) {
            otherNum = (actualFirstNum + 40) - interval;
        }
        for (int j = 0; j < tempArray.count; j++) {
            num = [[tempArray objectAtIndex:j] intValue];
            if (otherNum == num || (actualFirstNum + interval) == num) {
                for (int k = 0; k < firstArray.count; k++) {
                    if (num == [[firstArray objectAtIndex:k] intValue])
                        dontAdd = YES;
                }
                if (!dontAdd) {
                    [firstArray addObject:[tempArray objectAtIndex:j]];
                    dontAdd = NO;
                }
            }
            else if (otherNum == num || (actualFirstNum - interval) == num) {
                for (int k = 0; k < firstArray.count; k++) {
                    if (num == [[firstArray objectAtIndex:k] intValue])
                        dontAdd = YES;
                }
                if (!dontAdd) {
                    [firstArray addObject:[tempArray objectAtIndex:j]];
                    dontAdd = NO;
                }
            }
        }
    }
    self.firstNumberArray = firstArray;
}

- (void)fillCombinationsArray {
    NSString *num1;
    NSString *num2;
    NSString *num3 = [NSString stringWithFormat:@"%i",self.thirdNumber];
    NSString *space = @" - ";
    NSString *str;
    
    for (int i = 0; i < [self.firstNumberArray count]; i++) {
        for (int j = 0; j < [self.secondNumberArray count]; j++) {
            num1 = [NSString stringWithFormat:@"%@",[self.firstNumberArray objectAtIndex:i]];
            num2 = [NSString stringWithFormat:@"%@",[self.secondNumberArray objectAtIndex:j]];
            str = [[[[num1 stringByAppendingString:space] stringByAppendingString:num2] stringByAppendingString:space] stringByAppendingString:num3];
            [self.combinationsArray addObject:str];
        }
    }
}

- (BOOL)hasDecimal:(double)num {
    if (num == (int)num)
        return NO;
    else
        return YES;
}

- (void)numWithDifferentLastDigit:(NSMutableArray*)fiveNums {
    NSMutableArray *lastDigits = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < [fiveNums count]; i++) {
        int num = [[fiveNums objectAtIndex:i] intValue];
        if (num % 10 < 1)
            [lastDigits addObject:[fiveNums objectAtIndex:i]];
        else
            [lastDigits addObject:[NSNumber numberWithInt:num % 10]];
    }
    NSLog(@"%@",lastDigits);
    
    NSMutableArray *firArray = [[NSMutableArray alloc] init];
    NSMutableArray *secArray = [[NSMutableArray alloc] init];
    
    for (int i = 1; i < lastDigits.count; i++) {
        if ([lastDigits objectAtIndex:0] == [lastDigits objectAtIndex:i]) {
            [secArray addObject:[lastDigits objectAtIndex:i]];
        }
        else {
            [firArray addObject:[lastDigits objectAtIndex:i]];
        }
    }
    
    if (secArray.count == 0)
        [secArray addObject:[lastDigits objectAtIndex:0]];
    else if (firArray.count == 0)
        [firArray addObject:[lastDigits objectAtIndex:0]];
    else if ([lastDigits objectAtIndex:0] == [firArray objectAtIndex:0]) {
        [firArray addObject:[lastDigits objectAtIndex:0]];
    }
    else if ([lastDigits objectAtIndex:0] == [secArray objectAtIndex:0]) {
        [secArray addObject:[lastDigits objectAtIndex:0]];
    }
    else {
        self.alert2 = YES;
    }
    
    if (firArray != nil && secArray != nil) {
        if (firArray.count == 1) {
            for (int i = 0; i < lastDigits.count; i++) {
                if ([lastDigits objectAtIndex:i] == [firArray objectAtIndex:0]) {
                    self.thirdNumber = [[fiveNums objectAtIndex:i] intValue];
                }
            }
        }
        else if (secArray.count == 1) {
            for (int i = 0; i < lastDigits.count; i++) {
                if ([lastDigits objectAtIndex:i] == [secArray objectAtIndex:0]) {
                    self.thirdNumber = [[fiveNums objectAtIndex:i] intValue];
                }
            }
        }
        else {
            self.alert2 = YES;
        }
    }
    NSLog(@"%i",self.thirdNumber);
}

- (void)fillAllCombosArray {
    for (int i = 0; i < 40; i++) {
        [self setMagicNum:-1];
        [self.firstNumberArray removeAllObjects];
        [self.secondNumberArray removeAllObjects];
        [self.combinationsArray removeAllObjects];
        [self setThirdNumber:i];
        [self fillFirstNumberArray];
        [self fillSecondNumberArray];
        [self fillCombinationsArray];
        [self.allCombosArray addObjectsFromArray:self.combinationsArray];
    }
}

- (id) init {
    if (self = [super init]) {
        self.magicNum = -1;
        self.diffNum = -1;
        self.alert1 = NO;
        self.alert2 = NO;
        self.alert3 = NO;
        self.alert4 = NO;
        self.isFourNums = NO;
        self.isFiveNums = NO;
        self.stickyOne = 0;
        self.stickyTwo = 0;
        self.stickyThree = 0;
        self.stickyFour = 0;
        self.stickyFive = 0;
        self.stickySix = 0;
        self.stickySeven = 0;
        self.stickyEight = 0;
        self.stickyNine = 0;
        self.stickyTen = 0;
        self.stickyEleven = 0;
        self.stickyTwelve = 0;
        self.stickyNums = [[NSMutableArray alloc] init];
        self.fiveNums = [[NSMutableArray alloc] init];
        self.firstNumberArray = [[NSMutableArray alloc] init];
        self.secondNumberArray = [[NSMutableArray alloc] init];
        self.combinationsArray = [[NSMutableArray alloc] init];
        self.allCombosArray = [[NSMutableArray alloc] init];
        self.thirdNumber = -1;
    }
    return self;
}

@end
