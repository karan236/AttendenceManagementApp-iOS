//
//  EditAttendenceViewController.h
//  AttendenceManangent
//
//  Created by Karan Ghorai on 28/06/21.
//

#import <UIKit/UIKit.h>
#import "../EditAttendenceAttendenceViewController/EditAttendenceAttendenceViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface EditAttendenceViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>

@property (strong,nonatomic) EditAttendenceAttendenceViewController *editAttendenceAttendenceViewController;

@end

NS_ASSUME_NONNULL_END
