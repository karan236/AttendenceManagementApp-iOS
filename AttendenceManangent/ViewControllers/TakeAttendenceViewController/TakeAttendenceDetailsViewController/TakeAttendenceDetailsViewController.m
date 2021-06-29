//
//  TakeAttendenceDetailsViewController.m
//  AttendenceManangent
//
//  Created by Karan Ghorai on 25/06/21.
//

#import "TakeAttendenceDetailsViewController.h"
#import "../TakeAttendenceAttendenceViewController/TakeAttendenceAttendenceViewController.h"
#import "AttendenceRecord+CoreDataClass.h"

@interface TakeAttendenceDetailsViewController ()

@property (strong, nonatomic) NSArray *studentClasses;

- (IBAction)createAttendanceSheetButtonAction:(id)sender;

@end

@implementation TakeAttendenceDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    _datePickerInput.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:10*60*60];
    
    _studentClasses = @[@"Nursery", @"Kindergarten", @"I", @"II", @"III", @"IV", @"V", @"VI", @"VII", @"VIII", @"IX", @"X", @"XI", @"XII"];
    
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(popTakeAttendenceDetailsViewController)];
    
    rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer: rightSwipe];
    
    UIPickerView *pickerView = [[UIPickerView alloc] init];
    pickerView.delegate = self;
    pickerView.dataSource = self;
    
    _studentClassInputField.inputView = pickerView;
}

- (void)popTakeAttendenceDetailsViewController {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
   if ([[segue identifier] isEqualToString:@"AttendenceSheetSegue"]) {
       
       _takeAttendenceAttendenceViewController = [segue destinationViewController];
       _takeAttendenceAttendenceViewController.studentClass = _studentClassInputField.text;
       _takeAttendenceAttendenceViewController.topicTaught = _topicInputField.text;
       
       NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
       [dateFormatter setDateFormat:@"YYYY/MM/dd"];
       NSString *dateString = [dateFormatter stringFromDate:_datePickerInput.date];
       
       _takeAttendenceAttendenceViewController.attendenceDate = dateString;

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
    _studentClassInputField.text = [_studentClasses objectAtIndex:row];
    [_studentClassInputField resignFirstResponder];
}


- (IBAction)createAttendanceSheetButtonAction:(id)sender {
    
//    Important For date formatting.
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY/MM/dd"];
    NSString *dateString = [dateFormatter stringFromDate:_datePickerInput.date];
    
//    NSLog(@"Date is: %@", dateString);
    
    if (_studentClassInputField.text.length == 0 || _topicInputField.text.length == 0) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Incomplete" message:@"Please enter all the details." preferredStyle:UIAlertControllerStyleAlert];

        UIAlertAction *okActionButton = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];

        [alert addAction:okActionButton];

        [self presentViewController:alert animated:YES completion:nil];
        
    }
    else if ([AttendenceRecord doesAttendenceExistsForDate:dateString class:_studentClassInputField.text]) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"Attendence already exists for given class and date." preferredStyle:UIAlertControllerStyleAlert];

        UIAlertAction *okActionButton = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];

        [alert addAction:okActionButton];

        [self presentViewController:alert animated:YES completion:nil];
    }
}

@end
