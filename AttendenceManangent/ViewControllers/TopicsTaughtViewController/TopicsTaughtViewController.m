//
//  TopicsTaughtViewController.m
//  AttendenceManangent
//
//  Created by Karan Ghorai on 26/06/21.
//

#import "TopicsTaughtViewController.h"
#import "../../Models/AttendenceRecordModel/AttendenceRecord+CoreDataClass.h"

@interface TopicsTaughtViewController ()
@property (strong, nonatomic) IBOutlet UITextField *studentClassInput;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *studentClasses;
@property (strong, nonatomic) IBOutlet UILabel *statusLabel;
@property (strong, nonatomic) NSArray *fetchedData;
@property (strong, nonatomic) NSMutableDictionary *topicsToughtData;
@property (strong, nonatomic) NSMutableArray *fetchedDates;
@end

@implementation TopicsTaughtViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(popTopicsTaughtViewController)];
    rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:rightSwipe];
    
    UIPickerView *pickerView = [[UIPickerView alloc] init];
    pickerView.delegate = self;
    pickerView.dataSource = self;
    
    _studentClassInput.inputView = pickerView;
    
    _studentClasses = @[@"Nursery", @"Kindergarten", @"I", @"II", @"III", @"IV", @"V", @"VI", @"VII", @"VIII", @"IX", @"X", @"XI", @"XII"];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
}


- (void)popTopicsTaughtViewController {
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
    return [_fetchedDates count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TopicsTaughtTableCell"];
    
    UILabel *dateLabel = [cell viewWithTag:1];
    UILabel *topicLabel = [cell viewWithTag:2];
    
    dateLabel.text = [_fetchedDates objectAtIndex:indexPath.row];
    topicLabel.text = [_topicsToughtData objectForKey:[_fetchedDates objectAtIndex:indexPath.row]];
    
    return cell;
}


- (IBAction)showTopicsButtonsAction:(id)sender {
    _topicsToughtData = [[NSMutableDictionary alloc] init];
    _fetchedDates = [[NSMutableArray alloc] init];
    
    if (_studentClassInput.text.length == 0) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"No class chosen" message:@"Choose a class." preferredStyle:UIAlertControllerStyleAlert];

        UIAlertAction *okActionButton = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];

        [alert addAction:okActionButton];

        [self presentViewController:alert animated:YES completion:nil];
        
    }
    else {
        _fetchedData = [AttendenceRecord fetchAttendenceRecordForClass:_studentClassInput.text];
        if (_fetchedData.count == 0) {
            _statusLabel.text = @"No Data Found";
        }
        else {
            _statusLabel.text = [NSString stringWithFormat:@"Class %@", _studentClassInput.text];
            
            for (AttendenceRecord *currentRecord in _fetchedData){
                if ([_topicsToughtData valueForKey:currentRecord.date] == nil){
                    [_topicsToughtData setObject:currentRecord.topicTaught forKey:currentRecord.date];
                    [_fetchedDates addObject:currentRecord.date];
                }
            }
        }
        
        [_tableView reloadData];
    }
}

@end
