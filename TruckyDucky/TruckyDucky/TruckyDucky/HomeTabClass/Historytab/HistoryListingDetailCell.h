//
//  HistoryListingDetailCell.h
//  TruckyDucky
//
//  Created by anil kumar on 14/12/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>

NS_ASSUME_NONNULL_BEGIN

@interface HistoryListingDetailCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIView *bckView;
@property (strong, nonatomic) IBOutlet GMSMapView *objMapVW;


@property (strong, nonatomic) IBOutlet UILabel *lblCompanyX;
@property (strong, nonatomic) IBOutlet UILabel *lblCompanyY;
@property (strong, nonatomic) IBOutlet UILabel *lblPickup_Address;
@property (strong, nonatomic) IBOutlet UILabel *lblDropoff_Address;
@property (strong, nonatomic) IBOutlet UILabel *lblDistance;
@property (strong, nonatomic) IBOutlet UILabel *lblVehicle;
@property (strong, nonatomic) IBOutlet UILabel *lblBrand;
@property (strong, nonatomic) IBOutlet UILabel *lblModel;
@property (strong, nonatomic) IBOutlet UILabel *lblRego;
@property (strong, nonatomic) IBOutlet UILabel *lblColor;




@property (strong, nonatomic) IBOutlet UILabel *lblDriverName;
@property (strong, nonatomic) IBOutlet UILabel *lblDriverCompany;
@property (strong, nonatomic) IBOutlet UILabel *lblPrice;
@property (strong, nonatomic) IBOutlet UIImageView *imgProfile;



@property (strong, nonatomic) IBOutlet UIButton *btnClickToCall;



@end

NS_ASSUME_NONNULL_END
