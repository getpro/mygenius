#import "PhotonListener.h"

@implementation Listener

@synthesize delegate;

-(void) InitListener:(CPhotonLib*)lib
{
	current = lib;
}

- (void) PhotonPeerOperationResult:(nByte)opCode :(int)returnCode :(NSDictionary*)returnValues :(short)invocID
{
	NSLog(@"OperationResult called, opCode = %d , returnCode = %d",opCode, returnCode);
	switch([current GetState])
	{
		case Joining :
			if(opCode == OPC_RT_JOIN) 
			{
				[current SetState:Joined];
				NSLog(@"----------JOINED-------");
				
				if(delegate)
				{
					[delegate MyListenerOperationResult:opCode :returnCode :returnValues:invocID];
				}
				
			}
			else [current SetState:ErrorJoining];
			break;
		case Leaving :
			if(opCode == OPC_RT_LEAVE) 
			{
				[current SetState:Left];
				NSLog(@"----------LEFT-------");
				
				if(delegate)
				{
					[delegate MyListenerOperationResult:opCode :returnCode :returnValues:invocID];
				}
				
			}
			else [current SetState:ErrorLeaving];
			break;
		default:
			break;
	}
}

- (void) PhotonPeerStatus:(int)statusCode
{
	switch([current GetState])
	{
		case Connecting :
			if(statusCode == SC_CONNECT)
			{
				[current SetState:Connected];
				NSLog(@"-------CONNECTED-------");
			}
			else
				[current SetState:ErrorConnecting];
			break;
		case Disconnecting:
			if(statusCode == SC_DISCONNECT)
			{
				[current SetState:Disconnected];
				NSLog(@"-------DISCONNECTED-------");
			}
			break;
		case Receiving:
			NSLog(@"-->! PeerStatus function was called, statusCode: %d", statusCode);
			break;
		default:
			break;
	}
}	

- (void) PhotonPeerEventAction:(nByte)eventCode :(NSDictionary*)photonEvent
{	
	NSLog(@"-----Listener::EventAction called, eventCode = %d", eventCode);
	
	//NSString * str = nil;
	//[textView writeToTextView:str];
	//[textView writeToTextView:[Utils hashToString:photonEvent :true]];
	
	if(!photonEvent)
		return;
	switch(eventCode)
	{
		// you do not receive your own events, so you must start 2 clients, to receive the events, you sent
		case 101:
		{
			/*
			NSDictionary* eventData = nil;
			static int i = 0;
			const nByte POS_X = 101, POS_Y = 102, key2 = 103;
			EGArray* ary = nil, *ary2 = nil, *ary3 = nil;
			int x = 0, y = 0;
			NSDictionary* testHash = nil;

			// first access the inner Hash with your userdata inside the outer hash with general event data
			if(!(eventData=[photonEvent objectForKey:[KeyObject withByteValue:P_DATA]]))
				break;

			// then take your user data from within the inner hash

			// nByte key and int value:
			[(NSValue*)[eventData objectForKey:[KeyObject withByteValue:POS_X]] getValue:&x];

			// NSString key and EGArray of float value
			ary = [eventData objectForKey:[KeyObject withStringValue:@"testKey"]];

			// nByte key and NSDictionary value
			testHash = [eventData objectForKey:[KeyObject withByteValue:key2]];
			[((NSValue*)[testHash objectForKey:[KeyObject withByteValue:POS_X]])getValue:&x];
			[((NSValue*)[testHash objectForKey:[KeyObject withByteValue:POS_Y]])getValue:&y];

			// NSString key and empty EGArray of int value
			ary2 = [eventData objectForKey:[KeyObject withStringValue:@"emptyArray"]];

			// NSString key and multidimensional EGArray of NSString* value
			ary3 = [eventData objectForKey:[KeyObject withStringValue:@"multidimensional array"]];

			str = [NSString stringWithFormat:@"data received:%d\n", i++];
			str = [str stringByAppendingString:[NSString stringWithFormat:@"X: %d    Y: %d\n", x, y]];
			if([ary.Type compare:[NSString stringWithUTF8String:@encode(float)]])
				DEBUG_RELEASE(NSAssert(false, "ERROR: unexpected type"), break);
			for(int i=0; i<ary.count; i++)
			{
				float b;
				[[ary objectAtIndex:i] getValue:&b];
				str = [str stringByAppendingString:[NSString stringWithFormat:@"ary1[%d]: %.1f\n", i, b]];
			}
			str = [str stringByAppendingString:[NSString stringWithFormat:@"emptyArrayLength: %d\n", ary2.count]];
			for(int i=0; i<ary3.count; i++)
			{
				for(int j=0; j<((EGArray*)[ary3 objectAtIndex:i]).count; j++)
					str = [str stringByAppendingString:[NSString stringWithFormat:@"ary3[%d][%d]: %@ ", i, j, [(EGArray*)[ary3 objectAtIndex:i] objectAtIndex:j]]];
				str = [str stringByAppendingString:@"\n"];
			}

			//[textView writeToTextView:str];
			 
			*/
			
			
			NSDictionary* eventData = nil;
			//static int i = 0;
			//const nByte POS_X = 101, POS_Y = 102, key2 = 103;
	
			// first access the inner Hash with your userdata inside the outer hash with general event data
			if(!(eventData=[photonEvent objectForKey:[KeyObject withByteValue:P_DATA]]))
				break;
			
			// then take your user data from within the inner hash
			
			
			//int value:
			//int x = 0;
			//[(NSValue*)[eventData objectForKey:[KeyObject withByteValue:POS_X]] getValue:&x];
			//NSLog(@"get_int[%d]",x);
			
			
			//float value
			//float x = 0.0f;
			//[(NSValue*)[eventData objectForKey:[KeyObject withStringValue:@"float"]] getValue:&x];
			//NSLog(@"get_float[%f]",x);
			
			//string
			NSLog(@"get_string[%@]",[eventData objectForKey:[KeyObject withStringValue:@"NSString"]]);
			
			
			if(delegate)
			{
				[delegate MyListenerEventAction:eventCode :photonEvent];
			}
			
		}
			break;
		default:
			break;
	}
}

- (void) PhotonPeerDebugReturn:(PhotonPeer_DebugLevel)debugLevel :(NSString*)string
{
	char* lvlstr;
	switch(debugLevel)
	{
		case DEBUG_LEVEL_OFF:
			lvlstr = "FATAL ERROR: ";
			break;
		case DEBUG_LEVEL_ERRORS:
			lvlstr = "ERROR: ";
			break;
		case DEBUG_LEVEL_WARNINGS:
			lvlstr = "WARNING: ";
			break;
		case DEBUG_LEVEL_INFO:
			lvlstr = "INFO: ";
			break;
		case DEBUG_LEVEL_ALL:
			lvlstr = "DEBUG: ";
			break;
		default:
			lvlstr = "";
			break;
	}
	printf("%s%s\n", lvlstr, [string UTF8String]);
}
@end