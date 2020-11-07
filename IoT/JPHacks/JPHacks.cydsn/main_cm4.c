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

#include <project.h>
#include "BLEFindMe.h"
#include "DHT11.h"
#include <stdio.h>
#include <math.h>

#include "proximity_task.h"
#include "queue.h"


#define timeout_duration 100
#define READ_FREQ 1000 /* Read sensor every 1000 ms */
#define MAX_MOIS 620
#define MIN_MOIS 310

/*******************************************************************************
* Function Name: Fraction_Convert
****************************************************************************//**
*
* Converts a 8 bit binary number into a fractional decimal value
*
* \param num
* 8 bit binary value
*
* \return
* Fractional decimal value of the binary number
*
*******************************************************************************/
float Fraction_Convert(uint8_t num)
{
    float fraction = 0;
    int unit = 0;
    for( int i = 0; i<8; i++)
    {
        unit = num & 1;
        num = num>>1;
        fraction = fraction + unit * pow(2, -(1+i));
    }
    return fraction;
}

/*******************************************************************************
* Function Name: Map
****************************************************************************//**
*
* Converts a number from one range to another.
*
* \param x, in_minn in_max, out_min, out_max
* long value
*
* \return
* 
*
*******************************************************************************/
float Map(long x, long in_min, long in_max, long out_min, long out_max) {
  return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;
}

/*******************************************************************************
* Function Name: Start
****************************************************************************//**
*
* Initiates the communication with the sensor. 
* Function sends 18ms low signal after 1s delay.
*
*******************************************************************************/

void Start(void)
{
    Cy_GPIO_Write(Data_Tempreature_Humidity_PORT, Data_Tempreature_Humidity_NUM, 1);
    CyDelay(1000);
    Cy_GPIO_Write(Data_Tempreature_Humidity_PORT, Data_Tempreature_Humidity_NUM, 0);
    CyDelay(18);
    Cy_GPIO_Write(Data_Tempreature_Humidity_PORT, Data_Tempreature_Humidity_NUM, 1);
}

/*******************************************************************************
* Function Name: main()
********************************************************************************
* Summary:
*  Main function for the project.
*
* Parameters:
*  None
*
* Return:
*  None
*
* Theory:
*  The main function initializes the PSoC 6 BLE device and runs a BLE process.
*
*******************************************************************************/

int main(void)
{
    __enable_irq(); /* Enable global interrupts. */
    
    bleCommandQ       = xQueueCreate(BLE_COMMAND_QUEUE_LEN,
                                        sizeof(ble_command_t));
    proximityCommandQ = xQueueCreate(PROXIMITY_QUEUE_LEN,
                                        sizeof(proximity_command_t));
    statusLedDataQ    = xQueueCreate(STATUS_LED_QUEUE_LEN,
                                        sizeof(status_led_data_t));
    
    /* Initialize BLE */
    BleFindMe_Init();
    
    //UART_DEBUG_Start();   /* Start UART component */

    /* Place your initialization/startup code here (e.g. MyInst_Start()) */
    UART_DEBUG_Start();    
    UART_DEBUG_PutString("Results\n\r");
    ADC_Photoresistor_Init();
    ADC_Photoresistor_Start();
    ADC_Photoresistor_StartConvert();
    
    uint8* data;
    char buffer[100];
    
    float humidity = 0, temperature = 0;    /* Variables to store temperature and humidity values */
    
    uint8_t result;
    
    int illuminance = 0;
    int soil_moisture = 0;
    float soil_moisture_persent = 0;
    uint8 alart = 0;
     
    for(;;)
    {
        /* Place your application code here. */
        alart = BleFindMe_Process();
        
        if(alart == CY_BLE_HIGH_ALERT){
            data = DHT_Read(&humidity, &temperature);
            
            ADC_Photoresistor_IsEndConversion(1);
            illuminance = ADC_Photoresistor_GetResult16(0);
            soil_moisture = ADC_Photoresistor_GetResult16(1);
            soil_moisture_persent = Map(soil_moisture, MAX_MOIS, MIN_MOIS, 0, 100);
            if(data[0] != ERROR){
                humidity = (int)data[0] + Fraction_Convert(data[1]);
                temperature = (int)data[2] + Fraction_Convert(data[3]);
                sprintf(buffer, " Humidity: %.2f \n\r Temperature: %.2f \n\r", humidity, temperature);
                printf(" Illuminance: %d\n\r SoilMoisture: %d\n\r SoilMoisturePersent: %.2f\n\r", illuminance, soil_moisture, soil_moisture_persent);
                UART_DEBUG_PutString(buffer);
            }else{  
                UART_DEBUG_PutString(" Error reading sensor!\n\r");
            }
            
            /* Ensure that there is atleast 1 second delay between each DHT_Read() function call */
            Cy_SysLib_Delay(READ_FREQ);
        }
    }
}

/* [] END OF FILE */
