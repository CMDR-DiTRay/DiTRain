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
  NSString * str       = [[NSString alloc] initWithString: @""];
  NSString * hourStr   = [[NSString alloc] initWithString: @""];
  NSString * minuteStr = [[NSString alloc] initWithString: @""];
  NSString * secondStr = [[NSString alloc] initWithString: @""];
  
  unsigned hour   = 0,
           minute = 0,
           second = 0;
           
  hour   = number / 3600;
  minute = (number % 3600) / 60;
  second = number % 60;
  
  if (hour > 0)
    hourStr   = [NSString stringWithFormat: @"%u:",   hour];
  
  if ((hour > 0) && (minute < 10))
    minuteStr = [NSString stringWithFormat: @"0%u:", minute];
  else
    minuteStr = [NSString stringWithFormat: @"%u:", minute];
  secondStr = [NSString stringWithFormat: @"%u", second];
  
  if (second < 10)
    secondStr = [NSString stringWithFormat: @"0%u", second];
  else
    secondStr = [NSString stringWithFormat: @"%u", second];
  
  str = [NSString stringWithFormat: @"%@%@%@", hourStr, minuteStr, secondStr];
  
  return str;
}
@end

@implementation AppController

- (IBAction) backPressed: (id) sender
{
  [timer invalidate];
  timer = nil;
  [timerButton setTitle: [self buttonTitleStart: YES]];

  if ([nextButton isHidden])
    [nextButton setHidden: NO];

  index--;

  [view updateFromArray: views atIndex: index];
  [self printCurrentTitle];
  timeCounter = [view time];
  [timerLabel setStringValue: [TimeString stringFromInt: timeCounter]];
  [currentImage setImage: [view image]];
  
  if (index == 0)
    [backButton setHidden: YES];
}

- (IBAction) nextPressed: (id) sender
{
  [timer invalidate];
  timer = nil;
  [timerButton setTitle: [self buttonTitleStart: YES]];

  if ([backButton isHidden])
    [backButton setHidden: NO];

  index++;
    
  [view updateFromArray: views atIndex: index];
  [self printCurrentTitle];
  timeCounter = [view time];
  [timerLabel setStringValue: [TimeString stringFromInt: timeCounter]];
  [currentImage setImage: [view image]];
  
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
    [timerButton setTitle: [self buttonTitleStart: YES]];
    return;
  }
  
  [timerButton setTitle: [self buttonTitleStart: NO]];
  
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
  if ((self = [super init]))
  {
    lang = [[NSString alloc] init];
    currentImage = [[NSImageView alloc] init];
    view = [[View alloc] init];
    index = 0;
    timer = nil;
  }
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
  // Detect language
  if ([[timerButton title] containsString: @"Старт"])
    lang = @"RUS";
  else
    lang = @"ENG";
  NSLog(@"Title: %@; Lang: %@", [timerButton title], lang);

  // Select excersises plist according to language
  NSString * plistName = [[NSString alloc] init];
  if ([lang isEqualTo: @"ENG"])
    plistName = @"ExcersisesEng.plist";
  if ([lang isEqualTo: @"RUS"])
    plistName = @"ExcersisesRus.plist"; 
  
  // Check if excersises plist exists
  NSString * plistPath = 
  [
    [
      [NSBundle mainBundle] resourcePath
    ] stringByAppendingPathComponent: plistName
  ];
  NSFileManager *fileManager = [NSFileManager defaultManager];
  if (![fileManager fileExistsAtPath: plistPath])
  {
    NSLog(@"File \"%@\" does not exist. Quitting...", plistPath);
    [self release];
    self = nil;
    exit(1);
  }
  
  // Try to load excersises plist
  NSDictionary * plistDict = [
    [NSDictionary alloc]  initWithContentsOfFile: plistPath
  ];
  views = [[NSArray alloc] initWithArray: [plistDict objectForKey: @"Views"]];

  if (views == nil)
  {
    NSLog(@"No views");
    [self release];
    exit(1);
  }
  
  // Initialize interface
  [backButton setHidden: YES];
  
  if ([views count] < 2)
    [nextButton setHidden: YES];

  [view updateFromArray: views atIndex: index];
  [self printCurrentTitle];
  timeCounter = [view time];
  [timerLabel setStringValue: [TimeString stringFromInt: timeCounter]];
  
  [currentImage setImage: [view image]];
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
        @"%@ (%d/%lu)", [view name], index + 1, [views count]
    ]
  ];
}

- (NSString *) buttonTitleStart: (BOOL)start
{
  NSString * title = [[NSString alloc] init];
  if ([lang isEqualTo: @"RUS"])
  {
    if (start)
      title = @"Старт";
    else
      title = @"Стоп";
  }
  else
  {
    if (start)
      title = @"Start";
    else
      title = @"Stop";
  }
  
  return title;
}

- (void) timerTick
{
  [timerLabel setStringValue: [TimeString stringFromInt: --timeCounter]];
  NSLog(@"Tick...");
  
  if (timeCounter == 0) {
    //[[NSSound soundNamed:@"Glass"] play];
    NSBeep();
    [timer invalidate];
    timer = nil;
    
    [timerButton setTitle: [self buttonTitleStart: YES]];
  }
}

@end
