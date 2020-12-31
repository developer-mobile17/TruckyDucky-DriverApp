//
//  MainTabVC.m
//  UbxCloudApp
//
//  Created by bllss it sloutions on 23/10/17.
//  Copyright © 2017 bllss it sloutions. All rights reserved.
//

#import "MainTabVC.h"

#import "AppDelegate.h"

@interface MainTabVC ()
{
    UITabBarItem * tabBarItems;
    UITabBarController *tabBarController;
   
}

@end


@implementation MainTabVC

- (void)viewDidLoad
{
    [super viewDidLoad];


  //  [[self.tabBar.items objectAtIndex:2] setBadgeValue:@"1"];
   
     [[UITabBar appearance] setBackgroundColor:[UIColor blackColor]];
     [[UITabBar appearance] setBarStyle:UIBarStyleBlack];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end




