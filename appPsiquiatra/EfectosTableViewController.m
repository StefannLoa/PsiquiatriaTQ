//
//  EfectosTableViewController.m
//  appPsiquiatra
//
//  Created by Igloo-Lab(IMac1) on 2/02/15.
//  Copyright (c) 2015 Igloo Lab. All rights reserved.
//

#import "EfectosTableViewController.h"

@implementation EfectosTableViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //objeto efecto No.1
    _efecto = [[EfectosSecundatios alloc] init];
    _efecto.nombre = @"Vomito";
    _efecto.descripcion = @"El peor de los efectos.";
    
    //array de los efectos
    _arrayEfectos = [[NSMutableArray alloc] init];
    
    // Agregamos el objeto al array.
    [_arrayEfectos addObject:_efecto];
    
}

 //Metodo para agregar datos a una tabla.
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //Inicializamos la celda reutilizando el identificador.
    UITableViewCell *celda = [tableView dequeueReusableCellWithIdentifier:@"efectos"];
    
    _efecto = [_arrayEfectos objectAtIndex:indexPath.row];
    
    //Damos la label, el dato que corresponde a la fila de la lista.
    UILabel *tituloEfecto = (UILabel *)[celda viewWithTag:6];
    
    tituloEfecto.text = _efecto.nombre;
    
    return celda;

}

// Metodo para saber cuantas celdas tendra la tabla.
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return [_arrayEfectos count];
}

// Metodo para cuando se selecciona cualquier celda de la tabla.
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (cell.accessoryType == UITableViewCellAccessoryNone) {
        
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
}

//Metodo para agregar otro dato a la lista.
- (IBAction)addItemToList:(UIBarButtonItem *)sender {
    
    UIAlertView * alertEfect = [[UIAlertView alloc]
                                initWithTitle:@"Agregar un Síntoma"
                                message:@"Ingresa el nombre de tu síntoma"
                                delegate:self
                                cancelButtonTitle:@"Cancelar"
                                otherButtonTitles:nil];
    
    alertEfect.alertViewStyle = UIAlertViewStylePlainTextInput;
    
    [alertEfect addButtonWithTitle:@"Agregar"];
    [alertEfect show];

}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    //Inicializamos el nuevo objeto.
    _efecto = [[EfectosSecundatios alloc] init];
    
    UITextField *username = [alertView textFieldAtIndex:0];
    
    //Veriicamos que boton de la alaerta ha sido oprimido.
    if (buttonIndex == 1){
        
        if(![username.text isEqual: @""] ){
        
            //Agregamos el nuevo objeto al array.
            _efecto.nombre = [username.text capitalizedString];
            _efecto.descripcion = @"111";
        
            [_arrayEfectos addObject:_efecto];
        
            [self.tableView reloadData];
            
        }else{
            
            UIAlertView * alertEfect2 = [[UIAlertView alloc]
                                        initWithTitle:@"Error"
                                        message:@"Debes ingresar un nombre."
                                        delegate:self
                                        cancelButtonTitle:@"Ok!"
                                         otherButtonTitles:nil];
            alertEfect2.tintColor = [UIColor redColor];
            [alertEfect2 setTintColor:[UIColor redColor]];
            [alertEfect2 show];
        }
    }
    
}

@end
