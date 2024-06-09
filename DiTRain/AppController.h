/* 
   Project: DiTRain

   Author: CMDR-DiTRay

   Created: 2022-08-27 16:55:40 +0300 by CMDR-DiTRay
   
   Application Controller
*/
 
#ifndef _PCAPPPROJ_APPCONTROLLER_H
#define _PCAPPPROJ_APPCONTROLLER_H

#import <AppKit/AppKit.h>
#import "View.h"

@interface TimeString : NSString
+ (NSString *) stringFromInt: (unsigned) number;
@end

@interface AppController : NSObject
{
  NSArray * views;
  NSTimer * timer;
  View    * view;
  unsigned  index;
  unsigned  timeCounter;
  
  IBOutlet NSTextField * nameLabel;
  IBOutlet NSImageView * currentImage;
  IBOutlet NSTextField * timerLabel;
  IBOutlet NSButton    * backButton;
  IBOutlet NSButton    * nextButton;
  IBOutlet NSButton    * timerButton;
}

- (IBAction) backPressed: (id) sender;
- (IBAction) nextPressed: (id) sender;
- (IBAction) timerPressed: (id) sender;

+ (void)  initialize;

- (id) init;
- (void) dealloc;

- (void) awakeFromNib;

- (void) applicationDidFinishLaunching: (NSNotification *)aNotif;
- (BOOL) applicationShouldTerminate: (id)sender;
- (void) applicationWillTerminate: (NSNotification *)aNotif;
- (BOOL) application: (NSApplication *)application
	    openFile: (NSString *)fileName;

- (void) showPrefPanel: (id)sender;

- (void) printCurrentTitle;

@end

#endif
