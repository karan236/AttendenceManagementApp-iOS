//
//  StudentListViewController.m
//  AttendenceManangent
//
//  Created by Karan Ghorai on 24/06/21.
//

#import "StudentListViewController.h"
#import "../../Models/StudentModel/Students+CoreDataClass.h"

@interface StudentListViewController ()
@property (strong, nonatomic) IBOutlet UITextField *classInputTextField;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *fetchedData;
@property (strong, nonatomic) NSArray *studentClasses;

- (IBAction)doneButtonAction:(id)sender;

@end

@implementation StudentListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _studentClasses = @[@"All", @"Nursery", @"Kindergarten", @"I", @"II", @"III", @"IV", @"V", @"VI", @"VII", @"VIII", @"IX", @"X", @"XI", @"XII"];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;

    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(popStudentListViewController)];
    
    rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer: rightSwipe];
    
    UIPickerView *pickerView = [[UIPickerView alloc] init];
    pickerView.delegate = self;
    pickerView.dataSource = self;
    
    
    _classInputTextField.text = @"All";
    _classInputTextField.inputView = pickerView;
    
    _fetchedData = [Students fetchAllDataFromStudentEntity];
}


-(void)popStudentListViewController{
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
    _classInputTextField.text = [_studentClasses objectAtIndex:row];
    [_classInputTextField resignFirstResponder];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_fetchedData.count == 0){
        return 1;
    }
    return [_fetchedData count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    UILabel *rollNoLabel = [cell viewWithTag:1];
    UILabel *classLabel = [cell viewWithTag:2];
    UILabel *nameLabel = [cell viewWithTag:3];
    
    if(_fetchedData.count == 0){
        rollNoLabel.text = @"";
        classLabel.text = @"No Data";
        nameLabel.text = @"";
    }
    else{
        Students *data = (Students *)[_fetchedData objectAtIndex:indexPath.row];
        
        rollNoLabel.text = [NSString stringWithFormat:@"%lld", data.rollNo];
        classLabel.text = data.studentClass;
        nameLabel.text = data.name;
    }
    
    
    return cell;
}

- (IBAction)doneButtonAction:(id)sender {
    
    if ([_classInputTextField.text isEqualToString:@"All"]){
        _fetchedData = [Students fetchAllDataFromStudentEntity];
    }
    else{
        _fetchedData = [Students fetchDataFromStudentEntityForStudentClass: _classInputTextField.text];
    }
    
    [_tableView reloadData];
}
@end
