//
//  Log_InViewController.m
//  appPsiquiatra
//
//  Created by Igloo-Lab(IMac1) on 10/03/15.
//  Copyright (c) 2015 Igloo Lab. All rights reserved.
//

#import "Log_InViewController.h"

@interface Log_InViewController ()

@end

@implementation Log_InViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

//Table Methods

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

-(UITableViewCell *) tableView:(UITableView*) tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [loginTable dequeueReusableCellWithIdentifier:@"ID"];
    
    if (indexPath.row != 0) {
        
        cell = [loginTable dequeueReusableCellWithIdentifier:@"Passw"];

    }
    
    // MORE CODE.....
    
    
    
    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
