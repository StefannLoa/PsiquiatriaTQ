//
//  EfectosTableViewController.h
//  appPsiquiatra
//
//  Created by Igloo-Lab(IMac1) on 2/02/15.
//  Copyright (c) 2015 Igloo Lab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EfectosSecundatios.h"

@interface EfectosTableViewController : UITableViewController

@property NSMutableArray *arrayEfectos;

@property EfectosSecundatios *efecto;

- (IBAction)addItemToList:(UIBarButtonItem *)sender;

@end
