//
//  AboutViewController.h
//  BullsEye
//
//  Created by Grégoire Jacquin on 08/09/12.
//  Copyright (c) 2012 Grégoire Jacquin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIWebView *webView;
- (IBAction)close;
@end
