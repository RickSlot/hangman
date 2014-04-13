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
@property (weak, nonatomic) IBOutlet UILabel *rankOneLabel;
@property (weak, nonatomic) IBOutlet UILabel *rankTwoLabel;
@property (weak, nonatomic) IBOutlet UILabel *rankThreeLabel;
@property (weak, nonatomic) IBOutlet UILabel *rankFourLabel;
@property (weak, nonatomic) IBOutlet UILabel *rankFiveLabel;
@property (weak, nonatomic) IBOutlet UILabel *rankSixLabel;
@property (weak, nonatomic) IBOutlet UILabel *rankSevenLabel;
@property (weak, nonatomic) IBOutlet UILabel *rankEightLabel;
@property (weak, nonatomic) IBOutlet UILabel *rankNineLabel;
@property (weak, nonatomic) IBOutlet UILabel *rankTenLabel;

@end

@implementation RSLHighscoresViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.jpg"]];
    RSLHighscoreController *highscores = [[RSLHighscoreController alloc] init];
    [self setLabels];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

- (void)setLabels{
    self.rankOneLabel.text = @"Rick";
}

@end
