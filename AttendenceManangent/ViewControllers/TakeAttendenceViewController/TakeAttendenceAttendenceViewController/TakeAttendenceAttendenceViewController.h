//
//  TakeAttendenceAttendenceViewController.h
//  AttendenceManangent
//
//  Created by Karan Ghorai on 25/06/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TakeAttendenceAttendenceViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSString *studentClass;
@property (strong, nonatomic) NSString *topicTaught;
@property (strong, nonatomic) NSString *attendenceDate;
-(void)setStudentClass:(NSString * _Nonnull)studentClass;

@end

NS_ASSUME_NONNULL_END
