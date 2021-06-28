//
//  DeleteStudentTableViewCell.h
//  AttendenceManangent
//
//  Created by Karan Ghorai on 28/06/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DeleteStudentTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *rollNoLabel;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
- (IBAction)deleteButtonAction:(id)sender;

@property (copy,nonatomic) void (^deleteButtonActionBlock)(void);

@end

NS_ASSUME_NONNULL_END
