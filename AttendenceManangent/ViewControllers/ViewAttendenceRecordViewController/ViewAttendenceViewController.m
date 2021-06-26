//
//  ViewAttendenceViewController.m
//  AttendenceManangent
//
//  Created by Karan Ghorai on 25/06/21.
//

#import "ViewAttendenceViewController.h"
#import "../../Models/AttendenceRecordModel/AttendenceRecord+CoreDataClass.h"

@interface ViewAttendenceViewController ()
@property (strong, nonatomic) IBOutlet UITextField *classInputField;
@property (strong, nonatomic) IBOutlet UIDatePicker *dateInput;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *studentClasses;
@property (strong, nonatomic) IBOutlet UILabel *dataFoundStatusLabel;
@property (strong, nonatomic) NSArray *fetchedRecord;

@end

@implementation ViewAttendenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _studentClasses = @[@"Nursery", @"Kindergarten", @"I", @"II", @"III", @"IV", @"V", @"VI", @"VII", @"VIII", @"IX", @"X", @"XI", @"XII"];
    
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(popViewAttendenceViewController)];
    rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:rightSwipe];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    UIPickerView *pickerView = [[UIPickerView alloc] init];
    pickerView.delegate = self;
    pickerView.dataSource = self;
    
    _classInputField.inputView = pickerView;
    
    _dataFoundStatusLabel.text = @"";
}

- (void)popViewAttendenceViewController{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)doneButtonAction:(id)sender {
    
    if (_classInputField.text.length == 0){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Incomplete" message:@"Please choose Student's Class." preferredStyle:UIAlertControllerStyleAlert];

        UIAlertAction *okActionButton = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];

        [alert addAction:okActionButton];

        [self presentViewController:alert animated:YES completion:nil];
    }
    else{
        NSString *chosenDate = [NSString stringWithFormat:@"%@", [_dateInput date]];
        _fetchedRecord = [AttendenceRecord fetchAttendenceRecordForClass:_classInputField.text date:[chosenDate substringToIndex:10]];
        
        if(_fetchedRecord.count == 0){
            _dataFoundStatusLabel.text = @"No data found.";
        }
        else{
            _dataFoundStatusLabel.text = @"";
        }
        [_tableView reloadData];
        
    }
}

-(NSInteger)numberOfComponentsInPickerView:(nonnull UIPickerView *)pickerView {
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_fetchedRecord count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AttendenceRecordCell"];
    
    UILabel *rollNoLabel = [cell viewWithTag:1];
    UILabel *nameLabel = [cell viewWithTag:2];
    UILabel *topicLabel = [cell viewWithTag:3];
    UILabel *attendenceLabel = [cell viewWithTag:4];
    
    AttendenceRecord *currentStudentRecord = [_fetchedRecord objectAtIndex:indexPath.row];
    
    rollNoLabel.text = [NSString stringWithFormat:@"%lli",currentStudentRecord.rollNo];
    nameLabel.text = currentStudentRecord.name;
    topicLabel.text = currentStudentRecord.topicTaught;
    attendenceLabel.text = currentStudentRecord.attendence;
    
    if ([currentStudentRecord.attendence isEqualToString:@"Absent"]){
        attendenceLabel.textColor = [UIColor redColor];
    }
    else{
        attendenceLabel.textColor = [UIColor orangeColor];
    }
    
    return cell;
}


@end
