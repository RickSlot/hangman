//
//  RSLGameplay.m
//  hangman-final
//
//  Created by Rick Slot on 05/04/14.
//  Copyright (c) 2014 Rick Slot. All rights reserved.
//

#import "RSLGameplay.h"
#import <stdlib.h>

@implementation RSLGameplay

/*
 * This function inits a gameplay object and picks a random word.
 */
- (id) init{
    self = [super init];
    if(!self) return nil;
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    _words = [[NSArray alloc] initWithContentsOfFile: [[NSBundle mainBundle] pathForResource: @"words" ofType: @"plist"]];
    int random;
    while(1){
        random = arc4random_uniform([_words count]);
        if([[_words objectAtIndex:random] length] <= [userDefaults integerForKey:@"wordLength"]){
            _wordToGuess = [_words objectAtIndex:random];
            break;
        }
    }
    NSLog(@"Word to guess: %@", _wordToGuess);
    _chosenCharacters = [[NSMutableSet alloc] init];
    _wordToGuessMutable = [[NSMutableString alloc] initWithString:_wordToGuess];
    
    
    
    
    _guessesLeft = [NSNumber numberWithInt:[userDefaults integerForKey:@"numberOfGuesses"]];
    _totalNumberGuesses = _guessesLeft;
    [self setWordStringForLabel];
    
    return self;

}

/*
 * This function checks if a character is already picked and handles the input
 */
- (BOOL) characterPicked:(NSString * ) character{
    NSString *characterUpperCase = [self convertToUpperCase:character];
    for(NSString *alreadyPicked in _chosenCharacters){
        if([alreadyPicked isEqualToString:characterUpperCase]){
            return NO;
        }
    }
    [_chosenCharacters addObject:characterUpperCase];
    return [self checkIfCharacterExistsInWord:characterUpperCase];
}

/*
 * This function converts a character to uppercase
 */
- (NSString *) convertToUpperCase:(NSString *) character{
    return [character uppercaseString];
}

/*
 * This function checks if a character exists in a word
 */
- (BOOL) checkIfCharacterExistsInWord: (NSString *) character{
    if([self.wordToGuessMutable rangeOfString:character].location != NSNotFound){
        while([self.wordToGuessMutable rangeOfString:character].location != NSNotFound){
            int location =  [self.wordToGuessMutable rangeOfString:character].location;
            NSRange range1 = NSMakeRange(location, 1);
            [self.wordToGuessMutable replaceCharactersInRange:range1 withString:@"*"];

            NSRange range2 = NSMakeRange(location, 1);
            [_wordStringForLabel replaceCharactersInRange:range2 withString:character];
        }
        return YES;
    }else{
        _guessesLeft = [NSNumber numberWithInt: _guessesLeft.intValue - 1];
        return NO;
    }
}

/*
 * This function sets a string with a number of dashes according to the wordlength
 */
- (void) setWordStringForLabel{
    int wordLength = [self.wordToGuess length];
    NSMutableString *labelString = [[NSMutableString alloc] init];
    for(int i = 0; i < wordLength; i++){
        NSString *part = [[NSString alloc] initWithFormat:@"-"];
        [labelString appendString:part];
    }
    _wordStringForLabel = labelString;
}

@end

