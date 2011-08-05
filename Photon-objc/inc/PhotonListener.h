/* Exit Games Photon - objC Client Lib
 * Copyright (C) 2004-2011 by Exit Games GmbH. All rights reserved.
 * http://www.exitgames.com
 * mailto:developer@exitgames.com
 */

#ifndef __PHOTONLISTENER_H__
#define __PHOTONLISTENER_H__

#include <Foundation/Foundation.h>
#include "WrapperDefines.h"

/**
 @@objC_PhotonListener
   <title PhotonListener>
   <toctitle PhotonListener>
   Summary
   The PhotonListener class defines the callback interface to
   allow your application to communicate with the Photon Server
   via the <link PhotonPeer> class.
   Description
   The interface defines the following callback methods:
   <table noborder>
   <link objC_PhotonListener_Method_PhotonPeerEventAction, PhotonListener::PhotonPeerEventAction()>,
   is called every time an event is received.
   <link objC_PhotonListener_Method_PhotonPeerOperationResult, PhotonListener::PhotonPeerOperationResult()>,
   is called in response to every operation you sent to the
   Photon server, carrying the Photon servers result code.
   <link objC_PhotonListener_Method_PhotonPeerStatus, PhotonListener::PhotonPeerStatus()>,
   is called on errors and connection-state changes.
   <link objC_PhotonListener_Method_PhotonPeerDebugReturn, PhotonListener::PhotonPeerDebugReturn()>,
   is called if a Photon related error occurs,
   passing an error message. This will happen e.g. if you call
   a PhotonPeer method with invalid parameters.
   </table>
   Please note that Photon will free any data passed as
   \arguments as soon as the callback function returns, so make
   sure to create copies within the callback funrction of all
   data needed by your application beyond the scope of the
   callback function.
   C++ Syntax
**/
@protocol PhotonListener
/// endDoc

/**
 @@objC_PhotonListener_Method_PhotonPeerOperationResult
   <title PhotonListener_Method_PhotonPeerOperationResult>
   <toctitle PhotonListener_Method_PhotonPeerOperationResult>
   Summary
   called by the library as callback to operations. See <link OPERATIONRESULT_CB>.
   Parameters
   opCode :        opCode of operation
   returnCode :    The result code of the operation.
   returnValues :  any returned values for the operation
   invocID :       index number of operation
   Returns
   Nothing.
   C++ Syntax
**/
- (void) PhotonPeerOperationResult:(nByte)opCode :(int)returnCode :(NSDictionary*)returnValues :(short)invocID;
/// endDoc

/**
 @@objC_PhotonListener_Method_PhotonPeerStatus
   <title PhotonListener_Method_PhotonPeerStatus>
   <toctitle PhotonListener_Method_PhotonPeerStatus>
   Summary
   called by the library as callback for peer
   state-changes and errors. See <link PEERSTATUS_CB>.
   Parameters
   statusCode :    the status code
   Returns
   Nothing..
   C++ Syntax
**/
- (void) PhotonPeerStatus:(int)statusCode;
/// endDoc

/**
 @@objC_PhotonListener_Method_eventAction
   <title PhotonListener_Method_eventAction>
   <toctitle PhotonListener_Method_eventAction>
   Summary
   called by the library as callback for events coming inParameters
   opCode :        Code of event
   returnValues :  event data.
   Returns
   Nothing.
   C++ Syntax
**/
- (void) PhotonPeerEventAction:(nByte)opCode :(NSDictionary*)returnValues;
/// endDoc

/**
 @@objC_PhotonListener_Method_DebugReturn
   <title PhotonListener_Method_DebugReturn>
   <toctitle PhotonListener_Method_DebugReturn>
   Summary
   called by the library as callback for debug messages in error
   case.
   Parameters
   debugLevel : the debug level, the message was created with
   string : the debug message
   Returns
   Nothing.
**/
- (void) PhotonPeerDebugReturn:(PhotonPeer_DebugLevel)debugLevel :(NSString*)string;
///endDoc
@end
#endif //__PHOTONLISTENER_H__