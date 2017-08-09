//
//  OctNumeralSystemController.m
//  AKCalculator
//
//  Created by WorkStation on 7/30/17.
//  Copyright © 2017 aksanakarpenka. All rights reserved.
//

#import "OctNumeralSystemController.h"
#import "ViewController.h"

@interface OctNumeralSystemController ()

@end

@implementation OctNumeralSystemController

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
        if ([button.currentTitle isEqualToString: @"8"] || [button.currentTitle isEqualToString: @"9"]) {
            button.enabled = NO;
            UIColor *buttonTitleColor = [UIColor grayColor];
            [button setTitleColor:buttonTitleColor forState:UIControlStateNormal];
            continue;
        }
        button.enabled = YES;
        UIColor *buttonTitleColor = [UIColor blackColor];
        [button setTitleColor:buttonTitleColor forState:UIControlStateNormal];
    }
    
    [super enableDotButton:NO];
}

@end
