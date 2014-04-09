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

- (IBAction)done:(id)sender
{
    [userDefaults setInteger:(int) _numberOfGuesses.value forKey:@"numberOfGuesses"];
    [userDefaults setInteger:(int) _wordLength.value forKey:@"wordLength"];
    [userDefaults synchronize];
    [self.delegate flipsideViewControllerDidFinish:self];
}

- (IBAction)numberOfGuessesChanged:(UISlider *)sender {
    _numberOfGuessesLabel.text = [[NSMutableString alloc] initWithFormat:@"%d", (int) _numberOfGuesses.value];
    
}

- (IBAction)wordLengthChanged:(UISlider *)sender {
    _wordLengthLabel.text = [[NSMutableString alloc] initWithFormat:@"%d", (int) _wordLength.value];
}


@end
