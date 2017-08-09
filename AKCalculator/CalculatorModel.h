//
//  CalculatorModel.h
//  AKCalculator
//
//  Created by HomeStation on 6/6/17.
//  Copyright © 2017 aksanakarpenka. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CalculatorModel;

@protocol CalculatorModelDelegate <NSObject>

- (void)handleResultValueChanges:(CalculatorModel *)model;

@end

@interface CalculatorModel : NSObject

@property (assign, nonatomic) CGFloat firstOperand;
@property (assign, nonatomic) CGFloat secondOperand;
@property (retain, nonatomic) NSString *currentOperation;
@property (retain, nonatomic) NSString *previousOperation;
@property (assign, nonatomic) int performingOperationStatus;
@property (assign, nonatomic) id<CalculatorModelDelegate> delegate;

- (CGFloat)performOperationWithOperand:(CGFloat)operand;
- (CGFloat)changeSign:(UILabel *)label;
- (void)catchResultValueChanges;

@end
