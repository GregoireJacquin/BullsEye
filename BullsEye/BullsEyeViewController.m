//
//  ViewController.m
//  BullsEye
//
//  Created by Grégoire Jacquin on 08/09/12.
//  Copyright (c) 2012 Grégoire Jacquin. All rights reserved.
//

#import "BullsEyeViewController.h"
#import "AboutViewController.h"

@interface BullsEyeViewController ()

@end

@implementation BullsEyeViewController
{
    int currentValue;
    int targetValue;
    int score;
    int round;
}
@synthesize slider;
@synthesize targetLabel;
@synthesize scoreLabel;
@synthesize roundLabel;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self startNewGame];
    [self updateLabel];
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setSlider:nil];
    [self setTargetLabel:nil];
    [self setScoreLabel:nil];
    [self setRoundLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

- (IBAction)sliderMove:(UISlider *)sender {
    
    currentValue = lround(sender.value);
}

- (IBAction)done {
    int difference = abs(targetValue - currentValue);
    int points = 100 - difference;
    
    NSString *title;
    if(difference == 0) {
        title = @"Parfait!";
        points += 100;
    }
    else if (difference < 5) {
        title = @"Vous l'avais presque!";
        points += 50;
    }
    else if (difference < 10) {
        title = @"Assez bien!";
    }
    else {
        title = @"Vous êtes loin du compte ...";
    }
    score += points;
    NSString *message = [NSString stringWithFormat:@"Vous avez marquez %d points",points];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    
    [alert show];
}
- (void)startNewRounds
{
    currentValue = 50;
    self.slider.value = currentValue;
    targetValue = 1 + (arc4random() %100);
    round += 1;
}
- (void)updateLabel
{
    targetLabel.text = [NSString stringWithFormat:@"%d",targetValue];
    scoreLabel.text = [NSString stringWithFormat:@"%d",score];
    roundLabel.text = [NSString stringWithFormat:@"%d",round];
}
- (void)startOver
{
    [self startNewGame];
    [self updateLabel];
}

- (IBAction)showInfo {
    AboutViewController *controller = [[AboutViewController alloc] initWithNibName:@"AboutViewController" bundle:nil];
    controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:controller animated:YES completion:nil];
}
- (void)startNewGame
{
    score = 0;
    round = 0;
    [self startNewRounds];
}
#pragma mark UIAlerteDelegate
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    [self startNewRounds];
    [self updateLabel];
}
@end
