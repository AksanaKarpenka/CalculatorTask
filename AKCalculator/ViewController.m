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
#import "BinNumeralSystemController.h"
#import "OctNumeralSystemController.h"
#import "DecNumeralSystemController.h"
#import "HexNumeralSystemController.h"
#import "NumeralSystemController.h"
#import "Constants.h"

@interface ViewController ()

@end

@implementation ViewController

const int NUM_SYSTEM_BIN_BUTTON = 0;
const int NUM_SYSTEM_OCT_BUTTON = 1;
const int NUM_SYSTEM_DEC_BUTTON = 2;
const int NUM_SYSTEM_HEX_BUTTON = 3;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UISwipeGestureRecognizer *swipeRecognizer = [[[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                           action:@selector
                                                  (handleSwipeRecognizer:)] autorelease];
    [self.decResultLabel addGestureRecognizer:swipeRecognizer];
    UIBarButtonItem *aboutUsUIBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"О нас"
                                                                               style:UIBarButtonItemStylePlain
                                                                              target:self
                                                                              action:@selector(aboutButtonPressed:)];
    self.navigationItem.leftBarButtonItem = aboutUsUIBarButtonItem;
    [aboutUsUIBarButtonItem release];
    [self.sqrtUIButton setTitle:@"\u221A" forState:UIControlStateNormal];
    [self.plusMinusUIButton setTitle:@"\u00B1" forState:UIControlStateNormal];
    self.model = [[[CalculatorModel alloc] init] autorelease];
    NSMutableArray *allButtonsMutableArray = [NSMutableArray array];
    [allButtonsMutableArray addObjectsFromArray:self.hexCollectionButtons];
    for (UIButton *button in allButtonsMutableArray) {
        button.enabled = NO;
        UIColor *buttonTitleColor = [UIColor grayColor];
        [button setTitleColor:buttonTitleColor forState:UIControlStateNormal];
    }
    
    [self.decResultLabel addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];
    
    self.numSystemButtonsNames = [NSDictionary dictionaryWithObjectsAndKeys:
                                  [NSNumber numberWithInt:NUM_SYSTEM_BIN_BUTTON], @"BIN",
                                  [NSNumber numberWithInt:NUM_SYSTEM_OCT_BUTTON], @"OCT",
                                  [NSNumber numberWithInt:NUM_SYSTEM_DEC_BUTTON], @"DEC",
                                  [NSNumber numberWithInt:NUM_SYSTEM_HEX_BUTTON], @"HEX",
                                  nil];
    
    self.numSystemControllerObject = [[[DecNumeralSystemController alloc] init] autorelease];
    self.numSystemControllerObject.resultLabel = self.decResultLabel;
}

/* 
 cleans the last symbol in displayLabelText;
 sets the value to @"0" if all symbols were removed
 */
- (void)handleSwipeRecognizer:(UISwipeGestureRecognizer *)swipeRecognizer {
    NSString *displayLabelText = self.decResultLabel.text;
    NSString *result = [displayLabelText substringToIndex:self.decResultLabel.text.length - 1];
    
    if (result.length == 0) {
        self.decResultLabel.text = @"0";
    }
    else {
        self.decResultLabel.text = result;
    }
}

/*
 digitButtons handler
 formats string as float value (to prevent entering leading zero)
 if the displayLabelText contains "." dot-symbol
 or appends a new digit to the displayLabelText if it does not
 */
- (IBAction)digitTapped:(id)sender {
    if (self.isResultButtonClicked) {
        self.isResultButtonClicked = NO;
    }
    NSString *digit = [sender titleForState:UIControlStateNormal];
    NSString *result;

    if (self.isTypingNumber) {
        result = [NSString stringWithFormat:@"%@%@", self.displayLabel.text, digit];
    }
    else {
        result = [NSString stringWithFormat:@"%@", digit];
        self.isTypingNumber = YES;
    }
    NSString *displayLabelText = self.decResultLabel.text;
    
    if (![displayLabelText containsString:@"."]) {
        self.decResultLabel.text = [NSString stringWithFormat:@"%.f",  result.floatValue];
    }
    else {
        self.decResultLabel.text = result;
    }
}

// reset displayLabelText value to @"0"
- (IBAction)clearButtonTapped:(id)sender {
    self.decResultLabel.text = @"0";
    self.binResultLabel.text = @"0";
    self.octResultLabel.text = @"0";
    self.hexResultLabel.text = @"0";
    self.model.currentOperation = nil;
    self.model.previousOperation = nil;
    self.model.firstOperand = 0;
    self.model.secondOperand = 0;
    self.model.operationCount = 0;
    self.numSystemControllerObject.resultLabel = self.decResultLabel;
    self.model.performingOperationStatus = STATUS_CURRENT_OPERATION_IS_NULL;
    
    [self switchAvailabilityButton:YES];
}

// disable(enable) all buttons except clear button in case of arithmetic error
- (void)switchAvailabilityButton:(BOOL)enable {
    NSMutableArray *allButtonsMutableArray = [NSMutableArray array];
    [allButtonsMutableArray addObjectsFromArray:self.digitCollectionButtons];
    [allButtonsMutableArray addObjectsFromArray:self.operationsCollectionButtons];
    [allButtonsMutableArray addObjectsFromArray:self.hexCollectionButtons];
    [allButtonsMutableArray addObjectsFromArray:self.numeralSystemButtons];
    for (UIButton *button in allButtonsMutableArray) {
        button.enabled = enable;
        UIColor *buttonTitleColor = (enable) ? [UIColor blackColor] : [UIColor grayColor];
        [button setTitleColor:buttonTitleColor forState:UIControlStateNormal];
    }
    for (UIButton *button in self.operationsCollectionButtons) {
        UIColor *buttonTitleColor;
        if ([button.currentTitle isEqualToString:@"."] || [button.currentTitle isEqualToString:@"="]) {
            buttonTitleColor = (enable) ? [UIColor blackColor] : [UIColor grayColor];
        } else {
            buttonTitleColor = (enable) ? [UIColor whiteColor] : [UIColor grayColor];
        }
        [button setTitleColor:buttonTitleColor forState:UIControlStateNormal];
    }
    if (enable) {
        [self activateNumeralSystemButtons];
    }
}

- (void)activateNumeralSystemButtons {
    for (UIButton *button in self.numeralSystemButtons) {
        if ([button.currentTitle isEqualToString:@"DEC"]) {
            UIColor *buttonBackgroundColor = [UIColor blackColor];
            UIColor *buttonTitleColor = [UIColor colorWithRed:(255/255.0) green:(128/255.0) blue:(0/255.0) alpha:1.0];
            [button setAlpha:0.65];
            [button setTitleColor:buttonTitleColor forState:UIControlStateNormal];
            [button setBackgroundColor:buttonBackgroundColor];
            [button.titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
            [button.titleLabel setShadowColor:[UIColor whiteColor]];
            [button.titleLabel setShadowOffset:CGSizeMake(-1, 0)];
            self.decResultLabel.textColor = [UIColor blackColor];
            [self.decResultLabel setFont:[UIFont systemFontOfSize:25]];
            continue;
        }
    
        [self.numSystemControllerObject stylizeNotActiveNumSystemButton:button];
        
        [self.numSystemControllerObject setLabelAppearance:2];
    }
    for (UIButton *button in self.hexCollectionButtons) {
        button.enabled = NO;
        UIColor *buttonTitleColor = [UIColor grayColor];
        [button setTitleColor:buttonTitleColor forState:UIControlStateNormal];
    }
}

/*
 dotButton handler
 appends a dot to the displayLabelText only once
 */
- (IBAction)dotButtonTapped:(id)sender {
    NSString *dot = [sender titleForState:UIControlStateNormal];
    NSString *displayLabelText = self.decResultLabel.text;
    
    if (![displayLabelText containsString:@"."]) {
        NSString *result = [NSString stringWithFormat:@"%@%@", self.decResultLabel.text, dot];
        self.decResultLabel.text = result;
    }
}

// all operation buttons except "square root" is handled here
- (IBAction)opeationButtonTapped:(id)sender {
    if (self.isResultButtonClicked) {
        self.isResultButtonClicked = NO;
        self.model.secondOperand = 0;
    }
    CGFloat value = 0;
    if (!self.model.firstOperand) {
        self.model.firstOperand = [self.decResultLabel.text floatValue];
    }
    if (!self.model.currentOperation && !self.model.previousOperation) {
        self.model.currentOperation = self.model.previousOperation = [sender currentTitle];
    }
    if (self.isTypingNumber) {
        self.isTypingNumber = NO;
        [self setPerformingOperationStatus];
        self.model.currentOperation = [sender currentTitle];

        if (self.model.performingOperationStatus == STATUS_PERFORMING_PREVIOUS_OPERATION) {
            self.model.secondOperand = [self.displayLabel.text floatValue];
            @try {
                value = [self.model performOperationWithOperand:self.model.secondOperand];
            } @catch (NSException *exception) {
                [self showExceptionMessageAndClearData:exception];
                
                return;
            }
            self.model.secondOperand = 0;
            self.model.currentOperation = self.model.previousOperation = [sender currentTitle];
            self.model.performingOperationStatus = STATUS_WAITING_NEXT_OPERATION;
            [self showResult:value];
        }
    }
    else {
        self.model.currentOperation = self.model.previousOperation = [sender currentTitle];
    }
}

// change sign of number to opposite
- (IBAction)changeSignTapped:(id)sender {
    [self showResult:[self.model changeSign:self.displayLabel]];
}

// square root operation button is handled here
- (IBAction)sqrtOperationTapped:(id)sender {
    CGFloat value = 0;
    [self setPerformingOperationStatus];
    
    @try {
        if (self.model.performingOperationStatus == STATUS_PERFORMING_PREVIOUS_OPERATION) {
            if (self.isTypingNumber) {
                value = [self.model performOperationWithOperand:[self.displayLabel.text floatValue]];
                self.model.firstOperand = value;
            }
            self.model.currentOperation = self.model.previousOperation = [sender currentTitle];
            value = [self.model performOperationWithOperand:0];
            self.model.performingOperationStatus = STATUS_WAITING_NEXT_OPERATION;
        }
        else {
            self.model.firstOperand = [self.decResultLabel.text floatValue];
            self.model.currentOperation = self.model.previousOperation = [sender currentTitle];
            value = [self.model performOperationWithOperand:0];
        }
        self.isTypingNumber = NO;
    } @catch (NSException *exception) {
        [self showExceptionMessageAndClearData:exception];
        
        return;
    }
    [self showResult:value];
}

// equals sign is handled here
- (IBAction)resultButtonTapped:(id)sender {
    self.isResultButtonClicked = YES;
    CGFloat value = 0;
    @try {
        if (self.isTypingNumber) {
            self.isTypingNumber = NO;
            if(self.model.performingOperationStatus == STATUS_WAITING_NEXT_OPERATION) {
                self.model.secondOperand = [self.displayLabel.text floatValue];
                value = [self.model performOperationWithOperand:self.model.secondOperand];
                [self showResult:value];
            }
        }
        else {
            if (!self.model.secondOperand) {
                self.model.secondOperand = self.model.firstOperand;
            }
            value = [self.model performOperationWithOperand:self.model.secondOperand];
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
    self.model.delegate = self;
    [self.model catchResultValueChanges];

    [formatDecimal release];
}

// realization of protocol method
- (void)handleResultValueChanges:(CalculatorModel *)model {
    NSLog(@"Result was changed.");
}

// show error message and set data to init state
- (void)showExceptionMessageAndClearData:(NSException *)exception {
    self.numSystemControllerObject.resultLabel.text = [NSString stringWithFormat:@"%@", exception.reason];
    [self switchAvailabilityButton:NO];
    self.model.firstOperand = 0;
    self.model.secondOperand = 0;
    self.model.previousOperation = nil;
    self.model.currentOperation = nil;
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

// move buttons group to other location after orientation is changed
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    if (size.width > size.height) {
        [UIView animateWithDuration:0.5f
                              delay:0.0
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{[self.centralButtonsBlockUIStackView insertArrangedSubview:self.operationsMovableUIStackView atIndex:0];}
                         completion:^(BOOL finished) {}
         ];
        NSLog(@"Part1");
    } else {
        [UIView animateWithDuration:0.5f
                              delay:0.0
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{[self.centralButtonsBlockUIStackView insertArrangedSubview:self.operationsMovableUIStackView atIndex:[[self.centralButtonsBlockUIStackView subviews] count] - 1];}
                         completion:^(BOOL finished) {}
         ];
    }
}

- (IBAction)numSystemButtonTapped:(id)sender {
    [self createNumeralSystemObject:sender];
    self.numSystemControllerObject.viewController = self;
    [self.numSystemControllerObject disableButtons:sender contr:self];
}

- (void)createNumeralSystemObject:(id)sender {
    NSNumber *numSystemButtonIndex = [self.numSystemButtonsNames objectForKey:[sender currentTitle]];
    switch ([numSystemButtonIndex integerValue]) {
        case NUM_SYSTEM_BIN_BUTTON:
            self.numSystemControllerObject = [[[BinNumeralSystemController alloc] init] autorelease];
            self.numSystemControllerObject.resultLabel = self.binResultLabel;
            break;
        case NUM_SYSTEM_OCT_BUTTON:
            self.numSystemControllerObject = [[[OctNumeralSystemController alloc] init] autorelease];
            self.numSystemControllerObject.resultLabel = self.octResultLabel;
            break;
        case NUM_SYSTEM_DEC_BUTTON:
            self.numSystemControllerObject = [[[DecNumeralSystemController alloc] init] autorelease];
            self.numSystemControllerObject.resultLabel = self.decResultLabel;
            break;
        case NUM_SYSTEM_HEX_BUTTON:
            self.numSystemControllerObject = [[[HexNumeralSystemController alloc] init] autorelease];
            self.numSystemControllerObject.resultLabel = self.hexResultLabel;
            break;
        default:
            break;
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    unsigned int valFloat = (unsigned int)[self.decResultLabel.text floatValue];
    self.hexResultLabel.text = [NSString stringWithFormat:@"%X", valFloat];
    self.octResultLabel.text = [NSString stringWithFormat:@"%O", valFloat];
    NSMutableString *str = [NSMutableString string];
    if (valFloat == 0) {
        [str insertString:@"0" atIndex:0];
    }

    while (valFloat) {
        [str insertString:(valFloat & 1) ? @"1" : @"0" atIndex:0];
        valFloat /= 2;
    }
    self.binResultLabel.text = [NSString stringWithFormat:@"%@", str];

- (void)setPerformingOperationStatus {
    if (self.model.performingOperationStatus == STATUS_CURRENT_OPERATION_IS_NULL) {
        self.model.performingOperationStatus = STATUS_WAITING_NEXT_OPERATION;
    } else if (self.model.performingOperationStatus == STATUS_WAITING_NEXT_OPERATION) {
        self.model.performingOperationStatus = STATUS_PERFORMING_PREVIOUS_OPERATION;
    }
}

- (void)dealloc {
    [_decResultLabel release];
    [_digitCollectionButtons release];
    [_clearButton release];
    [_sqrtUIButton release];
    [_plusMinusUIButton release];
    [_model release];
    [_operationsMovableUIStackView release];
    [_centralButtonsBlockUIStackView release];
    [_operationsCollectionButtons release];
    [_binResultLabel release];
    [_octResultLabel release];
    [_hexResultLabel release];
    [_hexCollectionButtons release];
    [_numeralSystemButtons release];
    [_numSystemButtonsNames release];
    [_numSystemControllerObject release];
    [_numSystemResultLabelsCollection release];
    [super dealloc];
}

@end
