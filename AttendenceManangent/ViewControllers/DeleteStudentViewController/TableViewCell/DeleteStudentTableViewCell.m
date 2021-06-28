//
//  DeleteStudentTableViewCell.m
//  AttendenceManangent
//
//  Created by Karan Ghorai on 28/06/21.
//

#import "DeleteStudentTableViewCell.h"

@implementation DeleteStudentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)deleteButtonAction:(id)sender {
    _deleteButtonActionBlock();
}
@end
