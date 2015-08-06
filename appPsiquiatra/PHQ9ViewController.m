//
//  PHQ9ViewController.m
//  appPsiquiatra
//
//  Created by Igloo-Lab(IMac1) on 9/02/15.
//  Copyright (c) 2015 Igloo Lab. All rights reserved.
//

#import "PHQ9ViewController.h"
#import <Parse/Parse.h>

@interface PHQ9ViewController (){
    PFObject *paciente;
    NSMutableArray *response;
    int total;
}
@end

@implementation PHQ9ViewController 

bool error;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    total = 0;
    //Array de las preguntas y respuestas
    _phq9 = @[@"¿Poco interés o agrado al hacer cosas?",
              @"¿Se ha sentido triste, deprimido(a) o sin esperanzas?",
              @"¿Ha tenido dificultad para quedarse o permanecer dormido(a), o ha dormido demasiado?",
              @"¿Se ha sentido cansado(a) o con poca energía?",
              @"¿Sin apetito o ha comido en exceso?",
              @"¿Se ha sentido mal con usted mismo(a) – o que es un fracaso?",
              @"¿Ha tenido dificultad para concentrarse en ciertas actividades, como leer el periódico o ver la televisión?",
              @"¿Se ha movido o hablado tan lento que otras personas podrían haberlo notado? o lo contrario?",
              @"¿Tiene pensamientos de que estaría mejor muerto(a) o de lastimarse de alguna manera?"];
    _respuestas = @[@"Nunca",@"Varios dias",@"Mas de la mitad de los dias",@"Casi todos los dias"];
    
    // Arrays que manejan los datos y el color de las respuestas del usuario.
    _selectedRequest = [NSMutableArray array];
    _selectedColor = [NSMutableArray array];
    UIColor * newColor = [UIColor colorWithRed:0 green:0.55 blue:1 alpha:1];
    for (int i = 0; i < 9; i++) {
        [_selectedRequest addObject:@"Seleccionar"];
        [_selectedColor addObject:newColor];
    }
    error = NO;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    // Return the number of rows in the section.
    return [_phq9 count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"quiz" forIndexPath:indexPath];
    
    //Añadimos las preguntas la label, en cada celda.
    UILabel *preguntas = (UILabel *)[cell viewWithTag:2];
    preguntas.text = [_phq9 objectAtIndex:indexPath.row];
    NSString * dato= [_selectedRequest objectAtIndex:indexPath.row];
    UILabel *respuestas = (UILabel *)[cell viewWithTag:3];
    respuestas.text = dato;
    respuestas.textColor = [_selectedColor objectAtIndex:indexPath.row];
    cell.imageView.hidden = YES;
    if(![dato isEqual: @"Seleccionar"]){
        cell.imageView.image = [UIImage imageNamed:@"2.png"];
        cell.imageView.hidden = NO;
    }else{
        if (error == YES) {
            respuestas.textColor = [UIColor redColor];
            cell.imageView.image = [UIImage imageNamed:@"x"];
            cell.imageView.hidden = NO;
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        // Creamos la instancia por tag del label respuestas
    UILabel *respuestas = (UILabel *)[cell viewWithTag:3];
    UIImage *imgView = [UIImage imageNamed:@"2.png"];
        //Creamos el action del picker.
    [ActionSheetStringPicker
     showPickerWithTitle:@"Seleccionar"
     rows:_respuestas
     initialSelection:0
     doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
         //NSLog(@"Picker: %@", picker);
         //NSLog(@"Selected Index: %ld", (long)selectedIndex);
         respuestas.text = selectedValue;
         [response addObject:[NSString stringWithFormat:@"%@",selectedValue]];
         total = total + (int)selectedValue;
         [_selectedRequest replaceObjectAtIndex:indexPath.row withObject:selectedValue];
         respuestas.textColor = [UIColor colorWithRed:0.27 green:0.88 blue:0.02 alpha:1];
         [_selectedColor replaceObjectAtIndex:indexPath.row withObject:respuestas.textColor];
         cell.imageView.image = imgView;
         [tableView reloadData];
     }
     cancelBlock:^(ActionSheetStringPicker *picker) {
         //NSLog(@"Block Picker Canceled");
     }
     origin:cell];
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
        dateFormatter.dateFormat = @"HH:mm";
    }
    return dateFormatter;
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

#pragma mark - Button Method

- (IBAction)sendDatasPHQ:(UIButton *)sender {
    BOOL goodData = YES;
    error = NO;
    for (int i =0 ; i<[_selectedRequest count]; i++) {
        //NSLog(@"%@",[_selectedRequest objectAtIndex:i]);
        NSString * select = [_selectedRequest objectAtIndex:i];
        if ([select isEqual: @"Seleccionar"]) {
            goodData = NO;
            error = YES;
            break;
        }
    }
    if (goodData == YES) {
        UIAlertView * alertEfect = [[UIAlertView alloc]
                                    initWithTitle:@"Exito!"
                                    message:@"Se Guardaron los datos Correctamente."
                                    delegate:self
                                    cancelButtonTitle:nil
                                    otherButtonTitles:@"OK", nil];
/*
    Parse - 
 */
        paciente = [self getDataPaciente];
        NSString *preg = @"Pregunta";
        NSNumber *numero = [NSNumber numberWithInt: total];
        PFObject *data = [PFObject objectWithClassName:@"FormularioPHQ"];
        data[@"Paciente_Form"] = paciente;
        for (int i = 0; i < [response count]; i++) {
            data[[preg stringByAppendingFormat:@"%d",i]] = response[i];
        }
        data[@"TotalRespuestas"] = numero;
        [data saveEventually];
            //Mostramos el label.
        [alertEfect show];
    }else{
        UIAlertView * alertEfect = [[UIAlertView alloc]
                                    initWithTitle:@"Error"
                                    message:@"No se enviaron los datos. Por favor, compruebelos."
                                    delegate:nil
                                    cancelButtonTitle:@"OK"
                                    otherButtonTitles:nil];
        
        [alertEfect show];
        [tableQuiz reloadData];
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Picker Methods

@end
