//
//  BookedtabVC.m
//  TruckyDucky
//
//  Created by bllss it sloutions on 11/12/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import "BookedtabVC.h"
#import "BookedTabCell.h"

#import "SingleBookListingDetailsVC.h"
#import "webServicesSingulton.h"
#import "SVProgressHUD.h"
#import "checkInternet.h"
@interface BookedtabVC ()
{
    NSArray *arrResponse;
    NSString *strUserID;
    
    NSString *strNoData;
    NSArray *arrLogin;
    
}

@end

@implementation BookedtabVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    

    [self setNeedsStatusBarAppearanceUpdate];
    
    [self.objTbl setBackgroundColor:[UIColor whiteColor]];
    
   
    
    CGRect frame= self.objsegment.frame;
    [self.objsegment setFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 40)];
    
    [[UISegmentedControl appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor]} forState:UIControlStateSelected];
    [[UISegmentedControl appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]} forState:UIControlStateNormal];
    
    
    self.objsegment.layer.borderWidth = 1;
    self.objsegment.layer.borderColor = [[UIColor blackColor]CGColor];
    self.vwNoData.layer.cornerRadius = 5;
    self.vwNoData.hidden = YES;
   

    
   
}


- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDarkContent;
}
-(void)viewWillAppear:(BOOL)animated{
    
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
                         
        [self calledBookingListWebService];
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
-(void)calledBookingListWebService
{

   
    arrLogin = [[webServicesSingulton sharedManager]CustomerOrdersHistory:[[NSUserDefaults standardUserDefaults]valueForKey:@"UserIDD"]];
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
            
            arrResponse = [[arrLogin objectAtIndex:0] valueForKey:@"OrdersHistory"];
            [self.objTbl reloadData];
               
                          
               }
              
        else
        {
            
              
              strNoData = [[arrLogin objectAtIndex:0] valueForKey:@"msg"];
              
            
              self.vwNoData.hidden = NO;
              self.lblNoData.text = strNoData;
            
           // arrResponse = [[arrLogin objectAtIndex:0] valueForKey:@"response"];
          //  strAlert = [arrResponse valueForKey:@"msg"];
          
//                [self showMessage:strAlert
//                        withTitle:@"Trucky Ducky"];
                
           
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
    
    return  [arrResponse count];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"BookedTabCell";
    BookedTabCell *cell = [tableView
                        dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil) {
        cell = [[BookedTabCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:MyIdentifier] ;
    }
    
    
    
     [cell setBackgroundColor:[UIColor whiteColor]];
   
    
    cell.lblHeaderTitle.text =  [[arrResponse objectAtIndex:indexPath.row]valueForKey:@"Pickup_Name"];
    cell.lblPickup_Address.text = [[arrResponse objectAtIndex:indexPath.row]valueForKey:@"Pickup_Address"];
    cell.lblDropoff_Address.text = [[arrResponse objectAtIndex:indexPath.row]valueForKey:@"Dropoff_Address"];
    cell.lblPrice.text =[NSString stringWithFormat:@"$%@",[[arrResponse objectAtIndex:indexPath.row]valueForKey:@"Price"]];
    cell.lblTime.text = [[arrResponse objectAtIndex:indexPath.row]valueForKey:@"Booked_Date"];
    cell.lblDistance.text = [NSString stringWithFormat:@"%@km",[[arrResponse objectAtIndex:indexPath.row]valueForKey:@"Distance"]];
    
    
    
    
    
    //[[arrSegmenttbleData objectAtIndex:indexPath.row]
    cell.bckView.layer.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.2].CGColor;
    cell.bckView.layer.shadowOffset = CGSizeMake(3.0, 3.0);
    cell.bckView.layer.shadowOpacity = 17.0;
    cell.bckView.layer.shadowRadius = 7.0;
    cell.bckView.layer.cornerRadius = 10;
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    SingleBookListingDetailsVC *Login = [self.storyboard instantiateViewControllerWithIdentifier:@"SingleBookListingDetailsVC"];
    

    
    NSArray *arrTest;
    arrTest = [arrResponse objectAtIndex:indexPath.row];
    
    Login.self.arrBookDetailsPass= [arrResponse objectAtIndex:indexPath.row];

    [self.navigationController pushViewController:Login animated:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
