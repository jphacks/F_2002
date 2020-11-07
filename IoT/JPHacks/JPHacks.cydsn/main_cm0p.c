/* ========================================
 *
 * Copyright YOUR COMPANY, THE YEAR
 * All Rights Reserved
 * UNPUBLISHED, LICENSED SOFTWARE.
 *
 * CONFIDENTIAL AND PROPRIETARY INFORMATION
 * WHICH IS THE PROPERTY OF your company.
 *
 * ========================================
*/

#include "project.h"

int main(void)
{
    cy_en_ble_api_result_t          apiResult;
    
    __enable_irq(); /* Enable global interrupts. */
    
    /* Unfreeze IO if device is waking up from hibernate */
    if(Cy_SysPm_GetIoFreezeStatus())
    {
        Cy_SysPm_IoUnfreeze();
    }
    
    /* Start the Controller portion of BLE. Host runs on the CM4 */
    apiResult = Cy_BLE_Start(NULL);
    
    if(apiResult == CY_BLE_SUCCESS)
    {
        /* Enable CM4 only if BLE Controller started successfully. 
        *  CY_CORTEX_M4_APPL_ADDR must be updated if CM4 memory layout 
        *  is changed. */
        Cy_SysEnableCM4(CY_CORTEX_M4_APPL_ADDR); 
    }
    else
    {
        /* Halt CPU */
        CY_ASSERT(0u != 0u);
    }
   
    /* Place your initialization/startup code here (e.g. MyInst_Start()) */
    
    for(;;)
    {
        /* Place your application code here. */
        /* Put CM0p to deep sleep */
        Cy_SysPm_DeepSleep(CY_SYSPM_WAIT_FOR_INTERRUPT);
        
        /* Cy_Ble_ProcessEvents() allows BLE stack to process pending events */
        /* The BLE Controller automatically wakes up host if required */
        Cy_BLE_ProcessEvents();        
    }
}

/* [] END OF FILE */
