//
//  ViewController.h
//  TruckyDucky
//
//  Created by bllss it sloutions on 11/12/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>

@interface ViewController : UIViewController <GMSMapViewDelegate,CLLocationManagerDelegate>
@property (strong, nonatomic) IBOutlet UIButton *btnLoginAccount;

- (IBAction)actionLoginWithAccount:(id)sender;

@end

