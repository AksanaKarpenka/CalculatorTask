//
//  ViewController.h
//  AKCalculator
//
//  Created by Rose on 5/14/17.
//  Copyright © 2017 aksanakarpenka. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalculatorModel.h"

@class NumeralSystemController;

@interface ViewController : UIViewController<CalculatorModelDelegate>

@property (retain, nonatomic) NSDictionary *numSystemButtonsNames;
@property (retain, nonatomic) IBOutlet UILabel *decResultLabel;
@property (retain, nonatomic) IBOutlet UILabel *binResultLabel;
@property (retain, nonatomic) IBOutlet UILabel *octResultLabel;
@property (retain, nonatomic) IBOutlet UILabel *hexResultLabel;
@property (retain, nonatomic) IBOutletCollection(UIButton) NSArray *digitCollectionButtons;
@property (retain, nonatomic) IBOutletCollection(UIButton) NSArray *hexCollectionButtons;
@property (retain, nonatomic) IBOutletCollection(UIButton) NSArray *numeralSystemButtons;
@property (retain, nonatomic) IBOutletCollection(UILabel) NSArray *numSystemResultLabelsCollection;
@property (retain, nonatomic) IBOutlet UIButton *clearButton;
@property (retain, nonatomic) IBOutlet UIButton *sqrtUIButton;
@property (retain, nonatomic) IBOutlet UIButton *plusMinusUIButton;
@property (retain, nonatomic) CalculatorModel *model;
@property (retain, nonatomic) NumeralSystemController *numSystemControllerObject;
@property (retain, nonatomic) IBOutlet UIStackView *operationsMovableUIStackView;
@property (retain, nonatomic) IBOutlet UIStackView *centralButtonsBlockUIStackView;
@property (assign, nonatomic) CGRect operationsMovableUIStackViewFrame;
@property (retain, nonatomic) IBOutletCollection(UIButton) NSArray *operationsCollectionButtons;
@property (assign, nonatomic) BOOL isTypingNumber;
@property (assign, nonatomic) BOOL isResultButtonClicked;

- (IBAction)numSystemButtonTapped:(id)sender;

@end
