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
#ifndef STATUS_LED_TASK_H
#define STATUS_LED_TASK_H

/* Header file includes */
#include "project.h"
#include "FreeRTOS.h"
#include "queue.h"    

/* Data-type of status LED commands of an individual LED */
typedef enum     
{
    LED_NO_CHANGE,
    LED_TURN_ON,
    LED_TURN_OFF,
    LED_TOGGLE_EN,
    LED_BLINK_ONCE,
    LED_TIMER_EXPIRED
}   status_led_command_t;

/* Data-type used for the control of Red and Orange status LEDs  */
typedef struct
{
    status_led_command_t redLed;
    status_led_command_t orangeLed;
}   status_led_data_t;    

/* Handle for the Queue that contains Status LED data */
extern QueueHandle_t statusLedDataQ;

/* Task_StatusLed updates status LED indications */
void Task_StatusLed(void *pvParameters);

#endif /* STATUS_LED_TASK_H */

/* [] END OF FILE */
