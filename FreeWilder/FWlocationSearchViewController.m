//
//  FWlocationSearchViewController.m
//  FreeWilder
//
//  Created by esolz1 on 18/02/16.
//  Copyright © 2016 Esolz Tech. All rights reserved.
//

#import "FWlocationSearchViewController.h"
#import "searchCell.h"
#import "AppDelegate.h"

@interface FWlocationSearchViewController ()

{

    NSMutableDictionary *data;
    NSMutableArray *Arraytable;
    searchCell *searchCell;
    float keyBoardHeight;
    AppDelegate *app;
    NSArray *choosenLocationData;
    
}


@end

@implementation FWlocationSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    app=[[UIApplication sharedApplication]delegate];
    
    data=[[NSMutableDictionary alloc]init];
    Arraytable=[[NSMutableArray alloc]init];
    [_locationTextBox becomeFirstResponder];
    _locationTextBox.delegate=self;
    choosenLocationData=[[NSArray alloc]init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyBoardWillShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
}

-(void)viewWillAppear:(BOOL)animated
{

    [super viewWillAppear:animated];
      self.automaticallyAdjustsScrollViewInsets=NO ;

}

#pragma mark-Location Search text field methods

- (void)keyBoardWillShow:(NSNotification*)notification
{
    NSDictionary* keyboardInfo = [notification userInfo];
    NSValue* keyboardFrameBegin = [keyboardInfo valueForKey:UIKeyboardFrameBeginUserInfoKey];
    CGRect keyboardFrameBeginRect = [keyboardFrameBegin CGRectValue];
    
    keyBoardHeight=keyboardFrameBeginRect.size.height;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    
    if(textField==_locationTextBox)
    {
        [_locationTextBox addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
 
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{

    [textField resignFirstResponder];
    return YES;

}

-(void)textFieldDidChange:(UITextField *)thetextfield
{
    
    
    if (_locationTextBox.text.length==0)
    {
        _locationTable.hidden=YES;
    }
    
    
    
    
    
    else
    {
        
        
        
        // Main thread work (UI usually)
        
        
     //   NSString *urlll =[NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/autocomplete/json?region=GB&key=AIzaSyA9CuugBNIOxYTO_GVn0fTEUaPzM03jvNo&input=%@",[_locationTextBox text]];
        
        NSString *urlString=[NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/geocode/json?address=%@&key=AIzaSyAsdkm0gt7PAsMO7uUFH-BnYOwclf0KsZI",[_locationTextBox text]];
        
     //   NSLog(@"url----->>>> %@",urlll);
        
        
        NSString* encodedUrl = [urlString stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
        
        
        
        NSURL *url = [NSURL URLWithString:encodedUrl];
        
        
        //--------------- GET Method-----------  //
        
        NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate:self delegateQueue: [NSOperationQueue mainQueue]];
        
        
        
        NSURLSessionDataTask * dataTask = [defaultSession dataTaskWithURL:url
                                                        completionHandler:^(NSData *data1, NSURLResponse *response, NSError *error) {
                                                            if(error == nil)
                                                            {
                                                                NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data1 options:kNilOptions error:&error];
                                                                
                                                                NSLog(@"RETURN DATA------> %@",dictionary);
                                                                
                                                                
                                                                if ([[dictionary valueForKey:@"status"] isEqualToString:@"OK"])
                                                                {
                                                                    
                                                                    
                                                                    
                                                                    data = [dictionary mutableCopy];
                                                                    choosenLocationData=[data valueForKey:@"results"];
                                                                    
                                                                    NSLog(@"data %@",data);
                                                                    
                                                                    Arraytable=[data valueForKey:@"results"];
                                                                    
                                                                    Arraytable = [Arraytable valueForKey:@"formatted_address"];
                                                                    
                                                                   _locationTable.frame=CGRectMake(_locationTable.frame.origin.x, _locationTableTopSeperator.frame.origin.y+_locationTableTopSeperator.frame.size.height+1, _locationTable.frame.size.width, Arraytable.count*40.0);
                                                                    
//                                                                    _locationTable.frame=CGRectMake(_locationTable.frame.origin.x,_locationTable.frame.origin.y, _locationTable.frame.size.width, self.view.bounds.size.height-(_locationTableTopSeperator.frame.origin.y+_locationTableTopSeperator.frame.size.height+1));
                                                                    
                                                                    if(_locationTable.frame.size.height>self.view.bounds.size.height-(_locationTableTopSeperator.frame.origin.y+_locationTableTopSeperator.frame.size.height+1))
                                                                    {
                                                                    
                                                                     
                                                                       _locationTable.frame=CGRectMake(_locationTable.frame.origin.x, _locationTableTopSeperator.frame.origin.y+_locationTableTopSeperator.frame.size.height+1, _locationTable.frame.size.width, self.view.bounds.size.height-(_locationTableTopSeperator.frame.origin.y+_locationTableTopSeperator.frame.size.height+1));
                                                                    
                                                                    }
                                                                    
                                                //self.view.bounds.size.height-(_locationTableTopSeperator.frame.origin.y+_locationTableTopSeperator.frame.size.height+1)
                                                                    
                                                                    _locationTable.hidden=NO;
                                                                    
                                                                    
                                                                   // NSLog(@"ARRA ====%@",Arraytable);
                                                                    
                                                                    
                                                                    [_locationTable reloadData];
                                                                    
                                                                    
                                                                    
                                                                }
                                                                
                                                                else if ([[dictionary valueForKey:@"status"] isEqualToString:@"ZERO_RESULTS"])
                                                                {
                                                                   
                                                                }
                                                                
                                                                
                                                                
                                                                
                                                                else
                                                                {
                                                                    UIAlertView *alart = [[UIAlertView alloc]initWithTitle:[data valueForKey:@"status"] message:@"Invalid Search." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                                                                    [alart show];
                                                                   
                                                                    
                                                                }
                                                                
                                                            }
                                                            
                                                        }];
        
        [dataTask resume];
        
        
        
    }
}

#pragma mark-Location Table delegates implementation

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    return  0;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [Arraytable count];
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{

    return nil;

}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    searchCell *cell1=(searchCell *)[tableView dequeueReusableCellWithIdentifier:@"location"];
    
    
    
    cell1.locationName.text = [Arraytable objectAtIndex:indexPath.row];
    
    
    
    return cell1;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    NSString *locationAddress=[Arraytable objectAtIndex:indexPath.row];
    
    app.locationData=locationAddress;
    app.location_lat=[[[[choosenLocationData objectAtIndex:indexPath.row] valueForKey:@"geometry"] valueForKey:@"location"] valueForKey:@"lat"];
    app.location_long=[[[[choosenLocationData objectAtIndex:indexPath.row] valueForKey:@"geometry"] valueForKey:@"location"] valueForKey:@"lng"];
    app.ne_lat=[[[[[choosenLocationData objectAtIndex:indexPath.row] valueForKey:@"geometry"] valueForKey:@"bounds"] valueForKey:@"northeast"] valueForKey:@"lat"];
    app.ne_long=[[[[[choosenLocationData objectAtIndex:indexPath.row] valueForKey:@"geometry"] valueForKey:@"bounds"] valueForKey:@"northeast"] valueForKey:@"lng"];
    app.sw_lat=[[[[[choosenLocationData objectAtIndex:indexPath.row] valueForKey:@"geometry"] valueForKey:@"bounds"] valueForKey:@"southwest"] valueForKey:@"lat"];
    app.sw_long=[[[[[choosenLocationData objectAtIndex:indexPath.row] valueForKey:@"geometry"] valueForKey:@"bounds"] valueForKey:@"southwest"] valueForKey:@"lng"];
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"LocationNotification"
     object:self];

    
    [self dismissViewControllerAnimated:YES completion:^{
        
        // Do something after completion...
        
    }];

}

#pragma mark-cancel button action

- (IBAction)cancelBtnTapped:(id)sender
{
    
    
    [self dismissViewControllerAnimated:YES completion:^{
        
        // Do something after completion...
        
    }];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
