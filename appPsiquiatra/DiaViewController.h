//
//  DiaViewController.h
//  appPsiquiatra
//
//  Created by Igloo-Lab(IMac1) on 3/02/15.
//  Copyright (c) 2015 Igloo Lab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JTCalendar.h>

@interface DiaViewController : UIViewController <JTCalendarDataSource ,UITableViewDelegate, UITableViewDataSource, UITabBarDelegate, UITabBarControllerDelegate>{

    IBOutlet UITableView *tableEfects;
}

@property NSMutableArray *medicamentos;
@property JTCalendar *calendar;

@property (strong, nonatomic) IBOutlet UITableView *tableMedics;
@property (strong, nonatomic) IBOutlet JTCalendarContentView *content;


- (IBAction)segueValue:(id)sender;


@end

