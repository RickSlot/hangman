//
//  RSLHighscoresViewController.m
//  hangman-final
//
//  Created by Rick Slot on 09/04/14.
//  Copyright (c) 2014 Rick Slot. All rights reserved.
//

#import "RSLHighscoresViewController.h"
#import "RSLHighscoreController.h"

@interface RSLHighscoresViewController ()

@end

@implementation RSLHighscoresViewController

RSLHighscoreController *highscores;

- (void)viewDidLoad{
    [super viewDidLoad];
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.jpg"]];
    highscores = [[RSLHighscoreController alloc] init];
    [self setLabels];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

- (void)setLabels{
    NSDictionary *dict = [highscores dictionaryFromPlist];
    
    for(int i = 1; i <= 10; i++){
        UILabel *nameLabel = (UILabel *)[self.view viewWithTag:i];
        NSString *nameString = [[NSString alloc] initWithFormat:@"name%d", i];
        
        UILabel *scoreLabel = (UILabel *)[self.view viewWithTag:i+10];
        NSString *scoreString = [[NSString alloc] initWithFormat:@"score%d", i];
        
        nameLabel.text = [dict valueForKey:nameString];
        scoreLabel.text = [dict valueForKey:scoreString];
    }
}

@end
