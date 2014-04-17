//
//  RSLHighscore.m
//  hangman-final
//
//  Created by Rick Slot on 12/04/14.
//  Copyright (c) 2014 Rick Slot. All rights reserved.
//

#import "RSLHighscoreController.h"

@implementation RSLHighscoreController

- (id) init{
    self = [super init];
    if(!self) return nil;
    return self;
}

/*
 * This function adds a new highscore to the plist if it is a highscore
 */
- (void) addHighscoreWithName:(NSString *) name andScore:(int) score{
    NSMutableDictionary *dictFromPlist = [self dictionaryFromPlist];
    int position = -1;
    for(int i = 1; i <= 10; i++){
        NSString *scoreString = [[NSString alloc] initWithFormat:@"score%d", i];
        scoreString = [dictFromPlist valueForKey:scoreString];
        if(scoreString != nil){
            NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
            NSNumber *scoreNumber = [f numberFromString:scoreString];
            int localScore = [scoreNumber integerValue];
            if(score >= localScore){
                position = i;
                break;
            }
        }else{
            position = i;
            break;
        }
    }

    if(position != -1){
        dictFromPlist = [self createDictionaryForScore:score withName:name withDict:dictFromPlist andPosition:position];
        [self writeDictionaryToPlist:dictFromPlist];
    }else{
        NSLog(@"not a highscore!");
    }
}

/*
 * This function calculates the highscore of the game played
 */
- (int) calculateHighscoreWithGuessesLeft:(int) guessesLeft wordLength:(int) wordLength totalNumberGuesses:(int) totalNumberGuesses{
    int score = ((wordLength * 100 * guessesLeft) / totalNumberGuesses) + (totalNumberGuesses - guessesLeft) * 100;
    return score;
}

/*
 * This function creates a dictionary with highscores to be saved as plist
 */
- (NSMutableDictionary*) createDictionaryForScore:(int) scored withName:(NSString*) name withDict:(NSMutableDictionary*) dict andPosition:(int) position{
    NSMutableDictionary *newDict = [[NSMutableDictionary alloc] init];
    
    NSString *scoreDown = nil;
    NSString *nameDown = nil;
    for(int i = 1; i <= 10; i++){
        NSString *scoreString = [[NSString alloc] initWithFormat:@"score%d", i];
        NSString *nameString = [[NSString alloc] initWithFormat:@"name%d", i];
        
        if(scoreDown != nil){
            [newDict setValue:scoreDown forKey:scoreString];
            [newDict setValue:nameDown forKey:nameString];
            NSLog(@"score: %@  name: %@ pos: %d", scoreDown, nameDown, position);
        }else{
            [newDict setValue:[dict valueForKey:scoreString] forKey:scoreString];
            [newDict setValue:[dict valueForKey:nameString] forKey:nameString];
        }
        if(i >= position -1){
            scoreDown = [dict valueForKey:scoreString];
            nameDown = [dict valueForKey:nameString];
        }
        
        if(i == position){
            NSString *score = [[NSString alloc] initWithFormat:@"%d", scored];
            [newDict setValue:score forKey:scoreString];
            [newDict setValue:name forKey:nameString];
        }
    }
    return newDict;
}

/*
 * This function reads the plist and returns a dictionary
 */
- (NSMutableDictionary*)dictionaryFromPlist {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingString:@"/highscores.plist"];
    NSMutableDictionary* propertyListValues = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
    if(propertyListValues == nil){
        propertyListValues = [[NSMutableDictionary alloc] init];
    }
    return propertyListValues;
}

/*
 * This function saves a dictionary to a plist
 */
- (BOOL)writeDictionaryToPlist:(NSDictionary*)plistDict{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"highscores.plist"];
    
    return [plistDict writeToFile:path atomically:YES];
}

@end
