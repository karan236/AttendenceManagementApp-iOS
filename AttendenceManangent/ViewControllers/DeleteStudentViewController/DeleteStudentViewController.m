//
//  DeleteStudentViewController.m
//  AttendenceManangent
//
//  Created by Karan Ghorai on 28/06/21.
//

#import "DeleteStudentViewController.h"
#import "../../Models/StudentModel/Students+CoreDataClass.h"
#import "TableViewCell/DeleteStudentTableViewCell.h"

@interface DeleteStudentViewController ()
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UITextField *classInputField;
@property (strong, nonatomic) NSArray *studentClasses;
@property (strong, nonatomic) NSMutableArray *fetchedData;
@property (strong, nonatomic) NSMutableSet *removedObjectSet;
@end

@implementation DeleteStudentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _studentClasses = @[@"Nursery", @"Kindergarten", @"I", @"II", @"III", @"IV", @"V", @"VI", @"VII", @"VIII", @"IX", @"X", @"XI", @"XII"];
    
    UIPickerView *pickerView = [[UIPickerView alloc] init];
    
    pickerView.delegate = self;
    pickerView.dataSource = self;
    
    _classInputField.inputView = pickerView;
    
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(popDeleteStudentViewController)];
    
    rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    
    [self.view addGestureRecognizer:rightSwipe];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    _fetchedData = [[NSMutableArray alloc] init];
    _removedObjectSet = [[NSMutableSet alloc] init];
}

- (void)popDeleteStudentViewController {
    [self.navigationController popViewControllerAnimated:YES];
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
   _classInputField.text = [_studentClasses objectAtIndex:row];
   [_classInputField resignFirstResponder];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_fetchedData count] - [_removedObjectSet count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DeleteStudentTableViewCell *cell = (DeleteStudentTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"DeleteStudentCell"];
    
    int i = (int)indexPath.row;
    
    while ([_removedObjectSet containsObject:[_fetchedData objectAtIndex: indexPath.row]]) {
        i++;
    }
    
    Students *currentStudent = [_fetchedData objectAtIndex:i];
    
    cell.rollNoLabel.text = [NSString stringWithFormat:@"%lld", currentStudent.rollNo];
    cell.nameLabel.text = currentStudent.name;
    
    cell.deleteButtonActionBlock = ^{
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Delete?" message:@"Delete?" preferredStyle:UIAlertControllerStyleAlert];

        UIAlertAction *confirmActionButton = [UIAlertAction actionWithTitle:@"Confirm" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            
            [Students deleteStudentForClass:self->_classInputField.text rollNo:currentStudent.rollNo];
            
//            NSLog(@"%ld", indexPath.row);
            
            [self->_removedObjectSet addObject:currentStudent];
            
            [self->_tableView reloadData];
            
        }];

        UIAlertAction *noActionButton = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleCancel handler:nil];

        [alert addAction:confirmActionButton];
        [alert addAction:noActionButton];
        
        [self presentViewController:alert animated:YES completion:nil];
        
    };
    
    return cell;
}

- (void)deleteFromFetchedData{
    [_fetchedData removeObjectAtIndex:1];
    [_tableView reloadData];
}


- (IBAction)showStudentsButtonAction:(id)sender {
    _fetchedData = (NSMutableArray *)[Students fetchDataFromStudentEntityForStudentClass:_classInputField.text];
    
    _removedObjectSet = [[NSMutableSet alloc] init];
    
    if (_fetchedData.count == 0) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"No data." message:@"No data found for given class." preferredStyle:UIAlertControllerStyleAlert];

        UIAlertAction *okActionButton = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];

        [alert addAction:okActionButton];

        [self presentViewController:alert animated:YES completion:nil];
        
    }
     
    [_tableView reloadData];
}



@end
