//
//  AttendenceRecord+CoreDataProperties.h
//  AttendenceManangent
//
//  Created by Karan Ghorai on 25/06/21.
//
//

#import "AttendenceRecord+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface AttendenceRecord (CoreDataProperties)

+ (NSFetchRequest<AttendenceRecord *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *attendence;
@property (nullable, nonatomic, copy) NSString *date;
@property (nullable, nonatomic, copy) NSString *name;
@property (nonatomic) int64_t rollNo;
@property (nullable, nonatomic, copy) NSString *studentClass;
@property (nullable, nonatomic, copy) NSString *topicTaught;

@end

NS_ASSUME_NONNULL_END
