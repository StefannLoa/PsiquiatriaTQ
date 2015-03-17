//
//  DiaViewController.h
//  appPsiquiatra
//
//  Created by Igloo-Lab(IMac1) on 3/02/15.
//  Copyright (c) 2015 Igloo Lab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JTCalendar.h>

@interface DiaViewController : UIViewController <JTCalendarDataSource ,UITableViewDelegate, UITableViewDataSource>{
    
    IBOutlet UITableView *tableEfects;
}

//@property (strong, nonatomic) IBOutlet UITableView *tableEfects;

@property (strong, nonatomic) IBOutlet JTCalendarContentView *content;
@property JTCalendar *calendar;

@end

