//
//  ViewController.m
//  AttendenceManangent
//
//  Created by Karan Ghorai on 23/06/21.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UIButton *takeAttendenceButton;
@property (strong, nonatomic) IBOutlet UIButton *viewAttendenceRecordButton;
@property (strong, nonatomic) IBOutlet UIButton *topicsTaughtButton;
@property (strong, nonatomic) IBOutlet UIButton *topicsMissedByStudentButton;
@property (strong, nonatomic) IBOutlet UIButton *studentsListButton;
@property (strong, nonatomic) IBOutlet UIButton *attendenceRecordOfAStudent;
@property (strong, nonatomic) IBOutlet UIButton *deleteStudentButton;
@property (strong, nonatomic) IBOutlet UIButton *updateAttendenceButton;
@property (strong, nonatomic) IBOutlet UIButton *addStudentButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    Home Page buttons Configuration
    _takeAttendenceButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _takeAttendenceButton.titleLabel.numberOfLines = 2;
//    [_takeAttendenceButton setTitle:@"Take\nAttendence" forState:UIControlStateNormal];
    _takeAttendenceButton.titleLabel.adjustsFontForContentSizeCategory = YES;
    _takeAttendenceButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    _takeAttendenceButton.layer.cornerRadius = _takeAttendenceButton.bounds.size.height/8;
    
    _viewAttendenceRecordButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _viewAttendenceRecordButton.titleLabel.numberOfLines = 3;
//    [_viewAttendenceRecordButton setTitle:@"View\nAttendence\nRecord" forState:UIControlStateNormal];
    _viewAttendenceRecordButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    _viewAttendenceRecordButton.layer.cornerRadius = _viewAttendenceRecordButton.bounds.size.height/8;
    
    _topicsTaughtButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _topicsTaughtButton.titleLabel.numberOfLines = 2;
//    [_topicsTaughtButton setTitle:@"Topics\nTaught" forState:UIControlStateNormal];
    _topicsTaughtButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    _topicsTaughtButton.layer.cornerRadius = _topicsTaughtButton.bounds.size.height/8;
    
    _topicsMissedByStudentButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _topicsMissedByStudentButton.titleLabel.numberOfLines = 3;
//    [_topicsMissedByStudentButton setTitle:@"Topics\nMissed by\nStudent" forState:UIControlStateNormal];
    _topicsMissedByStudentButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    _topicsMissedByStudentButton.layer.cornerRadius = _topicsMissedByStudentButton.bounds.size.height/8;
    
    _studentsListButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _studentsListButton.titleLabel.numberOfLines = 2;
//    [_studentsListButton setTitle:@"Students\nList" forState:UIControlStateNormal];
    _studentsListButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    _studentsListButton.layer.cornerRadius = _studentsListButton.bounds.size.height/8;
    
    _attendenceRecordOfAStudent.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _attendenceRecordOfAStudent.titleLabel.numberOfLines = 3;
//    [_attendenceRecordOfAStudent setTitle:@"Attendence\nRecord of a\nStudent" forState:UIControlStateNormal];
    _attendenceRecordOfAStudent.titleLabel.textAlignment = NSTextAlignmentCenter;
    _attendenceRecordOfAStudent.layer.cornerRadius = _attendenceRecordOfAStudent.bounds.size.height/8;
    
    _deleteStudentButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _deleteStudentButton.titleLabel.numberOfLines = 2;
//    [_deleteStudentButton setTitle:@"Delete\nStudent" forState:UIControlStateNormal];
    _deleteStudentButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    _deleteStudentButton.layer.cornerRadius = _deleteStudentButton.bounds.size.height/8;
    
    _updateAttendenceButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _updateAttendenceButton.titleLabel.numberOfLines = 2;
//    [_updateAttendenceButton setTitle:@"Update\nStudent" forState:UIControlStateNormal];
    _updateAttendenceButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    _updateAttendenceButton.layer.cornerRadius = _updateAttendenceButton.bounds.size.height/8;
    
    _addStudentButton.layer.cornerRadius = _addStudentButton.bounds.size.height/8;
    
}


@end
