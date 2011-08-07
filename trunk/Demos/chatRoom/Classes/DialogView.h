
#import <UIKit/UIKit.h>


@interface DialogView : UIView 
{
	NSUInteger  direction;
	NSString  * labelText;
}

@property NSUInteger direction;
@property(retain,nonatomic) NSString *labelText;

-(void)addLabelView:(CGRect)frame;
-(void)drawAsHeaderLeft:(CGContextRef)c rect:(CGRect)rect;

-(void)drawASHeaderRight:(CGContextRef)c rect:(CGRect)rect;
@end
