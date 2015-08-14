//
//  MesViewController.m
//  appPsiquiatra
//
//  Created by Igloo-Lab(IMac1) on 23/02/15.
//  Copyright (c) 2015 Igloo Lab. All rights reserved.
//
#import "MesViewController.h"
#import <Parse/Parse.h>
@interface MesViewController (){
    NSMutableArray *objects;
    NSMutableDictionary *eventsByDate;
    PFUser *user;
    NSMutableArray * arrayObj;
        //fecha
    NSString * fech;
    NSString * hour;
}
@end

@implementation MesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        // Do any additional setup after loading the view.
        //Declaracion de variables.
    arrayObj = [NSMutableArray array];
    objects = [NSMutableArray array];
/*
        Parse - LLamando los datos del dia establecido.
*/
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
        //Obtenemos las citas de hoy.
    NSString *key = [[self dateFormatter] stringFromDate:[NSDate date]];
    for (int i =0; i < arrayObj.count; i++) {
            //
        fech = [[self dateFormatter] stringFromDate:arrayObj[i]];
        if ([fech isEqualToString:key]) {
                //
            hour = [[self hourFormatter] stringFromDate:arrayObj[i]];
            NSArray *dates = [NSArray arrayWithObjects:fech, hour, nil];
            [objects insertObject:dates atIndex:0];
        }
    }
        //Declaración del calendario del año.
    self.calendar = [JTCalendar new];
    self.calendar.calendarAppearance.calendar.firstWeekday = 2; // Sunday == 1, Saturday == 7
        //Apariencia del mes.
    self.calendar.calendarAppearance.ratioContentMenu = 2.;
    self.calendar.calendarAppearance.menuMonthTextColor = [UIColor colorWithRed:0.04 green:0.45 blue:1 alpha:1];
    self.calendar.calendarAppearance.menuMonthTextFont = [UIFont fontWithName:@"HelveticaNeue-Medium" size:18.0];
        //Apariencia del dia.
    self.calendar.calendarAppearance.dayCircleColorSelected = [UIColor colorWithRed:0.08 green:0.49 blue:0.98 alpha:1];
    self.calendar.calendarAppearance.dayCircleRatio = 1.1;
    self.calendar.calendarAppearance.dayTextFont = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:16.0];
        //Apariencia del evento
    self.calendar.calendarAppearance.dayDotColor = [UIColor redColor];
    self.calendar.calendarAppearance.dayDotColorOtherMonth = [UIColor colorWithRed:0.08 green:0.49 blue:0.98 alpha:1];
    self.calendar.calendarAppearance.dayDotColorToday = [UIColor greenColor];
        //Datos para cambiar defaults del calendar.
    [self.calendar setMenuMonthsView:self.calendarMenuView];
    [self.calendar setContentView:self.calendarContentView];
        //Creamos eventos.
    [self createEvents];
    [self.calendar setDataSource:self];
    [self.calendar setCurrentDate:[NSDate date]];
        //[datasTableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:NO];
    [self.calendar reloadData]; // Must be call in viewDidAppear
    [datasTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
#ifdef DEBUG
    NSLog(@"Danger: Memory");
#endif
}

#pragma mark Calendar methods

- (BOOL)calendarHaveEvent:(JTCalendar *)calendar date:(NSDate *)date{
    NSString *key = [[self dateFormatter] stringFromDate:date];
        //Verificamos si el evento existe.
    if(eventsByDate[key] && [eventsByDate[key] count] > 0){
        return YES;
    }
    return NO;
}

- (void)calendarDidDateSelected:(JTCalendar *)calendar date:(NSDate *)date{
    [objects removeAllObjects];
        //Verificamos los eventos.
    NSString *key = [[self dateFormatter] stringFromDate:date];
    for (int i =0; i < arrayObj.count; i++) {
        fech = [[self dateFormatter] stringFromDate:arrayObj[i]];
        if ([fech isEqualToString:key]) {
            fech = @"Cita Médica";
            hour = [[self hourFormatter] stringFromDate:arrayObj[i]];
            NSArray *dates = [NSArray arrayWithObjects:fech, hour, nil];
            [objects insertObject:dates atIndex:0];

        }
    }
    [datasTableView reloadData];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
    // Manage rotation
    [self.calendar repositionViews];
}

#pragma mark - Table methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return objects.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [datasTableView dequeueReusableCellWithIdentifier:@"Cell" ];
    // En el label de la celda.
    UILabel *hora = (UILabel *)[tableView viewWithTag:5];
    UILabel *data = (UILabel *)[tableView viewWithTag:6];

    NSString *date = [objects objectAtIndex:indexPath.row][0];
    NSString *hor = [objects objectAtIndex:indexPath.row][1];

    data.text = date;
    hora.text = hor;
    return cell;
}

#pragma mark - Buttons callback

- (IBAction)GoTodayTouch{
        //Borramos la data.
    [objects removeAllObjects];
        //Empezamos a buscar los eventos del dia de hoy.
    NSString *key = [[self dateFormatter] stringFromDate:[NSDate date]];
    for (int i =0; i < arrayObj.count; i++) {
        fech = [[self dateFormatter] stringFromDate:arrayObj[i]];
        if ([fech isEqualToString:key]) {
            hour = [[self hourFormatter] stringFromDate:arrayObj[i]];

            NSArray *dates = [NSArray arrayWithObjects:fech, hour, nil];
            [objects insertObject:dates atIndex:0];
        }
    }
    [self.calendar setCurrentDate:[NSDate date]];
    [datasTableView reloadData];
        //NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        //[datasTableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (NSDateFormatter *)dateFormatter{
    static NSDateFormatter *dateFormatter;
    if(!dateFormatter){
        dateFormatter = [NSDateFormatter new];
        dateFormatter.dateFormat = @"dd-MM-yyyy";
    }
    return dateFormatter;
}

- (NSDateFormatter *)hourFormatter{
    static NSDateFormatter *dateFormatter;
    if(!dateFormatter){
        dateFormatter = [NSDateFormatter new];
        dateFormatter.timeStyle = NSDateFormatterShortStyle;
        dateFormatter.dateFormat = @"HH:mm a";
    }
    return dateFormatter;
}

- (void)createEvents{
    eventsByDate = [NSMutableDictionary new];
    for(int i = 0; i < arrayObj.count; ++i){
        // Use the date as key for eventsByDate
        NSString *key = [[self dateFormatter] stringFromDate:arrayObj[i]];
        if(!eventsByDate[key]){
            eventsByDate[key] = [NSMutableArray new];
        }
        [eventsByDate[key] addObject:arrayObj[i]];
    }
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
