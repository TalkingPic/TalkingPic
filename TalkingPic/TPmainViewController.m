//
//  TPmainViewController.m
//  TalkingPic
//
//  Created by Howard Huang on 12-10-27.
//  Copyright (c) 2012年 Howard Huang. All rights reserved.
//

#import "TPmainViewController.h"
#import "TPfacebookAuthenticationViewController.h"
#import <Parse/Parse.h>

@interface TPmainViewController ()

@end

@implementation TPmainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didClickFacebook:(id)sender {
    // The permissions requested from the user
    NSArray *permissionsArray = @[ @"user_about_me", @"user_relationships", @"user_birthday", @"user_location"];
    
    // Login PFUser using Facebook
    [PFFacebookUtils logInWithPermissions:permissionsArray block:^(PFUser *user, NSError *error) {
        
        if (!user) {
            if (!error) {
                NSLog(@"Uh oh. The user cancelled the Facebook login.");
            } else {
                NSLog(@"Uh oh. An error occurred: %@", error);
            }
        } else if (user.isNew) {
            NSLog(@"User with facebook signed up and logged in!");
               } else {
            NSLog(@"User with facebook logged in!");
#warning this is just for testing purpose
                   // ...
                   // Create request for user's Facebook data
                   NSString *requestPath = @"me/?fields=name,location,gender,birthday,relationship_status";
                   
                   // Send request to Facebook
                   PF_FBRequest *request = [PF_FBRequest requestForGraphPath:requestPath];
                   [request startWithCompletionHandler:^(PF_FBRequestConnection *connection, id result, NSError *error) {
                       if (!error) {
                           NSDictionary *userData = (NSDictionary *)result; // The result is a dictionary
                           
                           NSString *facebookId = userData[@"id"];
                           NSLog(@"%@\n",facebookId);
                           NSString *name = userData[@"name"];
                           NSLog(@"%@\n",name);
                           NSString *location = userData[@"location"][@"name"];
                           NSLog(@"%@\n",location);
                           NSString *gender = userData[@"gender"];
                           NSLog(@"%@\n",gender);
                           NSString *birthday = userData[@"birthday"];
                           NSLog(@"%@\n",birthday);
                           NSString *relationship = userData[@"relationship_status"];
                           NSLog(@"%@\n",relationship);
                           
                           // Now add the data to the UI elements
                           // ...
                       }
                   }];
        }
    }];
}
@end
