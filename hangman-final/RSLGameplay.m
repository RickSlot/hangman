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
    _chosenCharacters = [[NSMutableSet alloc] init];
    _wordToGuessMutable = [[NSMutableString alloc] initWithString:_wordToGuess];
    
    
    
    
    _guessesLeft = [NSNumber numberWithInt:[userDefaults integerForKey:@"numberOfGuesses"]];
    [self setWordStringForLabel];
    
    return self;

}

- (NSString *) characterPicked:(NSString * ) character{
    NSString *characterUpperCase = [self convertToUpperCase:character];
    for(NSString *alreadyPicked in _chosenCharacters){
        if([alreadyPicked isEqualToString:characterUpperCase]){
            return @"You already picked that one!";
        }
    }
    [_chosenCharacters addObject:characterUpperCase];
    return [self checkIfCharacterExistsInWord:characterUpperCase];
}

- (NSString *) convertToUpperCase:(NSString *) character{
    return [character uppercaseString];
}

- (NSString *) checkIfCharacterExistsInWord: (NSString *) character{
    
    if([self.wordToGuessMutable rangeOfString:character].location != NSNotFound){
        while([self.wordToGuessMutable rangeOfString:character].location != NSNotFound){
            int location =  [self.wordToGuessMutable rangeOfString:character].location;
            NSRange range1 = NSMakeRange(location, 1);
            [self.wordToGuessMutable replaceCharactersInRange:range1 withString:@"*"];

            NSRange range2 = NSMakeRange(location, 1);
            [_wordStringForLabel replaceCharactersInRange:range2 withString:character];
        }
        return @"nice one! pick another character!";
    }else{
        _guessesLeft = [NSNumber numberWithInt: _guessesLeft.intValue - 1];
        return @"your guess was wrong please try again!";
    }
}

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

