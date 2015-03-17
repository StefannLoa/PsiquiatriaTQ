//
//  PHQ9ViewController.m
//  appPsiquiatra
//
//  Created by Igloo-Lab(IMac1) on 9/02/15.
//  Copyright (c) 2015 Igloo Lab. All rights reserved.
//

#import "PHQ9ViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface PHQ9ViewController ()

@end

@implementation PHQ9ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //Array de las preguntas y respuestas
    _phq9 = [[NSArray alloc] init];
    
    _respuestas = [[NSArray alloc] init];
    
    _phq9 = @[@"Poco interés o agrado al hacer cosas.",
              @"Se ha sentido triste, deprimido(a) o sin esperanzas.",
              @"Ha tenido dormir, mantenerse despierto, o desesperado.",
              @"Se ha sentido cansado(a) o con poca energía.",
              @"Sin apetito o ha comido en exceso.",
              @"Se ha sentido mal con usted mismo(a) – o que es un fracaso o que ha quedado mal con usted mismo(a) o con su familia.",
              @"Ha tenido dificultad para concentrarse en ciertas actividades, tales como leer el periódico o ver la televisión",
              @"¿Se ha movido o hablado tan lento que otras personas podrían haberlo notado? o lo contrario – muy inquieto(a) o agitado(a) que ha estado moviéndose mucho más de lo normal",
              @"Pensamientos de que estaría mejor muerto(a) o de lastimarse de alguna manera"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *CellIdentifier = @"quiz";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    // Create the cell if it could not be dequeued
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    UIButton *newButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    newButton.frame = CGRectMake(220.0f, 5.0f, 75.0f, 30.0f);
    [newButton setTitle:@"hola" forState:UIControlStateNormal];
    newButton.tag = 50;
    [cell addSubview:newButton];

    // add friend button
    UIButton *addFriendButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    addFriendButton.frame = CGRectMake(110.0f, 5.0f, 75.0f, 30.0f);
    [addFriendButton setTitle:@"Add" forState:UIControlStateNormal];
    addFriendButton.tag = indexPath.row;
    [cell addSubview:addFriendButton];
    [addFriendButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    
    [addFriendButton addTarget:self action:@selector(selectButtonResultPHQ:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    // Return the number of rows in the section.
    return 9;//[_phq9 count];
}

-(void)selectButtonResultPHQ:(id)sender{
    
    UIButton *data = (UIButton *)sender;
    NSLog(@"%ld",(long)data.tag);
    
    // Cambia el color de  l boton que se undio.
    if(data.layer.borderWidth == 0){
        
        [data setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [[data layer] setBorderWidth:1.5f];
        [[data layer] setBorderColor:[UIColor blueColor].CGColor];
        data.layer.cornerRadius = 11.0;
        
    }else{
        
        [[data layer] setBorderWidth:0];
        [data setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }
    
    //[tableQuiz reloadData];
}

- (IBAction)sendDatasPHQ:(UIButton *)sender {
    
    UIAlertView * alertEfect = [[UIAlertView alloc]
                                initWithTitle:@"Envio"
                                message:@"Se envio: "
                                delegate:self
                                cancelButtonTitle:@"OK"
                                otherButtonTitles:nil];
    
    [alertEfect show];
    
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    
    [self.navigationController popViewControllerAnimated:YES];
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