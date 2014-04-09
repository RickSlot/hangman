//
//  RSLHighscoresViewController.m
//  hangman-final
//
//  Created by Rick Slot on 09/04/14.
//  Copyright (c) 2014 Rick Slot. All rights reserved.
//

#import "RSLHighscoresViewController.h"

@interface RSLHighscoresViewController ()

@end

@implementation RSLHighscoresViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.jpg"]];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
}


@end
