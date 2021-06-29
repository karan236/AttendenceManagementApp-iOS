//
//  StudentTabViewController.m
//  AttendenceManangent
//
//  Created by Karan Ghorai on 29/06/21.
//

#import "StudentTabViewController.h"

@interface StudentTabViewController ()
@property (strong, nonatomic) IBOutlet UIButton *studentsListButton;
@property (strong, nonatomic) IBOutlet UIButton *deleteStudentButton;
@property (strong, nonatomic) IBOutlet UIButton *addStudentButton;

@end

@implementation StudentTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _studentsListButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _studentsListButton.titleLabel.numberOfLines = 2;
//    [_studentsListButton setTitle:@"Students\nList" forState:UIControlStateNormal];
    _studentsListButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    _studentsListButton.layer.cornerRadius = _studentsListButton.bounds.size.height/8;
    
    _deleteStudentButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _deleteStudentButton.titleLabel.numberOfLines = 2;
//    [_deleteStudentButton setTitle:@"Delete\nStudent" forState:UIControlStateNormal];
    _deleteStudentButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    _deleteStudentButton.layer.cornerRadius = _deleteStudentButton.bounds.size.height/8;
    
    _addStudentButton.layer.cornerRadius = _addStudentButton.bounds.size.height/8;
}

@end
