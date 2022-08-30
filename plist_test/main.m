/*
   Project: plist_test

   Author: Филипп,,,

   Created: 2022-08-27 23:30:40 +0300 by philip
*/

#import <Cocoa/Cocoa.h>
#import <limits.h>

int
main(int argc, const char *argv[])
{
  id pool = [[NSAutoreleasePool alloc] init];

  //Get plist path
  char * cpath = valloc(sizeof(char)*PATH_MAX);
  int arrLen = 0, i;
  
  if (argc > 1)
    strcpy(cpath,argv[1]);
  else
    scanf("%s", cpath);
  
  //Get array of views
  NSString * path = [[NSString alloc] initWithCString: cpath];
  free(cpath);
  
  NSLog(@"%@", path);

  NSDictionary * plistDict = [
    [NSDictionary alloc]  initWithContentsOfFile: path
  ];
  NSArray * views = [plistDict objectForKey: @"Views"];
  
  //Print out contents
  arrLen = [views count];  
  NSString * name = [[NSString alloc] init];
  NSNumber * timeStr = [[NSNumber alloc] init];
  NSTimeInterval time = 0;
  
  for (i = 0; i < arrLen; ++i) {
    name = [[views objectAtIndex: i] objectForKey: @"Name"];
    timeStr = [[views objectAtIndex: i] valueForKey: @"Time"];
    time = [timeStr doubleValue];
        
    NSLog(@"i: %d,\tName: %@,\tTime: %.f", i + 1, name, time);
  }
  
  //NSLog(@"%@", views);
  
  [pool release];

  return 0;
}

