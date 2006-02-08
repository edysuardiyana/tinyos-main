// $Id: HplMsp430GeneralIOP.nc,v 1.1.2.1 2006-01-27 23:28:12 jwhui Exp $

/* "Copyright (c) 2000-2005 The Regents of the University of California.  
 * All rights reserved.
 *
 * Permission to use, copy, modify, and distribute this software and its
 * documentation for any purpose, without fee, and without written agreement
 * is hereby granted, provided that the above copyright notice, the following
 * two paragraphs and the author appear in all copies of this software.
 * 
 * IN NO EVENT SHALL THE UNIVERSITY OF CALIFORNIA BE LIABLE TO ANY PARTY FOR
 * DIRECT, INDIRECT, SPECIAL, INCIDENTAL, OR CONSEQUENTIAL DAMAGES ARISING OUT
 * OF THE USE OF THIS SOFTWARE AND ITS DOCUMENTATION, EVEN IF THE UNIVERSITY
 * OF CALIFORNIA HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 * 
 * THE UNIVERSITY OF CALIFORNIA SPECIFICALLY DISCLAIMS ANY WARRANTIES,
 * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY
 * AND FITNESS FOR A PARTICULAR PURPOSE.  THE SOFTWARE PROVIDED HEREUNDER IS
 * ON AN "AS IS" BASIS, AND THE UNIVERSITY OF CALIFORNIA HAS NO OBLIGATION TO
 * PROVIDE MAINTENANCE, SUPPORT, UPDATES, ENHANCEMENTS, OR MODIFICATIONS."
 */

/**
 * @author Joe Polastre
 */

includes msp430regtypes;

generic module HplMsp430GeneralIOP(
				uint8_t port_in_addr,
				uint8_t port_out_addr,
				uint8_t port_dir_addr,
				uint8_t port_sel_addr,
				uint8_t pin
				)
{
  provides interface HplMsp430GeneralIO as IO;
}
implementation
{
  #define PORTxIN (*(volatile TYPE_PORT_IN*)port_in_addr)
  #define PORTx (*(volatile TYPE_PORT_OUT*)port_out_addr)
  #define PORTxDIR (*(volatile TYPE_PORT_DIR*)port_dir_addr)
  #define PORTxSEL (*(volatile TYPE_PORT_SEL*)port_sel_addr)

  async command void IO.set() { atomic PORTx |= (0x01 << pin); }
  async command void IO.clr() { atomic PORTx &= ~(0x01 << pin); }
  async command void IO.toggle() { atomic PORTx ^= (0x01 << pin); }
  async command uint8_t IO.getRaw() { return PORTxIN & (0x01 << pin); }
  async command bool IO.get() { return (call IO.getRaw() != 0); }
  async command void IO.makeInput() { atomic PORTxDIR &= ~(0x01 << pin); }
  async command void IO.makeOutput() { atomic PORTxDIR |= (0x01 << pin); }
  async command void IO.selectModuleFunc() { atomic PORTxSEL |= (0x01 << pin); }
  async command void IO.selectIOFunc() { atomic PORTxSEL &= ~(0x01 << pin); }
}
