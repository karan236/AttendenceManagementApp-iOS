//
//  EditAttendenceAttendenceViewController.m
//  AttendenceManangent
//
//  Created by Karan Ghorai on 28/06/21.
//

#import "EditAttendenceAttendenceViewController.h"
#import "../../../Models/AttendenceRecordModel/AttendenceRecord+CoreDataClass.h"

@interface EditAttendenceAttendenceViewController ()
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *fetchedData;
@property (strong, nonatomic) NSMutableArray *absentButtons;
@property (strong, nonatomic) NSMutableArray *presentButtons;
@property (strong, nonatomic) NSMutableArray *currentAttendenceResponse;
@end

@implementation EditAttendenceAttendenceViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    NSLog(@"class: %@   date: %@", _studentClass, _attendenceDate);
    
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(popEditAttendenceAttendenceViewController)];
    rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:rightSwipe];
    
    _fetchedData = [AttendenceRecord fetchAttendenceRecordForClass:_studentClass date:_attendenceDate];
    
    _presentButtons = [[NSMutableArray alloc] init];
    _absentButtons = [[NSMutableArray alloc] init];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    
    [self initializeCurrentAttendenceResponse];
    
}

- (void)initializeCurrentAttendenceResponse {
    
    _currentAttendenceResponse = [[NSMutableArray alloc] init];
    
    for (AttendenceRecord *currentAttendence in _fetchedData){
        if ([currentAttendence.attendence isEqualToString:@"Absent"]){
            [_currentAttendenceResponse addObject:@"0"];
        }
        else{
            [_currentAttendenceResponse addObject:@"1"];
        }
    }
}


- (void)popEditAttendenceAttendenceViewController {
    [self.navigationController popViewControllerAnimated:YES];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_fetchedData count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"editAttendenceCell"];
    
    UILabel *rollNoLabel = [cell viewWithTag:1];
    UILabel *nameLabel = [cell viewWithTag:2];
    UIButton *absentButton = [cell viewWithTag:3];
    UIButton *presentButton = [cell viewWithTag:4];
    
    absentButton.tag = indexPath.row;
    presentButton.tag = indexPath.row;
    
    [absentButton addTarget:self action:@selector(absentButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [presentButton addTarget:self action:@selector(presentButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    AttendenceRecord *currentdata = [_fetchedData objectAtIndex:indexPath.row];
    
    rollNoLabel.text = [NSString stringWithFormat:@"%lld", currentdata.rollNo];
    nameLabel.text = currentdata.name;
    
    if ([currentdata.attendence isEqualToString:@"Absent"]){
        absentButton.enabled = NO;
        absentButton.alpha = 1;
//        presentButton.enabled = YES;
//        presentButton.alpha = 0.5;
    }
    else{
        presentButton.enabled = NO;
        presentButton.alpha = 1;
//        absentButton.enabled = YES;
//        absentButton.alpha = 0.5;
    }
    
    [_absentButtons addObject:absentButton];
    [_presentButtons addObject:presentButton];
    
    return cell;
}


- (void)absentButtonAction:(id)sender {
    NSLog(@"%li", [sender tag]);
    UIButton *correspondingPresentButton = [_presentButtons objectAtIndex:[sender tag]];
    UIButton *correspondingAbsentButton = [_absentButtons objectAtIndex:[sender tag]];
    NSLog(@"count %ld", _presentButtons.count);
    correspondingAbsentButton.enabled = NO;
    correspondingAbsentButton.alpha = 1;
    correspondingPresentButton.enabled = YES;
    correspondingPresentButton.alpha = 0.5;
    
    [_currentAttendenceResponse replaceObjectAtIndex:[sender tag] withObject:@"0"];
}


- (void)presentButtonAction:(id)sender {
    UIButton *correspondingPresentButton = [_presentButtons objectAtIndex:[sender tag]];
    UIButton *correspondingAbsentButton = [_absentButtons objectAtIndex:[sender tag]];
    
    correspondingPresentButton.enabled = NO;
    correspondingPresentButton.alpha = 1;
    correspondingAbsentButton.enabled = YES;
    correspondingAbsentButton.alpha = 0.5;
    
    [_currentAttendenceResponse replaceObjectAtIndex:[sender tag] withObject:@"1"];
}


- (IBAction)resetButtonAction:(id)sender {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"Are you sure want to reset the attendence sheet?" preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction *yesActionButton = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        
        [self initializeCurrentAttendenceResponse];
        
        for (int i =0; i<[self->_fetchedData count]; i++){
            UIButton *correspondingAbsentButton = [self->_absentButtons objectAtIndex: i];
            UIButton *correspondingPresentButton = [self->_presentButtons objectAtIndex:i];
            
            if ([[self->_currentAttendenceResponse objectAtIndex:i] isEqualToString:@"0"]){
                correspondingAbsentButton.enabled = NO;
                correspondingAbsentButton.alpha = 1;
                correspondingPresentButton.enabled = YES;
                correspondingPresentButton.alpha = 0.5;
            }
            else{
                correspondingPresentButton.enabled = NO;
                correspondingPresentButton.alpha = 1;
                correspondingAbsentButton.enabled = YES;
                correspondingAbsentButton.alpha = 0.5;
            }
        }
        
    }];

    UIAlertAction *noActionButton = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleCancel handler:nil];

    [alert addAction:yesActionButton];
    [alert addAction:noActionButton];
    
    [self presentViewController:alert animated:YES completion:nil];
}


- (IBAction)doneButtonAction:(id)sender {
    
    [AttendenceRecord updateDataForData:_fetchedData newAttendence:_currentAttendenceResponse];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"Data saved Successfully!" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okActionButton = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }];
    
    [alert addAction:okActionButton];
    
    [self presentViewController:alert animated:YES completion:nil];
}


@end
