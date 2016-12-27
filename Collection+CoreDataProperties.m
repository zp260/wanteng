//
//  Collection+CoreDataProperties.m
//  
//
//  Created by mrz on 2016/12/27.
//
//  This file was automatically generated and should not be edited.
//

#import "Collection+CoreDataProperties.h"

@implementation Collection (CoreDataProperties)

+ (NSFetchRequest<Collection *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Collection"];
}

@dynamic articleDate;
@dynamic articleId;
@dynamic source;
@dynamic title;
@dynamic thumb;
@dynamic hits;

@end
