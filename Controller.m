#import "Controller.h"
#import "SFPasswordAssistantInspectorController.h"

@implementation Controller {
    SFPasswordAssistantInspectorController *pwAsst;
    NSStatusItem *statusItem;
}

- (void)awakeFromNib {
    // Get icon from bundle and create image of the right size
    
    NSURL* iconURL = [[NSBundle mainBundle] URLForResource:@"Unlock-256" withExtension:@"icns"];
    NSImage* image = [[NSImage alloc] initWithContentsOfURL:iconURL];
    float statusBarThickness = [[NSStatusBar systemStatusBar] thickness];
    [image setSize:NSMakeSize(statusBarThickness, statusBarThickness)];
    
    // Init statusItem:
    
    statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSSquareStatusItemLength];
    [statusItem setImage: image];
    [statusItem setEnabled:YES];
    [statusItem setToolTip:@"Password Assistant"];
    [statusItem setHighlightMode:YES];
    [statusItem setTarget:self];
    [statusItem setAction:@selector(showPasswordAssistantPanel:)];
}

- (IBAction)showPasswordAssistantPanel:(id)sender {
    if (pwAsst) {
        [pwAsst closePasswordAssistantPanel];
    }
    
    pwAsst = [[SFPasswordAssistantInspectorController alloc] init];
    
    // Load the nib to force pwAsst to create its panel without showing the panel to the
    // user.  Then hide the panel by setting its alpha to zero, before doing the normal
    // password assistant startup.  This order of events is required to avoid flashing
    // the panel on startup in its standard location in the lower-left.
    
    [pwAsst loadOurNib];
    [[pwAsst panel] setAlphaValue:0];
    [pwAsst showPasswordAssistantPanel:sender];
    

    // Place the panel directly underneat the status bar icon.
    if (sender && [sender isKindOfClass:[NSView class]]) {
        NSPanel* panel = [pwAsst panel];
        NSRect frame = [panel convertRectFromScreen:[[sender window] convertRectToScreen:[sender frame]]];
        NSPoint topLeft = frame.origin;
        topLeft.y += frame.size.height;
        [panel setFrameTopLeftPoint:topLeft];
    }
    
    // Once the panel is set up in the right place, show it to the user.
    [[pwAsst panel] setAlphaValue:1];
    [[pwAsst panel] makeKeyAndOrderFront:sender];
    
    [NSApp activateIgnoringOtherApps:YES];
}

@end
