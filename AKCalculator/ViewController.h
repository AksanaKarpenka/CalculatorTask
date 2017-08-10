//
//  ViewController.h
//  AKCalculator
//
//  Created by Rose on 5/14/17.
//  Copyright © 2017 aksanakarpenka. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalculatorModel.h"

@interface ViewController : UIViewController<CalculatorModelDelegate>

@property (retain, nonatomic) IBOutlet UILabel *displayLabel;
@property (retain, nonatomic) IBOutletCollection(UIButton) NSArray *digitCollectionButtons;
@property (retain, nonatomic) IBOutlet UIButton *clearButton;
@property (retain, nonatomic) IBOutlet UIButton *sqrtUIButton;
@property (retain, nonatomic) IBOutlet UIButton *plusMinusUIButton;
@property (retain, nonatomic) CalculatorModel *model;
@property (retain, nonatomic) IBOutlet UIStackView *operationsMovableUIStackView;
@property (retain, nonatomic) IBOutlet UIStackView *centralButtonsBlockUIStackView;
@property (assign, nonatomic) CGRect operationsMovableUIStackViewFrame;
@property (retain, nonatomic) IBOutletCollection(UIButton) NSArray *operationsCollectionButtons;
@property (assign, nonatomic) BOOL isTypingNumber;
@property (assign, nonatomic) BOOL isResultButtonClicked;

@end
