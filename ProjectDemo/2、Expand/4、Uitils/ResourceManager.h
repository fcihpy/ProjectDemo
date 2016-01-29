//
//  ResourceManager.h
//  T2
//
//  Created by lirongfeng on 14/12/24.
//  Copyright (c) 2014年 xujunli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIImage.h>
#import <UIKit/UIDevice.h>
#import <UIKit/UIScreen.h>


#define STR_FILE (@"str_chs")
#define ERROR_FILE (@"error")

@interface ResourceManager : NSObject

+(ResourceManager*) shareManager;

- (instancetype)init;
- (void) initStr;

-(NSString*) strNamed:(NSString*) key;
-(id) IdNamed:(NSString*) key;

+(NSMutableDictionary*) readPlist:(NSString*)fileName;
+(NSArray *) readPlistForcountry:(void (^)(NSArray *array)) rblock;

-(NSString*) errorIded:(NSString*)key;

-(NSString *) resourStrforModel:(NSInteger)model andKey:(NSString *)key;

@end
//-(UIImage*) imageNamed:(NSString*) name;

//#define IMAGE_NAMED(name)  ([[ResourceManager shareManager]  imageNamed:name])
#define STR_NAMED(name)  ([[ResourceManager shareManager]  strNamed:name])
#define ID_NAMED(name)   ([[ResourceManager shareManager]  IdNamed:name])
#define ERROR_IDED(id)   ([[ResourceManager shareManager]  errorIded:id])
