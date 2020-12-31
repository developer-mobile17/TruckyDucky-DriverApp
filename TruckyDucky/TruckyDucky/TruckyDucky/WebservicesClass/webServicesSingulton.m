  //
//  webServicesSingulton.m
//  SAS
//
//  Created by Abhishek Gupta on 29/09/14.
//  Copyright (c) 2014 Abhishek Gupta. All rights reserved.
//

#import "webServicesSingulton.h"
#import "SBJSON.h"

//#define BaseUrl @"http://3.20.149.139/index.php/api/v1/"
#define BaseUrl @"http://hourlylancer.com/kickTraders/api/v1/"

@implementation webServicesSingulton
static webServicesSingulton
*	myInstance;
+ (webServicesSingulton *) sharedManager
{
	if (!myInstance)
	{
		myInstance = [[webServicesSingulton alloc] init];
	}
    return myInstance;
}

- (NSData *)sendSynchronousRequest:(NSURLRequest *)request returningResponse:(NSURLResponse **)response error:(NSError **)error
{
    
    NSError __block *err = NULL;
    NSData __block *data;
    BOOL __block reqProcessed = false;
    NSURLResponse __block *resp;
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable _data, NSURLResponse * _Nullable _response, NSError * _Nullable _error) {
        resp = _response;
        err = _error;
        data = _data;
        reqProcessed = true;
    }] resume];
    
    while (!reqProcessed) {
        [NSThread sleepForTimeInterval:0];
    }
    
    *response = resp;
    *error = err;
    return data;
}


-(NSArray *)Login:(NSString *)FieldType :(NSString *)Mobile :(NSString *)Password :(NSString *)Device_Token :(NSString *)Role :(NSString *)MobileType

//**************************************** Login **********************************************
{
    NSString *urlString =[NSString stringWithFormat:@"%@login",BaseUrl];
    
    //NSLog(@"urlstring %@",urlString);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    [request setValue:@"813937bae1a26e2d442acec31c85c460e0a12c98" forHTTPHeaderField:@"apitoken"];
    
    NSMutableData *body = [NSMutableData data];
    
    
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"FieldType\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[FieldType dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"Mobile\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[Mobile dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"Password\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[Password dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"Device_Token\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[Device_Token dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    
      [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
       [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"Role\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
       [body appendData:[Role dataUsingEncoding:NSUTF8StringEncoding]];
       [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"MobileType\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
          [body appendData:[MobileType dataUsingEncoding:NSUTF8StringEncoding]];
          [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    [request setHTTPBody:body];
    
    NSURLResponse *resp;
    NSError *err;
    
    NSData *returnData = [self sendSynchronousRequest:request returningResponse:&resp error:&err];
    NSString *strjson=[[NSString alloc]initWithData:returnData encoding: NSUTF8StringEncoding];
    //NSLog(@"%@",strjson);
    SBJSON *jsonobject=[[SBJSON alloc]init];
    NSDictionary *dictionary = [jsonobject objectWithString:strjson];
    //NSLog(@" %@",dictionary);
    
    NSArray *signupArr=[[NSArray alloc]initWithObjects:dictionary, nil];
    //NSLog(@"signupArr=%@",signupArr);
    return signupArr;
}


//*************************************Forgot Password **************************************

-(NSArray *)ForgotPassword : (NSString *) Email
{
    NSString *urlString =[NSString stringWithFormat:@"%@ForgetPassword",BaseUrl];
    
    //NSLog(@"urlstring %@",urlString);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    [request setValue:@"813937bae1a26e2d442acec31c85c460e0a12c98" forHTTPHeaderField:@"apitoken"];
    
    NSMutableData *body = [NSMutableData data];
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"Email\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[Email dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    
    
    [request setHTTPBody:body];
    
    NSURLResponse *resp;
    NSError *err;
    
    NSData *returnData = [self sendSynchronousRequest:request returningResponse:&resp error:&err];
    NSString *strjson=[[NSString alloc]initWithData:returnData encoding: NSUTF8StringEncoding];
    //NSLog(@"%@",strjson);
    SBJSON *jsonobject=[[SBJSON alloc]init];
    NSDictionary *dictionary = [jsonobject objectWithString:strjson];
    //NSLog(@" %@",dictionary);
    
    NSArray *signupArr=[[NSArray alloc]initWithObjects:dictionary, nil];
    //NSLog(@"signupArr=%@",signupArr);
    return signupArr;
}





//*************************************Create New Password **************************************

-(NSArray *)CreateNewAccount:(NSString *)Email :(NSString *)OTP :(NSString *)Password
{
    NSString *urlString =[NSString stringWithFormat:@"%@CreateNewPassword",BaseUrl];
    
    //NSLog(@"urlstring %@",urlString);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    [request setValue:@"813937bae1a26e2d442acec31c85c460e0a12c98" forHTTPHeaderField:@"apitoken"];
    
    NSMutableData *body = [NSMutableData data];
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"Email\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[Email dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"OTP\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[OTP dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"Password\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[Password dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    
    
    [request setHTTPBody:body];
    
    NSURLResponse *resp;
    NSError *err;
    
    NSData *returnData = [self sendSynchronousRequest:request returningResponse:&resp error:&err];
    NSString *strjson=[[NSString alloc]initWithData:returnData encoding: NSUTF8StringEncoding];
    //NSLog(@"%@",strjson);
    SBJSON *jsonobject=[[SBJSON alloc]init];
    NSDictionary *dictionary = [jsonobject objectWithString:strjson];
    //NSLog(@" %@",dictionary);
    
    NSArray *signupArr=[[NSArray alloc]initWithObjects:dictionary, nil];
    //NSLog(@"signupArr=%@",signupArr);
    return signupArr;
}






//*************************************Create New Password **************************************

-(NSArray *)ResetYourPassword:(NSString *)User_Id :(NSString *)oldPassword :(NSString *)newPassword
{
    NSString *urlString =[NSString stringWithFormat:@"%@changePassword",BaseUrl];
    
    //NSLog(@"urlstring %@",urlString);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    [request setValue:@"813937bae1a26e2d442acec31c85c460e0a12c98" forHTTPHeaderField:@"apitoken"];
    
    NSMutableData *body = [NSMutableData data];
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"User_Id\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[User_Id dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"oldPassword\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[oldPassword dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"newPassword\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[newPassword dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    
    
    [request setHTTPBody:body];
    
    NSURLResponse *resp;
    NSError *err;
    
    NSData *returnData = [self sendSynchronousRequest:request returningResponse:&resp error:&err];
    NSString *strjson=[[NSString alloc]initWithData:returnData encoding: NSUTF8StringEncoding];
    //NSLog(@"%@",strjson);
    SBJSON *jsonobject=[[SBJSON alloc]init];
    NSDictionary *dictionary = [jsonobject objectWithString:strjson];
    //NSLog(@" %@",dictionary);
    
    NSArray *signupArr=[[NSArray alloc]initWithObjects:dictionary, nil];
    //NSLog(@"signupArr=%@",signupArr);
    return signupArr;
}






//**************************************** Sign Up **********************************************

-(NSArray *)signup : (NSString *) Full_Name : (NSString *) Email :(NSString *)Mobile :(NSString *)Password :(NSString *)Role :(NSString *)Device_Token
{
    NSString *urlString =[NSString stringWithFormat:@"%@signup",BaseUrl];
    
    //NSLog(@"urlstring %@",urlString);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    [request setValue:@"813937bae1a26e2d442acec31c85c460e0a12c98" forHTTPHeaderField:@"apitoken"];
    
    
    
    
    NSMutableData *body = [NSMutableData data];
    
    
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"Full_Name\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[Full_Name dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"Email\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[Email dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"Mobile\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[Mobile dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"Password\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[Password dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
   

    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"Role\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[Role dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"Device_Token\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[Device_Token dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    [request setHTTPBody:body];
   
    NSURLResponse *resp;
    NSError *err;
    
    NSData *returnData = [self sendSynchronousRequest:request returningResponse:&resp error:&err];
    
    NSString *strjson=[[NSString alloc]initWithData:returnData encoding: NSUTF8StringEncoding];
    //NSLog(@"%@",strjson);
    SBJSON *jsonobject=[[SBJSON alloc]init];
    NSDictionary *dictionary = [jsonobject objectWithString:strjson];
    //NSLog(@" %@",dictionary);
    
    NSArray *signupArr=[[NSArray alloc]initWithObjects:dictionary, nil];
    //NSLog(@"signupArr=%@",signupArr);
    return signupArr;
}



//******************* VerifyNewAccount ***********************
-(NSArray *)VerifyNewAccount:(NSString *)Mobile :(NSString *)Code


{
    NSString *urlString =[NSString stringWithFormat:@"%@verify",BaseUrl];
    
    //NSLog(@"urlstring %@",urlString);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    [request setValue:@"813937bae1a26e2d442acec31c85c460e0a12c98" forHTTPHeaderField:@"apitoken"];
    
    NSMutableData *body = [NSMutableData data];
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"Mobile\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[Mobile dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"Code\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[Code dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    [request setHTTPBody:body];
    
    NSURLResponse *resp;
    NSError *err;
    
    NSData *returnData = [self sendSynchronousRequest:request returningResponse:&resp error:&err];
    NSString *strjson=[[NSString alloc]initWithData:returnData encoding: NSUTF8StringEncoding];
    //NSLog(@"%@",strjson);
    SBJSON *jsonobject=[[SBJSON alloc]init];
    NSDictionary *dictionary = [jsonobject objectWithString:strjson];
    //NSLog(@" %@",dictionary);
    
    NSArray *signupArr=[[NSArray alloc]initWithObjects:dictionary, nil];
    //NSLog(@"signupArr=%@",signupArr);
    return signupArr;
}
//******************* SetYourPresence ***********************
-(NSArray *)SetYourPresence:(NSString *)User_Id :(NSString *)Set_Your_Presence

{
    NSString *urlString =[NSString stringWithFormat:@"%@SetYourPresence",BaseUrl];
    
    //NSLog(@"urlstring %@",urlString);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    [request setValue:@"813937bae1a26e2d442acec31c85c460e0a12c98" forHTTPHeaderField:@"apitoken"];
    
    NSMutableData *body = [NSMutableData data];
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"User_Id\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[User_Id dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"Set_Your_Presence\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[Set_Your_Presence dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
        
    [request setHTTPBody:body];
    
    NSURLResponse *resp;
    NSError *err;
    
    NSData *returnData = [self sendSynchronousRequest:request returningResponse:&resp error:&err];
    NSString *strjson=[[NSString alloc]initWithData:returnData encoding: NSUTF8StringEncoding];
    //NSLog(@"%@",strjson);
    SBJSON *jsonobject=[[SBJSON alloc]init];
    NSDictionary *dictionary = [jsonobject objectWithString:strjson];
    //NSLog(@" %@",dictionary);
    
    NSArray *signupArr=[[NSArray alloc]initWithObjects:dictionary, nil];
    //NSLog(@"signupArr=%@",signupArr);
    return signupArr;
}

//********************* New List Home API  **************************

-(NSArray *)GetCarsById:(NSString *)Posted_By

{
    NSString *urlString =[NSString stringWithFormat:@"%@GetCarsById",BaseUrl];
    
    //NSLog(@"urlstring %@",urlString);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    [request setValue:@"813937bae1a26e2d442acec31c85c460e0a12c98" forHTTPHeaderField:@"apitoken"];
    
    NSMutableData *body = [NSMutableData data];
    

    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"Posted_By\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[Posted_By dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    

    [request setHTTPBody:body];
    
    NSURLResponse *resp;
    NSError *err;
    
    NSData *returnData = [self sendSynchronousRequest:request returningResponse:&resp error:&err];
    NSString *strjson=[[NSString alloc]initWithData:returnData encoding: NSUTF8StringEncoding];
    //NSLog(@"%@",strjson);
    SBJSON *jsonobject=[[SBJSON alloc]init];
    NSDictionary *dictionary = [jsonobject objectWithString:strjson];
    //NSLog(@" %@",dictionary);
    
    NSArray *signupArr=[[NSArray alloc]initWithObjects:dictionary, nil];
    //NSLog(@"signupArr=%@",signupArr);
    return signupArr;
}




-(NSArray *)GetCarsRequest:(NSString *)Posted_By

{
    NSString *urlString =[NSString stringWithFormat:@"%@GetCarsRequest",BaseUrl];
    
    //NSLog(@"urlstring %@",urlString);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    [request setValue:@"813937bae1a26e2d442acec31c85c460e0a12c98" forHTTPHeaderField:@"apitoken"];
    
    NSMutableData *body = [NSMutableData data];
    

    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"Posted_By\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[Posted_By dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    

    [request setHTTPBody:body];
    
    NSURLResponse *resp;
    NSError *err;
    
    NSData *returnData = [self sendSynchronousRequest:request returningResponse:&resp error:&err];
    NSString *strjson=[[NSString alloc]initWithData:returnData encoding: NSUTF8StringEncoding];
    //NSLog(@"%@",strjson);
    SBJSON *jsonobject=[[SBJSON alloc]init];
    NSDictionary *dictionary = [jsonobject objectWithString:strjson];
    //NSLog(@" %@",dictionary);
    
    NSArray *signupArr=[[NSArray alloc]initWithObjects:dictionary, nil];
    //NSLog(@"signupArr=%@",signupArr);
    return signupArr;
}





-(NSArray *)RequestAgain :(NSString *)Listing_Id
{
    
       NSString *urlString =[NSString stringWithFormat:@"%@CloneCars",BaseUrl];
        
        //NSLog(@"urlstring %@",urlString);
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:urlString]];
        [request setHTTPMethod:@"POST"];
        
        NSString *boundary = @"---------------------------14737809831466499882746641449";
        NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
        [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
        [request setValue:@"813937bae1a26e2d442acec31c85c460e0a12c98" forHTTPHeaderField:@"apitoken"];
        
        NSMutableData *body = [NSMutableData data];
        

        
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"Listing_Id\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[Listing_Id dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        

        [request setHTTPBody:body];
        
        NSURLResponse *resp;
        NSError *err;
        
        NSData *returnData = [self sendSynchronousRequest:request returningResponse:&resp error:&err];
        NSString *strjson=[[NSString alloc]initWithData:returnData encoding: NSUTF8StringEncoding];
        //NSLog(@"%@",strjson);
        SBJSON *jsonobject=[[SBJSON alloc]init];
        NSDictionary *dictionary = [jsonobject objectWithString:strjson];
        //NSLog(@" %@",dictionary);
        
        NSArray *signupArr=[[NSArray alloc]initWithObjects:dictionary, nil];
        //NSLog(@"signupArr=%@",signupArr);
        return signupArr;
    }







-(NSArray *)CustomerOrdersHistory:(NSString *)Posted_By

{
    NSString *urlString =[NSString stringWithFormat:@"%@CustomerOrdersHistory",BaseUrl];
    
    //NSLog(@"urlstring %@",urlString);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    [request setValue:@"813937bae1a26e2d442acec31c85c460e0a12c98" forHTTPHeaderField:@"apitoken"];
    
    NSMutableData *body = [NSMutableData data];
    
   
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"Posted_By\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[Posted_By dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    [request setHTTPBody:body];
    
    NSURLResponse *resp;
    NSError *err;
    
    NSData *returnData = [self sendSynchronousRequest:request returningResponse:&resp error:&err];
    NSString *strjson=[[NSString alloc]initWithData:returnData encoding: NSUTF8StringEncoding];
    //NSLog(@"%@",strjson);
    SBJSON *jsonobject=[[SBJSON alloc]init];
    NSDictionary *dictionary = [jsonobject objectWithString:strjson];
    //NSLog(@" %@",dictionary);
    
    NSArray *signupArr=[[NSArray alloc]initWithObjects:dictionary, nil];
    //NSLog(@"signupArr=%@",signupArr);
    return signupArr;
}






-(NSArray *)Booking :(NSString *)Listing_Id :(NSString *)Status :(NSString *)Driver_Id :(NSString *)Customer_Name

{
    NSString *urlString =[NSString stringWithFormat:@"%@Booking",BaseUrl];
    
    //NSLog(@"urlstring %@",urlString);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    [request setValue:@"813937bae1a26e2d442acec31c85c460e0a12c98" forHTTPHeaderField:@"apitoken"];
    
    NSMutableData *body = [NSMutableData data];
    
   
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"Listing_Id\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[Listing_Id dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"Status\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[Status dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"Driver_Id\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[Driver_Id dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"Customer_Name\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[Customer_Name dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    [request setHTTPBody:body];
    
    NSURLResponse *resp;
    NSError *err;
    
    NSData *returnData = [self sendSynchronousRequest:request returningResponse:&resp error:&err];
    NSString *strjson=[[NSString alloc]initWithData:returnData encoding: NSUTF8StringEncoding];
    //NSLog(@"%@",strjson);
    SBJSON *jsonobject=[[SBJSON alloc]init];
    NSDictionary *dictionary = [jsonobject objectWithString:strjson];
    //NSLog(@" %@",dictionary);
    
    NSArray *signupArr=[[NSArray alloc]initWithObjects:dictionary, nil];
    //NSLog(@"signupArr=%@",signupArr);
    return signupArr;
}


-(NSArray *)BookedHistory:(NSString *)Posted_By

{
    NSString *urlString =[NSString stringWithFormat:@"%@CustomerBookedHistory",BaseUrl];
    
    //NSLog(@"urlstring %@",urlString);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    [request setValue:@"813937bae1a26e2d442acec31c85c460e0a12c98" forHTTPHeaderField:@"apitoken"];
    
    NSMutableData *body = [NSMutableData data];
    
   
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"Posted_By\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[Posted_By dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    [request setHTTPBody:body];
    
    NSURLResponse *resp;
    NSError *err;
    
    NSData *returnData = [self sendSynchronousRequest:request returningResponse:&resp error:&err];
    NSString *strjson=[[NSString alloc]initWithData:returnData encoding: NSUTF8StringEncoding];
    //NSLog(@"%@",strjson);
    SBJSON *jsonobject=[[SBJSON alloc]init];
    NSDictionary *dictionary = [jsonobject objectWithString:strjson];
    //NSLog(@" %@",dictionary);
    
    NSArray *signupArr=[[NSArray alloc]initWithObjects:dictionary, nil];
    //NSLog(@"signupArr=%@",signupArr);
    return signupArr;
}

-(NSArray *)CancelByCustomer:(NSString *)Listing_Id :(NSString *)Driver_Id

{
    NSString *urlString =[NSString stringWithFormat:@"%@CancelByCustomer",BaseUrl];
    
    //NSLog(@"urlstring %@",urlString);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    [request setValue:@"813937bae1a26e2d442acec31c85c460e0a12c98" forHTTPHeaderField:@"apitoken"];
    
    NSMutableData *body = [NSMutableData data];
    
   
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"Listing_Id\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[Listing_Id dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"Driver_Id\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[Driver_Id dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    
    
    [request setHTTPBody:body];
    
    NSURLResponse *resp;
    NSError *err;
    
    NSData *returnData = [self sendSynchronousRequest:request returningResponse:&resp error:&err];
    NSString *strjson=[[NSString alloc]initWithData:returnData encoding: NSUTF8StringEncoding];
    //NSLog(@"%@",strjson);
    SBJSON *jsonobject=[[SBJSON alloc]init];
    NSDictionary *dictionary = [jsonobject objectWithString:strjson];
    //NSLog(@" %@",dictionary);
    
    NSArray *signupArr=[[NSArray alloc]initWithObjects:dictionary, nil];
    //NSLog(@"signupArr=%@",signupArr);
    return signupArr;
}








-(NSArray *)GetHistotyByDate:(NSString *)Posted_By :(NSString *)Delivered_Date

{
    NSString *urlString =[NSString stringWithFormat:@"%@CustomerBookedHistoryByDate",BaseUrl];
    
    //NSLog(@"urlstring %@",urlString);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    [request setValue:@"813937bae1a26e2d442acec31c85c460e0a12c98" forHTTPHeaderField:@"apitoken"];
    
    NSMutableData *body = [NSMutableData data];
    
   
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"Posted_By\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[Posted_By dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    
    
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"Delivered_Date\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[Delivered_Date dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    
    
    [request setHTTPBody:body];
    
    NSURLResponse *resp;
    NSError *err;
    
    NSData *returnData = [self sendSynchronousRequest:request returningResponse:&resp error:&err];
    NSString *strjson=[[NSString alloc]initWithData:returnData encoding: NSUTF8StringEncoding];
    //NSLog(@"%@",strjson);
    SBJSON *jsonobject=[[SBJSON alloc]init];
    NSDictionary *dictionary = [jsonobject objectWithString:strjson];
    //NSLog(@" %@",dictionary);
    
    NSArray *signupArr=[[NSArray alloc]initWithObjects:dictionary, nil];
    //NSLog(@"signupArr=%@",signupArr);
    return signupArr;
}













-(NSArray *)ListingBID:(NSString *)Id :(NSString *)Driver_Id :(NSString *)Message

{
    NSString *urlString =[NSString stringWithFormat:@"%@ListingBID",BaseUrl];
    
    //NSLog(@"urlstring %@",urlString);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    [request setValue:@"813937bae1a26e2d442acec31c85c460e0a12c98" forHTTPHeaderField:@"apitoken"];
    
    NSMutableData *body = [NSMutableData data];
    
   
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"Id\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[Id dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"Driver_Id\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[Driver_Id dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"Message\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[Message dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    [request setHTTPBody:body];
    
    NSURLResponse *resp;
    NSError *err;
    
    NSData *returnData = [self sendSynchronousRequest:request returningResponse:&resp error:&err];
    NSString *strjson=[[NSString alloc]initWithData:returnData encoding: NSUTF8StringEncoding];
    //NSLog(@"%@",strjson);
    SBJSON *jsonobject=[[SBJSON alloc]init];
    NSDictionary *dictionary = [jsonobject objectWithString:strjson];
    //NSLog(@" %@",dictionary);
    
    NSArray *signupArr=[[NSArray alloc]initWithObjects:dictionary, nil];
    //NSLog(@"signupArr=%@",signupArr);
    return signupArr;
}











-(NSArray *)Terms_conditionAPI

{
    NSString *urlString =[NSString stringWithFormat:@"%@GetAllPages",BaseUrl];
    
    //NSLog(@"urlstring %@",urlString);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    [request setValue:@"813937bae1a26e2d442acec31c85c460e0a12c98" forHTTPHeaderField:@"apitoken"];
    
    NSMutableData *body = [NSMutableData data];
    

    [request setHTTPBody:body];
    
    NSURLResponse *resp;
    NSError *err;
    
    NSData *returnData = [self sendSynchronousRequest:request returningResponse:&resp error:&err];
    NSString *strjson=[[NSString alloc]initWithData:returnData encoding: NSUTF8StringEncoding];
    //NSLog(@"%@",strjson);
    SBJSON *jsonobject=[[SBJSON alloc]init];
    NSDictionary *dictionary = [jsonobject objectWithString:strjson];
    //NSLog(@" %@",dictionary);
    
    NSArray *signupArr=[[NSArray alloc]initWithObjects:dictionary, nil];
    //NSLog(@"signupArr=%@",signupArr);
    return signupArr;
}





-(NSArray *)SubmitReportrInfo:(NSString *)User_Id :(NSString *)Category :(NSString *)Message

{
    NSString *urlString =[NSString stringWithFormat:@"%@SubmitReport",BaseUrl];
    
    //NSLog(@"urlstring %@",urlString);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    [request setValue:@"813937bae1a26e2d442acec31c85c460e0a12c98" forHTTPHeaderField:@"apitoken"];
    
    NSMutableData *body = [NSMutableData data];
    
   
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"User_Id\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[User_Id dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"Category\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[Category dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"Message\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[Message dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    
    [request setHTTPBody:body];
    
    NSURLResponse *resp;
    NSError *err;
    
    NSData *returnData = [self sendSynchronousRequest:request returningResponse:&resp error:&err];
    NSString *strjson=[[NSString alloc]initWithData:returnData encoding: NSUTF8StringEncoding];
    //NSLog(@"%@",strjson);
    SBJSON *jsonobject=[[SBJSON alloc]init];
    NSDictionary *dictionary = [jsonobject objectWithString:strjson];
    //NSLog(@" %@",dictionary);
    
    NSArray *signupArr=[[NSArray alloc]initWithObjects:dictionary, nil];
    //NSLog(@"signupArr=%@",signupArr);
    return signupArr;
}










//****************************  Profile Data *************************************


-(NSArray *)GetUserInfo:(NSString *)Key :(NSString *)Value

{
    NSString *urlString =[NSString stringWithFormat:@"%@GetUserInfo",BaseUrl];
    
    //NSLog(@"urlstring %@",urlString);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    [request setValue:@"813937bae1a26e2d442acec31c85c460e0a12c98" forHTTPHeaderField:@"apitoken"];
    
    NSMutableData *body = [NSMutableData data];
    
   
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"Key\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[Key dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"Value\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[Value dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    [request setHTTPBody:body];
    
    NSURLResponse *resp;
    NSError *err;
    
    NSData *returnData = [self sendSynchronousRequest:request returningResponse:&resp error:&err];
    NSString *strjson=[[NSString alloc]initWithData:returnData encoding: NSUTF8StringEncoding];
    //NSLog(@"%@",strjson);
    SBJSON *jsonobject=[[SBJSON alloc]init];
    NSDictionary *dictionary = [jsonobject objectWithString:strjson];
    //NSLog(@" %@",dictionary);
    
    NSArray *signupArr=[[NSArray alloc]initWithObjects:dictionary, nil];
    //NSLog(@"signupArr=%@",signupArr);
    return signupArr;
}



//****************************   Edit - Profile Data *************************************


-(NSArray *)editUser:(NSString *)User_Id :(NSString *)Full_Name :(NSString *)Email :(NSString *)Mobile :(NSString *)Address :(NSData *)Profile_Image

{
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"hh:mm:ss"];
    NSString* strTime =  [formatter stringFromDate:[NSDate date]];
    
    
    NSString *urlString =[NSString stringWithFormat:@"%@UpdateUserInfo",BaseUrl];
    
    //NSLog(@"urlstring %@",urlString);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    [request setValue:@"813937bae1a26e2d442acec31c85c460e0a12c98" forHTTPHeaderField:@"apitoken"];
    
    NSMutableData *body = [NSMutableData data];
    
   
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"User_Id\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[User_Id dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"Full_Name\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[Full_Name dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"Email\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[Email dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"Mobile\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[Mobile dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
   
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"Address\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[Address dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
       NSString *strImg = [NSString stringWithFormat: @"%@%@",
                           @"imag", strTime];
       [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
       [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"Profile_Image\"; filename=\"%@.jpg\"\r\n", strImg] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
       [body appendData:[NSData dataWithData:Profile_Image]];
       [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
       
    
    
    
    
 
    
    [request setHTTPBody:body];
    
    NSURLResponse *resp;
    NSError *err;
    
    NSData *returnData = [self sendSynchronousRequest:request returningResponse:&resp error:&err];
    NSString *strjson=[[NSString alloc]initWithData:returnData encoding: NSUTF8StringEncoding];
    //NSLog(@"%@",strjson);
    SBJSON *jsonobject=[[SBJSON alloc]init];
    NSDictionary *dictionary = [jsonobject objectWithString:strjson];
    //NSLog(@" %@",dictionary);
    
    NSArray *signupArr=[[NSArray alloc]initWithObjects:dictionary, nil];
    //NSLog(@"signupArr=%@",signupArr);
    return signupArr;
}


//****************************  Company Login API *************************************


-(NSArray *)GetTruckListing:(NSString *)Key :(NSString *)Value

{
    NSString *urlString =[NSString stringWithFormat:@"%@GetUserInfo",BaseUrl];
    
    //NSLog(@"urlstring %@",urlString);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    [request setValue:@"813937bae1a26e2d442acec31c85c460e0a12c98" forHTTPHeaderField:@"apitoken"];
    
    NSMutableData *body = [NSMutableData data];
    
   
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"Key\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[Key dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"Value\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[Value dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    [request setHTTPBody:body];
    
    NSURLResponse *resp;
    NSError *err;
    
    NSData *returnData = [self sendSynchronousRequest:request returningResponse:&resp error:&err];
    NSString *strjson=[[NSString alloc]initWithData:returnData encoding: NSUTF8StringEncoding];
    //NSLog(@"%@",strjson);
    SBJSON *jsonobject=[[SBJSON alloc]init];
    NSDictionary *dictionary = [jsonobject objectWithString:strjson];
    //NSLog(@" %@",dictionary);
    
    NSArray *signupArr=[[NSArray alloc]initWithObjects:dictionary, nil];
    //NSLog(@"signupArr=%@",signupArr);
    return signupArr;
}






#pragma mark : Company Trucks GetDriversByCompany 

//-(NSArray *)GetDriversByCompany:(NSString *)Driver_Id :(NSString *)Company_Id
-(NSArray *)GetDriversByCompany:(NSString *)Company_Id
{
    NSString *urlString =[NSString stringWithFormat:@"%@GetDriversByCompany",BaseUrl];
    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    [request setValue:@"813937bae1a26e2d442acec31c85c460e0a12c98" forHTTPHeaderField:@"apitoken"];
    
    NSMutableData *body = [NSMutableData data];
    
    
    
//    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
//    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"Driver_Id\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
//    [body appendData:[Driver_Id dataUsingEncoding:NSUTF8StringEncoding]];
//    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"Company_Id\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[Company_Id dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    [request setHTTPBody:body];
    
    NSURLResponse *resp;
    NSError *err;
    
    NSData *returnData = [self sendSynchronousRequest:request returningResponse:&resp error:&err];
    NSString *strjson=[[NSString alloc]initWithData:returnData encoding: NSUTF8StringEncoding];
    //NSLog(@"%@",strjson);
    SBJSON *jsonobject=[[SBJSON alloc]init];
    NSDictionary *dictionary = [jsonobject objectWithString:strjson];
    //NSLog(@" %@",dictionary);
    
    NSArray *signupArr=[[NSArray alloc]initWithObjects:dictionary, nil];
    //NSLog(@"signupArr=%@",signupArr);
    return signupArr;
}



#pragma mark : Company Trucks AddDriverWithTrucks 

-(NSArray *)AddCar:(NSString *)Posted_By :(NSString *)Car_Model :(NSString *)Car_Make :(NSString *)Car_Rego :(NSString *)Car_Colour :(NSString *)Total_Vehicle : (NSString *)Distance : (NSString *)Pickup_Name :(NSString *)Pickup_Address :(NSString *)Pickup_Lat :(NSString *)Pickup_Long :(NSString *)Dropoff_Name :(NSString *)Dropoff_Address :(NSString *)Dropoff_Lat :(NSString *)Dropoff_Long
{
    
    NSString *urlString =[NSString stringWithFormat:@"%@AddCars",BaseUrl];
    
    //NSLog(@"urlstring %@",urlString);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    [request setValue:@"813937bae1a26e2d442acec31c85c460e0a12c98" forHTTPHeaderField:@"apitoken"];
    
    NSMutableData *body = [NSMutableData data];
    
   
    
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"Posted_By\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[Posted_By dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"Car_Model\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[Car_Model dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"Car_Make\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[Car_Make dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"Car_Rego\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[Car_Rego dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"Car_Colour\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[Car_Colour dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"Total_Vehicle\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[Total_Vehicle dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"Distance\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[Distance dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"Pickup_Name\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[Pickup_Name dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"Pickup_Address\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[Pickup_Address dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"Pickup_Lat\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[Pickup_Lat dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"Pickup_Long\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[Pickup_Long dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"Dropoff_Name\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[Dropoff_Name dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"Dropoff_Address\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[Dropoff_Address dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"Dropoff_Lat\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[Dropoff_Lat dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"Dropoff_Long\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[Dropoff_Long dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    [request setHTTPBody:body];
    
    NSURLResponse *resp;
    NSError *err;
    
    NSData *returnData = [self sendSynchronousRequest:request returningResponse:&resp error:&err];
    NSString *strjson=[[NSString alloc]initWithData:returnData encoding: NSUTF8StringEncoding];
    //NSLog(@"%@",strjson);
    SBJSON *jsonobject=[[SBJSON alloc]init];
    NSDictionary *dictionary = [jsonobject objectWithString:strjson];
    //NSLog(@" %@",dictionary);
    
    NSArray *signupArr=[[NSArray alloc]initWithObjects:dictionary, nil];
    //NSLog(@"signupArr=%@",signupArr);
    return signupArr;
}


#pragma mark : Job Confirmatin Listing  API 


-(NSArray *)jobConfirmationListing:(NSString *)Posted_By
{
    NSString *urlString =[NSString stringWithFormat:@"%@GetCarsRequest",BaseUrl];
    
    //NSLog(@"urlstring %@",urlString);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    [request setValue:@"813937bae1a26e2d442acec31c85c460e0a12c98" forHTTPHeaderField:@"apitoken"];
    
    NSMutableData *body = [NSMutableData data];
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"Posted_By\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[Posted_By dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
  
    
    
    [request setHTTPBody:body];
    
    NSURLResponse *resp;
    NSError *err;
    
    NSData *returnData = [self sendSynchronousRequest:request returningResponse:&resp error:&err];
    NSString *strjson=[[NSString alloc]initWithData:returnData encoding: NSUTF8StringEncoding];
    //NSLog(@"%@",strjson);
    SBJSON *jsonobject=[[SBJSON alloc]init];
    NSDictionary *dictionary = [jsonobject objectWithString:strjson];
    //NSLog(@" %@",dictionary);
    
    NSArray *signupArr=[[NSArray alloc]initWithObjects:dictionary, nil];
    //NSLog(@"signupArr=%@",signupArr);
    return signupArr;
}





#pragma mark : Customer ACCEPTED | REJECTED  API 


-(NSArray *)CustomerJOBConfirmation:(NSString *)Listing_Id :(NSString *)Status :(NSString *)Driver_Id :(NSString *)Bid_Price :(NSString *)Customer_Name :(NSString *)Company_Id
{
    NSString *urlString =[NSString stringWithFormat:@"%@Booking",BaseUrl];
    
    //NSLog(@"urlstring %@",urlString);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    [request setValue:@"813937bae1a26e2d442acec31c85c460e0a12c98" forHTTPHeaderField:@"apitoken"];
    
    NSMutableData *body = [NSMutableData data];
    
   
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"Listing_Id\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[Listing_Id dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"Status\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[Status dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"Driver_Id\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[Driver_Id dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"Bid_Price\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[Bid_Price dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    

    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
       [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"Customer_Name\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
       [body appendData:[Customer_Name dataUsingEncoding:NSUTF8StringEncoding]];
       [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
       
    
    
    
    
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
       [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"Company_Id\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
       [body appendData:[Company_Id dataUsingEncoding:NSUTF8StringEncoding]];
       [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
       
    
    
    
    [request setHTTPBody:body];
    
    NSURLResponse *resp;
    NSError *err;
    
    NSData *returnData = [self sendSynchronousRequest:request returningResponse:&resp error:&err];
    NSString *strjson=[[NSString alloc]initWithData:returnData encoding: NSUTF8StringEncoding];
    //NSLog(@"%@",strjson);
    SBJSON *jsonobject=[[SBJSON alloc]init];
    NSDictionary *dictionary = [jsonobject objectWithString:strjson];
    //NSLog(@" %@",dictionary);
    
    NSArray *signupArr=[[NSArray alloc]initWithObjects:dictionary, nil];
    //NSLog(@"signupArr=%@",signupArr);
    return signupArr;
}


-(NSArray *)GetDriverLocationForTracking :(NSString *)User_Id

{
    NSString *urlString =[NSString stringWithFormat:@"%@GetUserById",BaseUrl];
    
    //NSLog(@"urlstring %@",urlString);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    [request setValue:@"813937bae1a26e2d442acec31c85c460e0a12c98" forHTTPHeaderField:@"apitoken"];
    
    NSMutableData *body = [NSMutableData data];
    
   
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"User_Id\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[User_Id dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    [request setHTTPBody:body];
    
    NSURLResponse *resp;
    NSError *err;
    
    NSData *returnData = [self sendSynchronousRequest:request returningResponse:&resp error:&err];
    NSString *strjson=[[NSString alloc]initWithData:returnData encoding: NSUTF8StringEncoding];
    //NSLog(@"%@",strjson);
    SBJSON *jsonobject=[[SBJSON alloc]init];
    NSDictionary *dictionary = [jsonobject objectWithString:strjson];
    //NSLog(@" %@",dictionary);
    
    NSArray *signupArr=[[NSArray alloc]initWithObjects:dictionary, nil];
    //NSLog(@"signupArr=%@",signupArr);
    return signupArr;
}



-(NSArray *)PushNotificationSET :(NSString *)User_Id :(NSString *)Push_Notification

{
    NSString *urlString =[NSString stringWithFormat:@"%@UpdateUserInfo",BaseUrl];
    
    //NSLog(@"urlstring %@",urlString);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    [request setValue:@"813937bae1a26e2d442acec31c85c460e0a12c98" forHTTPHeaderField:@"apitoken"];
    
    NSMutableData *body = [NSMutableData data];
    
   
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"User_Id\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[User_Id dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"Push_Notification\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[Push_Notification dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    
    [request setHTTPBody:body];
    
    NSURLResponse *resp;
    NSError *err;
    
    NSData *returnData = [self sendSynchronousRequest:request returningResponse:&resp error:&err];
    NSString *strjson=[[NSString alloc]initWithData:returnData encoding: NSUTF8StringEncoding];
    //NSLog(@"%@",strjson);
    SBJSON *jsonobject=[[SBJSON alloc]init];
    NSDictionary *dictionary = [jsonobject objectWithString:strjson];
    //NSLog(@" %@",dictionary);
    
    NSArray *signupArr=[[NSArray alloc]initWithObjects:dictionary, nil];
    //NSLog(@"signupArr=%@",signupArr);
    return signupArr;
}



@end

