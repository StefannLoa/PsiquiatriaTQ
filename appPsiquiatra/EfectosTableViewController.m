//
//  EfectosTableViewController.m
//  appPsiquiatra
//
//  Created by Igloo-Lab(IMac1) on 2/02/15.
//  Copyright (c) 2015 Igloo Lab. All rights reserved.
//

#import "EfectosTableViewController.h"
#import <Parse/Parse.h>

@interface EfectosTableViewController (){

    PFObject *pac;
    NSMutableArray *objects;
    NSMutableArray *arrayObj;
    NSMutableDictionary *eventsByDate;
    NSString * horas;
        //fechas
    NSString *hoy;
    NSString *fech;
    NSString *hour;
}
@end

@implementation EfectosTableViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    hoy = [[self dateFormatter] stringFromDate:[NSDate date]];
    objects = [NSMutableArray array];
    arrayObj = [NSMutableArray array];
    horas = @"";
/*
     Parse - LLamando los datos de la clase efectos.
*/
    PFQuery *query = [PFQuery queryWithClassName:@"Efectos"];
    [query orderByAscending:@"Sintoma"];
        //Consulta sincronica (Se evita error).
    NSArray *queryObj = [query findObjects];
    if (!queryObj) {
        NSLog(@"The findObjects request failed.");
    } else {
        for (int i = 0; i < [queryObj count]; i++) {
            [arrayObj addObject:queryObj[i][@"Sintoma"]];
        }
        NSLog(@"%@", arrayObj);
    }
}

 //Metodo para agregar datos a una tabla.
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //Inicializamos la celda reutilizando el identificador.
    UITableViewCell *celda = [tableView dequeueReusableCellWithIdentifier:@"efectos"];
    NSString *Efects = arrayObj[indexPath.row];
    //Damos la label, el dato que corresponde a la fila de la lista.
    UILabel *tituloEfecto = (UILabel *)[celda viewWithTag:6];
    tituloEfecto.text = Efects;
    return celda;
}

// Metodo para saber cuantas celdas tendra la tabla.
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [arrayObj count];
}

// Metodo para cuando se selecciona cualquier celda de la tabla.
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
        //Des seleccionamos la celda.
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    UILabel *tituloEfecto = (UILabel *)[cell viewWithTag:6];
    BOOL addElement;
        //Verficamos si tiene elaccesorio para saber si esta guardada o hay que quitarla.
    if (cell.accessoryType == UITableViewCellAccessoryNone) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        addElement = YES;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
        addElement = NO;
    }
    [self VerifyDate:tituloEfecto add:addElement];
}

#pragma mark - Parse Methods

-(PFObject *) getDataPaciente{
/*
        Parse - Implementamos la busqueda de los datos del paciente.
*/
    PFQuery *query = [PFQuery queryWithClassName:@"Paciente"];
        //Obtenemos al usuario logueado.
    PFUser *user = [PFUser currentUser];
    [query whereKey:@"NumeroDocumento" equalTo:user[@"NumeroDocumento"]];
        //Consulta sincronica (Se evita error).
    PFObject *object = [query getFirstObject];
    return object;
}

#pragma mark - Others Methods

- (NSDateFormatter *)dateFormatter{
    static NSDateFormatter *dateFormatter;
    if(!dateFormatter){
        dateFormatter = [NSDateFormatter new];
        dateFormatter.timeZone = [NSTimeZone localTimeZone];
        dateFormatter.dateFormat = @"dd-MM-yyyy";
    }
    return dateFormatter;
}

    // METODO - verifica el dato seleccionado para saber si guardarlo o quitarlo.
-(void)VerifyDate:(UILabel *)nombre add:(BOOL)addElement{
    pac = [self getDataPaciente];
/*
    Parse - Buscamos si existe alguna fila con datos de hoy. Si SI, entonces actualizamos. Si NO, entonces creamos.
*/
        //NSString *date = [[self dateFormatter] stringFromDate:[NSDate date]];
    PFQuery *query = [PFQuery queryWithClassName:@"EfectosSecundarios_Pac"];
    [query whereKey:@"Paciente_Id" equalTo:pac];
    [query orderByDescending:@"createdAt"];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *objectEfect, NSError *error){
            NSLog(@"%@",objectEfect.createdAt);
            NSLog(@"%@",objectEfect[@"Efectos_Secundarios"]);/*
        if (objectEfect == nil || [objectEfect count] == 0) {
            PFObject *efectos = [PFObject objectWithClassName:@"EfectosSecundarios_Pac"];
            efectos[@"Efectos_Secundarios"] = @[[NSString stringWithFormat:@"%@",nombre.text]];
            efectos[@"Paciente_Id"] = pac;
            [efectos save];
#ifdef DEBUG
            NSLog(@"Guardado con exito.");
#endif
        }else{
            for(int i = 0; i < [objectEfect count]; i++){
                PFObject *object = [objectEfect objectAtIndex:i];
                NSString *created = [[self dateFormatter] stringFromDate:object.createdAt];
                NSArray *array = [object objectForKey:@"Efectos_Secundarios"];
                    //Verificamos la fecha de
                if([created isEqualToString:hoy]) {
#ifdef DEBUG
                    NSLog(@"Ibamos a actualizar. Hay estos datos: %@", array);
#endif
                }else{
#ifdef DEBUG
                    NSLog(@"Ibamos a actualizar. Hay estos datos: %@", array);
#endif
                }
            }
        }*/
    }];
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
   /*     //Inicializamos el nuevo objeto.
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
    */
}


@end
