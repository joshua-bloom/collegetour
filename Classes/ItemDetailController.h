//
//  ItemDetailController.h
//  Tour
//
//  Created by Samuel Clark on 4/6/11.
//  Copyright 2011 College Visions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemDetailController : UIViewController <UINavigationControllerDelegate , UIImagePickerControllerDelegate>{
	IBOutlet UIImageView *imageView;
	UIButton *cameraButton;
	int counter;
	NSMutableDictionary *photoName;
}

- (void)saveImage:(UIImage *)image withName:(NSString *)name;
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error 
  contextInfo:(void *)contextInfo;
-(IBAction)takePicture;

@property (nonatomic,retain) IBOutlet UIButton * cameraButton;
@property (nonatomic,retain) NSMutableDictionary* photoName;


@end
