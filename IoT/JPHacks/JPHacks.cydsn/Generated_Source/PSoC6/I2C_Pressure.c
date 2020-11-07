/***************************************************************************//**
* \file I2C_Pressure.c
* \version 2.0
*
*  This file provides the source code to the API for the I2C Component.
*
********************************************************************************
* \copyright
* Copyright 2016-2017, Cypress Semiconductor Corporation. All rights reserved.
* You may use this file only in accordance with the license, terms, conditions,
* disclaimers, and limitations in the end user license agreement accompanying
* the software package with which this file was provided.
*******************************************************************************/

#include "I2C_Pressure.h"
#include "sysint/cy_sysint.h"
#include "cyfitter_sysint.h"
#include "cyfitter_sysint_cfg.h"


#if defined(__cplusplus)
extern "C" {
#endif

/***************************************
*     Global variables
***************************************/

/** I2C_Pressure_initVar indicates whether the I2C_Pressure
*  component has been initialized. The variable is initialized to 0
*  and set to 1 the first time I2C_Pressure_Start() is called.
*  This allows  the component to restart without reinitialization
*  after the first call to the I2C_Pressure_Start() routine.
*
*  If re-initialization of the component is required, then the
*  I2C_Pressure_Init() function can be called before the
*  I2C_Pressure_Start() or I2C_Pressure_Enable() function.
*/
uint8_t I2C_Pressure_initVar = 0U;

/** The instance-specific configuration structure.
* The pointer to this structure should be passed to Cy_SCB_I2C_Init function
* to initialize component with GUI selected settings.
*/
cy_stc_scb_i2c_config_t const I2C_Pressure_config =
{
    .i2cMode    = CY_SCB_I2C_SLAVE,

    .useRxFifo = false,
    .useTxFifo = false,

    .slaveAddress        = 0x8U,
    .slaveAddressMask    = 0xFEU,
    .acceptAddrInFifo    = false,
    .ackGeneralAddr      = false,

    .enableWakeFromSleep = false
};

/** The instance-specific context structure.
* It is used while the driver operation for internal configuration and
* data keeping for the I2C. The user should not modify anything in this
* structure.
*/
cy_stc_scb_i2c_context_t I2C_Pressure_context;


/*******************************************************************************
* Function Name: I2C_Pressure_Start
****************************************************************************//**
*
* Invokes I2C_Pressure_Init() and I2C_Pressure_Enable().
* Also configures interrupt and low and high oversampling phases.
* After this function call the component is enabled and ready for operation.
* This is the preferred method to begin component operation.
*
* \globalvars
* \ref I2C_Pressure_initVar - used to check initial configuration,
* modified  on first function call.
*
*******************************************************************************/
void I2C_Pressure_Start(void)
{
    if (0U == I2C_Pressure_initVar)
    {
        /* Configure component */
        (void) Cy_SCB_I2C_Init(I2C_Pressure_HW, &I2C_Pressure_config, &I2C_Pressure_context);

    #if (I2C_Pressure_ENABLE_MASTER)
        /* Configure desired data rate */
        (void) Cy_SCB_I2C_SetDataRate(I2C_Pressure_HW, I2C_Pressure_DATA_RATE_HZ, I2C_Pressure_CLK_FREQ_HZ);

        #if (I2C_Pressure_MANUAL_SCL_CONTROL)
            Cy_SCB_I2C_MasterSetLowPhaseDutyCycle (I2C_Pressure_HW, I2C_Pressure_LOW_PHASE_DUTY_CYCLE);
            Cy_SCB_I2C_MasterSetHighPhaseDutyCycle(I2C_Pressure_HW, I2C_Pressure_HIGH_PHASE_DUTY_CYCLE);
        #endif /* (I2C_Pressure_MANUAL_SCL_CONTROL) */
    #endif /* (I2C_Pressure_ENABLE_MASTER) */

        /* Hook interrupt service routine */
    #if defined(I2C_Pressure_SCB_IRQ__INTC_ASSIGNED)
        (void) Cy_SysInt_Init(&I2C_Pressure_SCB_IRQ_cfg, &I2C_Pressure_Interrupt);
    #endif /* (I2C_Pressure_SCB_IRQ__INTC_ASSIGNED) */

        I2C_Pressure_initVar = 1U;
    }

    /* Enable interrupt in NVIC */
#if defined(I2C_Pressure_SCB_IRQ__INTC_ASSIGNED)
    NVIC_EnableIRQ((IRQn_Type) I2C_Pressure_SCB_IRQ_cfg.intrSrc);
#endif /* (I2C_Pressure_SCB_IRQ__INTC_ASSIGNED) */

    Cy_SCB_I2C_Enable(I2C_Pressure_HW);
}

#if defined(__cplusplus)
}
#endif


/* [] END OF FILE */
