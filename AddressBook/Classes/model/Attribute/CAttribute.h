//
//  CAttribute.h
//

#import <Foundation/Foundation.h>
#import "CAttributeCell.h"

/*	Characters have multiple attribute types in Pulp.  Most are pretty simple (string and text) while
	others are compound attributes with several properties of their own.  An character attribute
	may or may not have a label, which affects how it is displayed.
 */
@interface CAttribute : NSObject <NSCoding> 
{
	NSString *label;
}

@property (nonatomic, retain) NSString *label;

- (NSString*)type;

- (id)initWithString:(NSString*)inputString;

- (id)initWithCoder:(NSCoder *)decoder;

- (void)encodeWithCoder:(NSCoder *)encoder;

/*	Return a UITableViewCell that is configured to display the attribute information correctly
	and, in some cases, even allow you to edit it without detail views.
 */
- (CAttributeCell*)cellForTableView:(UITableView *)tableView;

/*	Returns a detail view controller for the attribute.  The intent is for the caller to use
	it as a modal view both for details and for editing.  The caller passes in the current desired
	editing state.  If the editing state is valid for the kind of attribute, then a view controller
	is returned.
 
	For example, string attributes never return a controller because they can be edited within
	the cell.  Ladder attributes have a view for editing (changing the ladder value), but no 
	view for detail display.  Tracks have both a detail and an editing display, becuase all
	of the information for a track won't ever fit inside a cell (unless we make cells a lot
	bigger).
 */
- (UIViewController*) detailViewController:(BOOL)editing;

/*
 Show the UIViewController
*/

- (void) Show :(id) pVc;

@end
