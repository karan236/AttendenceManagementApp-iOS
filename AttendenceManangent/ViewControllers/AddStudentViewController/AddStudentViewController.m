//
//  AddStudentViewController.m
//  AttendenceManangent
//
//  Created by Karan Ghorai on 24/06/21.
//

#import "AddStudentViewController.h"
#import "../../Models/StudentModel/Students+CoreDataClass.h"


@interface AddStudentViewController ()
@property (strong, nonatomic) IBOutlet UITextField *classInputField;
@property (strong, nonatomic) IBOutlet UITextField *rollNoInputField;
@property (strong, nonatomic) IBOutlet UITextField *nameInputField;
@property (readonly, strong) NSArray *studentClasses;

- (IBAction)addButtonAction:(id)sender;
- (IBAction)resetButtonAction:(id)sender;

@end

@implementation AddStudentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _studentClasses = @[@"Nursery", @"Kindergarten", @"I", @"II", @"III", @"IV", @"V", @"VI", @"VII", @"VIII", @"IX", @"X", @"XI", @"XII"];
    
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(popAddStudentViewController)];
    
    rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer: rightSwipe];
    
    UIPickerView *pickerView = [[UIPickerView alloc] init];
    pickerView.delegate = self;
    pickerView.dataSource = self;
    
    
    _classInputField.inputView = pickerView;
}


-(void)popAddStudentViewController{
    [self.navigationController popViewControllerAnimated:YES];
}


- (NSInteger)numberOfComponentsInPickerView:(nonnull UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(nonnull UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return _studentClasses.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [_studentClasses objectAtIndex: row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    _classInputField.text = [_studentClasses objectAtIndex:row];
    [_classInputField resignFirstResponder];
}
- (IBAction)resetButtonAction:(id)sender {
    _classInputField.text = @"";
    _rollNoInputField.text = @"";
    _nameInputField.text = @"";
}

- (IBAction)addButtonAction:(id)sender {
    
    if (_classInputField.text.length == 0 || _rollNoInputField.text.length == 0 || _nameInputField.text.length == 0){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Incomplete" message:@"Please enter all the details." preferredStyle:UIAlertControllerStyleAlert];

        UIAlertAction *okActionButton = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];

        [alert addAction:okActionButton];

        [self presentViewController:alert animated:YES completion:nil];

    }
    else if(![self aretextFieldsInputValid]){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Invalid Input" message:@"Please enter a valid Roll No. or Name" preferredStyle:UIAlertControllerStyleAlert];

        UIAlertAction *okActionButton = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];

        [alert addAction:okActionButton];

        [self presentViewController:alert animated:YES completion:nil];
    }
    else{
        if(![Students addStudentDetailsFromDictionary:@{@"rollNo":_rollNoInputField.text, @"name":_nameInputField.text, @"studentClass": _classInputField.text}]){
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Entered details already exists" preferredStyle:UIAlertControllerStyleAlert];

            UIAlertAction *okActionButton = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];

            [alert addAction:okActionButton];

            [self presentViewController:alert animated:YES completion:nil];
            
        }
        else{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"Student added succesfully!" preferredStyle:UIAlertControllerStyleAlert];

            UIAlertAction *okActionButton = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];

            [alert addAction:okActionButton];
            
            _classInputField.text = @"";
            _rollNoInputField.text = @"";
            _nameInputField.text = @"";
            
            [self presentViewController:alert animated:YES completion:nil];
        }
        
        [Students fetchAllDataFromStudentEntity];
    }

}

-(BOOL)aretextFieldsInputValid{
    NSSet *digitSet = [[NSSet alloc] initWithArray:@[@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9"]];
    
    BOOL isEnteredRollNoValidInteger = YES;
    
    for(int i = 0; i<[_rollNoInputField.text length]; i++){
        if(![digitSet containsObject: [_rollNoInputField.text substringWithRange:NSMakeRange(i, 1)]]){
            isEnteredRollNoValidInteger = NO;
            break;
        }
    }
    
    if(!isEnteredRollNoValidInteger){
        return FALSE;
    }

    BOOL isEnteredNameValid = YES;
    
    for(int i = 0; i<[_nameInputField.text length]; i++){
        if([digitSet containsObject: [_nameInputField.text substringWithRange:NSMakeRange(i, 1)]]){
            isEnteredNameValid = NO;
            break;
        }
    }
    
    if(!isEnteredNameValid){
        return FALSE;
    }
    
    return TRUE;
}
@end
