//
//  AlertViewController.m
//  appPsiquiatra
//
//  Created by Igloo-Lab(IMac1) on 23/02/15.
//  Copyright (c) 2015 Igloo Lab. All rights reserved.
//

#import "AlertViewController.h"

@implementation AlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    UIAlertView * alertCall = [[UIAlertView alloc]
                               initWithTitle:@"Red de Apoyo"
                               message:nil
                               delegate:self
                               cancelButtonTitle:@"Cancelar"
                               otherButtonTitles:@"Llamar", nil];
    [alertCall show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
        // the user clicked OK
    if (buttonIndex == 1) {
        // do something here...
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:3128949279"]];
    }else{
        self.tabBarController.selectedIndex = 0;
    }
}
@end
