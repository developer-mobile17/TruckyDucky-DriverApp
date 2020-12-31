//
//  NewtabVC.h
//  TruckyDucky
//
//  Created by bllss it sloutions on 11/12/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
@interface NewtabVC : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *lblRequestForCar;
@property (strong, nonatomic) IBOutlet UITableView *objTbl;
//@property (strong, nonatomic) IBOutlet GMSMapView *objMapVW;


@property (strong, nonatomic) IBOutlet UILabel *lblNotificationCounter;
@property (strong, nonatomic) IBOutlet UIImageView *imgBackCounter;


@property (strong, nonatomic) IBOutlet UIView *vwNoData;
@property (strong, nonatomic) IBOutlet UILabel *lblNoData;


- (IBAction)actionNotificationClicked:(id)sender;
- (IBAction)actionProfile:(id)sender;
- (IBAction)actionRequestForCar:(id)sender;

@end
