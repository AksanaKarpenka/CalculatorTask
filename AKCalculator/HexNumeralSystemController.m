//
//  HexNumeralSystemController.m
//  AKCalculator
//
//  Created by WorkStation on 7/30/17.
//  Copyright © 2017 aksanakarpenka. All rights reserved.
//

#import "HexNumeralSystemController.h"
#import "ViewController.h"

@interface HexNumeralSystemController ()

@end

@implementation HexNumeralSystemController

- (void)disableButtons:(id)sender contr:(ViewController *)contr{
    [super disableButtons:sender contr:contr];
    
    [super setLabelAppearance:self.resultLabel.tag];
    
    NSMutableArray *allButtonsMutableArray = [NSMutableArray array];
    [allButtonsMutableArray addObjectsFromArray:self.viewController.hexCollectionButtons];
    [allButtonsMutableArray addObjectsFromArray:self.viewController.digitCollectionButtons];
    for (UIButton *button in allButtonsMutableArray) {
        button.enabled = YES;
        UIColor *buttonTitleColor = [UIColor blackColor];
        [button setTitleColor:buttonTitleColor forState:UIControlStateNormal];
    }
    
    [super enableDotButton:NO];
}

@end
