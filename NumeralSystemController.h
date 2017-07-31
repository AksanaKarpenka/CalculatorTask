//
//  NumeralSystemController.h
//  AKCalculator
//
//  Created by WorkStation on 7/28/17.
//  Copyright © 2017 aksanakarpenka. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ViewController;

@interface NumeralSystemController : UIViewController

@property (retain, nonatomic) ViewController *viewController;
@property (retain, nonatomic) UILabel *resultLabel;

- (void)disableButtons:(id)sender contr:(ViewController *)contr;
- (void)enableDotButton:(BOOL)enable;
- (void)setLabelAppearance:(NSInteger)labelTag;

@end
