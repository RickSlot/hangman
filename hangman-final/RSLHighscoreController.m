//
//  RSLHighscore.m
//  hangman-final
//
//  Created by Rick Slot on 12/04/14.
//  Copyright (c) 2014 Rick Slot. All rights reserved.
//

#import "RSLHighscoreController.h"
#import "RSLHighscore.h"

@implementation RSLHighscoreController

- (id) init{
    self = [super init];
    if(!self) return nil;
    [self writeTestDataToPlist];
    return self;
}

- (void) addHighscoreWithName:(NSString *) name GuessesLeft:(int) guessesLeft wordLength:(int) wordLength totalNumberGuesses:(int) totalNumberGuesses{
    int scored = ((wordLength * 1000 * guessesLeft) - (totalNumberGuesses * 100) - ((totalNumberGuesses - guessesLeft) * 100))/totalNumberGuesses;
    NSMutableDictionary *dictFromPlist = [self dictionaryFromPlist];
    int position = -1;
    for(int i = 1; i <= 10; i++){
        NSString *scoreString = [[NSString alloc] initWithFormat:@"score%d", i];
        scoreString = [dictFromPlist valueForKey:scoreString];
        if(scoreString != nil){
            NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
            NSNumber *scoreNumber = [f numberFromString:scoreString];
            int localScore = [scoreNumber integerValue];
            if(scored >= localScore){
                position = i;
                break;
            }
        }else{
            position = i;
            break;
        }
    }
    NSLog(@"name: %@", name);

    if(position != -1){
        dictFromPlist = [self createDictionaryForScore:scored withName:name withDict:dictFromPlist andPosition:position];
        BOOL saved = [self writeDictionaryToPlist:dictFromPlist];
    }else{
        NSLog(@"not a highscore!");
    }
}
- (NSArray *) getHighscoreNamesInOrder{
    return nil;
}

- (NSMutableDictionary*) createDictionaryForScore:(int) scored withName:(NSString*) name withDict:(NSMutableDictionary*) dict andPosition:(int) position{
    NSMutableDictionary *newDict = [[NSMutableDictionary alloc] init];
    NSLog(@"name2: %@", name);
    
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

- (BOOL)writeDictionaryToPlist:(NSDictionary*)plistDict{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"highscores.plist"];
    
    return [plistDict writeToFile:path atomically:YES];
}

- (void)writeTestDataToPlist{
    NSLog(@"Writing!");
    NSMutableDictionary *highscores = [self dictionaryFromPlist];
    BOOL result = [self writeDictionaryToPlist:highscores];
    
    highscores = [self dictionaryFromPlist];
    NSString *scoreString = [highscores valueForKey:@"score1"];
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    NSNumber *score = [f numberFromString:scoreString];
    
    [self addHighscoreWithName:@"Rick" GuessesLeft:1 wordLength:10 totalNumberGuesses:26];
    
}

@end
