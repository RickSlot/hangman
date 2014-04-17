//
//  RSLHighscoreControllerTest.m
//  hangman-final
//
//  Created by Rick Slot on 17/04/14.
//  Copyright (c) 2014 Rick Slot. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RSLHighscoreController.h"

@interface RSLHighscoreControllerTest : XCTestCase

@end

@implementation RSLHighscoreControllerTest

RSLHighscoreController *highscore;

- (void)setUp{
    [super setUp];
    highscore  = [[RSLHighscoreController alloc] init];
}

- (void)tearDown{
    [super tearDown];
}

- (void)testCalculateScore{
    int score = [highscore calculateHighscoreWithGuessesLeft:5 wordLength:10 totalNumberGuesses:15];
    XCTAssertEqual(score, 1333, @"should be 1333");
}

@end
