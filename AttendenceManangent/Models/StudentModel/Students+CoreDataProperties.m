//
//  Students+CoreDataProperties.m
//  AttendenceManangent
//
//  Created by Karan Ghorai on 24/06/21.
//
//

#import "Students+CoreDataProperties.h"

@implementation Students (CoreDataProperties)

+ (NSFetchRequest<Students *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Students"];
}

@dynamic name;
@dynamic rollNo;
@dynamic studentClass;

@end
