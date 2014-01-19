#import <UIKit/UIKit.h>
// declaration of checkbox view
@interface CheckboxViewController : UIViewController {
	BOOL checkboxSelected;
	IBOutlet UIButton *checkboxButton;
	
}

- (IBAction)checkboxButton:(id)sender;

@end

