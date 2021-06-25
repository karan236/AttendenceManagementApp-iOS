//
//  TakeAttendenceDetailsViewController.h
//  AttendenceManangent
//
//  Created by Karan Ghorai on 25/06/21.
//

#import <UIKit/UIKit.h>
#import "../TakeAttendenceAttendenceViewController/TakeAttendenceAttendenceViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface TakeAttendenceDetailsViewController : UIViewController<UIPickerViewDelegate, UIPickerViewDataSource>

@property (strong, nonatomic) IBOutlet UITextField *studentClassInputField;
@property (strong, nonatomic) IBOutlet UITextField *topicInputField;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePickerInput;
@property (strong, nonatomic) TakeAttendenceAttendenceViewController *takeAttendenceAttendenceViewController;

@end

NS_ASSUME_NONNULL_END
