//
//  EducationCollege.h
//  Pocket Resume
//
//  Created by Joshua Alvarado on 8/4/14.
//  Copyright (c) 2014 Joshua Alvarado. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Degree;

@interface EducationCollege : NSManagedObject

@property (nonatomic, retain) NSString * college;
@property (nonatomic, retain) NSManagedObject *collegeDetails;
@property (nonatomic, retain) NSOrderedSet *degree;
@end

@interface EducationCollege (CoreDataGeneratedAccessors)

- (void)insertObject:(Degree *)value inDegreeAtIndex:(NSUInteger)idx;
- (void)removeObjectFromDegreeAtIndex:(NSUInteger)idx;
- (void)insertDegree:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeDegreeAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInDegreeAtIndex:(NSUInteger)idx withObject:(Degree *)value;
- (void)replaceDegreeAtIndexes:(NSIndexSet *)indexes withDegree:(NSArray *)values;
- (void)addDegreeObject:(Degree *)value;
- (void)removeDegreeObject:(Degree *)value;
- (void)addDegree:(NSOrderedSet *)values;
- (void)removeDegree:(NSOrderedSet *)values;
@end
