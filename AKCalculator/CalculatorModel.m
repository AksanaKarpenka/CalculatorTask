//
//  CalculatorModel.m
//  AKCalculator
//
//  Created by HomeStation on 6/6/17.
//  Copyright © 2017 aksanakarpenka. All rights reserved.
//

#import "CalculatorModel.h"

@interface CalculatorModel ()

@end

@implementation CalculatorModel

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (CGFloat)performOperation:(CGFloat)operand {
    CGFloat value = self.firstOperand;
    NSArray *operations = @[@"+", @"-", @"*", @"/", @"%", @"\u221A"];
    switch ([operations indexOfObject:self.prevOperation]) {
        case 0:
            value += operand;
            NSLog(@"+ was tapped");
            break;
        case 1:
            value -= operand;
            NSLog(@"- was tapped");
            break;
        case 2:
            value *= operand;
            NSLog(@"* was tapped");
            break;
        case 3:
            if (operand == 0) {
                @throw([NSException exceptionWithName:@"Dividing by zero"
                                               reason:@"Деление на ноль"
                                             userInfo:nil]);
            }
            value /= operand;
            NSLog(@"/ was tapped");
            break;
        case 4:
            value = fmod(value, operand);
            NSLog(@"%% was tapped");
            break;
        case 5:
            if (value < 0) {
                @throw([NSException exceptionWithName:@"Square root of negative number"
                                               reason:@"Корень из отрицательного числа"
                                             userInfo:nil]);
            }
            value = sqrt(value);
            NSLog(@"\u221A was1 tapped");
            break;
        default:
            break;
    }
    self.firstOperand = value;
    return value;
}

- (void)dealloc {
    [_prevOperation release];
    [_curOperation release];
    [super dealloc];
}

@end
