//
//  Collection+CoreDataProperties.m
//  
//
//  Created by mrz on 2016/12/22.
//
//  This file was automatically generated and should not be edited.
//

#import "Collection+CoreDataProperties.h"

@implementation Collection (CoreDataProperties)

+ (NSFetchRequest<Collection *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Collection"];
}

@dynamic articleId;
@dynamic articleSource;
@dynamic articleDate;

@end
