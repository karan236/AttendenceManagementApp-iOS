//
//  Students+CoreDataClass.m
//  AttendenceManangent
//
//  Created by Karan Ghorai on 24/06/21.
//
//

#import "Students+CoreDataClass.h"
#import "AppDelegate.h"


@implementation Students

+ (BOOL)addStudentDetailsFromDictionary:(NSDictionary *)studentDetails {
    
    AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = appdelegate.persistentContainer.viewContext;
    
    NSFetchRequest *fetchRequest = [Students fetchRequest];
    fetchRequest.predicate = [NSPredicate predicateWithFormat: @"rollNo == %lld AND studentClass == %@", [[studentDetails valueForKey: @"rollNo"] integerValue], [studentDetails valueForKey: @"studentClass"]];
    
    NSError *error;
    NSArray *retrievedData = [context executeFetchRequest: fetchRequest error: &error];
    
    if ([retrievedData count] != 0){
        return FALSE;
    }
    else{
        
        Students *student = [NSEntityDescription insertNewObjectForEntityForName: @"Students" inManagedObjectContext: context];
        
        student.rollNo = [[studentDetails valueForKey: @"rollNo"] integerValue];
        student.studentClass = [studentDetails valueForKey: @"studentClass"];
        student.name = [studentDetails valueForKey: @"name"];
        
        [appdelegate saveContext];
        
        return TRUE;
    }
}


+ (NSArray *)fetchAllDataFromStudentEntity {
    
    AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = appdelegate.persistentContainer.viewContext;
    
    NSFetchRequest *fetchRequest = [Students fetchRequest];
    NSSortDescriptor *sortByClass = [[NSSortDescriptor alloc] initWithKey:@"studentClass" ascending:YES];
    NSSortDescriptor *sortByRollNo = [[NSSortDescriptor alloc] initWithKey:@"rollNo" ascending:YES];
    NSSortDescriptor *sortByName = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    
    fetchRequest.sortDescriptors = @[sortByClass,sortByRollNo,sortByName];
    
    NSError *error;
    NSArray *allStudentData = [context executeFetchRequest: fetchRequest error: &error];
    
    return allStudentData;
}

+ (NSArray *)fetchDataFromStudentEntityForStudentClass: (NSString *)studentClass {
    
    AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = appdelegate.persistentContainer.viewContext;
    
    NSFetchRequest *fetchRequest = [Students fetchRequest];
    fetchRequest.predicate = [NSPredicate predicateWithFormat: @"studentClass == %@", studentClass];
    
    NSSortDescriptor *sortByRollNo = [[NSSortDescriptor alloc] initWithKey:@"rollNo" ascending:YES];
    NSSortDescriptor *sortByName = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    
    fetchRequest.sortDescriptors = @[sortByRollNo, sortByName];
    
    NSError *error;
    NSArray *retrievedData = [context executeFetchRequest: fetchRequest error: &error];
    
    return retrievedData;
    
}

+ (void)deleteStudentForClass:(NSString *)studentClass rollNo:(NSInteger)rollNo {
    
    AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = appdelegate.persistentContainer.viewContext;
    
    NSFetchRequest *fetchRequest = [Students fetchRequest];
    fetchRequest.predicate = [NSPredicate predicateWithFormat: @"rollNo == %lld AND studentClass == %@", rollNo, studentClass];
    
    NSError *error;
    NSArray *retrievedData = [context executeFetchRequest: fetchRequest error: &error];
    
    [context deleteObject:[retrievedData objectAtIndex:0]];

//    NSLog(@"Class %@ roll %ld deleted", studentClass, (long)rollNo);
    
    [appdelegate saveContext];
}
@end
