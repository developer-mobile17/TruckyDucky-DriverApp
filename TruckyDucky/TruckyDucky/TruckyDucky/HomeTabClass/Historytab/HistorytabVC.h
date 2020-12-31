//
//  HistorytabVC.h
//  TruckyDucky
//
//  Created by bllss it sloutions on 11/12/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HistorytabVC : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *lblDate;
@property (strong, nonatomic) IBOutlet UITableView *objTbl;


@property (strong, nonatomic) IBOutlet UIView *vwNoData;
@property (strong, nonatomic) IBOutlet UILabel *lblNoData;


- (IBAction)actionSegment:(id)sender;

@end
