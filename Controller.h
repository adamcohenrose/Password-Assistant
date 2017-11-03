
#import <Cocoa/Cocoa.h>

@interface Controller : NSViewController <NSApplicationDelegate>
    
@property (nonatomic,strong) IBOutlet NSMenu *mymenu;
- (IBAction)showPasswordAssistantPanel:(id)sender;
   

@end
