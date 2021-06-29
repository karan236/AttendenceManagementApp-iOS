//
//  TopicsViewController.m
//  AttendenceManangent
//
//  Created by Karan Ghorai on 29/06/21.
//

#import "TopicsViewController.h"

@interface TopicsViewController ()
@property (strong, nonatomic) IBOutlet UIButton *topicsTaughtButton;
@property (strong, nonatomic) IBOutlet UIButton *topicsMissedByStudentsButton;

@end

@implementation TopicsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _topicsTaughtButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _topicsTaughtButton.titleLabel.numberOfLines = 2;
//    [_topicsTaughtButton setTitle:@"Topics\nTaught" forState:UIControlStateNormal];
    _topicsTaughtButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    _topicsTaughtButton.layer.cornerRadius = _topicsTaughtButton.bounds.size.height/8;
    
    _topicsMissedByStudentsButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _topicsMissedByStudentsButton.titleLabel.numberOfLines = 3;
//    [_topicsMissedByStudentButton setTitle:@"Topics\nMissed by\nStudent" forState:UIControlStateNormal];
    _topicsMissedByStudentsButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    _topicsMissedByStudentsButton.layer.cornerRadius = _topicsMissedByStudentsButton.bounds.size.height/8;
}



@end
