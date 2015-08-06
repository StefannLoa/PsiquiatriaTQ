//
//  ProfileViewController.m
//  appPsiquiatra
//
//  Created by Igloo-Lab(IMac1) on 5/02/15.
//  Copyright (c) 2015 Igloo Lab. All rights reserved.
//

#import "ProfileViewController.h"
#import <Parse/Parse.h>

@interface ProfileViewController ()
    @property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activity;
    @property (strong, nonatomic) NSArray *datas;
    @property (strong, nonatomic) NSArray *names;
    @property (strong, nonatomic) NSMutableArray *arrayObj;
    @property PFUser * user;
@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        //Settings Images
    self.image.layer.cornerRadius = self.image.frame.size.width / 2;
    self.image.clipsToBounds = YES;
    self.image.layer.borderWidth = 0.8f;
    self.image.layer.borderColor = [UIColor colorWithRed:0.04 green:0.45 blue:1 alpha:1].CGColor;
    _datas = @[@"Nombre",@"Apellido",@"Edad",@"Telefono",@"Cedula"];
    _arrayObj = [NSMutableArray array];
/*
        Parse - Implementamos la busqueda de los datos del paciente.
 */
    PFQuery *query = [PFQuery queryWithClassName:@"Paciente"];
        //Obtenemos al usuario logueado.
    _user = [PFUser currentUser];
    [query whereKey:@"NumeroDocumento" equalTo:_user[@"NumeroDocumento"]];
        //Consulta sincronica (Se evita error).
    PFObject *object = [query getFirstObject];
    if (!object || !(object.isDataAvailable)) {
        NSLog(@"The getFirstObject request failed.");
    } else {
        NSLog(@"%@",object);
            // The find succeeded.
        for (int i = 0; i < _datas.count; i++) {
            if ([_datas[i] isEqual:@"Cedula"]) {
                [self.arrayObj addObject:[object objectForKey:@"NumeroDocumento"]];
            }else{
                [self.arrayObj addObject:[object objectForKey:_datas[i] ]];
            }
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _datas.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
        //Nueva celda con el identificador de la celda de la vista.
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.backgroundColor = [UIColor clearColor];
        // Configuramos la celda.
    UILabel *datos = (UILabel *)[cell viewWithTag:1];
    datos.text = _datas[indexPath.row];
        // Parse: Añadimos los datos de la DB.
    UILabel *basicos = (UILabel *)[cell viewWithTag:4];
    basicos.text = [NSString stringWithFormat:@"%@", _arrayObj[indexPath.row]];

    return cell;
}

#pragma mark - Sessions methods

- (IBAction)endsessionAction:(UIButton *)sender {
    [_activity startAnimating];
    _activity.hidden = NO;
        // Cerramos sesion con Parse.

    [PFUser logOutInBackgroundWithBlock:^(NSError *error){
        if (!error) {
            _activity.hidden = YES;
            [_activity stopAnimating];
                // Devolvemos la vista.
            [self dismissViewControllerAnimated:YES completion:nil];
        }else{
            NSLog(@"Ha habido un error: %@", error);
        }

    }];
}

-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{

    BOOL validar = YES;

    return validar;
}

@end