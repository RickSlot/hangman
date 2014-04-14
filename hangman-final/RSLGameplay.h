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
- (NSString *) checkIfCharacterExistsInWord: (NSString *) character;
- (NSString *) characterPicked:(NSString * ) character;

@end
