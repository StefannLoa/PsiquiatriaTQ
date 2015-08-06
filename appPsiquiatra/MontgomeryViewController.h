//
//  MontgomeryViewController.h
//  appPsiquiatra
//
//  Created by Igloo-Lab(IMac1) on 18/03/15.
//  Copyright (c) 2015 Igloo Lab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActionSheetpicker.h"

@interface MontgomeryViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>{
    
    IBOutlet UITableView *tableQuiz;
}

    //Datas for the table.
@property NSArray * montg;
@property NSArray * respuestas;
@property NSMutableArray * selectedRequest;
@property NSMutableArray * selectedColor;
    //@property NSMutableArray * selectedImage;

- (IBAction)sendDatasPHQ:(UIButton *)sender;

@end