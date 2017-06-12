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
    [aboutUsUIBarButtonItem release];
    [self.sqrtUIButton setTitle:@"\u221A" forState:UIControlStateNormal];
    [self.plusMinusUIButton setTitle:@"\u00B1" forState:UIControlStateNormal];
    self.model = [[[CalculatorModel alloc] init] autorelease];
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
    if (isResultButtonClicked) {
        isResultButtonClicked = NO;
    }
    NSString *digit = [sender titleForState:UIControlStateNormal];
    NSString *result;
    if (isTypingNumber) {
        result = [NSString stringWithFormat:@"%@%@", self.displayLabel.text, digit];
    } else {
        result = [NSString stringWithFormat:@"%@", digit];
        isTypingNumber = YES;
    }
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
    self.model.curOperation = nil;
    self.model.prevOperation = nil;
    self.model.firstOperand = 0;
    self.model.secondOperand = 0;
    self.model.operationCount = 0;
    
    [self switchAvailabilityButton:YES];
}

// disable(enable) all buttons except clear button in case of arithmetic error
- (void)switchAvailabilityButton:(BOOL)enable {
    for (UIControl *subview in [[self.view viewWithTag:1] subviews]) {
        if ([subview isMemberOfClass:[UIButton class]]) {
            subview.enabled = enable;
            UIColor *buttonTitleColor = (enable) ? [UIColor blackColor] : [UIColor grayColor];
            [subview setTitleColor:buttonTitleColor forState:UIControlStateNormal];
        }
    }
    self.clearButton.enabled = YES;
    [self.clearButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
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

// all operation buttons except "square root" is handled here
- (IBAction)opeationButtonTapped:(id)sender {
    if (isResultButtonClicked) {
        isResultButtonClicked = NO;
        self.model.secondOperand = 0;
    }
    CGFloat value = 0;
    if (!self.model.firstOperand) {
        self.model.firstOperand = [self.displayLabel.text floatValue];
    }
    if (!self.model.curOperation && !self.model.prevOperation) {
        self.model.curOperation = self.model.prevOperation = [sender currentTitle];
    }
    if (isTypingNumber) {
        isTypingNumber = NO;
        self.model.operationCount++;
        self.model.curOperation = [sender currentTitle];
        if (self.model.operationCount == 2) {
            self.model.secondOperand = [self.displayLabel.text floatValue];
            @try {
                value = [self.model performOperation:self.model.secondOperand];
            } @catch (NSException *exception) {
                [self showExceptionMessageAndClearData:exception];
                return;
            }
            self.model.secondOperand = 0;
            self.model.curOperation = self.model.prevOperation = [sender currentTitle];
            self.model.operationCount = 1;
            [self showResult:value];
        }
    } else {
        self.model.curOperation = self.model.prevOperation = [sender currentTitle];
    }
}

// change sign of number to opposite
- (IBAction)changeSignTapped:(id)sender {
    if ([self.displayLabel.text floatValue] == 0) {
        return;
    }
    CGFloat value = [self.displayLabel.text floatValue] * (-1);
    [self showResult:value];
}

// square root operation button is handled here
- (IBAction)sqrtOperationTapped:(id)sender {
    CGFloat value = 0;
    self.model.operationCount++;
    
    @try {
        if (self.model.operationCount == 2) {
            if (isTypingNumber) {
                value = [self.model performOperation:[self.displayLabel.text floatValue]];
                self.model.firstOperand = value;
            }
            self.model.curOperation = self.model.prevOperation = [sender currentTitle];
            value = [self.model performOperation:0];
            self.model.operationCount = 1;
        } else {
            self.model.firstOperand = [self.displayLabel.text floatValue];
            self.model.curOperation = self.model.prevOperation = [sender currentTitle];
            value = [self.model performOperation:0];
        }
        isTypingNumber = NO;
    } @catch (NSException *exception) {
        [self showExceptionMessageAndClearData:exception];
        return;
    }
    [self showResult:value];
}

// equals sign is handled here
- (IBAction)resultButtonTapped:(id)sender {
    isResultButtonClicked = YES;
    CGFloat value = 0;
    @try {
        if (isTypingNumber) {
            isTypingNumber = NO;
            if(self.model.operationCount == 1) {
                self.model.secondOperand = [self.displayLabel.text floatValue];
                value = [self.model performOperation:self.model.secondOperand];
                [self showResult:value];
            }
        } else {
            if (!self.model.secondOperand) {
                self.model.secondOperand = self.model.firstOperand;
            }
            value = [self.model performOperation:self.model.secondOperand];
            self.model.firstOperand = value;
            [self showResult:value];
        }
    } @catch (NSException *exception) {
        [self showExceptionMessageAndClearData:exception];
    }
}

// show result of math operation
- (void)showResult:(CGFloat)value {
    NSNumberFormatter *formatDecimal = [[NSNumberFormatter alloc] init];
    [formatDecimal setNumberStyle:NSNumberFormatterDecimalStyle];
    [formatDecimal setMaximumFractionDigits:6];
    self.displayLabel.text = [NSString stringWithFormat:@"%@", [formatDecimal stringFromNumber:@(value)]];
    SampleProtocol *sampleProtocol = [[SampleProtocol alloc]init];
    sampleProtocol.delegate = self;
    [sampleProtocol sampleAction];
    [formatDecimal release];
}

// realization of protocol method
- (void)resultValueChanged {
    NSLog(@"Result was changed.");
}

// show error message and set data to init state
- (void)showExceptionMessageAndClearData:(NSException *)exception {
    self.displayLabel.text = [NSString stringWithFormat:@"%@", exception.reason];
    [self switchAvailabilityButton:NO];
    self.model.firstOperand = 0;
    self.model.secondOperand = 0;
    self.model.prevOperation = nil;
    self.model.curOperation = nil;
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
    [_sqrtUIButton release];
    [_plusMinusUIButton release];
    [_addUIButton release];
    [_subUIButton release];
    [_divUIButton release];
    [_multUIButton release];
    [_modUIButton release];
    [_resultUIButton release];
    [_model release];
    [super dealloc];
}

@end
