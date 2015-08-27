//
//  DiaViewController.m
//  appPsiquiatra
//
//  Created by Igloo-Lab(IMac1) on 3/02/15.
//  Copyright (c) 2015 Igloo Lab. All rights reserved.
//

#import "DiaViewController.h"
#import <Parse/Parse.h>

@interface DiaViewController (){
    PFUser *user;
    NSMutableArray *objects;
    NSMutableArray *arrayObj;
    NSMutableDictionary *eventsByDate;
    IBOutlet UIActivityIndicatorView *acti;
    NSString * horas;
        //fechas
    NSString *hoy;
    NSString *fech;
    NSString *hour;
}
@end

@implementation DiaViewController 

- (void)viewDidLoad {
    [super viewDidLoad];
        //Declaracion de variables.
    hoy = [[self dateFormatter] stringFromDate:[NSDate date]];
    objects = [[NSMutableArray alloc] init];
    arrayObj = [NSMutableArray array];
    _medicamentos = [NSMutableArray array];
    horas = @"";
/*
     Parse - LLamando los datos del dia establecido.
*/
    PFQuery *query = [PFQuery queryWithClassName:@"Medicamento_Paciente"];
        //Obtenemos al usuario-paciente logueado.
    PFObject *DataPac = [self getDataPaciente];
        //Realizamos la consulta.
    [query whereKey:@"Paciente" equalTo:DataPac];
        //Consulta sincronica (Se evita error).
    NSArray *queryObj = [query findObjects];
    if (!queryObj) {
        NSLog(@"The getFirstObject request failed.");
    } else {
            // The find succeeded.
        for (int i = 0; i < [queryObj count]; i++) {
            [arrayObj addObject:queryObj[i]];
                //
            PFObject *medicamento = queryObj[i][@"Medicamento"];
                //Obtenemos el nombre
            query = [PFQuery queryWithClassName:@"Medicamento"];
                //Realizamos la consulta.
            [query whereKey:@"objectId" equalTo:medicamento.objectId];
                //Consulta sincronica (Se evita error).
            PFObject *med = [query getFirstObject];
            if(med){
                [_medicamentos addObject:med[@"Nombre"]];
            }
        }
    }
        //Obtenemos los medicamentos de hoy.
    NSString *key = [[self dateFormatter] stringFromDate:[NSDate date]];
    for (int i =0; i < arrayObj.count; i++) {
        fech = [[self dateFormatter] stringFromDate:arrayObj[i]];
        if ([fech isEqualToString:key]) {
            hour = [[self hourFormatter] stringFromDate:arrayObj[i]];
            NSArray *dates = [NSArray arrayWithObjects:fech, hour, nil];
            [objects insertObject:dates atIndex:0];
        }
    }
        //Metodo para mostrar el boton de los formularios.
    [self appearButton:1];
        //Parte del calendario del año.
    self.calendar = [JTCalendar new];
    self.calendar.calendarAppearance.isWeekMode = YES;
        //Day style
    self.calendar.calendarAppearance.dayCircleColorToday = [UIColor colorWithRed:0.08 green:0.49 blue:0.98 alpha:1];
    self.calendar.calendarAppearance.dayCircleRatio = 1.1;
    self.calendar.calendarAppearance.dayTextColor = [UIColor colorWithRed:0.08 green:0.45 blue:1 alpha:1];
    self.calendar.calendarAppearance.dayTextColorSelected = [UIColor whiteColor];
        //Datas in View
    [self.calendar setContentView:self.content];
    [self.calendar setCurrentDate:[NSDate date]];
    [self.calendar setDataSource:self];
    [self.calendar reloadData];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.calendar reloadData]; // Must be call in viewDidAppear
#ifdef DEBUG
    NSLog(@"hola");
#endif
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [acti stopAnimating];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark calendar methods

- (BOOL)calendarHaveEvent:(JTCalendar *)calendar date:(NSDate *)date{
    NSString *key = [[self dateFormatter] stringFromDate:date];
        //Verificamos si el evento existe.
    if(eventsByDate[key] && [eventsByDate[key] count] > 0){
        return YES;
    }
    return NO;
}

-(void)calendarDidDateSelected:(JTCalendar *)calendar date:(NSDate *)date{
        //
}

#pragma mark table methods

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    NSString *CellIdentifier;
    UITableViewCell *celda;
    if (tableView == self.tableMedics) {

        CellIdentifier = @"Medic";
            //Inicializamos la celda reutilizando el identificador.
        celda = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            // Create the cell if it could not be dequeued
        if (celda == nil){
            celda = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        UILabel *tituloMedicamento = (UILabel *)[celda viewWithTag:10];
        UILabel *horasMed = (UILabel *)[celda viewWithTag:20];
        if ([_medicamentos count] > 0) {
                //Colocamos los nombres de los medicamentos.
            NSString *name = [NSString stringWithFormat:@"%@",_medicamentos[indexPath.row]];
            tituloMedicamento.text = [name stringByAppendingString:@" ®"];
                /*
                  Parte de las horas.
                 */
            horas = @"";
            NSMutableArray *horasArray = arrayObj[indexPath.row][@"Horas"];
                //Obtenemos el array de horas.
            for (int j = 0; j < [horasArray count]; j++) {
                horas = [horas stringByAppendingString: horasArray[j]];
                if (j + 1 != [horasArray count]) {
                    horas = [horas stringByAppendingString:@"  -  "];
                }
            }
            horasMed.text = horas;
        }else{
            tituloMedicamento.text = @"No hay medicamentos para hoy!";
            horasMed.text = @" ";
        }
    }else{
        CellIdentifier = @"list";
            //Inicializamos la celda reutilizando el identificador.
        celda = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            // Create the cell if it could not be dequeued
        if (celda == nil){
            celda = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        UILabel *titleE = (UILabel *)[celda viewWithTag:6];
        UILabel *efect = (UILabel *)[celda viewWithTag:5];
        titleE.text = @"Efectos Secundarios: ";
        efect.text = @"Vomito, Nauseas";
    }
    celda.backgroundColor = [UIColor clearColor];
    return celda;
}

// Metodo para saber cuantas celdas tendra la tabla.
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    int numbers = 0;
        //Verificamos la tabla que llama al metodo
    if (tableView == self.tableMedics) {
            //Le damos el numero de medicamentos que hay.
        numbers = (int)[_medicamentos count];
    }else{
        numbers = 1;
    }
    return numbers;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES ];
}

#pragma mark - Parse Methods

-(PFObject *) getDataPaciente{
/*
     Parse - Implementamos la busqueda de los datos del paciente.
*/
    PFQuery *query = [PFQuery queryWithClassName:@"Paciente"];
        //Obtenemos al usuario logueado.
    user = [PFUser currentUser];
    [query whereKey:@"NumeroDocumento" equalTo:user[@"NumeroDocumento"]];
        //Consulta sincronica (Se evita error).
    PFObject *object = [query getFirstObject];
    return object;
}

#pragma mark - Tab bar Methods

-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    NSLog(@"Did entro");
    acti.hidden = NO;
    [acti startAnimating];
}

-(void)tabBar:(UITabBar *)tabBar willEndCustomizingItems:(NSArray *)items changed:(BOOL)changed{
    NSLog(@"Will entro");
    acti.hidden = NO;
    [acti startAnimating];
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    NSLog(@"Did CONTROLLER entro");
    acti.hidden = NO;
    [acti startAnimating];
}

#pragma mark - Navigation

- (IBAction)segueValue:(id)sender {
    int numero = 1;
    if (numero == 1) {
        [self performSegueWithIdentifier:@"phq" sender:sender];
    }else{
        [self performSegueWithIdentifier:@"mont" sender:sender];
    }
}

-(void) appearButton:(int)button{
    UIButton * phq = (UIButton *)[self.view viewWithTag:6];
        // Button dependiendo del resultado de la consulta a la BD.
    switch (button) {
        case 1:
            phq.hidden =  NO;
            break;
        case 2:
            phq.hidden = YES;
            break;
    }
}

-(void) SaveState:(int) estado{
    /*
     Parse - Creacion de la llamada. Con relacion entre estado de animo y paciente.
     */
    NSNumber *numero = [NSNumber numberWithInt:estado];

    PFQuery *query = [PFQuery queryWithClassName:@"EstadoAnimo"];
    [query whereKey:@"EstadoAnimo" equalTo:numero];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *number, NSError *error){
        if (!number) {
            NSLog(@"No encontramos el estado");
        }else{
                //Creamos el objeto a donde ira la relacion.
            PFObject *animo = [PFObject objectWithClassName:@"Estado_Paciente"];
            animo[@"EstadoAnimo"] = number;
            animo[@"Paciente"] = [self getDataPaciente];
            animo[@"FechaCreacion"] = [NSDate date];
            [animo saveInBackgroundWithBlock:^(bool saved,NSError *error){
                if (saved) {
                    NSLog(@"Guardado");
                }else{
                    NSLog(@"No Guardo");
                    [animo saveEventually];
                }
            }];
                //Seleccionamos la vista del estado de animo por su Tag.
            UIView *v = [self.view viewWithTag:20];
            v.hidden = YES;
                //La colocamos al frente paraa borrarla.
            [self.view bringSubviewToFront:v];
            [v removeFromSuperview];
        }
    }];
}

- (IBAction)buttonClicked:(id)sender {
    int number = (int)[sender tag];
    [self SaveState:number];
}

- (NSDateFormatter *)dateFormatter{
    static NSDateFormatter *dateFormatter;
    if(!dateFormatter){
        dateFormatter = [NSDateFormatter new];
        dateFormatter.timeZone = [NSTimeZone localTimeZone];
        dateFormatter.dateFormat = @"dd-MM-yyyy";
    }
    return dateFormatter;
}

- (NSDateFormatter *)hourFormatter{
    static NSDateFormatter *dateFormatter;
    if(!dateFormatter){
        dateFormatter = [NSDateFormatter new];
        dateFormatter.timeStyle = NSDateFormatterShortStyle;
        dateFormatter.timeZone = [NSTimeZone localTimeZone];
        dateFormatter.dateFormat = @"HH:mm a";
    }
    return dateFormatter;
}


@end
