//
//  DiaViewController.m
//  appPsiquiatra
//
//  Created by Igloo-Lab(IMac1) on 3/02/15.
//  Copyright (c) 2015 Igloo Lab. All rights reserved.
//

#import "DiaViewController.h"

@interface DiaViewController ()

@end

@implementation DiaViewController 

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //Parte del calendario del año.
    self.calendar = [JTCalendar new];
    self.calendar.calendarAppearance.isWeekMode = YES;
    // Day style
    self.calendar.calendarAppearance.dayCircleColorSelected = [UIColor colorWithRed:0.08 green:0.49 blue:0.98 alpha:1];
    self.calendar.calendarAppearance.dayCircleRatio = 1.1;
    self.calendar.calendarAppearance.dayTextColor =[UIColor colorWithRed:0.08 green:0.45 blue:1 alpha:1];
    //Datas in View
    [self.calendar setContentView:self.content];
    [self.calendar setCurrentDate:[NSDate date]];
    [self.calendar setDataSource:self];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}



#pragma mark calendar methods

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    [self.calendar reloadData]; // Must be call in viewDidAppear
}

- (BOOL)calendarHaveEvent:(JTCalendar *)calendar date:(NSDate *)date{
    return NO;
}

- (void)calendarDidDateSelected:(JTCalendar *)calendar date:(NSDate *)date{
    NSLog(@"%@",date);
}

#pragma mark table methods

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *CellIdentifier = @"list";
    
    //Inicializamos la celda reutilizando el identificador.
    UITableViewCell *celda = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Create the cell if it could not be dequeued
    if (celda == nil){
        celda = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    UILabel *tituloEfecto = (UILabel *)[celda viewWithTag:5];
    
    tituloEfecto.text = @"Efectos Secundarios:";
    
    return celda;
    
}

// Metodo para saber cuantas celdas tendra la tabla.
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES ];
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
