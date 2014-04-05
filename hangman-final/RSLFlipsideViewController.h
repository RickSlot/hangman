//
//  RSLFlipsideViewController.h
//  hangman-final
//
//  Created by Rick Slot on 05/04/14.
//  Copyright (c) 2014 Rick Slot. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RSLFlipsideViewController;

@protocol RSLFlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(RSLFlipsideViewController *)controller;
@end

@interface RSLFlipsideViewController : UIViewController

@property (weak, nonatomic) id <RSLFlipsideViewControllerDelegate> delegate;

- (IBAction)done:(id)sender;

@end
