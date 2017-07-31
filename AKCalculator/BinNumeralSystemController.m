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

- (void)disableButtons:(id)sender contr:(ViewController *)contr {
    [super disableButtons:sender contr:contr];
    
    [super setLabelAppearance:self.resultLabel.tag];
    
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
    
    [super enableDotButton:NO];
}

@end
