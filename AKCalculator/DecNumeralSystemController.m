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
    
    [super setLabelAppearance:self.resultLabel.tag];
    
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
    
    [super enableDotButton:YES];
}

@end
