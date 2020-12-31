//
//  NewJobFullDetailsVC.h
//  TruckyDucky
//
//  Created by anil kumar on 30/04/20.
//  Copyright © 2020 Steve. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
NS_ASSUME_NONNULL_BEGIN

@interface NewJobFullDetailsVC : UIViewController
@property (strong, nonatomic) IBOutlet UITableView *objTbl;

@property (weak, nonatomic) NSArray *arrNewJobDetialDataPass;
@end

NS_ASSUME_NONNULL_END
