//
//  HistoryListingDetailsVC.h
//  TruckyDucky
//
//  Created by anil kumar on 14/12/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>

NS_ASSUME_NONNULL_BEGIN

@interface HistoryListingDetailsVC : UIViewController
@property (strong, nonatomic) IBOutlet UITableView *objTbl;
@property (strong, nonatomic) IBOutlet UIView *vwHeaderTop;
@property (strong, nonatomic) IBOutlet GMSMapView *objMapVW;


@property (weak, nonatomic) NSArray *arrHistoryDataPass;



@end

NS_ASSUME_NONNULL_END
