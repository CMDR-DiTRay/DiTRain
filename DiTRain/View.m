/*
   Project: DiTRain

   Copyright (C) 2024 Free Software Foundation

   Author: CMDR-DiTRay

   Created: 2024-06-09 05:43:50 +0400 by CMDR-DiTRay

   This application is free software; you can redistribute it and/or
   modify it under the terms of the GNU General Public
   License as published by the Free Software Foundation; either
   version 2 of the License, or (at your option) any later version.

   This application is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
   Library General Public License for more details.

   You should have received a copy of the GNU General Public
   License along with this library; if not, write to the Free
   Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111 USA.
*/

#import "View.h"

@implementation View

@synthesize name  = _name;
@synthesize time  = _time;
@synthesize image = _image;

- (void) updateFromArray: (NSArray *) views atIndex: (unsigned) i
{
  self.name = [[views objectAtIndex: i] objectForKey: @"Name"];
  NSLog(@"Name: %@", self.name);
    
  NSString * timeStr = [[views objectAtIndex: i] valueForKey: @"Time"];
  self.time = [timeStr doubleValue];
  NSLog(@"Time: %@", timeStr);
  
  NSString *imagePath = [[views objectAtIndex: i] valueForKey: @"Image"];
  NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
  NSString *fullImagePath = [resourcePath stringByAppendingPathComponent:
                              [NSString stringWithFormat:
                                @"Images/%@", imagePath]];
  
  NSLog(@"Image path: %@", imagePath);
  
  NSImage *tmpImage = [[NSImage alloc] initWithContentsOfFile:fullImagePath];

  if (tmpImage == nil) {
    NSLog(@"Error loading file: %@", fullImagePath);
    [tmpImage release];
    tmpImage = nil;
  }
  
  [self setImage: tmpImage];
}
@end
