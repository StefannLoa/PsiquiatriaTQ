//
//  Log_InViewController.m
//  appPsiquiatra
//
//  Created by Igloo-Lab(IMac1) on 10/03/15.
//  Copyright (c) 2015 Igloo Lab. All rights reserved.
//

#import "Log_InViewController.h"
#import <Parse/Parse.h>

@implementation Log_InViewController{

    NSString * mail;
    NSString * passwd;
}

    //Syntetize
@synthesize acti;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [acti startAnimating];
    acti.hidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    [acti stopAnimating];
    /*
        Parse: Verificamos si hay una sesion abierta de un usuario.
     */
    PFUser *user = [PFUser currentUser];
#ifdef DEBUG
    NSLog(@"= %@", user.username);
#endif
    if (user.isDataAvailable) {
            //[PFUser logOut];
        acti.hidden = NO;
        [acti startAnimating];
            //Pasamos a la siguiente vista.
        [self shouldPerformSegueWithIdentifier:@"yes" sender:self];
        [self performSegueWithIdentifier:@"segueLogin" sender:self];
    }
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [acti stopAnimating];
    acti.hidden = YES;
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
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
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

- (IBAction)Login:(id)sender {
    UITextField *mailTextField = (UITextField *)[self.view viewWithTag:5];
    UITextField *passwdTextField = (UITextField *)[self.view viewWithTag:6];
    mail = mailTextField.text;
    passwd = passwdTextField.text;
    if (mail == nil) {
        mail = @"";
    }
    if( passwd == nil){
        passwd = @"";
    }
    /*
        Parse: Logueamos el usuario despues de haber validado los campos.
    */
    if(mail != nil && ![mail isEqual: @""] && passwd != nil && ![passwd  isEqual: @""]) {
        acti.hidden = NO;
        [acti startAnimating];
            //Logueamos con parse y verificamos
        [PFUser logInWithUsernameInBackground:mail password:passwd block:^(PFUser *user, NSError *error) {
            if (user) {
                    // Do stuff after successful login.
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Bienvenido!" message:nil preferredStyle:UIAlertControllerStyleAlert];

                UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Ok!" style:UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction *action){
                                                               mailTextField.text = @"";
                                                               passwdTextField.text = @"";
                                                               [self performSegueWithIdentifier:@"segueLogin" sender:self];
                                                           }];
                [alert addAction:ok];
                    //Presentamos la alerta
                [self presentViewController:alert animated:YES completion:nil];
            } else {
                    // The login failed. Check error to see why.
#ifndef DEBUG
                NSLog(@"Error= %@", error.localizedDescription);
#endif

                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error!" message:@"No hemos podido iniciar la sesión. Por favor prueba otra vez." preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Ok!" style:UIAlertActionStyleDefault handler:nil];
                [alert addAction:ok];
                    //Presentamos la alerta
                [self presentViewController:alert animated:YES completion:nil];
            }
            [acti stopAnimating];
            acti.hidden = YES;
        }];
    }else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Falta!" message:@"No has colocado alguno de los datos. Por favor añadelos." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Ok!" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:ok];
            //Presentamos la alerta
        [self presentViewController:alert animated:YES completion:nil];
    }
}

-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    BOOL result = NO;
    if ([identifier isEqual: @"yes"]) {
        result = YES;
    }
    return result;
}

@end