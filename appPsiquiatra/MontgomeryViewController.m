//
//  MontgomeryViewController.m
//  appPsiquiatra
//
//  Created by Igloo-Lab(IMac1) on 18/03/15.
//  Copyright (c) 2015 Igloo Lab. All rights reserved.
//

#import "MontgomeryViewController.h"

@implementation MontgomeryViewController

bool error;

- (void)viewDidLoad {
    [super viewDidLoad];
        // Do any additional setup after loading the view.
        //Array de las preguntas y respuestas
    _montg = @[@"¿Poco interés o agrado al hacer cosas?",
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
        //_selectedImage = [NSMutableArray array];

    UIColor * newColor = [UIColor colorWithRed:0 green:0.55 blue:1 alpha:1];
    for (int i = 0; i < 9; i++) {
        [_selectedRequest addObject:@"Seleccionar"];
        [_selectedColor addObject:newColor];
            //[_selectedImage addObject:@""];
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
    return [_montg count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"questi" forIndexPath:indexPath];

        //Añadimos las preguntas la label, en cada celda.
    UILabel *preguntas = (UILabel *)[cell viewWithTag:2];
    preguntas.text = [_montg objectAtIndex:indexPath.row];

    UILabel *respuestas = (UILabel *)[cell viewWithTag:3];
    NSString * dato= [_selectedRequest objectAtIndex:indexPath.row];
    respuestas.text = dato;

    respuestas.textColor = [_selectedColor objectAtIndex:indexPath.row];

    cell.imageView.hidden = YES;

    if(![dato isEqual: @"Seleccionar"]){

        cell.imageView.image = [UIImage imageNamed:@"2.png"];
        cell.imageView.hidden = NO;
    }else{
        if (error == YES) {

            respuestas.textColor = [UIColor redColor];
            cell.imageView.image = [UIImage imageNamed:@"x.png"];
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
             //NSLog(@"Selected Value: %@", selectedValue);

         respuestas.text = selectedValue;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
