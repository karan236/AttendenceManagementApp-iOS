//
//  AttendenceRecord+CoreDataClass.h
//  AttendenceManangent
//
//  Created by Karan Ghorai on 25/06/21.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface AttendenceRecord : NSManagedObject

+(BOOL)doesAttendenceExistsForDate:(NSString *)date class:(NSString *)studentClass;

+(void)addAttendenceRecord:(NSArray *)studentData attendenceData:(NSArray *) attendenceData date:(NSString *)date topic:(NSString *)topic;

+(NSMutableArray *)fetchAttendenceRecordForClass:(NSString *)studentClass date:(NSString *)date;

+ (NSArray *)fetchAttendenceRecordForClass:(NSString *)studentClass;

+ (NSArray *)fetchAttendenceRecordForClass:(NSString *)studentClass rollNo:(NSString *)rollNo;

+ (NSArray *)fetchAttendenceRecordForClass:(NSString *)studentClass rollNo:(NSString *)rollNo attendence:(NSString *)attendence;

+ (void)updateDataForData:(NSArray *)data newAttendence:(NSArray *) newAttendenceData;

@end

NS_ASSUME_NONNULL_END

#import "AttendenceRecord+CoreDataProperties.h"
