//
//  ContactView.m
//  deadtone
//
//  Created by SARATH DR on 03/12/2012.
//
//

#import "ContactView.h"

@implementation ContactView
@synthesize  callbackId;
- (void)showContact:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options
{
    
    // CDVPluginResult* pluginResult = nil;
    NSString* javaScript = nil;
    
    // NSString *tempId = [arguments objectAtIndex:0];
    // callbackId = tempId;
    
    callbackId = [[arguments objectAtIndex:0] retain];
    
    NSLog (@"%@",callbackId);
    
    //  pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"sarath"];
    //  javaScript = [pluginResult toSuccessCallbackString:callbackId];
    
    
    
    ABPeoplePickerNavigationController *peopleController = [[ABPeoplePickerNavigationController alloc] init];
    //     navigationController = [[UINavigationController alloc] initWithRootViewController
    
    peopleController.peoplePickerDelegate = self;
    [[super viewController] presentModalViewController:peopleController animated:YES];
    [peopleController release];
    
    // [self writeJavascript:javaScript];
    
    
    
    
}


-(void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker
{
    
    [peoplePicker  dismissModalViewControllerAnimated:YES];
    
    CDVPluginResult* pluginResult = nil;
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@""];
    
    NSString* javaScript = nil;
    
    NSLog (@"%@",callbackId);
    
    javaScript = [pluginResult toSuccessCallbackString:callbackId];
    [self writeJavascript:javaScript];
    
    
}


-(BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker
     shouldContinueAfterSelectingPerson:(ABRecordRef)person
                               property:(ABPropertyID)property
                             identifier:(ABMultiValueIdentifier)identifier
{
    return NO;
}


-(BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker
     shouldContinueAfterSelectingPerson:(ABRecordRef)person
{
    //     NSString* fname = (NSString*)ABRecordCopyValue(person, kABPersonFirstNameProperty);
    //     NSString* lname = (NSString*)ABRecordCopyValue(person, kABPersonLastNameProperty);
    //
    //
    //    [self dismissModalViewControllerAnimated:YES];
    
    
    ABPersonViewController *personController = [[ABPersonViewController alloc] init];
    
    personController.personViewDelegate = self;
    personController.allowsEditing = NO;
    personController.displayedPerson = person;
    personController.addressBook = ABAddressBookCreate();
    
    personController.displayedProperties = [NSArray arrayWithObjects:
                                            [NSNumber numberWithInt:kABPersonPhoneProperty],
                                            nil];
    [peoplePicker pushViewController:personController animated:YES];
    [personController release];
    
    return NO;
    
}

- (BOOL) personViewController:(ABPersonViewController*)personView shouldPerformDefaultActionForPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifierForValue
{
    
    NSString* fname = (NSString*)ABRecordCopyValue(person, kABPersonFirstNameProperty);
    NSString* lname = (NSString*)ABRecordCopyValue(person, kABPersonLastNameProperty);
    
    if( [lname length] == 0 )
    {
        lname = @"";
    }
    
    if( [fname length] == 0 )
    {
        fname = @"";
    }
    
	ABMultiValueRef phoneProperty = ABRecordCopyValue(person,property);
	NSString *phone = (NSString *)ABMultiValueCopyValueAtIndex(phoneProperty,identifierForValue );
	
    
    
    [personView dismissModalViewControllerAnimated:YES];
    
    NSString *returnValue = [NSString stringWithFormat:@"%@ %@~%@", fname,lname, phone ];
    
    CDVPluginResult* pluginResult = nil;
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:returnValue];
    
    NSString* javaScript = nil;
    
    
    
    javaScript = [pluginResult toSuccessCallbackString:callbackId];
    [self writeJavascript:javaScript];
    
    
    return NO;
}




@end
