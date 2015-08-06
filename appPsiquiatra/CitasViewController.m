//
//  CitasViewController.m
//  appPsiquiatra
//
//  Created by Igloo-Lab(IMac1) on 23/02/15.
//  Copyright (c) 2015 Igloo Lab. All rights reserved.
//

#import "CitasViewController.h"
#import <Parse/Parse.h>

@interface CitasViewController(){
    NSMutableDictionary *eventsByDate;
    PFUser *user;
    NSMutableArray * arrayObj;

        //fecha
    NSString * fech;
    NSString * hour;
}
@end

@implementation CitasViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
/*
     Parse - LLamando los datos del dia establecido.
*/
        //Declaracion de variables.
    arrayObj = [NSMutableArray array];
    PFQuery *query = [PFQuery queryWithClassName:@"Citas"];
        //Obtenemos al usuario-paciente logueado.
    PFObject *DataPac = [self getDataPaciente];
        //Realizamos la consulta.
    [query whereKey:@"Paciente_Id" equalTo:DataPac];
    [query orderByAscending:@"FechaCita"];
        //Consulta sincronica (Se evita error).
    NSArray *queryObj = [query findObjects];
    if (!queryObj) {
        NSLog(@"The getFirstObject request failed.");
    } else {
            // The find succeeded.
        for (int i = 0; i < [queryObj count]; i++) {
            [arrayObj addObject:queryObj[i][@"FechaCita"]];
        }
    }
    //Inicializamos el calendario.
    self.calendar = [JTCalendar new];
    self.calendar.calendarAppearance.calendar.firstWeekday = 2; // Sunday == 1, Saturday == 7
    //Apariencia del mes.
    self.calendar.calendarAppearance.ratioContentMenu = 2.;
    self.calendar.calendarAppearance.menuMonthTextColor = [UIColor colorWithRed:0.04 green:0.45 blue:1 alpha:1];
    self.calendar.calendarAppearance.menuMonthTextFont = [UIFont fontWithName:@"HelveticaNeue-Medium" size:18.0];
    //Datos para cambiar defaults del calendar.
    [self.calendar setMenuMonthsView:self.calendarMenuView];
    [self.calendar setDataSource:self];
    [self.calendar setContentView:self.calendarContentView];
    //Inicializamos el objeto de las citas y la lista de nuevos objetos.
    _quote = [[Quotes alloc] init];
    _objects = [[NSMutableArray alloc] init];
    /*
        Agregamos al array, la fecha de hoy y sus eventos.
    */
    NSDate *date =[[NSDate alloc] init];
    NSDateFormatter *monthActual = [[NSDateFormatter alloc] init];
    [monthActual setDateFormat:@"M"];
    NSString *month = [monthActual stringFromDate:date];
    [monthActual setDateFormat:@"yyyy"];
    NSString *year = [monthActual stringFromDate:date];
    _quote.day = month;
    _quote.desc = year;
    _quote.hour = @"8:30 pm";
    [_objects insertObject:_quote atIndex:0];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.calendar reloadData]; // Must be call in viewDidAppear
}

// Update the position of calendar when rotate the screen, call `calendarDidLoadPreviousPage` or `calendarDidLoadNextPage`
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [self.calendar repositionViews];
}

- (BOOL)calendarHaveEvent:(JTCalendar *)calendar date:(NSDate *)date{
    return NO;
}
- (void)calendarDidDateSelected:(JTCalendar *)calendar date:(NSDate *)date{
    //[self.calendar setCurrentDate:date];
}

// Manage rotation
- (void)calendarDidLoadPreviousPage
{
    NSLog(@"Previous page loaded ");
}

- (void)calendarDidLoadNextPage
{
    
    NSLog(@"Next page loaded");
}
- (void)calendarDidLoadPreviousPage:(NSDate *)date{
    
    _quote = [[Quotes alloc] init];
    
    NSDateFormatter *monthActual = [[NSDateFormatter alloc] init];
    [monthActual setDateFormat:@"M"];
    NSString *month = [monthActual stringFromDate:date];
    [monthActual setDateFormat:@"yyyy"];
    NSString *year = [monthActual stringFromDate:date];
    
    _quote.day = month;
    _quote.desc = year;
    _quote.hour = @"8:30 pm";
    
    //Agregamos la fecha al array de objetos de la lista.
    [_objects addObject:_quote];
    
    [quoteDatas reloadData];
}

- (void)calendarDidLoadNextPage:(NSDate *)date{
    
    //_quote = [[Quotes alloc] init];
    
    NSDateFormatter *monthActual = [[NSDateFormatter alloc] init];
    [monthActual setDateFormat:@"M"];
    NSString *month = [monthActual stringFromDate:date];
    [monthActual setDateFormat:@"yyyy"];
    NSString *year = [monthActual stringFromDate:date];
    
    _quote.day = month;
    _quote.desc = year;
    _quote.hour = @"8:30 pm";
    
    //Agregamos la fecha al array de objetos de la lista.
    //[_objects addObject:_quote ];
    
    [quoteDatas reloadData];
    
}

#pragma mark Calendar methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [_objects count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [quoteDatas dequeueReusableCellWithIdentifier:@"Datas"];
    
    //incializamos el objeto con sus propiedades.
    _quote = [_objects objectAtIndex:indexPath.row];
    
    //Declaramos los label que seran reemplazados.
    UILabel *day = (UILabel *)[cell viewWithTag:1];
    UILabel *desc = (UILabel *)[cell viewWithTag:10];
    UILabel *hora = (UILabel *)[cell viewWithTag:15];
    
    day.text = _quote.day;
    desc.text = _quote.desc;
    hora.text = _quote.hour;
    
    // Y añadimos la etiqueta al contenido de la vista.
    return cell;
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

@end
