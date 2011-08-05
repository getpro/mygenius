/* Exit Games Photon - objC Client Lib
 * Copyright (C) 2004-2011 by Exit Games GmbH. All rights reserved.
 * http://www.exitgames.com
 * mailto:developer@exitgames.com
 */

#ifndef _PHOTON_PEER_H
#define _PHOTON_PEER_H

#include "Photon.h"
#include "PhotonListener.h"
#include "Utils.h"

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
@interface PhotonPeer : NSObject
///endDoc
{
@protected
	SPhotonPeer* m_pPhotonPeer;
	id<PhotonListener> m_plistener;
}

@property (readonly) id<PhotonListener> Listener;
@property (readonly) int ServerTimeOffset;
@property (readonly) int ServerTime;
@property (readonly) int BytesOut;
@property (readonly) int BytesIn;
@property (readonly) PeerState Peerstate;
@property (readwrite) int SentCountAllowance;
@property (readwrite) int TimePingInterval;
@property (readonly) int RoundTripTime;
@property (readonly) int RoundTripTimeVariance;
@property (readwrite) PhotonPeer_DebugLevel DebugOutputLevel;
@property (readonly) short PeerID;
@property (readonly) BOOL IsEncryptionAvailable;
@property (readonly) int IncomingReliableCommandsCount;
@property (readwrite) int SentTimeAllowance;
@property (readonly) unsigned int QueuedIncomingCommands;
@property (readonly) unsigned int QueuedOutgoingCommands;
@property (readonly) NSString* ServerAddress;

- (id) init:(id<PhotonListener>)listener;
- (bool) Connect:(NSString*)ipAddr; // = NULL
- (bool) Connect:(NSString*)ipAddr :(nByte*)appID;
- (void) Disconnect;
- (void) service; // = true
- (void) service:(bool)dispatchIncomingCommands;
- (void) serviceBasic;
- (short) opCustom:(nByte)customOpCode :(NSDictionary*)customOpParameters :(bool)sendReliable; // = 0, = false
- (short) opCustom:(nByte)customOpCode :(NSDictionary*)customOpParameters :(bool)sendReliable :(nByte)channelID; // = false
- (short) opCustom:(nByte)customOpCode :(NSDictionary*)customOpParameters :(bool)sendReliable :(nByte)channelID :(bool)encrypt;
- (void) sendOutgoingCommands;
- (bool) dispatchIncomingCommands;
- (short) opExchangeKeysForEncryption;
- (void) deriveSharedKey:(nByte*)serverPublicKey;
- (void) fetchServerTimestamp;
@end
#endif // _PHOTON_PEER_H