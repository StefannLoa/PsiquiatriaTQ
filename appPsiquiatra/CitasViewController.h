//
//  CitasViewController.h
//  appPsiquiatra
//
//  Created by Igloo-Lab(IMac1) on 23/02/15.
//  Copyright (c) 2015 Igloo Lab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JTCalendar.h>
#import "Quotes.h"

@interface CitasViewController : UIViewController<JTCalendarDataSource, UITableViewDelegate, UITableViewDataSource> {
    
    IBOutlet UITableView *quoteDatas;
}
    // Objetos del calendario.
@property (weak, nonatomic) IBOutlet JTCalendarMenuView *calendarMenuView;
@property (weak, nonatomic) IBOutlet JTCalendarContentView *calendarContentView;
@property (strong, nonatomic) JTCalendar *calendar;
    // Otros objetos.
@property Quotes *quote;
@property (strong, nonatomic) NSMutableArray *objects;

@end
