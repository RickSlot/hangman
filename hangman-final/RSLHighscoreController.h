//
//  RSLHighscore.h
//  hangman-final
//
//  Created by Rick Slot on 12/04/14.
//  Copyright (c) 2014 Rick Slot. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSLHighscoreController : NSObject

- (id) init;

- (void) addHighscoreWithName:(NSString *) name GuessesLeft:(int) guessesLeft wordLength:(int) wordLength totalNumberGuesses:(int) totalNumberGuesses;

- (NSArray *) getHighscoreNamesInOrder;
@end
