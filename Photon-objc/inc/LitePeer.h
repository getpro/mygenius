/* Exit Games Photon - objC Client Lib
 * Copyright (C) 2004-2011 by Exit Games GmbH. All rights reserved.
 * http://www.exitgames.com
 * mailto:developer@exitgames.com
 */

#ifndef _LITE_PEER_H
#define _LITE_PEER_H

#include "PhotonPeer.h"

/**
 @@objC_PhotonPeer
   <title PhotonPeer>
   <toctitle PhotonPeer>
   Summary
   The PhotonPeer class provides a channel for reliable or unreliable
   communication based on UDP.
   Description
   This class encapsulates Photon-related functions of the
   public API as described in section <link UDP based functions, Photon functions>.

   PhotonPeer uses the callback interface <link objC_PhotonListener> that
   needs to be implemented by your application, to receive
   results and events from the Photon Server.



   <b>How to establish a connection and to send data using the
   PhotonPeer class:</b>



   \1. create an PhotonPeer instance. Please note that there are
   slightly different constructors depending on the platform.

   \2. call <link objC_PhotonPeer_Method_Connect, PhotonPeer::Connect()>
   to connect to the server;

   \3. regularly call <link objC_PhotonPeer_Method_service, PhotonPeer::service()>
   to get new events and to send commands. (best called within the game loop!)

   \4. wait for a callback to <link objC_PhotonListener_Method_PhotonPeerReturn, PhotonListener::PhotonPeerReturn()>
   with returnCode: RC_RT_CONNECT;

   \5. call <link objC_PhotonPeer_Method_opJoin, opJoin()>
   to get into a game

   6 wait for "joined" return in PhotonListener::PhotonPeerReturn()
   with opCode: OPC_RT_JOIN;

   \7. send in-game data by calling <link objC_PhotonPeer_Method_opRaiseEvent, opRaiseEvent()>.
   See <link MemoryManagement, Sending and receiving data> for
   more information about Photon's serializable data structures

   \8. receive events by the <link objC_PhotonListener_Method_PhotonPeerEventAction, PhotonListener::PhotonPeerEventAction()>
   callback

   \9. call <link objC_PhotonPeer_Method_opLeave, opLeave()> to
   quit/leave the game.

   \10. wait for callback <link objC_PhotonListener_Method_PhotonPeerReturn, PhotonListener::PhotonPeerReturn()>
   with opCode: OPC_RT_LEAVE;

   \11. disconnect by calling <link objC_PhotonPeer_Method_Disconnect, Disconnect()>

   \12. check "disconnect" return in
   PhotonListener::PhotonPeerReturn() with returnCode:
   RC_RT_DISCONNECT;
   C++ Syntax
 **/
@interface LitePeer : PhotonPeer
///endDoc
{
}

- (id) init:(id<PhotonListener>)listener;
- (short) opRaiseEvent:(bool)sendReliable :(NSDictionary*)evData :(nByte)eventCode; // = 0
- (short) opRaiseEvent:(bool)sendReliable :(NSDictionary*)evData :(nByte)eventCode :(nByte)channelID; // = NULL, = 0
- (short) opRaiseEvent:(bool)sendReliable :(NSDictionary*)evData :(nByte)eventCode :(nByte)channelID  :(int*)targetActors :(short)numTargetActors;
- (short) opJoin:(NSString*)asid; // = NULL, = NULL, = false
- (short) opJoin:(NSString*)gameId :(NSDictionary*)gameProperties :(NSDictionary*)actorProperties :(bool)broadcastActorProperties;
- (short) opLeave:(NSString*)asid;
- (short) opSetPropertiesOfActor:(int)actorNr :(NSDictionary*)properties :(bool)broadcast; // = 0
- (short) opSetPropertiesOfActor:(int)actorNr :(NSDictionary*)properties :(bool)broadcast :(nByte)channelID;
- (short) opSetPropertiesOfGame:(NSDictionary*)properties :(bool)broadcast; // = 0
- (short) opSetPropertiesOfGame:(NSDictionary*)properties :(bool)broadcast :(nByte)channelID;
- (short) opGetProperties; // = 0
- (short) opGetProperties:(nByte)channelID;
- (short) opGetPropertiesOfActorByStringKeys:(int*)actorNrList :(short)numActors :(NSString**)properties :(short)numProperties; // = 0
- (short) opGetPropertiesOfActorByStringKeys:(int*)actorNrList :(short)numActors :(NSString**)properties :(short)numProperties :(nByte)channelID;
- (short) opGetPropertiesOfActorByByteKeys:(int*)actorNrList :(short)numActors :(nByte*)properties :(short)numProperties; // = 0
- (short) opGetPropertiesOfActorByByteKeys:(int*)actorNrList :(short)numActors :(nByte*)properties :(short)numProperties :(nByte)channelID;
- (short) opGetPropertiesOfGameByStringKeys:(NSString**)properties :(short)numProperties; // = 0
- (short) opGetPropertiesOfGameByStringKeys:(NSString**)properties :(short)numProperties :(nByte)channelID;
- (short) opGetPropertiesOfGameByByteKeys:(nByte*)properties :(short)numProperties; // = 0
- (short) opGetPropertiesOfGameByByteKeys:(nByte*)properties :(short)numProperties :(nByte)channelID;
@end
#endif // _LITE_PEER_H