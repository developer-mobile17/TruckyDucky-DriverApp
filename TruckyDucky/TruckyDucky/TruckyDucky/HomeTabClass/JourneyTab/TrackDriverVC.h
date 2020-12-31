//
//  TrackDriverVC.h
//  TruckyDucky
//
//  Created by anil kumar on 13/02/20.
//  Copyright © 2020 Steve. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TrackDriverVC : UIViewController
@property (strong, nonatomic) IBOutlet UITableView *objTbl;
@property (strong, nonatomic) NSMutableArray  *arrPassTodayData;


@property (strong, nonatomic) IBOutlet UIView *vwNoData;
@property (strong, nonatomic) IBOutlet UILabel *lblNoData;


@end

NS_ASSUME_NONNULL_END
