//
//  CalculatorNotificationController.m
//  AKCalculator
//
//  Created by HomeStation on 6/13/17.
//  Copyright © 2017 aksanakarpenka. All rights reserved.
//

#import "CalculatorNotificationController.h"

@implementation CalculatorNotificationController

- (void)catchResultValueChanges {
    SEL selector = @selector(handleResultValueChanges:);
    if (self.delegate && [self.delegate respondsToSelector:selector]) {
        [self.delegate handleResultValueChanges:self];
    }
}

@end
