//
//  CalculatorNotificationController.h
//  AKCalculator
//
//  Created by HomeStation on 6/13/17.
//  Copyright © 2017 aksanakarpenka. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CalculatorNotificationController;

@protocol CalculatorNotificationControllerDelegate <NSObject>

- (void)handleResultValueChanges:(CalculatorNotificationController *)controller;

@end


@interface CalculatorNotificationController : NSObject

@property (assign, nonatomic) id<CalculatorNotificationControllerDelegate> delegate;

- (void)catchResultValueChanges;

@end
