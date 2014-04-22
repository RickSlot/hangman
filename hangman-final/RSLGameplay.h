//
//  RSLGameplay.h
//  hangman-final
//
//  Created by Rick Slot on 05/04/14.
//  Copyright (c) 2014 Rick Slot. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSLGameplay : NSObject

@property (nonatomic) NSString *wordToGuess;
@property (nonatomic) NSMutableString *wordToGuessMutable;
@property (nonatomic) NSNumber *guessesLeft;
@property (nonatomic) NSMutableString *wordStringForLabel;
@property (nonatomic) NSArray *words;
@property (nonatomic) NSMutableSet *chosenCharacters;
@property (nonatomic) NSNumber *totalNumberGuesses;

- (id) init;
- (BOOL) checkIfCharacterExistsInWord: (NSString *) character;
- (BOOL) characterPicked:(NSString * ) character;
- (NSString *) convertToUpperCase:(NSString *) character;
- (void) setWordStringForLabel;
- (NSString *) calculateImage;

@end
