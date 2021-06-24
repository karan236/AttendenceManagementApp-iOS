//
//  Students+CoreDataProperties.h
//  AttendenceManangent
//
//  Created by Karan Ghorai on 24/06/21.
//
//

#import "Students+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Students (CoreDataProperties)

+ (NSFetchRequest<Students *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nonatomic) int64_t rollNo;
@property (nullable, nonatomic, copy) NSString *studentClass;

@end

NS_ASSUME_NONNULL_END
