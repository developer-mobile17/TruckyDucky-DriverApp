//
//  SingleBookListingDetailsVC.h
//  TruckyDucky
//
//  Created by anil kumar on 18/12/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
NS_ASSUME_NONNULL_BEGIN

@interface SingleBookListingDetailsVC : UIViewController

@property (weak, nonatomic) NSArray *arrBookDetailsPass;
@property (strong, nonatomic) IBOutlet UITableView *objTbl;
@property (strong, nonatomic) IBOutlet UIView *vwHeaderTop;
@property (strong, nonatomic) IBOutlet GMSMapView *objMapVW;
@property (strong, nonatomic) IBOutlet UIView *vwFooterTbl;

@property (weak, nonatomic) IBOutlet UIButton *btnClose;


@property (weak, nonatomic) IBOutlet UIButton *btnCall;
- (IBAction)actoinCall:(id)sender;
- (IBAction)actionChat:(id)sender;



@end

NS_ASSUME_NONNULL_END
