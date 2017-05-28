//
//  ViewController.m
//  AKCalculator
//
//  Created by Rose on 5/14/17.
//  Copyright © 2017 aksanakarpenka. All rights reserved.
//

#import "ViewController.h"
#import "AboutViewController.h"
#import "LicenseViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UISwipeGestureRecognizer *swipeRecognizer = [[[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                           action:@selector
                                                  (handleSwipeRecognizer:)] autorelease];
    [self.displayLabel addGestureRecognizer:swipeRecognizer];
    UIBarButtonItem *aboutUsUIBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"О нас"
                                                                               style:UIBarButtonItemStylePlain
                                                                              target:self
                                                                              action:@selector(aboutButtonPressed:)];
    self.navigationItem.leftBarButtonItem = aboutUsUIBarButtonItem;
}

/* 
 cleans the last symbol in displayLabelText;
 sets the value to @"0" if all symbols were removed
 */
- (void)handleSwipeRecognizer:(UISwipeGestureRecognizer *)swipeRecognizer {
    NSString *displayLabelText = self.displayLabel.text;
    NSString *result = [displayLabelText substringToIndex:self.displayLabel.text.length - 1];
    
    if (result.length == 0) {
        self.displayLabel.text = @"0";
    } else {
        self.displayLabel.text = result;
    }
}

/*
 digitButtons handler
 formats string as float value (to prevent entering leading zero)
 if the displayLabelText contains "." dot-symbol
 or appends a new digit to the displayLabelText if it does not
 */
- (IBAction)digitTapped:(id)sender {
    NSString *digit = [sender titleForState:UIControlStateNormal];
    NSString *result = [NSString stringWithFormat:@"%@%@", self.displayLabel.text, digit];
    NSString *displayLabelText = self.displayLabel.text;
    
    if (![displayLabelText containsString:@"."]) {
        self.displayLabel.text = [NSString stringWithFormat:@"%.f",  result.floatValue];
    } else {
        self.displayLabel.text = result;
    }
}

// reset displayLabelText value to @"0"
- (IBAction)clearButtonTapped:(id)sender {
    self.displayLabel.text = @"0";
}

/*
 dotButton handler
 appends a dot to the displayLabelText only once
 */
- (IBAction)dotButtonTapped:(id)sender {
    NSString *dot = [sender titleForState:UIControlStateNormal];
    NSString *displayLabelText = self.displayLabel.text;
    
    if (![displayLabelText containsString:@"."]) {
        NSString *result = [NSString stringWithFormat:@"%@%@", self.displayLabel.text, dot];
        self.displayLabel.text = result;
    }
}

// open screen containing an author info
- (IBAction)aboutButtonPressed:(id)sender {
    AboutViewController *aboutViewController = [[AboutViewController alloc] init];
    [self.navigationController pushViewController:aboutViewController animated:YES];
    [aboutViewController release];
}

// open license info
- (IBAction)licenseInfoUIButtonPressed:(id)sender {
    LicenseViewController *licenseViewController = [[LicenseViewController alloc] init];
    [self presentViewController:licenseViewController animated:YES completion:nil];
    [licenseViewController release];
}

- (void)dealloc {
    [_displayLabel release];
    [_digitCollectionButtons release];
    [_clearButton release];
    [_dotButton release];
    [_digitCollectionButtons release];
    [_licenseInfoUIButton release];
    [super dealloc];
}

@end
