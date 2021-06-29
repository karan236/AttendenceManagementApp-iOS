//
//  EditAttendenceViewController.m
//  AttendenceManangent
//
//  Created by Karan Ghorai on 28/06/21.
//

#import "EditAttendenceViewController.h"
#import "../../../Models/AttendenceRecordModel/AttendenceRecord+CoreDataClass.h"


@interface EditAttendenceViewController ()
@property (strong, nonatomic) IBOutlet UITextField *studentClassInput;
@property (strong, nonatomic) IBOutlet UIDatePicker *dateInput;
@property (strong, nonatomic) NSArray *studentClasses;
- (IBAction)editAttendenceButtonAction:(id)sender;

@end

@implementation EditAttendenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _studentClasses = @[@"Nursery", @"Kindergarten", @"I", @"II", @"III", @"IV", @"V", @"VI", @"VII", @"VIII", @"IX", @"X", @"XI", @"XII"];
    
    UIPickerView *pickerView = [[UIPickerView alloc] init];
    pickerView.delegate = self;
    pickerView.dataSource = self;
    
    _studentClassInput.inputView = pickerView;
    
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(popEditAttendenceViewController)];
    
    rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    
    [self.view addGestureRecognizer:rightSwipe];
}


- (void)popEditAttendenceViewController {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"editAttendenceSegue"]) {
        _editAttendenceAttendenceViewController = [segue destinationViewController];
        _editAttendenceAttendenceViewController.studentClass = _studentClassInput.text;
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"YYYY/MM/dd"];
        NSString *dateString = [dateFormatter stringFromDate:_dateInput.date];
        _editAttendenceAttendenceViewController.attendenceDate = dateString;
        
    }
}

- (NSInteger)numberOfComponentsInPickerView:(nonnull UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(nonnull UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return _studentClasses.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [_studentClasses objectAtIndex: row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    _studentClassInput.text = [_studentClasses objectAtIndex:row];
    [_studentClassInput resignFirstResponder];
}


- (IBAction)editAttendenceButtonAction:(id)sender {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY/MM/dd"];
    NSString *dateString = [dateFormatter stringFromDate:_dateInput.date];
    _editAttendenceAttendenceViewController.attendenceDate = dateString;
    
    if (_studentClassInput.text.length == 0) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"incomplete" message:@"Choose a class" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okActionButton = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];

        [alert addAction:okActionButton];

        [self presentViewController:alert animated:YES completion:nil];
    }
    else if (![AttendenceRecord doesAttendenceExistsForDate:dateString class:_studentClassInput.text]) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"No data found for given class and date." preferredStyle:UIAlertControllerStyleAlert];

        UIAlertAction *okActionButton = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];

        [alert addAction:okActionButton];

        [self presentViewController:alert animated:YES completion:nil];
        
    }
}
@end
