# DiTRain
Sports training program

## Intro
This is your simple sports e-trainer. It will help you to inflate a beautiful press in an extremely short time using a very effective technique. You can also add your own set of exercises and make this program even more useful for you. Train smart and be healthy! :wink:

## Description
Initially the program is designed to help in press workout using an extremely effective technique, however anyone can implement their own exercises using JSON-like or XML-like property list (plist) files. Default plist files are located in Resources folder.

There is also an extra utility which can check your custom configuration files. To find more info check "plist_test" subrepository ([plist_test](<https://github.com/CMDR-DiTRay/DiTRain/tree/main/plist_test>)).

The project is in pre-alpha state now, but the plist_test utility already works. Currently the program should work on any OS with GNUstep environment preinstalled. With version 1.0 native Mac OS X support will be added as well as the precompiled binary packages for Mac OS X, macOS and GNUstep on Linux and FreeBSD.

## Background
I like Objective-C, and once I found an interesting article, which described how to make press better in a very short amount of time. However, it was hard to follow the list on screen, do exercises and reset a timer in the same time. So, I decided to make this process easier so that nothing should distract me from just doing exercises. I wrote an app for Mac OS X, but unfortunately the source code is long gone.

Recently, I discovered GNUstep: a free and open source implementation of NeXTSTEP and Mac OS X frameworks. Thus, I decided to recreate the project to write something in Objective-C, to know GNUstep better and to make my app portable.
