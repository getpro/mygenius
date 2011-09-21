/*
 Erica Sadun, http://ericasadun.com
 iPhone Developer's Cookbook, 3.0 Edition
 BSD License, Use at your own risk
 */

#import "ABContactsHelper.h"
#import "ContactData.h"
#import "AddressBookAppDelegate.h"

@implementation ABContactsHelper
/*
 Note: You cannot CFRelease the addressbook after ABAddressBookCreate();
 */
+ (ABAddressBookRef) addressBook
{
	if(addressBook == nil)
		return ABAddressBookCreate();
	else
		return addressBook;
}



// Sorting
+ (BOOL) firstNameSorting
{
	return (ABPersonGetCompositeNameFormat() == kABPersonCompositeNameFormatFirstNameFirst);
}

#pragma mark Contact Management

// Thanks to Eridius for suggestions re: error
+ (BOOL) addContact: (ABContact *) aContact withError: (NSError **) error
{
	if (!ABAddressBookAddRecord(addressBook, aContact.record, (CFErrorRef *) error)) return NO;
	return ABAddressBookSave(addressBook, (CFErrorRef *) error);
}

+ (BOOL) addGroup: (ABGroup *) aGroup withError: (NSError **) error
{
	if (!ABAddressBookAddRecord(addressBook, aGroup.record, (CFErrorRef *) error)) return NO;
	return ABAddressBookSave(addressBook, (CFErrorRef *) error);
}

+ (NSArray *) contactsMatchingName: (NSString *) fname
{
	AddressBookAppDelegate * app = [AddressBookAppDelegate getAppDelegate];
	
	NSPredicate *pred;
	NSArray     *contacts = app.m_pContactData.contactsArray;
	
	pred = [NSPredicate predicateWithFormat:@"firstname contains[cd] %@ OR lastname contains[cd] %@ OR nickname contains[cd] %@ OR middlename contains[cd] %@", fname, fname, fname, fname];
	return [contacts filteredArrayUsingPredicate:pred];
}

+ (NSArray *) contactsMatchingName: (NSString *) fname andName: (NSString *) lname
{
	AddressBookAppDelegate * app = [AddressBookAppDelegate getAppDelegate];
	
	NSPredicate *pred;
	NSArray     *contacts = app.m_pContactData.contactsArray;
	pred = [NSPredicate predicateWithFormat:@"firstname contains[cd] %@ OR lastname contains[cd] %@ OR nickname contains[cd] %@ OR middlename contains[cd] %@", fname, fname, fname, fname];
	contacts = [contacts filteredArrayUsingPredicate:pred];
	pred = [NSPredicate predicateWithFormat:@"firstname contains[cd] %@ OR lastname contains[cd] %@ OR nickname contains[cd] %@ OR middlename contains[cd] %@", lname, lname, lname, lname];
	contacts = [contacts filteredArrayUsingPredicate:pred];
	return contacts;
}

+ (NSArray *) contactsMatchingPhone: (NSString *) number
{
	AddressBookAppDelegate * app = [AddressBookAppDelegate getAppDelegate];
	
	NSPredicate *pred;
	NSArray     *contacts = app.m_pContactData.contactsArray;
	pred = [NSPredicate predicateWithFormat:@"phonenumbers contains[cd] %@", number];
	return [contacts filteredArrayUsingPredicate:pred];
}

+ (NSArray *) contacts
{
	NSArray *thePeople = (NSArray *)ABAddressBookCopyArrayOfAllPeople(addressBook);
	NSMutableArray *array = [NSMutableArray arrayWithCapacity:thePeople.count];
	for (id person in thePeople)
		[array addObject:[ABContact contactWithRecord:(ABRecordRef)person]];
	[thePeople release];
	return array;
}

+ (int) contactsCount
{
	return ABAddressBookGetPersonCount(addressBook);
}

+ (int) contactsWithImageCount
{
	NSArray *peopleArray = (NSArray *)ABAddressBookCopyArrayOfAllPeople(addressBook);
	int ncount = 0;
	for (id person in peopleArray) if (ABPersonHasImageData(person)) ncount++;
	[peopleArray release];
	return ncount;
}

+ (int) contactsWithoutImageCount
{
	NSArray *peopleArray = (NSArray *)ABAddressBookCopyArrayOfAllPeople(addressBook);
	int ncount = 0;
	for (id person in peopleArray) if (!ABPersonHasImageData(person)) ncount++;
	[peopleArray release];
	return ncount;
}

// Groups
+ (int) numberOfGroups
{
	NSArray *groups = (NSArray *)ABAddressBookCopyArrayOfAllGroups(addressBook);
	int ncount = groups.count;
	[groups release];
	return ncount;
}

+ (NSArray *) groups
{
	NSArray *groups = (NSArray *)ABAddressBookCopyArrayOfAllGroups(addressBook);
	NSMutableArray *array = [NSMutableArray arrayWithCapacity:groups.count];
	for (id group in groups)
		[array addObject:[ABGroup groupWithRecord:(ABRecordRef)group]];
	[groups release];
	return array;
}

@end