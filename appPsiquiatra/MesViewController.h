//
//  MesViewController.h
//  appPsiquiatra
//
//  Created by Igloo-Lab(IMac1) on 23/02/15.
//  Copyright (c) 2015 Igloo Lab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JTCalendar.h>

@interface MesViewController : UIViewController <JTCalendarDataSource, UITableViewDelegate, UITableViewDataSource>{

    IBOutlet UITableView *datasTableView;
}

@property (weak, nonatomic) IBOutlet JTCalendarMenuView *calendarMenuView;
@property (weak, nonatomic) IBOutlet JTCalendarContentView *calendarContentView;
@property (strong, nonatomic) JTCalendar *calendar;

@end
