#import "Jastor.h"
#import "JastorRuntimeHelper.h"

#define PROPERTY_NAMES(aclass) [JastorRuntimeHelper propertyNames:aclass]

@implementation Jastor

@synthesize objectId;
static NSString *idPropertyName = @"id";
static NSString *idPropertyNameOnObject = @"objectId";

Class nsDictionaryClass;
Class nsArrayClass;

+ (id)objectFromDictionary:(NSDictionary*)dictionary {
    id item = [[[self alloc] initWithDictionary:dictionary] autorelease];
    return item;
}


- (void)dealloc {
	self.objectId = nil;
    //	for (NSString *key in [JastorRuntimeHelper propertyNames:[self class]]) {
    //		//[self setValue:nil forKey:key];
    //	}
	//NSLog(@"dealloc [%@]",NSStringFromClass([self class]));
	[super dealloc];
}
- (id)initWithDictionary:(NSDictionary *)dictionary {
	if (!nsDictionaryClass) nsDictionaryClass = [NSDictionary class];
	if (!nsArrayClass) nsArrayClass = [NSArray class];
    self = [super init];
	if (self && dictionary) {
        NSArray *propertyNames = PROPERTY_NAMES([self class]);
		for (NSString *key in propertyNames) {            
			id value = [dictionary valueForKey:key];
			if (value == [NSNull null] || value == nil) {
                continue;
            }
            if ([JastorRuntimeHelper isPropertyReadOnly:[self class] propertyName:key]) {
                continue;
            }
			// handle dictionary
			if ([value isKindOfClass:nsDictionaryClass]) {
				Class klass = [JastorRuntimeHelper propertyClassForPropertyName:key ofClass:[self class]];
				value = [[[klass alloc] initWithDictionary:value] autorelease];
			}
			// handle array
			else if ([value isKindOfClass:nsArrayClass]) {
                //[self class]
                SEL subSel = NSSelectorFromString([NSString stringWithFormat:@"%@_class", key]);
                if ([self respondsToSelector:subSel]) {
                    
                    Class arrayItemType = [self performSelector:NSSelectorFromString([NSString stringWithFormat:@"%@_class", key])];
                    NSMutableArray *childObjects = [NSMutableArray arrayWithCapacity:[(NSArray*)value count]];
                    for (id child in value) {
                        if ([[child class] isSubclassOfClass:nsDictionaryClass]) {
                            Jastor *childDTO = [[[arrayItemType alloc] initWithDictionary:child] autorelease];
                            [childObjects addObject:childDTO];
                        } else {
                            [childObjects addObject:child];
                        }
                    }
                    value = childObjects;
                }
                
			} 
			// handle all others
            Class klass = [JastorRuntimeHelper propertyClassForPropertyName:key ofClass:[self class]];
            if([value isKindOfClass:klass]){
                [self setValue:value forKey:key];
            }else{
                if([NSStringFromClass(klass) isEqualToString:NSStringFromClass([NSString class])]){
                    [self setValue:[NSString stringWithFormat:@"%@",value] forKey:key];
                }else if([NSStringFromClass(klass) isEqualToString:NSStringFromClass([NSNumber class])]){
                    if([value isKindOfClass:[NSString class]]){
                        [self setValue:[NSNumber numberWithDouble:((NSString *)value).doubleValue] forKey:key];
                    }
                }
            }
		}
		
		id objectIdValue;
		if ((objectIdValue = [dictionary objectForKey:idPropertyName]) && objectIdValue != [NSNull null]) {
			if (![objectIdValue isKindOfClass:[NSString class]]) {
				objectIdValue = [NSString stringWithFormat:@"%@", objectIdValue];
			}
            
			[self setValue:objectIdValue forKey:idPropertyNameOnObject];
		}
	}
	return self;	
}



- (void)encodeWithCoder:(NSCoder*)encoder {
	[encoder encodeObject:self.objectId forKey:idPropertyNameOnObject];
	for (NSString *key in [JastorRuntimeHelper propertyNames:[self class]]) {
		[encoder encodeObject:[self valueForKey:key] forKey:key];
	}
}

- (id)initWithCoder:(NSCoder *)decoder {
	if ((self = [super init])) {
		[self setValue:[decoder decodeObjectForKey:idPropertyNameOnObject] forKey:idPropertyNameOnObject];
		
		for (NSString *key in [JastorRuntimeHelper propertyNames:[self class]]) {
            if ([JastorRuntimeHelper isPropertyReadOnly:[self class] propertyName:key]) {
                continue;
            }
			id value = [decoder decodeObjectForKey:key];
			if (value != [NSNull null] && value != nil) {
				[self setValue:value forKey:key];
			}
		}
	}
	return self;
}

- (NSMutableDictionary *)toDictionary {
	NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (self.objectId) {
        [dic setObject:self.objectId forKey:idPropertyName];
    }
	
	for (NSString *key in [JastorRuntimeHelper propertyNames:[self class]]) {
		id value = [self valueForKey:key];
        if (value && [value isKindOfClass:[Jastor class]]) {            
            [dic setObject:[value toDictionary] forKey:key];
        } else if (value && [value isKindOfClass:[NSArray class]] && ((NSArray*)value).count > 0) {
            id internalValue = [value objectAtIndex:0];
            if (internalValue && [internalValue isKindOfClass:[Jastor class]]) {
                NSMutableArray *internalItems = [NSMutableArray array];
                for (id item in value) {
                    [internalItems addObject:[item toDictionary]];
                }
                [dic setObject:internalItems forKey:key];
            } else {
                [dic setObject:value forKey:key];
            }
        } else if (value != nil) {
            [dic setObject:value forKey:key];
        }
	}
    return dic;
}

- (NSString *)description {
    NSMutableDictionary *dic = [self toDictionary];
	
	return [NSString stringWithFormat:@"#<%@: id = %@ %@>", [self class], self.objectId, [dic description]];
}

- (BOOL)isEqual:(id)object {
	if (object == nil || ![object isKindOfClass:[Jastor class]]) return NO;
	
	Jastor *model = (Jastor *)object;
	
	return [self.objectId isEqualToString:model.objectId];
}

@end
