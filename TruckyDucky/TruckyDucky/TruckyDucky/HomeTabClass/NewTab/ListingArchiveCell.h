//
//  ListingArchiveCell.h
//  TruckyDucky
//
//  Created by anil kumar on 11/03/20.
//  Copyright © 2020 Steve. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
NS_ASSUME_NONNULL_BEGIN

@interface ListingArchiveCell : UITableViewCell
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




@property (strong, nonatomic) IBOutlet UIButton *btnEdit;
@property (strong, nonatomic) IBOutlet UIButton *btnRequestAgain;
@end

NS_ASSUME_NONNULL_END
