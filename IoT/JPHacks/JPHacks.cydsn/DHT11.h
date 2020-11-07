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

#ifndef DHT11_H
#define DHT11_H
    
#include "project.h"
    
#define MIN_INTERVAL 2000 /**< min interval value */
#define TIMEOUT -1        /**< timeout  */
#define SETUP_TIME 1000    /* In milliseconds */
#define RETENTION_TIME 19  /* Should be > 18ms */
#define ONE_DETECTION_TIME 120
#define ZERO_DETECTION_TIME 80
#define ERROR 99
    
uint8 data[5];

uint32_t expectPulse(uint32_t pinState);
uint8* DHT_Read();
void handle_error();

#endif

/* [] END OF FILE */
