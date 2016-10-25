//
//  ThirdViewController.m
//  ThemeInsteadTest
//
//  Created by laidianhuo on 25/10/2016.
//  Copyright © 2016 laidianhuo. All rights reserved.
//

#import "ThirdViewController.h"
#import "BaseTabbarController.h"

@interface ThirdViewController ()
- (IBAction)blueThemeAction:(id)sender;

- (IBAction)yellowThemeAction:(id)sender;

- (IBAction)redThemeAction:(id)sender;

@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = kBgColor;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)configTheme: (NSString *)theme{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:theme forKey:@"Theme"];
    [userDefaults synchronize];
    self.view.window.rootViewController = [[BaseTabbarController alloc]init];
}

- (IBAction)blueThemeAction:(id)sender {
    [self configTheme:@"Blue"];
}

- (IBAction)yellowThemeAction:(id)sender {
    [self configTheme:@"Yellow"];
}

- (IBAction)redThemeAction:(id)sender {
    [self configTheme:@"Red"];
}
@end
