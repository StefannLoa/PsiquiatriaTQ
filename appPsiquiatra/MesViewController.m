//
//  MesViewController.m
//  appPsiquiatra
//
//  Created by Igloo-Lab(IMac1) on 23/02/15.
//  Copyright (c) 2015 Igloo Lab. All rights reserved.
//

#import "MesViewController.h"

@interface MesViewController (){
    
    NSMutableDictionary *eventsByDate;
}

@end

@implementation MesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //Parte del calendario del año.
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
    
    [self createRandomEvents];
    [self.calendar setDataSource:self];
    
    [self.calendar setCurrentDate:[NSDate date]];
    //recargamos la tabla de los dias.
    _objects = [[NSMutableArray alloc] init];

    NSDate *date = [[NSDate alloc]init];

    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd-MM-yyyy"];

    NSString *fech = [dateFormat stringFromDate:date];
    [_objects insertObject:fech atIndex:0];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Calendar methods

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    [self.calendar reloadData]; // Must be call in viewDidAppear
}

- (BOOL)calendarHaveEvent:(JTCalendar *)calendar date:(NSDate *)date{
    
    NSString *key = [[self dateFormatter] stringFromDate:date];
    if(eventsByDate[key] && [eventsByDate[key] count] > 0){
        return YES;
    }
    
    return NO;
}

- (void)calendarDidDateSelected:(JTCalendar *)calendar date:(NSDate *)date{
    
    NSString *fecha = @"Fecha: ";
    
    //Formateamos la fecha para obtener el dia.
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd-MM-yyyy"];
    
    //Agregamos el dia en string al string anterior.
    fecha = [fecha stringByAppendingString:[dateFormat stringFromDate:date]];
    
    //Verificamos los eventos.
    NSString *key = [[self dateFormatter] stringFromDate:date];
    NSArray *events = eventsByDate[key];
    
    //Agregamos la cuenta de eventos.
    fecha = [fecha stringByAppendingFormat:@" - %ld eventos.",(unsigned long)[events count]];
    
    //Agregamos la fecha al array de objetos de la lista.
    [_objects insertObject:fecha atIndex:0];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [datasTableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
    // Manage rotation
    [self.calendar repositionViews];
}

#pragma mark - Table methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _objects.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [datasTableView dequeueReusableCellWithIdentifier:@"Cell" ];
    
    // En el label de la celda se .
    cell.textLabel.text = _objects[indexPath.row];
    
    // Y añadimos la etiqueta al contenido de la vista.
    return cell;
    
}

#pragma mark - Buttons callback

- (IBAction)GoTodayTouch{

    NSDate *date = [[NSDate alloc]init];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd-MM-yyyy"];
    
    NSString *fech = [dateFormat stringFromDate:date];
    [_objects insertObject:fech atIndex:0];
    
    [self.calendar setCurrentDate:date];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [datasTableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (NSDateFormatter *)dateFormatter
{
    static NSDateFormatter *dateFormatter;
    if(!dateFormatter){
        dateFormatter = [NSDateFormatter new];
        dateFormatter.dateFormat = @"dd-MM-yyyy";
    }
    
    return dateFormatter;
}


- (void)createRandomEvents
{
    eventsByDate = [NSMutableDictionary new];
    
    for(int i = 0; i < 30; ++i){
        // Generate 30 random dates between now and 60 days later
        NSDate *randomDate = [NSDate dateWithTimeInterval:(rand() % (3600 * 24 * 60)) sinceDate:[NSDate date]];
        
        // Use the date as key for eventsByDate
        NSString *key = [[self dateFormatter] stringFromDate:randomDate];
        
        if(!eventsByDate[key]){
            eventsByDate[key] = [NSMutableArray new];
        }
        
        [eventsByDate[key] addObject:randomDate];
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
