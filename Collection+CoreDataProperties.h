//
//  Collection+CoreDataProperties.h
//  
//
//  Created by mrz on 2016/12/27.
//
//  This file was automatically generated and should not be edited.
//

#import "Collection+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Collection (CoreDataProperties)

+ (NSFetchRequest<Collection *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *articleDate;
@property (nonatomic) int32_t articleId;
@property (nullable, nonatomic, copy) NSString *source;
@property (nullable, nonatomic, copy) NSString *title;
@property (nullable, nonatomic, copy) NSString *thumb;
@property (nonatomic) int32_t hits;

@end

NS_ASSUME_NONNULL_END
