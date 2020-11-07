/***************************************************************************//**
* \file UART_DEBUG.h
* \version 2.0
*
*  This file provides constants and parameter values for the UART component.
*
********************************************************************************
* \copyright
* Copyright 2016-2017, Cypress Semiconductor Corporation. All rights reserved.
* You may use this file only in accordance with the license, terms, conditions,
* disclaimers, and limitations in the end user license agreement accompanying
* the software package with which this file was provided.
*******************************************************************************/

#if !defined(UART_DEBUG_CY_SCB_UART_PDL_H)
#define UART_DEBUG_CY_SCB_UART_PDL_H

#include "cyfitter.h"
#include "scb/cy_scb_uart.h"

#if defined(__cplusplus)
extern "C" {
#endif

/***************************************
*   Initial Parameter Constants
****************************************/

#define UART_DEBUG_DIRECTION  (3U)
#define UART_DEBUG_ENABLE_RTS (0U)
#define UART_DEBUG_ENABLE_CTS (0U)

/* UART direction enum */
#define UART_DEBUG_RX    (0x1U)
#define UART_DEBUG_TX    (0x2U)

#define UART_DEBUG_ENABLE_RX  (0UL != (UART_DEBUG_DIRECTION & UART_DEBUG_RX))
#define UART_DEBUG_ENABLE_TX  (0UL != (UART_DEBUG_DIRECTION & UART_DEBUG_TX))


/***************************************
*        Function Prototypes
***************************************/
/**
* \addtogroup group_general
* @{
*/
/* Component specific functions. */
void UART_DEBUG_Start(void);

/* Basic functions */
__STATIC_INLINE cy_en_scb_uart_status_t UART_DEBUG_Init(cy_stc_scb_uart_config_t const *config);
__STATIC_INLINE void UART_DEBUG_DeInit(void);
__STATIC_INLINE void UART_DEBUG_Enable(void);
__STATIC_INLINE void UART_DEBUG_Disable(void);

/* Register callback. */
__STATIC_INLINE void UART_DEBUG_RegisterCallback(cy_cb_scb_uart_handle_events_t callback);

/* Configuration change. */
#if (UART_DEBUG_ENABLE_CTS)
__STATIC_INLINE void UART_DEBUG_EnableCts(void);
__STATIC_INLINE void UART_DEBUG_DisableCts(void);
#endif /* (UART_DEBUG_ENABLE_CTS) */

#if (UART_DEBUG_ENABLE_RTS)
__STATIC_INLINE void     UART_DEBUG_SetRtsFifoLevel(uint32_t level);
__STATIC_INLINE uint32_t UART_DEBUG_GetRtsFifoLevel(void);
#endif /* (UART_DEBUG_ENABLE_RTS) */

__STATIC_INLINE void UART_DEBUG_EnableSkipStart(void);
__STATIC_INLINE void UART_DEBUG_DisableSkipStart(void);

#if (UART_DEBUG_ENABLE_RX)
/* Low level: Receive direction. */
__STATIC_INLINE uint32_t UART_DEBUG_Get(void);
__STATIC_INLINE uint32_t UART_DEBUG_GetArray(void *buffer, uint32_t size);
__STATIC_INLINE void     UART_DEBUG_GetArrayBlocking(void *buffer, uint32_t size);
__STATIC_INLINE uint32_t UART_DEBUG_GetRxFifoStatus(void);
__STATIC_INLINE void     UART_DEBUG_ClearRxFifoStatus(uint32_t clearMask);
__STATIC_INLINE uint32_t UART_DEBUG_GetNumInRxFifo(void);
__STATIC_INLINE void     UART_DEBUG_ClearRxFifo(void);
#endif /* (UART_DEBUG_ENABLE_RX) */

#if (UART_DEBUG_ENABLE_TX)
/* Low level: Transmit direction. */
__STATIC_INLINE uint32_t UART_DEBUG_Put(uint32_t data);
__STATIC_INLINE uint32_t UART_DEBUG_PutArray(void *buffer, uint32_t size);
__STATIC_INLINE void     UART_DEBUG_PutArrayBlocking(void *buffer, uint32_t size);
__STATIC_INLINE void     UART_DEBUG_PutString(char_t const string[]);
__STATIC_INLINE void     UART_DEBUG_SendBreakBlocking(uint32_t breakWidth);
__STATIC_INLINE uint32_t UART_DEBUG_GetTxFifoStatus(void);
__STATIC_INLINE void     UART_DEBUG_ClearTxFifoStatus(uint32_t clearMask);
__STATIC_INLINE uint32_t UART_DEBUG_GetNumInTxFifo(void);
__STATIC_INLINE bool     UART_DEBUG_IsTxComplete(void);
__STATIC_INLINE void     UART_DEBUG_ClearTxFifo(void);
#endif /* (UART_DEBUG_ENABLE_TX) */

#if (UART_DEBUG_ENABLE_RX)
/* High level: Ring buffer functions. */
__STATIC_INLINE void     UART_DEBUG_StartRingBuffer(void *buffer, uint32_t size);
__STATIC_INLINE void     UART_DEBUG_StopRingBuffer(void);
__STATIC_INLINE void     UART_DEBUG_ClearRingBuffer(void);
__STATIC_INLINE uint32_t UART_DEBUG_GetNumInRingBuffer(void);

/* High level: Receive direction functions. */
__STATIC_INLINE cy_en_scb_uart_status_t UART_DEBUG_Receive(void *buffer, uint32_t size);
__STATIC_INLINE void     UART_DEBUG_AbortReceive(void);
__STATIC_INLINE uint32_t UART_DEBUG_GetReceiveStatus(void);
__STATIC_INLINE uint32_t UART_DEBUG_GetNumReceived(void);
#endif /* (UART_DEBUG_ENABLE_RX) */

#if (UART_DEBUG_ENABLE_TX)
/* High level: Transmit direction functions. */
__STATIC_INLINE cy_en_scb_uart_status_t UART_DEBUG_Transmit(void *buffer, uint32_t size);
__STATIC_INLINE void     UART_DEBUG_AbortTransmit(void);
__STATIC_INLINE uint32_t UART_DEBUG_GetTransmitStatus(void);
__STATIC_INLINE uint32_t UART_DEBUG_GetNumLeftToTransmit(void);
#endif /* (UART_DEBUG_ENABLE_TX) */

/* Interrupt handler */
__STATIC_INLINE void UART_DEBUG_Interrupt(void);
/** @} group_general */


/***************************************
*    Variables with External Linkage
***************************************/
/**
* \addtogroup group_globals
* @{
*/
extern uint8_t UART_DEBUG_initVar;
extern cy_stc_scb_uart_config_t const UART_DEBUG_config;
extern cy_stc_scb_uart_context_t UART_DEBUG_context;
/** @} group_globals */


/***************************************
*         Preprocessor Macros
***************************************/
/**
* \addtogroup group_macros
* @{
*/
/** The pointer to the base address of the hardware */
#define UART_DEBUG_HW     ((CySCB_Type *) UART_DEBUG_SCB__HW)
/** @} group_macros */


/***************************************
*    In-line Function Implementation
***************************************/

/*******************************************************************************
* Function Name: UART_DEBUG_Init
****************************************************************************//**
*
* Invokes the Cy_SCB_UART_Init() PDL driver function.
*
*******************************************************************************/
__STATIC_INLINE cy_en_scb_uart_status_t UART_DEBUG_Init(cy_stc_scb_uart_config_t const *config)
{
   return Cy_SCB_UART_Init(UART_DEBUG_HW, config, &UART_DEBUG_context);
}


/*******************************************************************************
* Function Name: UART_DEBUG_DeInit
****************************************************************************//**
*
* Invokes the Cy_SCB_UART_DeInit() PDL driver function.
*
*******************************************************************************/
__STATIC_INLINE void UART_DEBUG_DeInit(void)
{
    Cy_SCB_UART_DeInit(UART_DEBUG_HW);
}


/*******************************************************************************
* Function Name: UART_DEBUG_Enable
****************************************************************************//**
*
* Invokes the Cy_SCB_UART_Enable() PDL driver function.
*
*******************************************************************************/
__STATIC_INLINE void UART_DEBUG_Enable(void)
{
    Cy_SCB_UART_Enable(UART_DEBUG_HW);
}


/*******************************************************************************
* Function Name: UART_DEBUG_Disable
****************************************************************************//**
*
* Invokes the Cy_SCB_UART_Disable() PDL driver function.
*
*******************************************************************************/
__STATIC_INLINE void UART_DEBUG_Disable(void)
{
    Cy_SCB_UART_Disable(UART_DEBUG_HW, &UART_DEBUG_context);
}


/*******************************************************************************
* Function Name: UART_DEBUG_RegisterCallback
****************************************************************************//**
*
* Invokes the Cy_SCB_UART_RegisterCallback() PDL driver function.
*
*******************************************************************************/
__STATIC_INLINE void UART_DEBUG_RegisterCallback(cy_cb_scb_uart_handle_events_t callback)
{
    Cy_SCB_UART_RegisterCallback(UART_DEBUG_HW, callback, &UART_DEBUG_context);
}


#if (UART_DEBUG_ENABLE_CTS)
/*******************************************************************************
* Function Name: UART_DEBUG_EnableCts
****************************************************************************//**
*
* Invokes the Cy_SCB_UART_EnableCts() PDL driver function.
*
*******************************************************************************/
__STATIC_INLINE void UART_DEBUG_EnableCts(void)
{
    Cy_SCB_UART_EnableCts(UART_DEBUG_HW);
}


/*******************************************************************************
* Function Name: Cy_SCB_UART_DisableCts
****************************************************************************//**
*
* Invokes the Cy_SCB_UART_DisableCts() PDL driver function.
*
*******************************************************************************/
__STATIC_INLINE void UART_DEBUG_DisableCts(void)
{
    Cy_SCB_UART_DisableCts(UART_DEBUG_HW);
}
#endif /* (UART_DEBUG_ENABLE_CTS) */


#if (UART_DEBUG_ENABLE_RTS)
/*******************************************************************************
* Function Name: UART_DEBUG_SetRtsFifoLevel
****************************************************************************//**
*
* Invokes the Cy_SCB_UART_SetRtsFifoLevel() PDL driver function.
*
*******************************************************************************/
__STATIC_INLINE void UART_DEBUG_SetRtsFifoLevel(uint32_t level)
{
    Cy_SCB_UART_SetRtsFifoLevel(UART_DEBUG_HW, level);
}


/*******************************************************************************
* Function Name: UART_DEBUG_GetRtsFifoLevel
****************************************************************************//**
*
* Invokes the Cy_SCB_UART_GetRtsFifoLevel() PDL driver function.
*
*******************************************************************************/
__STATIC_INLINE uint32_t UART_DEBUG_GetRtsFifoLevel(void)
{
    return Cy_SCB_UART_GetRtsFifoLevel(UART_DEBUG_HW);
}
#endif /* (UART_DEBUG_ENABLE_RTS) */


/*******************************************************************************
* Function Name: UART_DEBUG_EnableSkipStart
****************************************************************************//**
*
* Invokes the Cy_SCB_UART_EnableSkipStart() PDL driver function.
*
*******************************************************************************/
__STATIC_INLINE void UART_DEBUG_EnableSkipStart(void)
{
    Cy_SCB_UART_EnableSkipStart(UART_DEBUG_HW);
}


/*******************************************************************************
* Function Name: UART_DEBUG_DisableSkipStart
****************************************************************************//**
*
* Invokes the Cy_SCB_UART_DisableSkipStart() PDL driver function.
*
*******************************************************************************/
__STATIC_INLINE void UART_DEBUG_DisableSkipStart(void)
{
    Cy_SCB_UART_DisableSkipStart(UART_DEBUG_HW);
}


#if (UART_DEBUG_ENABLE_RX)
/*******************************************************************************
* Function Name: UART_DEBUG_Get
****************************************************************************//**
*
* Invokes the Cy_SCB_UART_Get() PDL driver function.
*
*******************************************************************************/
__STATIC_INLINE uint32_t UART_DEBUG_Get(void)
{
    return Cy_SCB_UART_Get(UART_DEBUG_HW);
}


/*******************************************************************************
* Function Name: UART_DEBUG_GetArray
****************************************************************************//**
*
* Invokes the Cy_SCB_UART_GetArray() PDL driver function.
*
*******************************************************************************/
__STATIC_INLINE uint32_t UART_DEBUG_GetArray(void *buffer, uint32_t size)
{
    return Cy_SCB_UART_GetArray(UART_DEBUG_HW, buffer, size);
}


/*******************************************************************************
* Function Name: UART_DEBUG_GetArrayBlocking
****************************************************************************//**
*
* Invokes the Cy_SCB_UART_GetArrayBlocking() PDL driver function.
*
*******************************************************************************/
__STATIC_INLINE void UART_DEBUG_GetArrayBlocking(void *buffer, uint32_t size)
{
    Cy_SCB_UART_GetArrayBlocking(UART_DEBUG_HW, buffer, size);
}


/*******************************************************************************
* Function Name: UART_DEBUG_GetRxFifoStatus
****************************************************************************//**
*
* Invokes the Cy_SCB_UART_GetRxFifoStatus() PDL driver function.
*
*******************************************************************************/
__STATIC_INLINE uint32_t UART_DEBUG_GetRxFifoStatus(void)
{
    return Cy_SCB_UART_GetRxFifoStatus(UART_DEBUG_HW);
}


/*******************************************************************************
* Function Name: UART_DEBUG_ClearRxFifoStatus
****************************************************************************//**
*
* Invokes the Cy_SCB_UART_ClearRxFifoStatus() PDL driver function.
*
*******************************************************************************/
__STATIC_INLINE void UART_DEBUG_ClearRxFifoStatus(uint32_t clearMask)
{
    Cy_SCB_UART_ClearRxFifoStatus(UART_DEBUG_HW, clearMask);
}


/*******************************************************************************
* Function Name: UART_DEBUG_GetNumInRxFifo
****************************************************************************//**
*
* Invokes the Cy_SCB_UART_GetNumInRxFifo() PDL driver function.
*
*******************************************************************************/
__STATIC_INLINE uint32_t UART_DEBUG_GetNumInRxFifo(void)
{
    return Cy_SCB_UART_GetNumInRxFifo(UART_DEBUG_HW);
}


/*******************************************************************************
* Function Name: UART_DEBUG_ClearRxFifo
****************************************************************************//**
*
* Invokes the Cy_SCB_UART_ClearRxFifo() PDL driver function.
*
*******************************************************************************/
__STATIC_INLINE void UART_DEBUG_ClearRxFifo(void)
{
    Cy_SCB_UART_ClearRxFifo(UART_DEBUG_HW);
}
#endif /* (UART_DEBUG_ENABLE_RX) */


#if (UART_DEBUG_ENABLE_TX)
/*******************************************************************************
* Function Name: UART_DEBUG_Put
****************************************************************************//**
*
* Invokes the Cy_SCB_UART_Put() PDL driver function.
*
*******************************************************************************/
__STATIC_INLINE uint32_t UART_DEBUG_Put(uint32_t data)
{
    return Cy_SCB_UART_Put(UART_DEBUG_HW,data);
}


/*******************************************************************************
* Function Name: UART_DEBUG_PutArray
****************************************************************************//**
*
* Invokes the Cy_SCB_UART_PutArray() PDL driver function.
*
*******************************************************************************/
__STATIC_INLINE uint32_t UART_DEBUG_PutArray(void *buffer, uint32_t size)
{
    return Cy_SCB_UART_PutArray(UART_DEBUG_HW, buffer, size);
}


/*******************************************************************************
* Function Name: UART_DEBUG_PutArrayBlocking
****************************************************************************//**
*
* Invokes the Cy_SCB_UART_PutArrayBlocking() PDL driver function.
*
*******************************************************************************/
__STATIC_INLINE void UART_DEBUG_PutArrayBlocking(void *buffer, uint32_t size)
{
    Cy_SCB_UART_PutArrayBlocking(UART_DEBUG_HW, buffer, size);
}


/*******************************************************************************
* Function Name: UART_DEBUG_PutString
****************************************************************************//**
*
* Invokes the Cy_SCB_UART_PutString() PDL driver function.
*
*******************************************************************************/
__STATIC_INLINE void UART_DEBUG_PutString(char_t const string[])
{
    Cy_SCB_UART_PutString(UART_DEBUG_HW, string);
}


/*******************************************************************************
* Function Name: UART_DEBUG_SendBreakBlocking
****************************************************************************//**
*
* Invokes the Cy_SCB_UART_SendBreakBlocking() PDL driver function.
*
*******************************************************************************/
__STATIC_INLINE void UART_DEBUG_SendBreakBlocking(uint32_t breakWidth)
{
    Cy_SCB_UART_SendBreakBlocking(UART_DEBUG_HW, breakWidth);
}


/*******************************************************************************
* Function Name: UART_DEBUG_GetTxFifoStatus
****************************************************************************//**
*
* Invokes the Cy_SCB_UART_GetTxFifoStatus() PDL driver function.
*
*******************************************************************************/
__STATIC_INLINE uint32_t UART_DEBUG_GetTxFifoStatus(void)
{
    return Cy_SCB_UART_GetTxFifoStatus(UART_DEBUG_HW);
}


/*******************************************************************************
* Function Name: UART_DEBUG_ClearTxFifoStatus
****************************************************************************//**
*
* Invokes the Cy_SCB_UART_ClearTxFifoStatus() PDL driver function.
*
*******************************************************************************/
__STATIC_INLINE void UART_DEBUG_ClearTxFifoStatus(uint32_t clearMask)
{
    Cy_SCB_UART_ClearTxFifoStatus(UART_DEBUG_HW, clearMask);
}


/*******************************************************************************
* Function Name: UART_DEBUG_GetNumInTxFifo
****************************************************************************//**
*
* Invokes the Cy_SCB_UART_GetNumInTxFifo() PDL driver function.
*
*******************************************************************************/
__STATIC_INLINE uint32_t UART_DEBUG_GetNumInTxFifo(void)
{
    return Cy_SCB_UART_GetNumInTxFifo(UART_DEBUG_HW);
}


/*******************************************************************************
* Function Name: UART_DEBUG_IsTxComplete
****************************************************************************//**
*
* Invokes the Cy_SCB_UART_IsTxComplete() PDL driver function.
*
*******************************************************************************/
__STATIC_INLINE bool UART_DEBUG_IsTxComplete(void)
{
    return Cy_SCB_UART_IsTxComplete(UART_DEBUG_HW);
}


/*******************************************************************************
* Function Name: UART_DEBUG_ClearTxFifo
****************************************************************************//**
*
* Invokes the Cy_SCB_UART_ClearTxFifo() PDL driver function.
*
*******************************************************************************/
__STATIC_INLINE void UART_DEBUG_ClearTxFifo(void)
{
    Cy_SCB_UART_ClearTxFifo(UART_DEBUG_HW);
}
#endif /* (UART_DEBUG_ENABLE_TX) */


#if (UART_DEBUG_ENABLE_RX)
/*******************************************************************************
* Function Name: UART_DEBUG_StartRingBuffer
****************************************************************************//**
*
* Invokes the Cy_SCB_UART_StartRingBuffer() PDL driver function.
*
*******************************************************************************/
__STATIC_INLINE void UART_DEBUG_StartRingBuffer(void *buffer, uint32_t size)
{
    Cy_SCB_UART_StartRingBuffer(UART_DEBUG_HW, buffer, size, &UART_DEBUG_context);
}


/*******************************************************************************
* Function Name: UART_DEBUG_StopRingBuffer
****************************************************************************//**
*
* Invokes the Cy_SCB_UART_StopRingBuffer() PDL driver function.
*
*******************************************************************************/
__STATIC_INLINE void UART_DEBUG_StopRingBuffer(void)
{
    Cy_SCB_UART_StopRingBuffer(UART_DEBUG_HW, &UART_DEBUG_context);
}


/*******************************************************************************
* Function Name: UART_DEBUG_ClearRingBuffer
****************************************************************************//**
*
* Invokes the Cy_SCB_UART_ClearRingBuffer() PDL driver function.
*
*******************************************************************************/
__STATIC_INLINE void UART_DEBUG_ClearRingBuffer(void)
{
    Cy_SCB_UART_ClearRingBuffer(UART_DEBUG_HW, &UART_DEBUG_context);
}


/*******************************************************************************
* Function Name: UART_DEBUG_GetNumInRingBuffer
****************************************************************************//**
*
* Invokes the Cy_SCB_UART_GetNumInRingBuffer() PDL driver function.
*
*******************************************************************************/
__STATIC_INLINE uint32_t UART_DEBUG_GetNumInRingBuffer(void)
{
    return Cy_SCB_UART_GetNumInRingBuffer(UART_DEBUG_HW, &UART_DEBUG_context);
}


/*******************************************************************************
* Function Name: UART_DEBUG_Receive
****************************************************************************//**
*
* Invokes the Cy_SCB_UART_Receive() PDL driver function.
*
*******************************************************************************/
__STATIC_INLINE cy_en_scb_uart_status_t UART_DEBUG_Receive(void *buffer, uint32_t size)
{
    return Cy_SCB_UART_Receive(UART_DEBUG_HW, buffer, size, &UART_DEBUG_context);
}


/*******************************************************************************
* Function Name: UART_DEBUG_GetReceiveStatus
****************************************************************************//**
*
* Invokes the Cy_SCB_UART_GetReceiveStatus() PDL driver function.
*
*******************************************************************************/
__STATIC_INLINE uint32_t UART_DEBUG_GetReceiveStatus(void)
{
    return Cy_SCB_UART_GetReceiveStatus(UART_DEBUG_HW, &UART_DEBUG_context);
}


/*******************************************************************************
* Function Name: UART_DEBUG_AbortReceive
****************************************************************************//**
*
* Invokes the Cy_SCB_UART_AbortReceive() PDL driver function.
*
*******************************************************************************/
__STATIC_INLINE void UART_DEBUG_AbortReceive(void)
{
    Cy_SCB_UART_AbortReceive(UART_DEBUG_HW, &UART_DEBUG_context);
}


/*******************************************************************************
* Function Name: UART_DEBUG_GetNumReceived
****************************************************************************//**
*
* Invokes the Cy_SCB_UART_GetNumReceived() PDL driver function.
*
*******************************************************************************/
__STATIC_INLINE uint32_t UART_DEBUG_GetNumReceived(void)
{
    return Cy_SCB_UART_GetNumReceived(UART_DEBUG_HW, &UART_DEBUG_context);
}
#endif /* (UART_DEBUG_ENABLE_RX) */


#if (UART_DEBUG_ENABLE_TX)
/*******************************************************************************
* Function Name: UART_DEBUG_Transmit
****************************************************************************//**
*
* Invokes the Cy_SCB_UART_Transmit() PDL driver function.
*
*******************************************************************************/
__STATIC_INLINE cy_en_scb_uart_status_t UART_DEBUG_Transmit(void *buffer, uint32_t size)
{
    return Cy_SCB_UART_Transmit(UART_DEBUG_HW, buffer, size, &UART_DEBUG_context);
}


/*******************************************************************************
* Function Name: UART_DEBUG_GetTransmitStatus
****************************************************************************//**
*
* Invokes the Cy_SCB_UART_GetTransmitStatus() PDL driver function.
*
*******************************************************************************/
__STATIC_INLINE uint32_t UART_DEBUG_GetTransmitStatus(void)
{
    return Cy_SCB_UART_GetTransmitStatus(UART_DEBUG_HW, &UART_DEBUG_context);
}


/*******************************************************************************
* Function Name: UART_DEBUG_AbortTransmit
****************************************************************************//**
*
* Invokes the Cy_SCB_UART_AbortTransmit() PDL driver function.
*
*******************************************************************************/
__STATIC_INLINE void UART_DEBUG_AbortTransmit(void)
{
    Cy_SCB_UART_AbortTransmit(UART_DEBUG_HW, &UART_DEBUG_context);
}


/*******************************************************************************
* Function Name: UART_DEBUG_GetNumLeftToTransmit
****************************************************************************//**
*
* Invokes the Cy_SCB_UART_GetNumLeftToTransmit() PDL driver function.
*
*******************************************************************************/
__STATIC_INLINE uint32_t UART_DEBUG_GetNumLeftToTransmit(void)
{
    return Cy_SCB_UART_GetNumLeftToTransmit(UART_DEBUG_HW, &UART_DEBUG_context);
}
#endif /* (UART_DEBUG_ENABLE_TX) */


/*******************************************************************************
* Function Name: UART_DEBUG_Interrupt
****************************************************************************//**
*
* Invokes the Cy_SCB_UART_Interrupt() PDL driver function.
*
*******************************************************************************/
__STATIC_INLINE void UART_DEBUG_Interrupt(void)
{
    Cy_SCB_UART_Interrupt(UART_DEBUG_HW, &UART_DEBUG_context);
}

#if defined(__cplusplus)
}
#endif

#endif /* UART_DEBUG_CY_SCB_UART_PDL_H */


/* [] END OF FILE */
