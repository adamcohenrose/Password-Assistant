
#import <Cocoa/Cocoa.h>
#import <AppKit/NSResponder.h>

@interface Controller : NSViewController <NSApplicationDelegate>
{
    IBOutlet NSMenu *_menu;
}
- (IBAction)showPasswordAssistantPanel:(id)sender;

@end
