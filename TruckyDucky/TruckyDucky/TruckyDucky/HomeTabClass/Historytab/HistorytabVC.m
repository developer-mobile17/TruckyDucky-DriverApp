//
//  HistorytabVC.m
//  TruckyDucky
//
//  Created by bllss it sloutions on 11/12/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import "HistorytabVC.h"
#import "HistorytabCell.h"
#import "HistoryListingDetailsVC.h"

#import "SVProgressHUD.h"
#import "webServicesSingulton.h"
#import "checkInternet.h"
@interface HistorytabVC ()
{
    
    NSArray *arrResponse;
    NSDate *seletedDate;
    NSString *dateString;
    UIDatePicker *DatePicker;
    
    NSString *DeliveryDate;
    NSString *CurrentDate;
    NSString *strNoData;
    
    
}

@end

@implementation HistorytabVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNeedsStatusBarAppearanceUpdate];
    [self.objTbl setBackgroundColor:[UIColor whiteColor]];
    
    
    
    self.vwNoData.layer.cornerRadius = 5;
    self.vwNoData.hidden = YES;
    
   
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDarkContent;
}
-(void)viewWillAppear:(BOOL)animated{
    
    
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyy-MM-dd"];
    // or @"yyyy-MM-dd hh:mm:ss a" if you prefer the time with AM/PM
   // NSLog(@"%@",[dateFormatter stringFromDate:[NSDate date]]);
    CurrentDate = [dateFormatter stringFromDate:[NSDate date]];
    
    
    
    
    
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
                       [dateFormatter1 setDateFormat:@"MMMM dd,  yyy"];
                       NSString *str1 = [dateFormatter1 stringFromDate:[NSDate date]];
                      NSLog(@"Formated date - %@", str1);//output -> 09-05-2013 09:30
    
    
    
    self.lblDate.text = str1;
    
    
    
     self.vwNoData.hidden = YES;
      [SVProgressHUD showWithStatus:@"Loading..."];
      [self performSelector:@selector(checkinternet) withObject:nil afterDelay:0.2];
        
}


-(void)checkinternet
{
    BOOL checkInternetbool1=[checkInternet connectedToNetwork];
    
    if (checkInternetbool1 == NO)
    {
       [SVProgressHUD dismiss];
        [self showAlert];
        
    }
    else
    {
       
            
        [SVProgressHUD showWithStatus:@"Loading..."];
                     dispatch_async(dispatch_get_main_queue(), ^{
                         
        [self GetHistotyByCurrentDate];
                     });
       
    }
    
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
-(void)GetHistotyByDate
{
   // NSString *strAlert;
    NSArray *arrLogin = [[webServicesSingulton sharedManager]GetHistotyByDate:[[NSUserDefaults standardUserDefaults]valueForKey:@"UserIDD"] :DeliveryDate];
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
            
            
            self.vwNoData.hidden = YES;
            self.lblNoData.text = strNoData;
            
            arrResponse = [[arrLogin objectAtIndex:0] valueForKey:@"BookedHistory"];
            [self.objTbl reloadData];
            
  
        }
        else
        {
            arrResponse = [[arrLogin objectAtIndex:0] valueForKey:@"response"];
            arrResponse = nil;
            [self.objTbl reloadData];
            
            
             strNoData = [[arrLogin objectAtIndex:0] valueForKey:@"msg"];
             self.vwNoData.hidden = NO;
             self.lblNoData.text = strNoData;

            
            
            
        }
    }
}





#pragma mark webService Call 

#pragma mark webService Call 
-(void)GetHistotyByCurrentDate
{
   // NSString *strAlert;
    NSArray *arrLogin = [[webServicesSingulton sharedManager]GetHistotyByDate:[[NSUserDefaults standardUserDefaults]valueForKey:@"UserIDD"] :CurrentDate];
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
            
            
            self.vwNoData.hidden = YES;
            self.lblNoData.text = strNoData;
            
            arrResponse = [[arrLogin objectAtIndex:0] valueForKey:@"BookedHistory"];
            [self.objTbl reloadData];
            
  
        }
        else
        {
            arrResponse = [[arrLogin objectAtIndex:0] valueForKey:@"response"];
            arrResponse = nil;
            [self.objTbl reloadData];
            
            
             strNoData = [[arrLogin objectAtIndex:0] valueForKey:@"msg"];
             self.vwNoData.hidden = NO;
             self.lblNoData.text = strNoData;

            
            
            
        }
    }
}



//-(void)calledBookedHistoryWebService
//{
//   // NSString *strAlert;
//    NSArray *arrLogin = [[webServicesSingulton sharedManager]BookedHistory:[[NSUserDefaults standardUserDefaults]valueForKey:@"UserIDD"]];
//    NSLog(@"Data is %@",arrLogin);
//
//
//    [SVProgressHUD dismiss];
//    if (arrLogin.count==0)
//    {
//            [self showMessage:@"Server is busy. Please wait."
//                    withTitle:@"Trucky Ducky"];
//    }
//    else
//    {
//
//        if ([[[arrLogin  objectAtIndex:0] valueForKey:@"status"] isEqualToString:@"success"])
//        {
//
//            arrResponse = [[arrLogin objectAtIndex:0] valueForKey:@"BookedHistory"];
//
//
//                   NSString *str = [[arrResponse objectAtIndex:0] valueForKey:@"Created_Date"];
//                   NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//                   [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//                   NSDate *dt = [dateFormatter dateFromString:str];
//
//                   NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
//                   [dateFormatter1 setDateFormat:@"MMMM dd,  yyy"];
//                   NSString *str1 = [dateFormatter1 stringFromDate:dt];
//                   NSLog(@"Formated date - %@", str1);//output -> 09-05-2013 09:30
//
//                    self.lblDate.text = str1;


//            [self.objTbl reloadData];
//
//
//        }
//        else
//        {
//            arrResponse = [[arrLogin objectAtIndex:0] valueForKey:@"response"];
//          //  strAlert = [arrResponse valueForKey:@"msg"];
//
////                [self showMessage:strAlert
////                        withTitle:@"Trucky Ducky"];
//        }
//    }
//}
//
#pragma mark: UITableView 
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1 ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [arrResponse count];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"HistorytabCell";
    HistorytabCell *cell = [tableView
                        dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil) {
        cell = [[HistorytabCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:MyIdentifier] ;
    }
    
      [cell setBackgroundColor:[UIColor whiteColor]];
    

    
    
    cell.lblHeaderTitle.text =  [[arrResponse objectAtIndex:indexPath.row]valueForKey:@"Pickup_Name"];
    cell.lblPickup_Address.text = [[arrResponse objectAtIndex:indexPath.row]valueForKey:@"Pickup_Address"];
    cell.lblDropoff_Address.text = [[arrResponse objectAtIndex:indexPath.row]valueForKey:@"Dropoff_Address"];
    cell.lblPrice.text =[NSString stringWithFormat:@"$%@",[[arrResponse objectAtIndex:indexPath.row]valueForKey:@"Price"]];
   // cell.lblTime.text = [[arrResponse objectAtIndex:indexPath.row]valueForKey:@"Booked_Date"];
    cell.lblDistance.text = [NSString stringWithFormat:@"%@km",[[arrResponse objectAtIndex:indexPath.row]valueForKey:@"Distance"]];
    
    
    
    
    
    
    
    cell.bckView.layer.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5].CGColor;
    cell.bckView.layer.shadowOffset = CGSizeMake(3.0, 3.0);
    cell.bckView.layer.shadowOpacity = 17.0;
    cell.bckView.layer.shadowRadius = 7.0;
    cell.bckView.layer.cornerRadius = 10;
    
    
    

    
    return cell;
}






- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HistoryListingDetailsVC *HistoryDetails = [self.storyboard instantiateViewControllerWithIdentifier:@"HistoryListingDetailsVC"];
    
    HistoryDetails.arrHistoryDataPass = [arrResponse objectAtIndex:indexPath.row];
    
    [self.navigationController pushViewController:HistoryDetails animated:YES];
    
}



#pragma mark : action Select Date & Time  Button
- (IBAction)actionSelectDate:(id)sender {
    
    [self ShowDatePicker];
}


-(void)ShowDatePicker
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"\n\n\n\n\n\n\n\n" preferredStyle:UIAlertControllerStyleActionSheet];

       UIView *viewDatePicker = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,200)];
    
        [viewDatePicker setTintColor:[UIColor blackColor]];
        [viewDatePicker setBackgroundColor:[UIColor clearColor]];

       CGRect pickerFrame = CGRectMake(0, 0, self.view.frame.size.width, 200);
       DatePicker = [[UIDatePicker alloc] initWithFrame:pickerFrame];
       DatePicker.datePickerMode = UIDatePickerModeDate;
      
       [viewDatePicker addSubview:DatePicker];

       [alertController.view addSubview:viewDatePicker];


       UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Select Date" style:UIAlertActionStyleDefault
       handler:^(UIAlertAction * action) {

    
           [self SelectedDate];
        }];

        alertController.view.tintColor = [UIColor blackColor];
       [alertController addAction:defaultAction];
       [self presentViewController:alertController animated:YES completion:nil];
}




-(void)SelectedDate {
    

    
    
     NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
     NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
   
   
    
    [dateFormatter1 setDateFormat:@" MMMM dd,  yyy"];
    NSString *dateString = [dateFormatter1 stringFromDate:DatePicker.date];
     self.lblDate.text = dateString;
    
    
    [dateFormatter2 setDateFormat:@"yyy-MM-dd"];
    DeliveryDate = [dateFormatter2 stringFromDate:DatePicker.date];
    
    
    
    
   
    
    [SVProgressHUD showWithStatus:@"Loading..." maskType:SVProgressHUDMaskTypeBlack];
                      dispatch_async(dispatch_get_main_queue(), ^{
                          
                         [self GetHistotyByDate];
                      });
    
    
    
    
    
    
    
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

    

@end
