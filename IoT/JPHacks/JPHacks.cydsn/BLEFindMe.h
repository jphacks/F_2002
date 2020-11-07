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

#ifndef BLEFINDME_H
    
    #define BLEFINDME_H
    
    #include <project.h>
    #include "debug.h"
    #include "LED.h"
    
    /***************************************
    *       Function Prototypes
    ***************************************/
    void BleFindMe_Init(void);
    uint8 BleFindMe_Process(void); 
    void BleSendData(float, float, int, int, float);

#endif

/* [] END OF FILE */
