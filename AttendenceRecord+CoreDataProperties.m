//
//  AttendenceRecord+CoreDataProperties.m
//  AttendenceManangent
//
//  Created by Karan Ghorai on 25/06/21.
//
//

#import "AttendenceRecord+CoreDataProperties.h"

@implementation AttendenceRecord (CoreDataProperties)

+ (NSFetchRequest<AttendenceRecord *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"AttendenceRecord"];
}

@dynamic attendence;
@dynamic date;
@dynamic name;
@dynamic rollNo;
@dynamic studentClass;
@dynamic topicTaught;

@end
