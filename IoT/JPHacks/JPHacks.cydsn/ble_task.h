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
#ifndef BLE_TASK_H
#define BLE_TASK_H

/* Header file includes */ 
#include "project.h"
#include "FreeRTOS.h"
#include "queue.h"

/* Data type used for BLE commands */
typedef enum
{
    PROCESS_BLE_EVENTS,
    HANDLE_GPIO_INTERRUPT,
    SEND_PROXIMITY_NOTIFICATION,
}   ble_commands_list_t;

/* Data-type of BLE commands and data */
typedef struct
{   ble_commands_list_t command;
    uint8_t proximityData;
}   ble_command_t;

/* Handle for the Queue that contains BLE commands */
extern QueueHandle_t bleCommandQ;

/* Task_Ble takes care of the BLE module in this code example */    
void Task_Ble(void *pvParameters);

#endif /* BLE_TASK_H */

/* [] END OF FILE */
