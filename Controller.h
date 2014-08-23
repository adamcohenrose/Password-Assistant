
#import <Cocoa/Cocoa.h>

@interface Controller : NSViewController <NSApplicationDelegate>
    
@property (nonatomic,strong) IBOutlet NSMenu *menu;
- (IBAction)showPasswordAssistantPanel:(id)sender;
   

@end
