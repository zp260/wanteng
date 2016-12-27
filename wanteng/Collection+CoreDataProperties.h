//
//  Collection+CoreDataProperties.h
//  
//
//  Created by mrz on 2016/12/22.
//
//  This file was automatically generated and should not be edited.
//

#import "Collection+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Collection (CoreDataProperties)

+ (NSFetchRequest<Collection *> *)fetchRequest;

@property (nonatomic) int16_t articleId;
@property (nullable, nonatomic, copy) NSString *articleSource;
@property (nullable, nonatomic, copy) NSString *articleDate;

@end

NS_ASSUME_NONNULL_END
