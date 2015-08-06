//
//  PHQ9ViewController.h
//  appPsiquiatra
//
//  Created by Igloo-Lab(IMac1) on 9/02/15.
//  Copyright (c) 2015 Igloo Lab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActionSheetpicker.h"

@interface PHQ9ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>{
    
    IBOutlet UITableView *tableQuiz;
}

    //Datas for the table.
@property NSArray * phq9;
@property NSArray * respuestas;
@property NSMutableArray * selectedRequest;
@property NSMutableArray * selectedColor;
    //@property NSMutableArray * selectedImage;

- (IBAction)sendDatasPHQ:(UIButton *)sender;

@end