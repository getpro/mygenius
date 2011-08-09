#import "demo_iPhone_Photon_objC.h"



@implementation Listener

-(void) InitListener:(CPhotonLib*)lib :(iTestTextView*)txtView
{
	current = lib;
	textView = txtView;
}

- (void) PhotonPeerOperationResult:(nByte)opCode :(int)returnCode :(NSDictionary*)returnValues :(short)invocID
{
	[textView writeToTextView:[NSString stringWithFormat:@"OperationResult called, opCode = %d , returnCode = %d", opCode, returnCode]];
	switch([current GetState])
	{
		case Joining :
			if(opCode == OPC_RT_JOIN) 
			{
				[current SetState:Joined];
				[textView writeToTextView:@"----------JOINED-------"];
			}
			else [current SetState:ErrorJoining];
			break;
		case Leaving :
			if(opCode == OPC_RT_LEAVE) 
			{
				[current SetState:Left];
				[textView writeToTextView:@"----------LEFT-------"];
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
				[textView writeToTextView:@"-------CONNECTED-------"];
			}
			else
				[current SetState:ErrorConnecting];
			break;
		case Disconnecting:
			if(statusCode == SC_DISCONNECT)
			{
				[current SetState:Disconnected];
				[textView writeToTextView:@"-------DISCONNECTED-------"];
			}
			break;
		case Receiving:
			[textView writeToTextView:[NSString stringWithFormat:@"-->! PeerStatus function was called, statusCode: %d", statusCode]];
			break;
		default:
			break;
	}
}

- (void) PhotonPeerEventAction:(nByte)eventCode :(NSDictionary*)photonEvent
{
	NSString* str = [NSString stringWithFormat:@"-----Listener::EventAction called, eventCode = %d", eventCode];
	[textView writeToTextView:str];
	[textView writeToTextView:[Utils hashToString:photonEvent :true]];
	if(!photonEvent)
		return;
	
	NSLog(@"%@", [Utils hashToString:photonEvent :true]);
	
	switch(eventCode)
	{
		// you do not receive your own events, so you must start 2 clients, to receive the events, you sent
		case 101:
		{
			NSDictionary* eventData = nil;
			
			/*
			static int i = 0;
			const nByte POS_X = 101, POS_Y = 102, key2 = 103;
			EGArray* ary = nil, *ary2 = nil, *ary3 = nil;
			int x = 0, y = 0;
			NSDictionary* testHash = nil;
			*/

			// first access the inner Hash with your userdata inside the outer hash with general event data
			if(!(eventData=[photonEvent objectForKey:[KeyObject withByteValue:P_DATA]]))
				break;

			// then take your user data from within the inner hash

			/*
			
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

			[textView writeToTextView:str];
			
			*/
			
			
			const unsigned int packetHeaderSize = 3 * sizeof(int); // we have two "ints" for our header	
			
			NSString * pStr = (NSString * )[eventData objectForKey:[KeyObject withByteValue:88]];
			
			int pLength = [pStr length];
			
			char * p = [pStr UTF8String];
			
			NSData * pData =[pStr dataUsingEncoding:NSUTF8StringEncoding];
			
			unsigned char *incomingPacket = (unsigned char *)[pData bytes];
			
			int *pIntData = (int *)&incomingPacket[0];
			
			int packetTime   = pIntData[0];
			int packetID     = pIntData[1];
			int objectIndex  = pIntData[2];
			
			int peerUniqueID = pIntData[3];
			
			
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