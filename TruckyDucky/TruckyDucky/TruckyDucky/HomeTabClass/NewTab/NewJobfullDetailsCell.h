//
//  NewJobfullDetailsCell.h
//  TruckyDucky
//
//  Created by anil kumar on 30/04/20.
//  Copyright © 2020 Steve. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>

NS_ASSUME_NONNULL_BEGIN

@interface NewJobfullDetailsCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIView *bckView;
@property (strong, nonatomic) IBOutlet GMSMapView *objMapVW;

@property (strong, nonatomic) IBOutlet UILabel *lblPickupLocation;
@property (strong, nonatomic) IBOutlet UILabel *lblDropoffLocation;
@property (strong, nonatomic) IBOutlet UILabel *lblDistance;
@property (strong, nonatomic) IBOutlet UILabel *lblVehicles;
@property (strong, nonatomic) IBOutlet UILabel *lblBrand;
@property (strong, nonatomic) IBOutlet UILabel *lblModel;
@property (strong, nonatomic) IBOutlet UILabel *lblRegoNo;
@property (strong, nonatomic) IBOutlet UILabel *lblColour;


@end

NS_ASSUME_NONNULL_END
