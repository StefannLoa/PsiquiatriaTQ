//
//  ProfileViewController.m
//  appPsiquiatra
//
//  Created by Igloo-Lab(IMac1) on 5/02/15.
//  Copyright (c) 2015 Igloo Lab. All rights reserved.
//

#import "ProfileViewController.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    self.image.layer.cornerRadius = self.image.frame.size.width / 2;
    self.image.clipsToBounds = YES;
    self.image.layer.borderWidth = 0.8f;
    self.image.layer.borderColor = [UIColor colorWithRed:0.04 green:0.45 blue:1 alpha:1].CGColor;
    _datas = [NSArray arrayWithObjects:@"Nombre",@"Apellido",@"Edad",@"Telefono",@"Peso",@"Altura", nil];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _datas.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    //colocamos los datos personales.
    UILabel *names = (UILabel *)[cell viewWithTag:1];
    names.text = _datas[indexPath.row];
    
    // Y añadimos la etiqueta al contenido de la vista.
    return cell;
}

#pragma mark - Sessions methods

- (IBAction)endsessionAction:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end