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
@property (weak, nonatomic) IBOutlet UILabel *wordLabel;
@property (weak, nonatomic) IBOutlet UILabel *lettersGuessedLabel;
@property (weak, nonatomic) IBOutlet UIImageView *hangmanImageView;

@end

@implementation RSLMainViewController

RSLHighscoreController *highscore;

bool keyboardIsShown;

/*
 * Shows the keyabord and hides the navigation bar
 */
- (void)viewWillAppear:(BOOL)animated{
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    [_characterInput becomeFirstResponder];
}

/*
 * Sets up a new game and sets the background
 */
- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.jpg"]];
    highscore = [[RSLHighscoreController alloc] init];
    keyboardIsShown = NO;
    [self initGame];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}



#pragma mark - keyboard


/*
 * Handles the input when the user presses return on the keyboard
 */
-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    if([_characterInput.text length] == 1){
        [_gameplay characterPicked:self.characterInput.text];
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

    }
    _characterInput.text = @"";
    return NO;
}

#pragma mark - Flipside View

- (void)flipsideViewControllerDidFinish:(RSLFlipsideViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"prepare");
    [_characterInput resignFirstResponder];
    if ([[segue identifier] isEqualToString:@"showAlternate"]) {
        [[segue destinationViewController] setDelegate:self];
    }
}

#pragma mark - game stuff
/*
 * This function is called when the game is over and the user lost
 */
- (void) gameover{
    [_characterInput resignFirstResponder];
    NSString *text = [[NSString alloc] initWithFormat: @"Game over, we were looking for the word %@!", _gameplay.wordToGuess];
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Game over! :(" message:text delegate:self cancelButtonTitle:@"Done!" otherButtonTitles:nil];
    alert.tag = 2;
    [alert show];
}

/*
 * This function is called when the game is over and the user won, it asks for a name and submits the score to the highscores
 */
- (void) gamewin{
    NSLog(@"You won!");
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Congratulations!" message:@"You won the game! Please enter your name." delegate:self cancelButtonTitle:@"Done!" otherButtonTitles:nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    alert.tag = 1;
    [alert show];
}

/*
 * This function sets up a new game
 */
- (void) initGame{
    [self.characterInput setDelegate:self];
    _gameplay = [[RSLGameplay alloc] init];
    _guessesLeftLabel.text = _gameplay.guessesLeft.stringValue;
    _wordLabel.text = _gameplay.wordStringForLabel;
    _characterInput.text = @"";
    _lettersGuessedLabel.text = @"";
    UIImage *image = [UIImage imageNamed:@"hangman8"];
    [_hangmanImageView setImage:image];
}

/*
 * This function calculates which image should be shown
 */
- (NSString *) calculateImage{
    double percentage = [_gameplay.guessesLeft doubleValue] / [_gameplay.totalNumberGuesses doubleValue];
    NSString *imageName;
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
    return imageName;
}

/*
 * This function gets called when a user resets the game
 */
- (IBAction)resetGame:(id)sender {
    [self initGame];
}

#pragma mark - alertview stuff

/*
 * This function handles what happens when the game is over.
 */
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag == 1){
        int score = [highscore calculateHighscoreWithGuessesLeft:[_gameplay.guessesLeft integerValue] wordLength:_gameplay.wordToGuess.length totalNumberGuesses:[_gameplay.totalNumberGuesses integerValue]];
        NSString *name = [alertView textFieldAtIndex:0].text;
        [highscore addHighscoreWithName:name andScore: score];
        [self initGame];
        [self performSegueWithIdentifier:@"highscore" sender:self];
    }else if(alertView.tag == 2){
        [_characterInput becomeFirstResponder];
        [self initGame];
    }
}

@end
