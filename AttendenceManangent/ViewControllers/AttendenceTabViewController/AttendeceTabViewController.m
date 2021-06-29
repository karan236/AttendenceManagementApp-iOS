//
//  AttendeceTabViewController.m
//  AttendenceManangent
//
//  Created by Karan Ghorai on 29/06/21.
//

#import "AttendeceTabViewController.h"

@interface AttendeceTabViewController ()
@property (strong, nonatomic) IBOutlet UIButton *takeAttendenceButton;
@property (strong, nonatomic) IBOutlet UIButton *viewAttendenceRecordButton;
@property (strong, nonatomic) IBOutlet UIButton *attendenceRecordOfAStudentButton;
@property (strong, nonatomic) IBOutlet UIButton *editAttendenceButton;

@end

@implementation AttendeceTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
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
    
    _attendenceRecordOfAStudentButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _attendenceRecordOfAStudentButton.titleLabel.numberOfLines = 3;
//    [_attendenceRecordOfAStudent setTitle:@"Attendence\nRecord of a\nStudent" forState:UIControlStateNormal];
    _attendenceRecordOfAStudentButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    _attendenceRecordOfAStudentButton.layer.cornerRadius = _attendenceRecordOfAStudentButton.bounds.size.height/8;
    
    _editAttendenceButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _editAttendenceButton.titleLabel.numberOfLines = 2;
//    [_updateAttendenceButton setTitle:@"Update\nStudent" forState:UIControlStateNormal];
    _editAttendenceButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    _editAttendenceButton.layer.cornerRadius = _editAttendenceButton.bounds.size.height/8;
}

@end
