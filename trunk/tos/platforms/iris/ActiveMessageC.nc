/*
 * Copyright (c) 2007, Vanderbilt University
 * All rights reserved.
 *
 * Permission to use, copy, modify, and distribute this software and its
 * documentation for any purpose, without fee, and without written agreement is
 * hereby granted, provided that the above copyright notice, the following
 * two paragraphs and the author appear in all copies of this software.
 * 
 * IN NO EVENT SHALL THE VANDERBILT UNIVERSITY BE LIABLE TO ANY PARTY FOR
 * DIRECT, INDIRECT, SPECIAL, INCIDENTAL, OR CONSEQUENTIAL DAMAGES ARISING OUT
 * OF THE USE OF THIS SOFTWARE AND ITS DOCUMENTATION, EVEN IF THE VANDERBILT
 * UNIVERSITY HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 * 
 * THE VANDERBILT UNIVERSITY SPECIFICALLY DISCLAIMS ANY WARRANTIES,
 * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY
 * AND FITNESS FOR A PARTICULAR PURPOSE.  THE SOFTWARE PROVIDED HEREUNDER IS
 * ON AN "AS IS" BASIS, AND THE VANDERBILT UNIVERSITY HAS NO OBLIGATION TO
 * PROVIDE MAINTENANCE, SUPPORT, UPDATES, ENHANCEMENTS, OR MODIFICATIONS.
 *
 * Author: Miklos Maroti
 */

configuration ActiveMessageC
{
	provides
	{
		interface SplitControl;

		interface AMSend[uint8_t id];
		interface Receive[uint8_t id];
		interface Receive as Snoop[uint8_t id];
		interface Packet;
		interface AMPacket;

		interface PacketAcknowledgements;
		interface PacketField<uint8_t> as PacketLinkQuality;
		interface PacketTimeStamp<TMicro, uint16_t>;
		interface PacketTimeSynch<TMicro, uint16_t>;
	}
}

implementation
{
	components DefaultMacC as MAC;

	SplitControl = MAC;
	AMSend       = MAC;
	Receive      = MAC.Receive;
	Snoop        = MAC.Snoop;
	Packet       = MAC;
	AMPacket     = MAC;

	PacketAcknowledgements = MAC;
	PacketLinkQuality = MAC;
	PacketTimeStamp = MAC;
	PacketTimeSynch = MAC;
}
