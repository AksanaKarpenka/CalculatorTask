//
//  DecNumeralSystemController.m
//  AKCalculator
//
//  Created by WorkStation on 7/30/17.
//  Copyright © 2017 aksanakarpenka. All rights reserved.
//

#import "DecNumeralSystemController.h"
#import "ViewController.h"

@interface DecNumeralSystemController ()

@end

@implementation DecNumeralSystemController

- (void)disableButtons:(id)sender contr:(ViewController *)contr {
    [super disableButtons:sender contr:contr];
    
    self.viewController.decResultLabel.textColor = [UIColor blackColor];
    [self.viewController.decResultLabel setFont:[UIFont systemFontOfSize:25]];

    self.viewController.binResultLabel.textColor = [UIColor lightGrayColor];
    [self.viewController.binResultLabel setFont:[UIFont systemFontOfSize:17]];
    self.viewController.hexResultLabel.textColor = [UIColor lightGrayColor];
    [self.viewController.hexResultLabel setFont:[UIFont systemFontOfSize:17]];
    self.viewController.octResultLabel.textColor = [UIColor lightGrayColor];
    [self.viewController.octResultLabel setFont:[UIFont systemFontOfSize:17]];
    
    NSMutableArray *allButtonsMutableArray = [NSMutableArray array];
    [allButtonsMutableArray addObjectsFromArray:self.viewController.hexCollectionButtons];
    for (UIButton *button in allButtonsMutableArray) {
        button.enabled = NO;
        UIColor *buttonTitleColor = [UIColor grayColor];
        [button setTitleColor:buttonTitleColor forState:UIControlStateNormal];
    }
    for (UIButton *button in self.viewController.digitCollectionButtons) {
        button.enabled = YES;
        UIColor *buttonTitleColor = [UIColor blackColor];
        [button setTitleColor:buttonTitleColor forState:UIControlStateNormal];
    }
    
    self.viewController.dotButton.enabled = YES;
    UIColor *buttonTitleColor = [UIColor blackColor];
    [self.viewController.dotButton setTitleColor:buttonTitleColor forState:UIControlStateNormal];
}

@end
