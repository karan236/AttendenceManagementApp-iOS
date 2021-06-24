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

+(BOOL)addStudentDetailsFromDictionary:(NSDictionary *)studentDetails{
    
    AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = appdelegate.persistentContainer.viewContext;
    
    NSFetchRequest *fetchRequest = [Students fetchRequest];
    fetchRequest.predicate = [NSPredicate predicateWithFormat: @"rollNo == %lld AND studentClass == %@ AND name == %@", [[studentDetails valueForKey: @"rollNo"] integerValue], [studentDetails valueForKey: @"studentClass"], [studentDetails valueForKey: @"name"]];
    
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


+(void)fetchAllDataFromStudentEntity{
    
    AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = appdelegate.persistentContainer.viewContext;
    
    NSFetchRequest *fetchRequest = [Students fetchRequest];
        
    NSError *error;
    NSArray *allStudentData = [context executeFetchRequest: fetchRequest error: &error];
    
    for(Students *student in allStudentData){
        NSLog(@"%lld %@ %@", student.rollNo, student.studentClass, student.name);
    }
}
@end
