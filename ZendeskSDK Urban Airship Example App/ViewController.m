/*
 *
 *  ViewController.m
 *  ZendeskSDK Urban Airship Example App
 *
 *  Created by Zendesk on 5/26/15.
 *
 *  Copyright (c) 2015 Zendesk. All rights reserved.
 *
 *  By downloading or using the Zendesk Mobile SDK, You agree to the Zendesk Terms
 *  of Service https://www.zendesk.com/company/terms and Application Developer and API License
 *  Agreement https://www.zendesk.com/company/application-developer-and-api-license-agreement and
 *  acknowledge that such terms govern Your use of and access to the Mobile SDK.
 *
 */

#import "ViewController.h"
#import <ZendeskSDK/ZendeskSDK.h>


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (IBAction)showHelpCenter:(id)sender {
    [ZDKHelpCenter showHelpCenterWithNavController:self.navigationController];
}


- (IBAction)showTicketList:(id)sender {
    [ZDKRequests showRequestListWithNavController:self.navigationController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)registerForPush:(id)sender {
   
    NSString *identifier = [self getDeviceId];
    if ( ! identifier) {
        NSLog(@"No identifier found");
        return;
    }
    
    [[ZDKConfig instance] enablePushWithUAChannelID:identifier callback:^(ZDKPushRegistrationResponse *registrationResponse, NSError *error) {
        
        NSString *title;
        
        if (error) {
            
            title = @"Registration Failed";
            NSLog(@"Couldn't register device: %@. Error: %@", identifier, error);
            
        } else if (registrationResponse) {
            
            title = @"Registration Successful";
            NSLog(@"Successfully registered device with channel ID: %@", identifier);
        }
        
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:title message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }];
}


- (IBAction)unregisterForPush:(id)sender {
    
    NSString *identifier = [self getDeviceId];
    if ( ! identifier) {
        NSLog(@"No identifier found");
        return;
    }
    
    [[ZDKConfig instance] disablePush:identifier callback:^(NSNumber *responseCode, NSError *error) {
        
        NSString *title;
        
        if (error) {
            
            title = @"Failed to Unregister";
            NSLog(@"Couldn't unregister device: %@. Error: %@", identifier, error);
            
        } else if (responseCode) {
            
            title = @"Unregistered";
            NSLog(@"Successfully unregistered device: %@", identifier);
        }
        
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:title message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }];
    
}

- (NSString*) getDeviceId
{
    NSString *result = [[NSUserDefaults standardUserDefaults] objectForKey:APPLE_PUSH_UUID];
    
    return result;
}


@end
