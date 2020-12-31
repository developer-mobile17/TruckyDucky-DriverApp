//
//  DriverLocationVC.h
//  TruckyDucky
//
//  Created by anil kumar on 13/02/20.
//  Copyright © 2020 Steve. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>


NS_ASSUME_NONNULL_BEGIN

@interface DriverLocationVC : UIViewController <GMSMapViewDelegate,CLLocationManagerDelegate>
@property (strong, nonatomic) IBOutlet GMSMapView *objMapVW;
@property (strong, nonatomic) IBOutlet UILabel *lblHeaderTitle;
@property (strong, nonatomic)  NSString *StrPassDriverID;
@property (strong, nonatomic)  NSString *strPassHeaderTitle;
@end

NS_ASSUME_NONNULL_END
