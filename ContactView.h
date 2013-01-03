//
//  ContactView.h
//  deadtone
//
//  Created by SARATH DR on 03/12/2012.
//
//

#import <Foundation/Foundation.h>
#import <Cordova/CDVPlugin.h>
#import <Cordova/CDVPluginResult.h>
#import <AddressBookUI/AddressBookUI.h>

@interface ContactView : CDVPlugin

@property(nonatomic,retain) NSString* callbackId;

-init;
-(void) showContact:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options;
-(void) dealloc;

@end
