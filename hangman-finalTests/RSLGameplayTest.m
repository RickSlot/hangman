//
//  RSLGameplayTest.m
//  hangman-final
//
//  Created by Rick Slot on 17/04/14.
//  Copyright (c) 2014 Rick Slot. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RSLGameplay.h"

@interface RSLGameplayTest : XCTestCase

@end

@implementation RSLGameplayTest

RSLGameplay *gameplay;

- (void)setUp{
    [super setUp];
    gameplay = [[RSLGameplay alloc] init];
    gameplay.wordToGuess = @"HANGMAN";
    gameplay.wordToGuessMutable = [[NSMutableString alloc] initWithString:gameplay.wordToGuess];
    [gameplay setWordStringForLabel];
    NSLog(@"\n\n\n");
}

- (void)tearDown{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    NSLog(@"\n\n\n");
}

- (void)testPickLetterAShouldReturnYes{
    BOOL characterPicked = [gameplay characterPicked: @"A"];
    XCTAssertEqual(characterPicked, YES, @"should be true!");
}

- (void)testPickLetterPShouldReturnNo{
    BOOL characterPicked = [gameplay characterPicked: @"P"];
    XCTAssertEqual(characterPicked, NO, @"should be false!");
}

- (void)testConvertToUpperShouldReturnTrue{
    NSString *lowerCase = @"a";
    NSString *uppercase = [gameplay convertToUpperCase:lowerCase];
    XCTAssertTrue([uppercase isEqualToString:@"A"] ,@"should be uppercase");
}

- (void)testIfCharacterExistsInWordShouldReturnTrue{
    BOOL characterExists = [gameplay checkIfCharacterExistsInWord: @"A"];
    XCTAssertEqual(characterExists, YES, @"should be true!");
}

- (void)testIfCharacterExistsInWordShouldReturnNo{
    BOOL characterExists = [gameplay checkIfCharacterExistsInWord: @"P"];
    XCTAssertEqual(characterExists, NO, @"should be true!");
}

- (void)testSetWordStringForLabelShouldBeChanged{
    [gameplay setWordStringForLabel];
    XCTAssertTrue([gameplay.wordStringForLabel  isEqualToString:@"-------"],@"should be -------");
}

@end
