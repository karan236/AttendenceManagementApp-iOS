//
//  Students+CoreDataClass.h
//  AttendenceManangent
//
//  Created by Karan Ghorai on 24/06/21.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface Students : NSManagedObject
+(BOOL)addStudentDetailsFromDictionary: (NSDictionary *) studentDetails;
+(NSArray *)fetchAllDataFromStudentEntity;
+(NSArray *)fetchDataFromStudentEntityForStudentClass: (NSString *)studentClass;
@end

NS_ASSUME_NONNULL_END

#import "Students+CoreDataProperties.h"
