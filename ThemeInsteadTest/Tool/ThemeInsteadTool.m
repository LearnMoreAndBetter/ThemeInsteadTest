//
//  ThemeInsteadTool.m
//  ThemeInsteadTest
//
//  Created by laidianhuo on 25/10/2016.
//  Copyright © 2016 laidianhuo. All rights reserved.
//

#import "ThemeInsteadTool.h"

@implementation ThemeInsteadTool



+ (UIColor *)themeColor{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *theme = [userDefaults objectForKey:@"Theme"];
    if (![theme length]) {
        theme = @"Red";
    }
    NSString *bundlePath = [[NSBundle mainBundle].resourcePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.bundle",theme]];
    NSBundle *themeBundle = [NSBundle bundleWithPath:bundlePath];
    NSString *plistPath = [themeBundle pathForResource:@"Theme" ofType:@"plist"];
    NSMutableDictionary *plistDict = [[NSMutableDictionary alloc]initWithContentsOfFile:plistPath];
    
    UIColor *themeColor;
    NSString *colorHexString = [plistDict objectForKey:@"colorHex"];
    if ([colorHexString length]) {
        themeColor = [UIColor colorWithString:colorHexString];
    }else{
        themeColor = [UIColor greenColor];
    }
    return themeColor;
}


+ (UIImage *)imageWithImageName:(NSString *)imageName
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *theme = [userDefaults objectForKey:@"Theme"];
    if (![theme length]) {
        theme = @"Red";
    }
    NSString *bundlePath = [[NSBundle mainBundle].resourcePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.bundle",theme]];
    NSBundle *themeBundle = [NSBundle bundleWithPath:bundlePath];
    NSString *imagePath = [themeBundle pathForResource:imageName ofType:@"png"];
    
    return [UIImage imageWithContentsOfFile:imagePath];
}


@end
