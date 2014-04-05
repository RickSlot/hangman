//
//  RSLMainViewController.m
//  hangman-final
//
//  Created by Rick Slot on 05/04/14.
//  Copyright (c) 2014 Rick Slot. All rights reserved.
//

#import "RSLMainViewController.h"

@interface RSLMainViewController ()

@property (nonatomic) RSLGameplay *gameplay;
@property (strong, nonatomic) IBOutlet UITextField *characterInput;
@property (weak, nonatomic) IBOutlet UILabel *guessesLeftLabel;
@property (weak, nonatomic) IBOutlet UILabel *feedbackLabel;
@property (weak, nonatomic) IBOutlet UILabel *wordLabel;
@property (weak, nonatomic) IBOutlet UILabel *lettersGuessedLabel;

@end

@implementation RSLMainViewController

bool keyboardIsShown;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:self.view.window];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:self.view.window];
    
    keyboardIsShown = NO;
    [self.characterInput setDelegate:self];
    _gameplay = [[RSLGameplay alloc] init];
    _guessesLeftLabel.text = _gameplay.guessesLeft.stringValue;
    _wordLabel.text = _gameplay.wordStringForLabel;
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - keyboard

- (void)keyboardWillHide:(NSNotification *)n
{
    keyboardIsShown = NO;
}

- (void)keyboardWillShow:(NSNotification *)n
{
    if (keyboardIsShown) {
        return;
    }
    _characterInput.text = @"";
    keyboardIsShown = YES;
}

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
    }else{
        _feedbackLabel.text = @"Please pick just one character!";
    }
    return YES;
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
}

- (void) gamewin{
    NSLog(@"You won!");
    _feedbackLabel.text = @"Congratulations, you won the game!";
}

@end
