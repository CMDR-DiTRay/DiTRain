/*
   Project: DiTRain

   Copyright (C) 2024 Free Software Foundation

   Author: CMDR-DiTRay

   Created: 2024-06-09 05:44:00 +0400 by CMDR-DiTRay

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

#ifndef _VIEWS_H_
#define _VIEWS_H_

#import <Foundation/Foundation.h>
#import <AppKit/NSImage.h>

@interface View : NSObject
{
  NSString * _name;
  double     _time;
  NSImage  * _image;
}

@property (retain) NSString * name;
@property (assign) double time;
@property (retain) NSImage  * image;

- (void) updateFromArray: (NSArray *) views atIndex: (unsigned) i;

@end
#endif // _VIEWS_H_

