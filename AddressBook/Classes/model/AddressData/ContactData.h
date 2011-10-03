//
//  ContactData.h
//  Phone
//
//  Created by angel li on 10-9-20.
//  Copyright 2010 Lixf. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ABContact.h"

@interface ContactData : NSObject 
{
	NSMutableArray * contactsArray;
}

@property (nonatomic,retain) NSMutableArray * contactsArray;

- (id)initWithArry:(NSArray *)pArry;

//+(NSArray *) contactsArray; // people

//Equal contacts was exist in address book
-(NSDictionary *) hasContactsExistInAddressBookByPhone:(NSString *)phone;

//Get contact
-(ABContact *) byPhoneNumberAndLabelToGetContact:(NSString *)phone withLabel:(NSString *)label;
-(ABContact *) byPhoneNumberAndNameToGetContact:(NSString *)name withPhone:(NSString *)phone;
-(ABContact *) byNameToGetContact:(NSString *)name;
-(ABContact *) byPhoneNumberlToGetContact:(NSString *)phone withLabel:(NSString *)label;

+(NSArray *) getPhoneNumberAndPhoneLabelArray:(ABContact *) contact;
+(NSArray *) getPhoneNumberAndPhoneLabelArrayFromABRecodID:(ABRecordRef)person withABMultiValueIdentifier:(ABMultiValueIdentifier)identifierForValue;

+(NSString *) getPhoneNumberFromDic:(NSDictionary *) Phonedic;
+(NSString *) getPhoneLabelFromDic:(NSDictionary *) Phonedic;
+(NSString *) getPhoneNameFromDic:(NSDictionary *) Phonedic;

+(BOOL)addPhone:(ABContact *)contact phone:(NSString*)phone;

+(NSString *)getPhoneNumberFomat:(NSString *)phone;

+(BOOL)doesStringContain:(NSString* )string Withstr:(NSString*)charcter;

-(NSString *)equalContactByAddressBookContacts:(NSString *)name withPhone:(NSString *)phone withLabel:(NSString *)label PhoneOrLabel:(BOOL)isPhone withFavorite:(BOOL)isFavorite;

-(NSString *)getContactsNameByPhoneNumberAndLabel:(NSString *)phone withLabel:(NSString *)label;
-(NSString *)getContactsNameByID:(ABRecordID)pContactID;

+(BOOL) removeSelfFromAddressBook:(ABRecordRef)pABRecordRef;

+(BOOL)searchResult:(NSString *)contactName searchText:(NSString *)searchT;

@end
