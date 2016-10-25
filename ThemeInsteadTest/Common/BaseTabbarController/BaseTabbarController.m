//
//  BaseTabbarController.m
//  SkyGoods
//
//  Created by 王林 on 16/4/22.
//  Copyright © 2016年 com.benba. All rights reserved.
//

#import "BaseTabbarController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"

@interface BaseTabbarController ()<UITabBarControllerDelegate>

@end

@implementation BaseTabbarController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[UINavigationBar appearance] setBarTintColor:[ThemeInsteadTool themeColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : kWhiteColor}];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [self createTabbar];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 49)];
    backView.backgroundColor = [UIColor whiteColor];
    [self.tabBar insertSubview:backView atIndex:0];
}


- (void) createTabbar{
    [self addChildViewController:[[FirstViewController alloc]init] itemImage:@"menu1" selectedItemImage:@"menu1_press" title:@"首页" itemTag:0];
    
    [self addChildViewController:[[SecondViewController alloc]init] itemImage:@"menu2" selectedItemImage:@"menu2_press" title:@"购物车" itemTag:1];
    
    [self addChildViewController:[[ThirdViewController alloc]init] itemImage:@"menu3" selectedItemImage:@"menu3_press" title:@"我的中心" itemTag:2];
    self.delegate = self;
}

- (void)addChildViewController:(UIViewController *)childController itemImage:(NSString *)itemImageName selectedItemImage:(NSString *)selectedItemImageName title:(NSString *)title itemTag:(NSInteger)itemTag{
    childController.tabBarItem=[[UITabBarItem alloc]initWithTitle:title image:[UIImage imageNamed:itemImageName]  tag:itemTag];
    childController.title = title;
    [childController.tabBarItem  setTitlePositionAdjustment:UIOffsetMake(0, -3)];
    [childController.tabBarItem setTitleTextAttributes:[NSMutableDictionary dictionaryWithObjectsAndKeys:kBlackColor,NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
    selectTextAttrs[NSForegroundColorAttributeName] = [ThemeInsteadTool themeColor];
    [childController.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    
    childController.tabBarItem.image = [[UIImage imageNamed:itemImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childController.tabBarItem.selectedImage = [[ThemeInsteadTool imageWithImageName:selectedItemImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:childController];
    childController.navigationController.navigationBar.translucent = NO;
    
    // 添加为子控制器
    [self addChildViewController:nav];
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

@end
