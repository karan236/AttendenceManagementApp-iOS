//
//  TopicsMissedByStudentsViewController.m
//  AttendenceManangent
//
//  Created by Karan Ghorai on 27/06/21.
//

#import "TopicsMissedByStudentsViewController.h"
#import "../../Models/AttendenceRecordModel/AttendenceRecord+CoreDataClass.h"



@interface TopicsMissedByStudentsViewController ()
@property (strong, nonatomic) IBOutlet UITextField *studentClassInput;
@property (strong, nonatomic) IBOutlet UITextField *rollNoInput;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UILabel *statusLabel;
@property (strong, nonatomic) NSArray *studentClasses;
@property (strong, nonatomic) NSArray *fetchedData;

@end

@implementation TopicsMissedByStudentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(popAttendenceRecordOfAStudentViewController)];
    
    rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    
    [self.view addGestureRecognizer:rightSwipe];
    
    UIPickerView *pickerView = [[UIPickerView alloc] init];
    
    pickerView.delegate = self;
    pickerView.dataSource = self;
    
    _studentClassInput.inputView = pickerView;
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    _studentClasses = @[@"Nursery", @"Kindergarten", @"I", @"II", @"III", @"IV", @"V", @"VI", @"VII", @"VIII", @"IX", @"X", @"XI", @"XII"];
}



- (void)popAttendenceRecordOfAStudentViewController {
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return _studentClasses.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [_studentClasses objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    _studentClassInput.text = [_studentClasses objectAtIndex:row];
    [_studentClassInput resignFirstResponder];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_fetchedData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AttendenceRecordOfAStudentCell"];
    
    UILabel *dateLabel = [cell viewWithTag:1];
    UILabel *topicMissedLabel = [cell viewWithTag:2];
    
    AttendenceRecord *currentStudentRecord = [_fetchedData objectAtIndex:indexPath.row];
    
    dateLabel.text = currentStudentRecord.date;
    topicMissedLabel.text = currentStudentRecord.topicTaught;
    
    return cell;
}


- (IBAction)showRecordActionButton:(id)sender {
    
    _fetchedData = [[NSArray alloc] init];
    
    if (_studentClassInput.text.length == 0 || _rollNoInput.text.length == 0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Incomplete Data" message:@"Please fill both student's class and roll no." preferredStyle:UIAlertControllerStyleAlert];

        UIAlertAction *okActionButton = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];

        [alert addAction:okActionButton];

        [self presentViewController:alert animated:YES completion:nil];
    }
    else {
        _fetchedData = [AttendenceRecord fetchAttendenceRecordForClass:_studentClassInput.text rollNo:_rollNoInput.text attendence:@"Absent"];
        
        if (_fetchedData.count == 0) {
            _statusLabel.text = @"No Missed topics found.";
        }
        else{
            _statusLabel.text = [NSString stringWithFormat:@"Class %@", _studentClassInput.text];
        }
    }
    [_tableView reloadData];
    
}

@end
