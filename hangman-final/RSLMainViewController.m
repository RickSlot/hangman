//
//  RSLMainViewController.m
//  hangman-final
//
//  Created by Rick Slot on 05/04/14.
//  Copyright (c) 2014 Rick Slot. All rights reserved.
//

#import "RSLMainViewController.h"
#import "RSLHighscoreController.h"
#import "RSLHighscoresViewController.h"
@interface RSLMainViewController ()

@property (nonatomic) RSLGameplay *gameplay;
@property (strong, nonatomic) IBOutlet UITextField *characterInput;
@property (weak, nonatomic) IBOutlet UILabel *guessesLeftLabel;
@property (weak, nonatomic) IBOutlet UILabel *feedbackLabel;
@property (weak, nonatomic) IBOutlet UILabel *wordLabel;
@property (weak, nonatomic) IBOutlet UILabel *lettersGuessedLabel;
@property (weak, nonatomic) IBOutlet UIImageView *hangmanImageView;



@end

@implementation RSLMainViewController

RSLHighscoreController *highscore;

bool keyboardIsShown;

- (void)viewWillAppear:(BOOL)animated{
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.jpg"]];
    highscore = [[RSLHighscoreController alloc] init];
    keyboardIsShown = NO;
    [self initGame];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - keyboard


-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    if([_characterInput.text length] == 1){
        _feedbackLabel.text = [_gameplay characterPicked:self.characterInput.text];
        _guessesLeftLabel.text = _gameplay.guessesLeft.stringValue;
        _wordLabel.text = _gameplay.wordStringForLabel;
        if(_gameplay.guessesLeft.intValue == 0){
            [self gameover];
        }else if([_gameplay.wordToGuess isEqualToString:_gameplay.wordStringForLabel]){
            [self gamewin];
        }
        NSMutableString *lettersGuessed = [[NSMutableString alloc] init];
        for(NSString *chosenCharacter in _gameplay.chosenCharacters){
            [lettersGuessed appendString:chosenCharacter];
            [lettersGuessed appendString:@" "];
        }
        _lettersGuessedLabel.text = lettersGuessed;
        UIImage *image = [UIImage imageNamed:[self calculateImage]];
        [_hangmanImageView setImage:image];

    }else{
        _feedbackLabel.text = @"Please pick just one character!";
    }
    return NO;
}

#pragma mark - Flipside View

- (void)flipsideViewControllerDidFinish:(RSLFlipsideViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showAlternate"]) {
        [[segue destinationViewController] setDelegate:self];
    }
}

#pragma mark - game stuff
- (void) gameover{
    NSString *text = [[NSString alloc] initWithFormat: @"Game over, we were looking for the word %@!", _gameplay.wordToGuess];
    _feedbackLabel.text = text;
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Game over! :(" message:text delegate:self cancelButtonTitle:@"Done!" otherButtonTitles:nil];
    alert.tag = 2;
    [alert show];
}

- (void) gamewin{
    NSLog(@"You won!");
    _feedbackLabel.text = @"Congratulations, you won the game!";
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Congratulations!" message:@"You won the game! Please enter your name." delegate:self cancelButtonTitle:@"Done!" otherButtonTitles:nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    alert.tag = 1;
    [alert show];
}

- (void) initGame{
    [self.characterInput setDelegate:self];
    _gameplay = [[RSLGameplay alloc] init];
    _guessesLeftLabel.text = _gameplay.guessesLeft.stringValue;
    _wordLabel.text = _gameplay.wordStringForLabel;
    _characterInput.text = @"";
    _lettersGuessedLabel.text = @"";
    UIImage *image = [UIImage imageNamed:@"hangman8"];
    [_hangmanImageView setImage:image];
    _feedbackLabel.text = @"Please pick a letter!";
}

- (NSString *) calculateImage{
    double percentage = [_gameplay.guessesLeft doubleValue] / [_gameplay.totalNumberGuesses doubleValue];
    NSString *imageName;
    NSLog(@"percentage: %f", percentage);
    if(percentage == 0){
        imageName = @"hangman0";
    }else if(percentage < 0.125){
        imageName = @"hangman1";
    }else if(percentage < 0.25){
        imageName = @"hangman2";
    }else if(percentage < 0.375){
        imageName = @"hangman3";
    }else if(percentage < 0.5){
        imageName = @"hangman4";
    }else if(percentage < 0.625){
        imageName = @"hangman5";
    }else if(percentage < 0.75){
        imageName = @"hangman6";
    }else if(percentage < 0.875){
        imageName = @"hangman7";
    }else if(percentage >= 0.875){
        imageName = @"hangman8";
    }
    NSLog(@"%@", imageName);
        
    return imageName;
}

- (IBAction)resetGame:(id)sender {
    [self initGame];
}

#pragma mark - alertview stuff

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag == 1){
        int score = [highscore calculateHighscoreWithGuessesLeft:[_gameplay.guessesLeft integerValue] wordLength:_gameplay.wordToGuess.length totalNumberGuesses:[_gameplay.totalNumberGuesses integerValue]];
        NSString *name = [alertView textFieldAtIndex:0].text;
        [highscore addHighscoreWithName:name andScore: score];
        [self initGame];
        [self performSegueWithIdentifier:@"highscore" sender:self];
    }else if(alertView.tag == 2){
        [self initGame];
    }
}

@end
