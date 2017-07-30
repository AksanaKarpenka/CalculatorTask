//
//  BinNumeralSystemController.m
//  AKCalculator
//
//  Created by WorkStation on 7/28/17.
//  Copyright © 2017 aksanakarpenka. All rights reserved.
//

#import "BinNumeralSystemController.h"
#import "ViewController.h"

@implementation BinNumeralSystemController

- (void)disableButtons:(id)sender contr:(ViewController *)contr{
    [super disableButtons:sender contr:contr];
    
    self.viewController.binResultLabel.textColor = [UIColor blackColor];
    [self.viewController.binResultLabel setFont:[UIFont systemFontOfSize:25]];
    
    self.viewController.decResultLabel.textColor = [UIColor lightGrayColor];
    [self.viewController.decResultLabel setFont:[UIFont systemFontOfSize:17]];
    self.viewController.hexResultLabel.textColor = [UIColor lightGrayColor];
    [self.viewController.hexResultLabel setFont:[UIFont systemFontOfSize:17]];
    self.viewController.octResultLabel.textColor = [UIColor lightGrayColor];
    [self.viewController.octResultLabel setFont:[UIFont systemFontOfSize:17]];
    
    NSMutableArray *allButtonsMutableArray = [NSMutableArray array];
    [allButtonsMutableArray addObjectsFromArray:self.viewController.hexCollectionButtons];
    [allButtonsMutableArray addObjectsFromArray:self.viewController.digitCollectionButtons];
    for (UIButton *button in allButtonsMutableArray) {
        if ([button.currentTitle isEqualToString: @"0"] || [button.currentTitle isEqualToString: @"1"]) {
            continue;
        }
        button.enabled = NO;
        UIColor *buttonTitleColor = [UIColor grayColor];
        [button setTitleColor:buttonTitleColor forState:UIControlStateNormal];
    }
    
    self.viewController.dotButton.enabled = NO;
    UIColor *buttonTitleColor = [UIColor grayColor];
    [self.viewController.dotButton setTitleColor:buttonTitleColor forState:UIControlStateNormal];
}

@end
