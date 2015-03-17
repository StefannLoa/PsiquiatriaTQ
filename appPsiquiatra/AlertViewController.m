//
//  AlertViewController.m
//  appPsiquiatra
//
//  Created by Igloo-Lab(IMac1) on 23/02/15.
//  Copyright (c) 2015 Igloo Lab. All rights reserved.
//

#import "AlertViewController.h"

@interface AlertViewController ()

@end

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
        NSLog(@"Este es Llamar");
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:3218393267"]];

    }else{
        NSLog(@"Este es cancelar");
        
        //UIViewController *view = [[UIViewController alloc] initWithNibName:@"DiaViewController" bundle:nil];
        
    }
    
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
