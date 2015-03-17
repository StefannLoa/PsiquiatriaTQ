//
//  FormPHQ9ViewController.m
//  appPsiquiatra
//
//  Created by Igloo-Lab(IMac1) on 3/03/15.
//  Copyright (c) 2015 Igloo Lab. All rights reserved.
//

#import "FormPHQ9ViewController.h"

@interface FormPHQ9ViewController ()

@end

@implementation FormPHQ9ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    int num = (int)indexPath.row;
    UITableViewCell *cell;
    switch (num) {
        case 0:
            cell = self.OneCell;
            
            break;
        case 1:
            cell = self.TwoCell;
            
            break;
    }
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    // Return the number of rows in the section.
    return 9;//[_phq9 count];
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
