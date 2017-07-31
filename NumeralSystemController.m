//
//  NumeralSystemController.m
//  AKCalculator
//
//  Created by WorkStation on 7/28/17.
//  Copyright © 2017 aksanakarpenka. All rights reserved.
//

#import "NumeralSystemController.h"
#import "ViewController.h"

@implementation NumeralSystemController

- (void) disableButtons:(id)sender contr:(ViewController *)contr {
    for (UIButton *button in self.viewController.numeralSystemButtons) {
        if (button == sender) {
            UIColor *buttonBackgroundColor = [UIColor blackColor];
            UIColor *buttonTitleColor = [UIColor colorWithRed:(255/255.0) green:(128/255.0) blue:(0/255.0) alpha:1.0];
            [button setAlpha:0.65];
            [button setTitleColor:buttonTitleColor forState:UIControlStateNormal];
            [button setBackgroundColor:buttonBackgroundColor];
            [button.titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
            [button.titleLabel setShadowColor:[UIColor whiteColor]];
            [button.titleLabel setShadowOffset:CGSizeMake(-1, 0)];

            continue;
        }
        [self stylizeNotActiveNumSystemButton:button];
    }
}

- (void)stylizeNotActiveNumSystemButton:(UIButton *)button {
    UIColor *buttonBackgroundColor = [UIColor colorWithRed:(0/255.0) green:(0/255.0) blue:(0/255.0) alpha:1.0];
    UIColor *buttonTitleColor = [UIColor colorWithRed:(179/255.0) green:(179/255.0) blue:(179/255.0) alpha:1.0];
    [button setTitleColor:buttonTitleColor forState:UIControlStateNormal];
    [button setBackgroundColor:buttonBackgroundColor];
    [button setAlpha:0.5];
    [button.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [button.titleLabel setShadowColor:[UIColor whiteColor]];
    [button.titleLabel setShadowOffset:CGSizeMake(-1, 0)];
}

- (void)enableDotButton:(BOOL)enable {
    self.viewController.dotButton.enabled = enable;
    UIColor *buttonTitleColor = [UIColor grayColor];
    [self.viewController.dotButton setTitleColor:buttonTitleColor forState:UIControlStateNormal];
}

- (void)setLabelAppearance:(NSInteger)labelTag {
    for (UILabel *label in self.viewController.numSystemResultLabelsCollection) {
        if (label.tag == labelTag) {
            label.textColor = [UIColor blackColor];
            [label setFont:[UIFont systemFontOfSize:25]];
            continue;
        }
        label.textColor = [UIColor lightGrayColor];
        [label setFont:[UIFont systemFontOfSize:17]];
    }
}

- (void)dealloc {
    [_viewController release];
    [_resultLabel release];
    [super dealloc];
}

@end
