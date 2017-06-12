//
//  SampleProtocol.h
//  AKCalculator
//
//  Created by HomeStation on 6/11/17.
//  Copyright © 2017 aksanakarpenka. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SampleProtocolDelegate <NSObject>

- (void)resultValueChanged;

@end

@interface SampleProtocol : NSObject

@property (assign, nonatomic) id<SampleProtocolDelegate> delegate;

- (void)sampleAction;

@end
