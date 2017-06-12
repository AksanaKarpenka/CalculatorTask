//
//  SampleProtocol.m
//  AKCalculator
//
//  Created by HomeStation on 6/11/17.
//  Copyright © 2017 aksanakarpenka. All rights reserved.
//

#import "SampleProtocol.h"

@implementation SampleProtocol

- (void)sampleAction {
    SEL selector = @selector(resultValueChanged);
    if (self.delegate && [self.delegate respondsToSelector:selector]) {
        [self.delegate performSelector:selector];
    }
}

@end
