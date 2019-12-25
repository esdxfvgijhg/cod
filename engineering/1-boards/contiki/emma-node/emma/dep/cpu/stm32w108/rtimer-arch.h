/*
 * Copyright (c) 2010, STMicroelectronics.
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above
 *    copyright notice, this list of conditions and the following
 *    disclaimer in the documentation and/or other materials provided
 *    with the distribution.
 * 3. The name of the author may not be used to endorse or promote
 *    products derived from this software without specific prior
 *    written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS
 * OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY
 * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE
 * GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 * This file is part of the Contiki OS
 *
 * $Id: rtimer-arch.h,v 1.1 2010/10/25 09:03:39 salvopitru Exp $
 */

/**
 * \file
 *         Real-timer header file for STM32W.
 * \author
 *         Salvatore Pitrulli <salvopitru@users.sourceforge.net>
 */

#ifndef __RTIMER_ARCH_H__
#define __RTIMER_ARCH_H__

#include "contiki-conf.h"
#include "sys/clock.h"


//#define RT_RESOLUTION RES_85US
#ifdef RT_CONF_RESOLUTION
#define RT_RESOLUTION RT_CONF_RESOLUTION
#else
#define RT_RESOLUTION RES_171US
#endif

#define RES_341US 0
#define RES_171US 1
#define RES_85US  2

// If it was possible to define a custom size for the rtimer_clock_t type:
//typedef unsigned long long rtimer_clock_t;  // Only 48 bit are used. It's enough for hundreds of years.

#if RT_RESOLUTION == RES_341US
#define RT_PRESCALER 12      // CK_CNT =  PCLK/4096 = 12 MHz/4096 = 2929.6875 Hz
#define RTIMER_ARCH_SECOND 2930   // One tick: 341.33 us. Using this value we will delay about 9.22 sec after a day.
#endif /* RT_RESOLUTION == RES_341US */

#if RT_RESOLUTION == RES_171US
#define RT_PRESCALER 11      // CK_CNT =  PCLK/2048 = 12 MHz/2048 = 5859.375 Hz
#define RTIMER_ARCH_SECOND 5859    // One tick: 170.66 us. Using this value we will advance about 5.53 sec after a day.
#endif /* RT_RESOLUTION == RES_171US */

#if RT_RESOLUTION == RES_85US
#define RT_PRESCALER 10      // CK_CNT =  PCLK/2048 = 12 MHz/2048 = 5859.375 Hz
#define RTIMER_ARCH_SECOND 11719    // One tick: 85.33 us. Using this value we will delay about 1.84 sec after a day.
#endif /* RT_RESOLUTION == RES_85US */

rtimer_clock_t rtimer_arch_now(void);
//#define rtimer_arch_now() clock_time()

void rtimer_arch_disable_irq(void);
void rtimer_arch_enable_irq(void);

#endif /* __RTIMER_ARCH_H__ */
