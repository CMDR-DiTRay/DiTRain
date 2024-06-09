/* 
   Project: DiTRain

   Author: CMDR-DiTRay

   Created: 2022-08-27 16:55:40 +0300 by CMDR-DiTRay
   
   Application Controller
*/

#import "AppController.h"

@implementation TimeString : NSString
+ (NSString *) stringFromInt: (unsigned) number
{
  NSString * str = [[NSString alloc] initWithString: @""];
  unsigned tmpl    = 0,
           tmpr    = number,
           divider = 3600;
  BOOL     started = NO,
           first    = YES;
           
  do
  {
    tmpl = tmpr / divider;
    tmpr = tmpr % divider;
    if ((tmpl == 0) && (tmpr > 0) && !started)
    {
      divider /= 60;
      continue;
    }
    started = YES;
    if ((tmpl < 10) && !first)
    {
      str = [NSString stringWithFormat: @"%@0%u", str, tmpl];
    }
    else
    {
      str = [NSString stringWithFormat: @"%@%u", str, tmpl];
    }
    if (divider >= 60)
    {
      str = [NSString stringWithFormat: @"%@:", str];
    } else if ((number / 60) == 0)
    {
      str = [NSString stringWithFormat: @"0:%@", str];
    }
    divider /= 60;
    first = NO;
  } while ((divider >= 1) > 0);
  
  return str;
}
@end

@implementation AppController

- (IBAction) backPressed: (id) sender
{
  if ([nextButton isHidden])
    [nextButton setHidden: NO];

  index--;

  [view updateFromArray: views atIndex: index];
  [self printCurrentTitle];
  
  if (index == 0)
    [backButton setHidden: YES];
}

- (IBAction) nextPressed: (id) sender
{
  if ([backButton isHidden])
    [backButton setHidden: NO];

  index++;
    
  [view updateFromArray: views atIndex: index];
  [self printCurrentTitle];
  
  if (([views count] - 1) == index && ![nextButton isHidden])
    [nextButton setHidden: YES];
}

- (IBAction) timerPressed: (id) sender
{
  timeCounter = [view time];
  [timerLabel setStringValue: [TimeString stringFromInt: timeCounter]];

  if (timer)
  {
    [timer invalidate];
    timer = nil;
    [timerButton setTitle: @"Start"];
    return;
  }
  
  [timerButton setTitle: @"Stop"];
  
  timer = [NSTimer scheduledTimerWithTimeInterval:1.0
           target:self
           selector:@selector(timerTick)
           userInfo:nil
           repeats:YES];
}

+ (void) initialize
{
  NSMutableDictionary *defaults = [NSMutableDictionary dictionary];

  /*
   * Register your app's defaults here by adding objects to the
   * dictionary, eg
   *
   * [defaults setObject:anObject forKey:keyForThatObject];
   *
   */
  
  [[NSUserDefaults standardUserDefaults] registerDefaults: defaults];
  [[NSUserDefaults standardUserDefaults] synchronize];
}

- (id) init
{
  NSString *plistPath =
  [
    [
      [NSBundle mainBundle] resourcePath
    ] stringByAppendingPathComponent:@"ExcersisesEng.plist"
  ];

  NSFileManager *fileManager = [NSFileManager defaultManager];
  if (![fileManager fileExistsAtPath: plistPath])
  {
    NSLog(@"File \"%@\" does not exist. Quitting...", plistPath);
    [self release];
    self = nil;
    exit(1);
  }
  
  if ((self = [super init]))
  {
    NSDictionary * plistDict = [
      [NSDictionary alloc]  initWithContentsOfFile: plistPath
    ];
    views = [[NSArray alloc] initWithArray: [plistDict objectForKey: @"Views"]];
    
    if (views == nil)
    {
      NSLog(@"No views");
      [self release];
      return nil;
    }
    
    view = [[View alloc] init];
    index = 0;
    timer = nil;
  }
  
  //NSLog(@"R1:  %@",[TimeString stringFromInt: 39662]);
  //NSLog(@"R2:  %@",[TimeString stringFromInt: 40262]);
  //NSLog(@"R3:  %@",[TimeString stringFromInt: 40271]);
  //NSLog(@"R4:  %@",[TimeString stringFromInt: 32462]);
  //NSLog(@"R5:  %@",[TimeString stringFromInt: 33062]);
  //NSLog(@"R6:  %@",[TimeString stringFromInt: 33071]);
  //NSLog(@"R7:  %@",[TimeString stringFromInt: 62]);
  //NSLog(@"R8:  %@",[TimeString stringFromInt: 662]);
  //NSLog(@"R9:  %@",[TimeString stringFromInt: 671]);
  //NSLog(@"R10:  %@",[TimeString stringFromInt: 2]);
  //NSLog(@"R11:  %@",[TimeString stringFromInt: 11]);
  //NSLog(@"R12:  %@",[TimeString stringFromInt: 3602]);
  //NSLog(@"R13:  %@",[TimeString stringFromInt: 3600]);
  //NSLog(@"R14:  %@",[TimeString stringFromInt: 60]);
  
  return self;
}

- (void) dealloc
{
  [super dealloc];
}

- (void) awakeFromNib
{
}

- (void) applicationDidFinishLaunching: (NSNotification *)aNotif
{
  [backButton setHidden: YES];
  
  if ([views count] < 2)
    [nextButton setHidden: YES];

  [view updateFromArray: views atIndex: index];
  [self printCurrentTitle];
  //[timeLabel]
}

- (BOOL) applicationShouldTerminate: (id)sender
{
  return YES;
}

- (void) applicationWillTerminate: (NSNotification *)aNotif
{
}

- (BOOL) application: (NSApplication *)application
	    openFile: (NSString *)fileName
{
  return NO;
}

- (void) showPrefPanel: (id)sender
{
}

- (void) printCurrentTitle
{
  NSLog(@"Trying to change name...");
  [
    nameLabel setStringValue: 
    [
      NSString stringWithFormat:
        @"%@ (%d/%d)", [view name], index + 1, [views count]
    ]
  ];
}

- (void) timerTick
{
  [timerLabel setStringValue: [TimeString stringFromInt: --timeCounter]];
  NSLog(@"Tick...");
  
  if (timeCounter == 0) {
    [timer invalidate];
    timer = nil;
  }
}

@end
