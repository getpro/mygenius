/* Exit Games Photon - C Client Lib
 * Copyright (C) 2004-2011 by Exit Games GmbH. All rights reserved.
 * http://www.exitgames.com
 * mailto:developer@exitgames.com
 */

#ifndef __PHOTON_CONNECT_H
#define __PHOTON_CONNECT_H

#include "Constants.h"

#ifdef _EG_APPLE_PLATFORM // Apple defines them itself, already, but in a really weird way (on Apple platforms y=HTONL(x) changes byteorder in dest and source(!), not only in dest like htonl(x) and like everyone would expect)
#undef HTONS
#undef HTONL
#endif
#define HTONS htons
#define HTONL htonl

#ifndef _EG_BREW_PLATFORM

typedef void(*CONNECT_CB)(void* pUser, int nError);
typedef void(*SENDPACKAGE_CB)(void* pUser, int nError);
typedef void(*RECVPACKAGE_CB)(void* pUser, nByte* pBuf, int iCount, int nError);

struct _SPhotonConnect
{
	SPhotonPeer*	pSPeer;				// pointer to parent.

	int				m_nError;			// Code of last error.

	uint32			m_nRefs;			// Reference count.

	int				m_socket;           // Connection socket.
#ifdef _EG_WINDOWS_PLATFORM
	struct sockaddr_in	m_remoteAddr;	// Remote address
#endif
	int				m_iConnectionState; // Current state of connection.
	int				m_iSendState;       // Current state of data sending.
	int				m_iRecvState;	    // Current state of data receiving.

	EG_Callback		m_cbConnected;		// Pointer to callback function, raise after connect, and raise if was error
	EG_Callback		m_cbReadData;		// Pointer to callback function, raise after reception of data, and raise if was error
	EG_Callback		m_cbSendData;		// Pointer to callback function, raise after sending of data, and raise if was error

	nByte*			m_pSendBuffer;		// Pointer to the buffer of sent data.
	int32			m_dwSendBufferSize;	// Size of the data buffer for sending.
	int32			m_dwBytesToSend;	// Number of bytes for sending.

	nByte*			m_pRecvBuffer;		// Pointer to the buffer of the received data.
	int32			m_dwRecvBufferSize;	// Size of the data buffer for receiving.
	int32			m_dwBytesReceived;	// Number of received data.

	int				m_nBytesOut;		// counts all bytes going out (include header)
	int				m_nBytesIn;			// counts all bytes coming in (include header)
};

#ifdef __cplusplus
extern "C"
{
#endif 

#ifdef _EG_BREW_PLATFORM
	int PhotonConnect_New(PlatformSpecific* pPlatform, SPhotonConnect** ppMod, SPhotonPeer* pPeer);
#else
	int PhotonConnect_New(void** ppMod, SPhotonPeer* pPeer);
#endif
	unsigned int PhotonConnect_AddRef(SPhotonConnect* pMe);
	unsigned int PhotonConnect_Release(SPhotonConnect* pMe);

	void PhotonConnect_service(SPhotonConnect* pMe);
	bool PhotonConnect_createConnection(SPhotonConnect* pMe, char* ipAddr, CONNECT_CB pfn, void* pUser);
	int PhotonConnect_sendUdpPackage(SPhotonConnect* pMe, nByte* src, int count, SENDPACKAGE_CB pfn, void* pUser);
	void PhotonConnect_CheckRecvUdpPackage(SPhotonConnect* pMe, RECVPACKAGE_CB pfn, void* pUser);
	void PhotonConnect_StopRecvUdpPackage(SPhotonConnect* pMe);
	int PhotonConnect_closeConnection(SPhotonConnect* pMe);

#ifdef __cplusplus
}
#endif 

#endif // !_EG_BREW_PLATFORM

#endif  // _PHOTON_CONNECT_H_