//
//  TrackDriverVC.m
//  TruckyDucky
//
//  Created by anil kumar on 13/02/20.
//  Copyright © 2020 Steve. All rights reserved.
//

#import "TrackDriverVC.h"
#import "TrackDriverCell.h"

#import "SVProgressHUD.h"
#import "webServicesSingulton.h"

#import "DriverLocationVC.h"
#import "UIImageView+WebCache.h"

@interface TrackDriverVC ()
{
    NSArray *arrResponse;
    
    NSArray *arrINTransists;
}

@end

@implementation TrackDriverVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSLog(@"%@",self.arrPassTodayData);
    
    self.arrPassTodayData = [[NSMutableArray alloc]initWithObjects:@"Driver1",@"Driver 2",@"Driver 3", nil];
   
    [self.objTbl setBackgroundColor:[UIColor whiteColor]];
    [self setNeedsStatusBarAppearanceUpdate];
    
    self.vwNoData.layer.cornerRadius = 5;
    self.vwNoData.hidden = YES;
      
    
    
    
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDarkContent;
}



-(void)viewWillAppear:(BOOL)animated{
       
       [SVProgressHUD showWithStatus:@"Loading..." maskType:SVProgressHUDMaskTypeBlack];
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                [self TodayOrderAPI];
                });
    
}
-(void)showAlert
{
    [self showMessage:@"check your internet connection"
           withTitle:@"Trucky Ducky"];
}

-(void)showMessage:(NSString*)message withTitle:(NSString *)title
{
    UIAlertController * alert =[UIAlertController
                                alertControllerWithTitle:title
                                message:message
                                preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^( UIAlertAction *action )
                               {
                                   // do something when click button
                               }];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
    
}



#pragma mark webService Call 
-(void)TodayOrderAPI
{
    NSString *strAlert;
    NSArray *arrLogin = [[webServicesSingulton sharedManager]BookedHistory:[[NSUserDefaults standardUserDefaults]valueForKey:@"UserIDD"]];
    NSLog(@"Data is %@",arrLogin);
    
    
    [SVProgressHUD dismiss];
    if (arrLogin.count==0)
    {
            [self showMessage:@"Server is busy. Please wait."
                    withTitle:@"Trucky Ducky"];
    }
    else
    {
        
        if ([[[arrLogin  objectAtIndex:0] valueForKey:@"status"] isEqualToString:@"success"])
        {
            
            NSArray *arrTemp;
            arrTemp = [[arrLogin objectAtIndex:0] valueForKey:@"response"];
            arrResponse = [arrTemp  valueForKey:@"response"];
            
            arrINTransists = [arrResponse valueForKey:@"InTransit"];
            
            if (arrINTransists.count == 0) {
                self.vwNoData.hidden = NO;
            }
            
            else{
                self.vwNoData.hidden = YES;
            }
            
            [self.objTbl reloadData];
            
        }
        else
        {
            arrResponse = [[arrLogin objectAtIndex:0] valueForKey:@"response"];
            strAlert = [arrResponse valueForKey:@"msg"];
          
                [self showMessage:strAlert
                        withTitle:@"Trucky Ducky"];
        }
    }
}
 


#pragma mark: UITableView 
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1 ;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrINTransists count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"TrackDriverCell";
    TrackDriverCell *cell = [tableView
                        dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil) {
        cell = [[TrackDriverCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:MyIdentifier] ;
    }
    
    [cell setBackgroundColor:[UIColor whiteColor]];
   
//
    cell.lblHeaderTitle.text =  [[arrINTransists objectAtIndex:indexPath.row] valueForKey:@"Title"];
    cell.lblDrivername.text  =   [[[arrINTransists valueForKey:@"Driver_Id"] objectAtIndex:indexPath.row] valueForKey:@"Full_Name"];
    cell.lblDriverPhone.text  =   [[[arrINTransists valueForKey:@"Driver_Id"] objectAtIndex:indexPath.row] valueForKey:@"Mobile"];
    
    
    
    
    
    NSString *strDrivertruck = [[[arrINTransists valueForKey:@"Driver_Id"]objectAtIndex:indexPath.row] valueForKey:@"Truck_Name"];
    NSString *strDrivertruckRego = [[[arrINTransists valueForKey:@"Driver_Id"]objectAtIndex:indexPath.row] valueForKey:@"Truck_Number"];
    
    cell.lblDriverTruckinfo.text =  [NSString stringWithFormat:@"%@ - %@",strDrivertruck,strDrivertruckRego];
    
    
    
    
    
    NSString *strImg = [NSString stringWithFormat:@"%@%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"BaseURLPass"],[[[arrINTransists valueForKey:@"Driver_Id"] objectAtIndex:indexPath.row] valueForKey:@"Profile_Image"]];
    

    [cell.lblDriverPhoto sd_setImageWithURL:[NSURL URLWithString:strImg]
                            placeholderImage:[UIImage imageNamed:@"NoImage.png"] options:(0) == 0 ? SDWebImageRefreshCached : 0];
    
    
    cell.lblDriverPhoto.layer.cornerRadius = cell.lblDriverPhoto.frame.size.width/2;
    cell.lblDriverPhoto.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    cell.lblDriverPhoto.layer.borderWidth = 1;
    
    
    
    //
    cell.lblSenderName.text =  [[arrINTransists objectAtIndex:indexPath.row] valueForKey:@"Sender_Name"];
//
    cell.lblSenderPhone.text =  [[arrINTransists objectAtIndex:indexPath.row] valueForKey:@"Sender_Phone"];
    
    
    
    
    //38832546521
    
     cell.bckView.layer.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.2].CGColor;
     cell.bckView.layer.shadowOffset = CGSizeMake(3.0, 3.0);
     cell.bckView.layer.shadowOpacity = 17.0;
     cell.bckView.layer.shadowRadius = 7.0;
    
    
    if (@available(iOS 13.0, *)) {
        cell.btnTrackDriverLocation.layer.borderColor = [UIColor.linkColor CGColor];
    } else {
        // Fallback on earlier versions
    }
    
   
    CABasicAnimation *theAnimation;

    theAnimation=[CABasicAnimation animationWithKeyPath:@"opacity"];
    theAnimation.duration=1.0;
    theAnimation.repeatCount=HUGE_VALF;
    theAnimation.autoreverses=YES;
    theAnimation.fromValue=[NSNumber numberWithFloat:1.0];
    theAnimation.toValue=[NSNumber numberWithFloat:0.0];
    [cell.btnTrackDriverLocation.layer addAnimation:theAnimation forKey:@"animateOpacity"];
    
    
    
    
    cell.btnTrackDriverLocation.tag = indexPath.row;
    
    [cell.btnTrackDriverLocation addTarget:self action:@selector(btnTrackDriverLocation:) forControlEvents:UIControlEventTouchUpInside];
          
    
    
    
    return cell;
}

-(void)btnTrackDriverLocation: (UIButton *)sender

{
    
    NSString *DriverID = [[[arrINTransists valueForKey:@"Driver_Id"] objectAtIndex:sender.tag] valueForKey:@"User_Id"];
    
   NSString *HeaderTitle = [[arrINTransists objectAtIndex:sender.tag] valueForKey:@"Title"];
    
    DriverLocationVC *DriverTrack = [self.storyboard instantiateViewControllerWithIdentifier:@"DriverLocationVC"];
    DriverTrack.StrPassDriverID = DriverID;
    DriverTrack.strPassHeaderTitle = HeaderTitle;
    [self.navigationController pushViewController:DriverTrack animated:YES];
    
   
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



@end
