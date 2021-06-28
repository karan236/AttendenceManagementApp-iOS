//
//  EditAttendenceAttendenceViewController.h
//  AttendenceManangent
//
//  Created by Karan Ghorai on 28/06/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EditAttendenceAttendenceViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSString *studentClass;
@property (strong, nonatomic) NSString *attendenceDate;

@end

NS_ASSUME_NONNULL_END
