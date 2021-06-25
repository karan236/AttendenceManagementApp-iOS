//
//  TakeAttendenceAttendenceViewController.m
//  AttendenceManangent
//
//  Created by Karan Ghorai on 25/06/21.
//

#import "TakeAttendenceAttendenceViewController.h"
#import "../../../Models/StudentModel/Students+CoreDataClass.h"
#import "AttendenceRecord+CoreDataClass.h"

@interface TakeAttendenceAttendenceViewController ()
- (IBAction)resetButtonAction:(id)sender;
- (IBAction)doneButtonAction:(id)sender;

@property (strong, nonatomic) NSMutableArray *absentButtonsResponse;
@property (strong, nonatomic) NSMutableArray *presentButtonResponse;

@property (strong, nonatomic) IBOutlet UILabel *classLabel;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *studentsOfMentionedClass;
@property (strong, nonatomic) NSMutableArray *studentAttendence;

@end

@implementation TakeAttendenceAttendenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(popTakeAttendenceAttendenceViewController)];
    
    rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer: rightSwipe];
    
    _studentsOfMentionedClass = [Students fetchDataFromStudentEntityForStudentClass: _studentClass];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    _absentButtonsResponse = [[NSMutableArray alloc] init];
    _presentButtonResponse = [[NSMutableArray alloc] init];
    _studentAttendence = [[NSMutableArray alloc] init];
    
    for (int i=0; i<[_studentsOfMentionedClass count]; i++){
        [_studentAttendence addObject:@"-1"];
    }
}

-(void)viewDidAppear:(BOOL)animated {
    
    if ([_studentAttendence count] == 0){
        _classLabel.text = @"No data found";
        
    }
    else{
        _classLabel.text =[NSString stringWithFormat:@"Class: %@", _studentClass];
    }
}

-(void)setStudentClass:(NSString *)studentClass{
    _studentClass = studentClass;
}

-(void)popTakeAttendenceAttendenceViewController{
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_studentsOfMentionedClass count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"attenceSheetCell"];
    
    UILabel *rollNoLabel = [cell viewWithTag:1];
    UILabel *nameLabel = [cell viewWithTag:2];
    
    NSInteger rollNo = [[_studentsOfMentionedClass objectAtIndex:indexPath.row] rollNo];
    rollNoLabel.text = [NSString stringWithFormat:@"%ld", rollNo];
    nameLabel.text = [[_studentsOfMentionedClass objectAtIndex:indexPath.row] name];
    
    UIButton *absentButton = [cell viewWithTag:3];
    UIButton *presentButton = [cell viewWithTag:4];
    
    absentButton.tag = indexPath.row;
    presentButton.tag = indexPath.row;
    
    [_absentButtonsResponse addObject:absentButton];
    [_presentButtonResponse addObject:presentButton];
    
    [absentButton addTarget:self action:@selector(absentButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [presentButton addTarget:self action:@selector(presentButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
//    NSLog(@"Absent button tag changed back to: %li", absentButton.tag);
    
    return cell;
}

-(void)absentButtonAction:(id)sender{
    
    UIButton *correspondingPresentButton = [_presentButtonResponse objectAtIndex:[sender tag]];
    BOOL isCorrespondingPresentButtonEnabled = correspondingPresentButton.isEnabled;
    
    if (!isCorrespondingPresentButtonEnabled){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"Are you sure want to change the attendence status to absent?" preferredStyle:UIAlertControllerStyleAlert];

        UIAlertAction *yesActionButton = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            correspondingPresentButton.enabled = YES;
            correspondingPresentButton.alpha = 0.5;
            
            UIButton *btn = [self->_absentButtonsResponse objectAtIndex:[sender tag]];
            
            btn.alpha = 1;
            btn.enabled = NO;
            
            [self->_studentAttendence replaceObjectAtIndex:[sender tag] withObject:@"0"];
        }];

        UIAlertAction *noActionButton = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleCancel handler:nil];

        [alert addAction:yesActionButton];
        [alert addAction:noActionButton];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    else{
        
        NSLog(@"tapped on absent button with tag: %li and done", [sender tag]);
        UIButton *btn = [_absentButtonsResponse objectAtIndex:[sender tag]];
        
        btn.alpha = 1;
        btn.enabled = NO;
        
        [_studentAttendence replaceObjectAtIndex:[sender tag] withObject:@"0"];
    }
    
}

- (void)presentButtonAction:(id)sender{
    
    UIButton *correspondingAbsentButton = [_absentButtonsResponse objectAtIndex:[sender tag]];
    BOOL isCorrespondingAbsentButtonEnabled = correspondingAbsentButton.isEnabled;
    
    if (!isCorrespondingAbsentButtonEnabled){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"Are you sure want to change the attendence status to present?" preferredStyle:UIAlertControllerStyleAlert];

        UIAlertAction *yesActionButton = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            correspondingAbsentButton.enabled = YES;
            correspondingAbsentButton.alpha = 0.5;
            
            UIButton *btn = [self->_presentButtonResponse objectAtIndex:[sender tag]];
            
            btn.alpha = 1;
            btn.enabled = NO;
            
            [self->_studentAttendence replaceObjectAtIndex:[sender tag] withObject:@"1"];
        }];

        UIAlertAction *noActionButton = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleCancel handler:nil];

        [alert addAction:yesActionButton];
        [alert addAction:noActionButton];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    else{
        
        NSLog(@"tapped on present button with tag: %li and done", [sender tag]);
        UIButton *btn = [_presentButtonResponse objectAtIndex:[sender tag]];
        
        btn.alpha = 1;
        btn.enabled = NO;
        
        [_studentAttendence replaceObjectAtIndex:[sender tag] withObject:@"1"];
    }
    
    
}

- (IBAction)doneButtonAction:(id)sender {
    BOOL isAllAttendenceMarked = YES;
    
    for(NSString *currentAttendence in _studentAttendence){
        if ([currentAttendence isEqualToString:@"-1"]){
            isAllAttendenceMarked = NO;
        }
    }
    
    if (!isAllAttendenceMarked) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"Please mark attendence for all students." preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okActionButton = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:nil];
        
        [alert addAction:okActionButton];
        [self presentViewController:alert animated:YES completion:nil];
        
    }
    else if (_studentsOfMentionedClass.count>0) {
        
        [AttendenceRecord addAttendenceRecord:_studentsOfMentionedClass attendenceData:_studentAttendence date:_attendenceDate topic:_topicTaught];
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"Attendence saved successfully!" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okActionButton = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
            
            [self.navigationController popToRootViewControllerAnimated:YES];
            
        }];
        
        [alert addAction:okActionButton];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
}

- (IBAction)resetButtonAction:(id)sender {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"Are you sure want to reset the attendence sheet?" preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction *yesActionButton = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        for (int i=0; i<[self->_studentsOfMentionedClass count]; i++){
            UIButton *correspondingAbsentButton = [self->_absentButtonsResponse objectAtIndex:i];
            UIButton *correspondingPresentButton = [self->_presentButtonResponse objectAtIndex:i];
            
            correspondingAbsentButton.enabled = YES;
            correspondingPresentButton.enabled = YES;
            correspondingAbsentButton.alpha = 0.5;
            correspondingPresentButton.alpha = 0.5;
            
            [self->_studentAttendence replaceObjectAtIndex:i withObject:@"-1"];
        }
        
    }];

    UIAlertAction *noActionButton = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleCancel handler:nil];

    [alert addAction:yesActionButton];
    [alert addAction:noActionButton];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}
@end
