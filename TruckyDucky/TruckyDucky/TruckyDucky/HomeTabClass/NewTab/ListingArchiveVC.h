//
//  ListingArchiveVC.h
//  TruckyDucky
//
//  Created by anil kumar on 11/03/20.
//  Copyright © 2020 Steve. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ListingArchiveVC : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *lblDate;
@property (strong, nonatomic) IBOutlet UITableView *objTbl;

@property (strong, nonatomic) IBOutlet UIView *vwNoData;
@property (strong, nonatomic) IBOutlet UILabel *lblNoData;
@end

NS_ASSUME_NONNULL_END
