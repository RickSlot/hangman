//
//  RSLFlipsideViewController.m
//  hangman-final
//
//  Created by Rick Slot on 05/04/14.
//  Copyright (c) 2014 Rick Slot. All rights reserved.
//

#import "RSLFlipsideViewController.h"

@interface RSLFlipsideViewController ()

@property (weak, nonatomic) IBOutlet UISlider *numberOfGuesses;

@property (weak, nonatomic) IBOutlet UISlider *wordLength;

@property (weak, nonatomic) IBOutlet UILabel *numberOfGuessesLabel;

@property (weak, nonatomic) IBOutlet UILabel *wordLengthLabel;

@end

@implementation RSLFlipsideViewController

NSUserDefaults *userDefaults;

/*
 * Sets up the sliders with the right values
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.jpg"]];
    userDefaults = [NSUserDefaults standardUserDefaults];
    [_numberOfGuesses addTarget:self action:@selector(numberOfGuessesChanged:) forControlEvents:UIControlEventValueChanged];
    [_wordLength addTarget:self action:@selector(wordLengthChanged:) forControlEvents:UIControlEventValueChanged];
    _numberOfGuessesLabel.text = [[NSString alloc] initWithFormat:@"%d", [userDefaults integerForKey:@"numberOfGuesses"]];
    _wordLengthLabel.text = [[NSString alloc] initWithFormat:@"%d", [userDefaults integerForKey:@"wordLength"]];
    _numberOfGuesses.value = [userDefaults integerForKey:@"numberOfGuesses"];
    _wordLength.value = [userDefaults integerForKey:@"wordLength"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Actions

/*
 * Saves the settings
 */
- (IBAction)done:(id)sender
{
    [userDefaults setInteger:(int) _numberOfGuesses.value forKey:@"numberOfGuesses"];
    [userDefaults setInteger:(int) _wordLength.value forKey:@"wordLength"];
    [userDefaults synchronize];
    [self.delegate flipsideViewControllerDidFinish:self];
}

/*
 * This function sets the number of guesses label to the cosen number of guesses
 */
- (IBAction)numberOfGuessesChanged:(UISlider *)sender {
    _numberOfGuessesLabel.text = [[NSMutableString alloc] initWithFormat:@"%d", (int) _numberOfGuesses.value];
    
}

/*
 * This function sets the word length label to the chosen word length
 */
- (IBAction)wordLengthChanged:(UISlider *)sender {
    _wordLengthLabel.text = [[NSMutableString alloc] initWithFormat:@"%d", (int) _wordLength.value];
}


@end
