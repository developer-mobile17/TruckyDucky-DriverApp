//
//  NewTabCell.h
//  TruckyDucky
//
//  Created by bllss it sloutions on 11/12/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>


@interface NewTabCell : UITableViewCell
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






@property (strong, nonatomic) IBOutlet UIButton *btnDeailsCheck;
@property (strong, nonatomic) IBOutlet UIButton *btnOffers;

@end
