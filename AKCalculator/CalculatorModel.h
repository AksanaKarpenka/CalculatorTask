//
//  CalculatorModel.h
//  AKCalculator
//
//  Created by HomeStation on 6/6/17.
//  Copyright © 2017 aksanakarpenka. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalculatorModel : UIViewController

@property (assign, nonatomic) CGFloat firstOperand;
@property (assign, nonatomic) CGFloat secondOperand;
@property (retain, nonatomic) NSString *curOperation;
@property (retain, nonatomic) NSString *prevOperation;
@property (assign, nonatomic) int operationCount;

- (CGFloat)performOperation:(CGFloat)operand;

@end
