//
//  College.h
//  Tour
//
//  Created by Samuel Clark on 3/24/11.
//  Copyright 2011 College Visions. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface College :  NSManagedObject  {
	NSMutableArray *categoryArray;
	NSMutableDictionary *dic;
	NSMutableArray *settings;
}

-(void) makeCollege;
-(void)buildCategoryArray;
-(float)calculateCollegeRating;
-(void) populateDictionary;
-(NSString*) fullDescription;
-(NSDate*)getDate;
-(NSString*) getWeather;
//-(void) simpleRating;
//-(NSString*) titleKey;

@property (nonatomic, retain) NSMutableArray *settings;
@property (nonatomic, retain) NSMutableDictionary *dic;
@property (nonatomic, readonly) NSString* titleKey;
@property (nonatomic, retain) NSDate   * dat;
@property (nonatomic, retain) NSNumber * social;
@property (nonatomic, retain) NSNumber * rating;
@property (nonatomic, retain) NSString * finalThoughts;
@property (nonatomic, retain) NSNumber * food;
@property (nonatomic, retain) NSNumber * academics;
@property (nonatomic, retain) NSNumber * tourGuide;
@property (nonatomic, retain) NSNumber * vibe;
@property (nonatomic, retain) NSNumber * dorms;
@property (nonatomic, retain) NSNumber * town;
@property (nonatomic, retain) NSNumber * weather;
@property (nonatomic, retain) NSNumber * campus;
@property (nonatomic, retain) NSNumber * athletics;
@property (nonatomic, retain) NSString * name;


@end



