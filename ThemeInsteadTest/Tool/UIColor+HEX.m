//
//  UIColor+HEX.m
//  iOS-Categories (https://github.com/shaojiankui/iOS-Categories)
//
//  Created by Jakey on 14/12/15.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import "UIColor+HEX.h"
#import <Foundation/Foundation.h>
#import "NSString+Trims.h"

CGFloat colorComponentFrom(NSString *string, NSUInteger start, NSUInteger length) {
    NSString *substring = [string substringWithRange:NSMakeRange(start, length)];
    NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat: @"%@%@", substring, substring];
    
    unsigned hexComponent;
    [[NSScanner scannerWithString: fullHex] scanHexInt: &hexComponent];
    return hexComponent / 255.0;
}

@implementation UIColor (HEX)
+ (UIColor *)colorWithHex:(UInt32)hex{
    return [UIColor colorWithHex:hex andAlpha:1];
}
+ (UIColor *)colorWithHex:(UInt32)hex andAlpha:(CGFloat)alpha{
    return [UIColor colorWithRed:((hex >> 16) & 0xFF)/255.0
                           green:((hex >> 8) & 0xFF)/255.0
                            blue:(hex & 0xFF)/255.0
                           alpha:alpha];
}

+ (UIColor *)colorWithHexString:(NSString *)hexString {
    CGFloat alpha, red, blue, green;
    
    NSString *colorString = [[hexString stringByReplacingOccurrencesOfString:@"#" withString:@""] uppercaseString];
    switch ([colorString length]) {
        case 3: // #RGB
            alpha = 1.0f;
            red   = colorComponentFrom(colorString, 0, 1);
            green = colorComponentFrom(colorString, 1, 1);
            blue  = colorComponentFrom(colorString, 2, 1);
            break;
            
        case 4: // #ARGB
            alpha = colorComponentFrom(colorString, 0, 1);
            red   = colorComponentFrom(colorString, 1, 1);
            green = colorComponentFrom(colorString, 2, 1);
            blue  = colorComponentFrom(colorString, 3, 1);
            break;
            
        case 6: // #RRGGBB
            alpha = 1.0f;
            red   = colorComponentFrom(colorString, 0, 2);
            green = colorComponentFrom(colorString, 2, 2);
            blue  = colorComponentFrom(colorString, 4, 2);
            break;
            
        case 8: // #AARRGGBB
            alpha = colorComponentFrom(colorString, 0, 2);
            red   = colorComponentFrom(colorString, 2, 2);
            green = colorComponentFrom(colorString, 4, 2);
            blue  = colorComponentFrom(colorString, 6, 2);
            break;
            
        default:
            return nil;
    }
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

- (NSString *)HEXString{
    UIColor* color = self;
    if (CGColorGetNumberOfComponents(color.CGColor) < 4) {
        const CGFloat *components = CGColorGetComponents(color.CGColor);
        color = [UIColor colorWithRed:components[0]
                                green:components[0]
                                 blue:components[0]
                                alpha:components[1]];
    }
    if (CGColorSpaceGetModel(CGColorGetColorSpace(color.CGColor)) != kCGColorSpaceModelRGB) {
        return [NSString stringWithFormat:@"#FFFFFF"];
    }
    return [NSString stringWithFormat:@"#%02X%02X%02X", (int)((CGColorGetComponents(color.CGColor))[0]*255.0),
            (int)((CGColorGetComponents(color.CGColor))[1]*255.0),
            (int)((CGColorGetComponents(color.CGColor))[2]*255.0)];
}

+ (UIColor *)colorWithWholeRed:(CGFloat)red
                         green:(CGFloat)green
                          blue:(CGFloat)blue
                         alpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:red/255.f
                           green:green/255.f
                            blue:blue/255.f
                           alpha:alpha];
}

+ (UIColor *)colorWithWholeRed:(CGFloat)red
                         green:(CGFloat)green
                          blue:(CGFloat)blue
{
    return [self colorWithWholeRed:red
                             green:green
                              blue:blue
                             alpha:1.0];
}

+ (UIColor *)colorWithString:(NSString *)string
{
    if ( nil == string || 0 == string.length )
        return nil;
    
    string = [string trimmingWhitespaceAndNewlines];
    
    if ( [string hasPrefix:@"rgb("] && [string hasSuffix:@")"] )
    {
        string = [string substringWithRange:NSMakeRange(4, string.length - 5)];
        if ( string && string.length )
        {
            NSArray * elems = [string componentsSeparatedByString:@","];
            if ( elems && elems.count == 3 )
            {
                NSInteger r = [[elems objectAtIndex:0] integerValue];
                NSInteger g = [[elems objectAtIndex:1] integerValue];
                NSInteger b = [[elems objectAtIndex:2] integerValue];
                
                return [UIColor colorWithRed:(r * 1.0f / 255.0f) green:(g * 1.0f / 255.0f) blue:(b * 1.0f / 255.0f) alpha:1.0f];
            }
        }
    }
    
    NSArray *	array = [string componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *	color = [array objectAtIndex:0];
    CGFloat		alpha = 1.0f;
    
    if ( array.count == 2 )
    {
        alpha = [[array objectAtIndex:1] floatValue];
    }
    
    if ( [color hasPrefix:@"#"] ) // #FFF
    {
        color = [color substringFromIndex:1];
        
        if ( color.length == 3 )
        {
            NSUInteger hexRGB = strtol(color.UTF8String , nil, 16);
            return [UIColor fromShortHexValue:hexRGB alpha:alpha];
        }
        else if ( color.length == 6 )
        {
            NSUInteger hexRGB = strtol(color.UTF8String , nil, 16);
            return [UIColor fromHexValue:hexRGB alpha:alpha];
        }
    }
    else if ( [color hasPrefix:@"0x"] || [color hasPrefix:@"0X"] ) // #FFF
    {
        color = [color substringFromIndex:2];
        
        if ( color.length == 8 )
        {
            NSUInteger hexRGB = strtol(color.UTF8String , nil, 16);
            return [UIColor fromHexValue:hexRGB];
        }
        else if ( color.length == 6 )
        {
            NSUInteger hexRGB = strtol(color.UTF8String , nil, 16);
            return [UIColor fromHexValue:hexRGB alpha:1.0f];
        }
    }
    else
    {
        static NSMutableDictionary * __colors = nil;
        
        if ( nil == __colors )
        {
            __colors = [[NSMutableDictionary alloc] init];
            [__colors setObject:[UIColor clearColor]		forKey:@"clear"];
            [__colors setObject:[UIColor clearColor]		forKey:@"transparent"];
            [__colors setObject:[UIColor redColor]			forKey:@"red"];
            [__colors setObject:[UIColor blackColor]		forKey:@"black"];
            [__colors setObject:[UIColor darkGrayColor]		forKey:@"darkgray"];
            [__colors setObject:[UIColor lightGrayColor]	forKey:@"lightgray"];
            [__colors setObject:[UIColor whiteColor]		forKey:@"white"];
            [__colors setObject:[UIColor grayColor]			forKey:@"gray"];
            [__colors setObject:[UIColor greenColor]		forKey:@"green"];
            [__colors setObject:[UIColor blueColor]			forKey:@"blue"];
            [__colors setObject:[UIColor cyanColor]			forKey:@"cyan"];
            [__colors setObject:[UIColor yellowColor]		forKey:@"yellow"];
            [__colors setObject:[UIColor magentaColor]		forKey:@"magenta"];
            [__colors setObject:[UIColor orangeColor]		forKey:@"orange"];
            [__colors setObject:[UIColor purpleColor]		forKey:@"purple"];
            [__colors setObject:[UIColor brownColor]		forKey:@"brown"];
        }
        
        UIColor * result = [__colors objectForKey:color.lowercaseString];
        if ( result )
        {
            return [result colorWithAlphaComponent:alpha];
        }
    }
    
    return nil;
}

+ (UIColor *)fromShortHexValue:(NSUInteger)hex
{
    return [UIColor fromShortHexValue:hex alpha:1.0f];
}

+ (UIColor *)fromShortHexValue:(NSUInteger)hex alpha:(CGFloat)alpha
{
    NSUInteger r = ((hex >> 8) & 0x0000000F);
    NSUInteger g = ((hex >> 4) & 0x0000000F);
    NSUInteger b = ((hex >> 0) & 0x0000000F);
    
    float fr = (r * 1.0f) / 15.0f;
    float fg = (g * 1.0f) / 15.0f;
    float fb = (b * 1.0f) / 15.0f;
    
    return [UIColor colorWithRed:fr green:fg blue:fb alpha:alpha];
}

+ (UIColor *)fromHexValue:(NSUInteger)hex
{
    NSUInteger a = ((hex >> 24) & 0x000000FF);
    float fa = ((0 == a) ? 1.0f : (a * 1.0f) / 255.0f);
    
    return [UIColor fromHexValue:hex alpha:fa];
}

+ (UIColor *)fromHexValue:(NSUInteger)hex alpha:(CGFloat)alpha
{
    if ( hex == 0xECE8E3 ) {
        
    }
    NSUInteger r = ((hex >> 16) & 0x000000FF);
    NSUInteger g = ((hex >> 8) & 0x000000FF);
    NSUInteger b = ((hex >> 0) & 0x000000FF);
    
    float fr = (r * 1.0f) / 255.0f;
    float fg = (g * 1.0f) / 255.0f;
    float fb = (b * 1.0f) / 255.0f;
    
    return [UIColor colorWithRed:fr green:fg blue:fb alpha:alpha];
}

@end
