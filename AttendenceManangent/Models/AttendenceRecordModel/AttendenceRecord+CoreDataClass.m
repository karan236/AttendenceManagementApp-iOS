//
//  AttendenceRecord+CoreDataClass.m
//  AttendenceManangent
//
//  Created by Karan Ghorai on 25/06/21.
//
//

#import "AttendenceRecord+CoreDataClass.h"
#import "../StudentModel/Students+CoreDataClass.h"
#import "../../AppDelegate.h"

@implementation AttendenceRecord

+(BOOL)doesAttendenceExistsForDate:(NSString *)date class:(NSString *)studentClass{
    
    AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = appdelegate.persistentContainer.viewContext;
    
    NSFetchRequest *fetchRequest = [AttendenceRecord fetchRequest];
    fetchRequest.predicate = [NSPredicate predicateWithFormat: @"studentClass == %@ AND date == %@", studentClass, date];
    
    NSError *error;
    NSArray *retrievedData = [context executeFetchRequest: fetchRequest error: &error];
    
    return [retrievedData count] > 0;
}


+(void)addAttendenceRecord:(NSArray *)studentData attendenceData:(NSArray *) attendenceData date:(NSString *)date topic:(NSString *)topic{
    AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = appdelegate.persistentContainer.viewContext;
    
    for (int i=0; i<[attendenceData count]; i++){
        Students *currentStudentData = [studentData objectAtIndex:i];
        NSString *currentStudentAttendenceData = [attendenceData objectAtIndex:i];
        AttendenceRecord *attendenceRecord = [NSEntityDescription insertNewObjectForEntityForName: @"AttendenceRecord" inManagedObjectContext: context];
        
        if([currentStudentAttendenceData isEqualToString:@"1"]) {
            attendenceRecord.attendence = @"Present";
        }
        else{
            attendenceRecord.attendence = @"Absent";
        }
        
        attendenceRecord.date = date;
        attendenceRecord.name = currentStudentData.name;
        attendenceRecord.rollNo = currentStudentData.rollNo;
        attendenceRecord.studentClass = currentStudentData.studentClass;
        attendenceRecord.topicTaught = topic;
        
        [appdelegate saveContext];
    }
}

+ (NSArray *)fetchAttendenceRecordForClass:(NSString *)studentClass date:(NSString *)date {
    
    AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = appdelegate.persistentContainer.viewContext;
    
    NSFetchRequest *fetchRequest = [AttendenceRecord fetchRequest];
    fetchRequest.predicate = [NSPredicate predicateWithFormat: @"studentClass == %@ AND date == %@", studentClass, date];
    
    NSSortDescriptor *sortByRollNo = [[NSSortDescriptor alloc] initWithKey:@"rollNo" ascending:YES];
    fetchRequest.sortDescriptors = @[sortByRollNo];
    
    NSError *error;
    NSArray *retrievedData = [context executeFetchRequest: fetchRequest error: &error];
    
    return retrievedData;
}

+ (NSArray *)fetchAttendenceRecordForClass:(NSString *)studentClass {
    
    AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = appdelegate.persistentContainer.viewContext;
    
    NSFetchRequest *fetchRequest = [AttendenceRecord fetchRequest];
    fetchRequest.predicate = [NSPredicate predicateWithFormat: @"studentClass == %@", studentClass];
    
    NSSortDescriptor *sortByDate = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:YES];
    fetchRequest.sortDescriptors = @[sortByDate];
    
    NSError *error;
    NSArray *retrievedData = [context executeFetchRequest: fetchRequest error: &error];
    
    return retrievedData;
}

+ (NSArray *)fetchAttendenceRecordForClass:(NSString *)studentClass rollNo:(NSString *)rollNo {
    
    AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = appdelegate.persistentContainer.viewContext;
    
    NSFetchRequest *fetchRequest = [AttendenceRecord fetchRequest];
    fetchRequest.predicate = [NSPredicate predicateWithFormat: @"studentClass == %@ AND rollNo == %@", studentClass, rollNo];
    
    NSSortDescriptor *sortByRollNo = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:YES];
    fetchRequest.sortDescriptors = @[sortByRollNo];
    
    NSError *error;
    NSArray *retrievedData = [context executeFetchRequest: fetchRequest error: &error];
    
    return retrievedData;
}

@end
