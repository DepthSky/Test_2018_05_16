//
//	TestModel.m
//
//	Create by shinyv on 27/7/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "TestModel.h"

NSString *const kTestModelLabel = @"label";
NSString *const kTestModelMark = @"mark";
NSString *const kTestModelTitle = @"title";

@interface TestModel ()
@end
@implementation TestModel




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kTestModelLabel] isKindOfClass:[NSNull class]]){
		self.label = dictionary[kTestModelLabel];
	}	
	if(![dictionary[kTestModelMark] isKindOfClass:[NSNull class]]){
		self.mark = dictionary[kTestModelMark];
	}	
	if(![dictionary[kTestModelTitle] isKindOfClass:[NSNull class]]){
		self.title = dictionary[kTestModelTitle];
	}	
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.label != nil){
		dictionary[kTestModelLabel] = self.label;
	}
	if(self.mark != nil){
		dictionary[kTestModelMark] = self.mark;
	}
	if(self.title != nil){
		dictionary[kTestModelTitle] = self.title;
	}
	return dictionary;

}

/**
 * Implementation of NSCoding encoding method
 */
/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
- (void)encodeWithCoder:(NSCoder *)aCoder
{
	if(self.label != nil){
		[aCoder encodeObject:self.label forKey:kTestModelLabel];
	}
	if(self.mark != nil){
		[aCoder encodeObject:self.mark forKey:kTestModelMark];
	}
	if(self.title != nil){
		[aCoder encodeObject:self.title forKey:kTestModelTitle];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.label = [aDecoder decodeObjectForKey:kTestModelLabel];
	self.mark = [aDecoder decodeObjectForKey:kTestModelMark];
	self.title = [aDecoder decodeObjectForKey:kTestModelTitle];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	TestModel *copy = [TestModel new];

	copy.label = [self.label copy];
	copy.mark = [self.mark copy];
	copy.title = [self.title copy];

	return copy;
}
@end