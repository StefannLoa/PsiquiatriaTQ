//
//  ProfileViewController.h
//  appPsiquiatra
//
//  Created by Igloo-Lab(IMac1) on 5/02/15.
//  Copyright (c) 2015 Igloo Lab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>{

    IBOutlet UITableView *tableUserDatas;
}

- (IBAction)endsessionAction:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UIImageView *image;
@property (strong, nonatomic) NSArray *datas;

@end
