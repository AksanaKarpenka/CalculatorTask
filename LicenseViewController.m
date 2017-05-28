//
//  LicenseViewController.m
//  AKCalculator
//
//  Created by Rose on 5/22/17.
//  Copyright © 2017 aksanakarpenka. All rights reserved.
//

#import "LicenseViewController.h"

@interface LicenseViewController ()

@end

@implementation LicenseViewController

- (IBAction)closeLicenseWindow:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *fullURL = @"https://ru.wikipedia.org/wiki/";
    NSString *encodedCharacters = [NSString stringWithFormat:@"%@", [@"Лицензия_MIT" stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]]];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", fullURL, encodedCharacters]];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [_licenseUIWebView loadRequest:requestObj];
}

- (void)dealloc {
    [_closeUIButton release];
    [_licenseUIWebView release];
    [super dealloc];
}

@end
