//
//  ViewController.m
//  AKCalculator
//
//  Created by Rose on 5/14/17.
//  Copyright © 2017 aksanakarpenka. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UISwipeGestureRecognizer *swipeRecognizer = [[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeRecognizer:)] autorelease];
    [self.displayLabel addGestureRecognizer:swipeRecognizer];
}

- (void)handleSwipeRecognizer:(UISwipeGestureRecognizer *)swipeRecognizer {
    NSString *displayLabelText = self.displayLabel.text;
    NSString *result = [displayLabelText substringToIndex:self.displayLabel.text.length - 1];
    if (result.length == 0) {
        self.displayLabel.text = @"0";
    } else {
        self.displayLabel.text = result;
    }
}

- (IBAction)digitTapped:(id)sender {
    NSString *digit = [sender titleForState:UIControlStateNormal];
    
    NSString *result = [NSString stringWithFormat:@"%@%@", self.displayLabel.text, digit];
    
    NSString *displayLabelText = self.displayLabel.text;
    
    if ([displayLabelText rangeOfString:@"."].location == NSNotFound) {
        self.displayLabel.text = [NSString stringWithFormat:@"%.f",  result.floatValue];
    } else {
        self.displayLabel.text = [NSString stringWithFormat:@"%@",  result];
    }
}

- (IBAction)clearButtonTapped:(id)sender {
    self.displayLabel.text = @"0";
}

- (IBAction)dotButtonTapped:(id)sender {
    NSString *dot = [sender titleForState:UIControlStateNormal];
    
    NSString *displayLabelText = self.displayLabel.text;
    
    if ([displayLabelText rangeOfString:@"."].location == NSNotFound) {
        NSString *result = [NSString stringWithFormat:@"%@%@", self.displayLabel.text, dot];
        self.displayLabel.text = [NSString stringWithFormat:@"%@",  result];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_displayLabel release];
    [_digitCollectionButtons release];
    [_clearButton release];
    [_dotButton release];
    [_digitCollectionButtons release];
    [super dealloc];
}
@end
