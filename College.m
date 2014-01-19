// 
//  College.m
//  Tour
//
//  Created by Samuel Clark on 3/24/11.
//  Copyright 2011 College Visions. All rights reserved.
//

#import "College.h"
#import "SettingsTableViewController.h"

@implementation College 

-(NSMutableDictionary*) dic {
	if (!dic) {
		dic = [[NSMutableDictionary alloc] init];
		[self populateDictionary];
	}
	return dic;
}

-(NSMutableArray *) settings {
	NSUserDefaults *currentDefaults = [NSUserDefaults standardUserDefaults];
	NSData *dataRepresentingSavedArray = [currentDefaults objectForKey:@"savedArray"];
	if (dataRepresentingSavedArray != nil) {
		NSArray *oldSavedArray = [NSKeyedUnarchiver unarchiveObjectWithData:dataRepresentingSavedArray];
		
		if (oldSavedArray != nil) {
			settings = [[NSMutableArray alloc] initWithArray:oldSavedArray];
		}
		else {
			settings = [[NSMutableArray alloc]initWithObjects:@"1",@"1",@"1",@"1",@"1",@"1",@"1",nil];
		}
			//[oldSavedArray release];
	}

	return settings;
}

-(void) makeCollege {
	College * college;
	college = [NSEntityDescription insertNewObjectForEntityForName:@"College"
											inManagedObjectContext:self.managedObjectContext];
	college.finalThoughts = @" ";
	//self.dat = [NSDate date];
	[self populateDictionary];
	NSDate *today = [[NSDate alloc]init];
	college.dat = today; 
} 

-(void) buildCategoryArray {
	categoryArray = [[NSMutableArray alloc] initWithObjects: self.weather, self.dorms,self.food, self.town, self.tourGuide,self.campus,self.social,self.academics,self.athletics,self.vibe,nil];
}

-(NSString*)titleKey {
	return self.name;
}

-(NSDate*) getDate {
	NSDate *today = [[NSDate alloc] init];
	self.dat = today;
	return self.dat;
}

-(NSString*) getWeather {
	NSString *weather = [NSString stringWithFormat:@""];
	if ([self.weather intValue] == 0) {
		weather = [weather stringByAppendingString:[NSString stringWithFormat:@"Miserable"]];
	}
	else if ([self.weather intValue] == 1) {
		weather = [weather stringByAppendingString:[NSString stringWithFormat:@"Alright"]];
	}
	else {
		weather = [weather stringByAppendingString:[NSString stringWithFormat:@"Good"]];
	}
	return weather;
}

-(void) populateDictionary {
	[self.dic setObject:self.weather forKey:@"Weather"];
	[self.dic setObject:self.dorms forKey:@"Dorms"];;
	[self.dic setObject:self.food forKey:@"Food"];
	[self.dic setObject:self.town forKey:@"Town"];
	[self.dic setObject:self.tourGuide forKey:@"Tour Guide"];
	[self.dic setObject:self.campus forKey:@"Campus"];
	[self.dic setObject:self.social forKey:@"Social"];
	[self.dic setObject:self.academics forKey:@"Academics"];
	[self.dic setObject:self.athletics forKey:@"Athletics"];
	[self.dic setObject:self.vibe forKey:@"Vibe"];
	if (self.finalThoughts != nil) {
		[self.dic setObject:self.finalThoughts forKey:@"Final Thoughts"];
	}
}

/*
-(void) simpleRating {
	float sum = 0;
	int elements = 0;
	for (int i=0; i<categoryArray.count; i++) {

		if ([categoryArray objectAtIndex:i] != 0) {
			elements++;
				//NSLog(@"%@",[categoryArray objectAtIndex:i]);
			sum+= [[categoryArray objectAtIndex:i] floatValue];
		}
	}
	sum = (sum * 20) /elements;
	self.rating = [NSNumber numberWithFloat:sum];
}
*/

-(NSString*)fullDescription {
	return [NSString stringWithFormat:@"Name = %@, Weather = %@, Dorms = %@, Food = %@, Tour Guide = %@, Campus = %@, Social = %@, Town = %@, Academics = %@, Athletics = %@, Vibe = %@, FinalThoughts = %@", self.name, self.weather, self.dorms,self.food, self.tourGuide,self.campus,self.social,self.town,self.academics,self.athletics,self.vibe,self.finalThoughts];
}

-(NSString*)sectionTitle {
	return [self.name substringToIndex:1];
}

-(float) tourGuideMultiplier:(NSNumber*) tourGuide {
	if (tourGuide.intValue == 3) {		// Great
		return 0.97;
	}
	else if (tourGuide.intValue == 2) {	// Good
		return 0.99;
	}
	else if (tourGuide.intValue == 1) {	// Okay
		return 1.00;
	}
	else {								// Poor
		return 1.03;
	}
}

-(float) convertVibeRating: (NSNumber *) vibeRating {
	if (vibeRating.intValue == 3) {			// Good overall impression
		return 100.00;
	}
	else if (vibeRating.intValue == 2) {	// Alright overall impression
		return 85.00;
	}
	else if (vibeRating.intValue == 1) {	// Ehh overall impression
		return 70.00;
	}
	else {									// No Way overall impression
		return 55.00;
	}
	return -1;
}

-(float) convertStarRatings: (NSNumber *) starRating {
	if (starRating.intValue == 5) {			// 5 star rating
		return 100.00;
	}
	else if (starRating.intValue == 4) {	// 4 star rating
		return 90.00;
	}
	else if (starRating.intValue == 3) {	// 3 star rating
		return 80.00;
	}
	else if (starRating.intValue == 2) {	// 2 star rating
		return 70.00;
	}
	else {									// 1 star rating
		return 60.00;
	}
		// function not called if user doesn't rate a category
}

-(float) campusWeatherMultiplier {
	float campusStarRating = [self convertStarRatings:self.campus];  // this will give you campus' converted star rating
	
	if (self.weather.intValue == 2) {			// nice weather, their ratings need to be lowered by the multiplier
		if (campusStarRating == 100.00) {		// to account for the positive psychological effects of nice weather
			return 0.90;
		}
		if (campusStarRating == 90.00) {
			return 0.89;
		}
		if (campusStarRating == 80.00) {
			return 0.88;
		}
		if (campusStarRating == 70.00) {
			return 0.86;
		}
		if (campusStarRating == 60.00) {
			return 0.83;
		}
	}
	else if (self.weather.intValue == 1) {		// okay weather, their ratings do not need to be changed,
		return 1.00;							// they are in line with reality
	}
	else {										// poor weather, their ratings need to be boosted by the multiplier
		if (campusStarRating == 100.00) {		// to account for the negative psychological effects of poor weather
			return 1.10;
		}
		if (campusStarRating == 90.00) {
			return 1.11;
		}
		if (campusStarRating == 80.00) {
			return 1.13;
		}
		if (campusStarRating == 70.00) {
			return 1.14;
		}
		if (campusStarRating == 60.00) {
			return 1.17;
		}
	}
	return -1;
}

-(float) socialWeatherMultiplier {
	float socialStarRating = [self convertStarRatings:self.social]; // this will give you social's converted star rating
	
	if (self.weather.intValue == 2) {			// nice weather, their ratings need to be lowered by the multiplier
		if (socialStarRating == 100.00) {		// to account for the positive psychological effects of nice weather
			return 0.80;
		}
		if (socialStarRating == 90.00) {
			return 0.78;
		}
		if (socialStarRating == 80.00) {
			return 0.75;
		}
		if (socialStarRating == 70.00) {
			return 0.72;
		}
		if (socialStarRating == 60.00) {
			return 0.67;
		}
	}
	else if (self.weather.intValue == 1) {		// okay weather, their ratings do not need to be changed,
		return 1.00;							// they are in line with reality
	}
	else {										// poor weather, their ratings need to be boosted by the multiplier
		if (socialStarRating == 100.00) {		// to account for the negative psychological effects of poor weather
			return 1.20;
		}
		if (socialStarRating == 90.00) {
			return 1.22;
		}
		if (socialStarRating == 80.00) {
			return 1.25;
		}
		if (socialStarRating == 70.00) {
			return 1.29;
		}
		if (socialStarRating == 60.00) {
			return 1.33;
		}
	}
	return -1;
}

-(float) vibeWeatherMultiplier {
	float vibeStarRating = [self convertVibeRating:self.vibe]; // this will give you vibe's converted star rating
	
	if (self.weather.intValue == 2) {			// nice weather, their ratings need to be lowered by the multiplier
		if (vibeStarRating == 100.00) {			// to account for the positive psychological effects of nice weather
			return 0.85;
		}
		if (vibeStarRating == 85.00) {
			return 0.82;
		}
		if (vibeStarRating == 70.00) {
			return 0.79;
		}
		if (vibeStarRating == 55.00) {
			return 0.73;
		}
	}
	else if (self.weather.intValue == 1) {		// okay weather, their ratings do not need to be changed,
		return 1.00;							// they are in line with reality
	}
	else {										// poor weather, their ratings need to be boosted by the multiplier
		if (vibeStarRating == 100.00) {			// to account for the negative psychological effects of poor weather
			return 1.15;
		}
		if (vibeStarRating == 85.00) {
			return 1.18;
		}
		if (vibeStarRating == 70.00) {
			return 1.21;
		}
		if (vibeStarRating == 55.00) {
			return 1.27;
		}
	}
	return -1;
}

-(float) calculateCollegeRating {
	id key;
	int divisor = 0;
	float total = 0.00;
	float convertedRating = 0.0;
	float preTourGuideRating;
	float postTourGuideRating;
	//int nlpAnalysis;
	
	for (key in dic) {
		if (key != @"Weather" && key != @"Vibe" && key != @"Tour Guide" && key != @"Final Thoughts") {		// if category is a star rating category
			convertedRating = 0.00;															// initialize convertedRating to 0.00
			if ([[dic objectForKey:key]intValue] != 0) {									// if user gave a star rating to category
				convertedRating = [self convertStarRatings:[dic objectForKey:key]];			// convert star rating to float number
				if (key == @"Campus") {
					convertedRating = (convertedRating * [self campusWeatherMultiplier]);	// apply weather multiplier to campus
				}
				if (key == @"Social") {
					convertedRating = (convertedRating * [self socialWeatherMultiplier]);	// apply weather multiplier to social
				}
			}
		}
		else {																				// key == Weather, Vibe, or TourGuide
			if (key == @"Vibe") {
				convertedRating = [self convertVibeRating:[dic objectForKey:key]];			// convert overall impression (vibe) rating to float number
				convertedRating = (convertedRating * [self vibeWeatherMultiplier]);			// apply weather multiplier to vibe
			}
			/*
			 if (key == @"Final Thoughts") {
				nlpAnalysis == [self binaryAnalysisFinalThoughts];
				if (nlpAnalysis == 1) {
					convertedRating = 90.00						// positive experience
				}
				else if (nlpAnalysis == 0) {
					convertedRating = 70.00						// negative experience
				}
				else {
					convertedRating = 0.00						// nothing entered
				}
			 }
			 */
		}
		
			// preferred categories --> add to total and increment divisor (this will count preferred categories 2x)
		if (convertedRating != 0.00 && key == @"Academics") {
			if ([[self.settings objectAtIndex:0] isEqualToString:@"1"]) {
				total = (total + convertedRating);
				divisor = (divisor + 1);
			}
		}
		if (convertedRating != 0.00 && key == @"Athletics") {
			if ([[self.settings objectAtIndex:1] isEqualToString:@"1"]) {
				total = (total + convertedRating);
				divisor = (divisor + 1);
			}
		}
		if (convertedRating != 0.00 && key == @"Dorms") {
			if ([[self.settings objectAtIndex:2] isEqualToString:@"1"]) {
				total = (total + convertedRating);
				divisor = (divisor + 1);
			}
		}
		if (convertedRating != 0.00 && key == @"Food") {
			if ([[self.settings objectAtIndex:3] isEqualToString:@"1"]) {
				total = (total + convertedRating);
				divisor = (divisor + 1);
			}
		}
		if (convertedRating != 0.00 && key == @"Campus") {
			if ([[self.settings objectAtIndex:4] isEqualToString:@"1"]) {
				total = (total + convertedRating);
				divisor = (divisor + 1);
			}
		}
		if (convertedRating != 0.00 && key == @"Town") {
			if ([[self.settings objectAtIndex:5] isEqualToString:@"1"]) {
				total = (total + convertedRating);
				divisor = (divisor + 1);
			}
		}
		if (convertedRating != 0.00 && key == @"Social") {
			if ([[self.settings objectAtIndex:6] isEqualToString:@"1"]) {
				total = (total + convertedRating);
				divisor = (divisor + 1);
			}
		}
			// for all categories (except weather and tour guide)
		if (convertedRating != 0.00 && key != @"Weather" && key != @"TourGuide") {
			total = (total + convertedRating);												// add category rating to total
			divisor = (divisor + 1);														// increment divisor
		}
		convertedRating = 0.00;																// reset convertedRating
	}
	preTourGuideRating = (total / divisor);
	postTourGuideRating = (preTourGuideRating * [self tourGuideMultiplier:self.tourGuide]);
		[settings release];

	
	return postTourGuideRating;	
}

@dynamic social;
@dynamic rating;
@dynamic finalThoughts;
@dynamic food;
@dynamic academics;
@dynamic tourGuide;
@dynamic vibe;
@dynamic dorms;
@dynamic weather;
@dynamic campus;
@dynamic athletics;
@dynamic name;
@dynamic town;
@dynamic dat;

@synthesize dic;
@synthesize settings;

@end
