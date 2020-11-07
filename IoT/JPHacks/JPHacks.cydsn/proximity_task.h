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

/* Include guard */
#ifndef PROXIMITY_TASK_H
#define PROXIMITY_TASK_H

/* Header file includes */ 
#include "project.h"
#include "FreeRTOS.h"     
#include "queue.h"    

/* Data-type that's used to request periodic proximity data */    
typedef enum
{
    SEND_PROXIMITY, 
    SEND_NONE,
    PROXIMITY_TIMER_EXPIRED
}   proximity_command_t;    

/* Handles for the Queues that contain proximity command */ 
extern QueueHandle_t proximityCommandQ;

/* Task_Proximity scans the proximity sensor and sends data to Task_Ble when
   required */    
void Task_Proximity(void *pvParameters);    

#endif /* PROXIMITY_TASK_H */

/* [] END OF FILE */
