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

#include "DHT11.h"

/* Function to read high and low pulse values */
uint32_t expectPulse(uint32_t pinState){
    
    uint32_t count = 0;
    
    if(pinState == 0){
        while(Cy_GPIO_Read(Data_Tempreature_Humidity_PORT, Data_Tempreature_Humidity_NUM) == 0UL){
            count++;
            
            if(count > MIN_INTERVAL){
                count = TIMEOUT;
                break;
            }
        }
    }else{
        while(Cy_GPIO_Read(Data_Tempreature_Humidity_PORT, Data_Tempreature_Humidity_NUM) == 1UL){
            count++;
            if(count > MIN_INTERVAL){
                count = TIMEOUT;
                break;
            }
        }
    }
    
    return count;
}

/* Function to set read sensor values */
uint8* DHT_Read(){
    
    int highCycle = 0;
    int lowCycle = 0;
    uint32_t cycles[80];
    int timeout = 0;

    Cy_SysLib_Delay(SETUP_TIME);
    
    for(int i = 0; i < 5; i++){
        data[i] = 0;
    }
    
    // Now start reading the data line to get the value from the DHT sensor.
    
    // Turn off interrupts temporarily because the next sections
    // are timing critical and we don't want any interruptions.
    uint8_t state = CyEnterCriticalSection();
    
    Cy_GPIO_SetDrivemode(Data_Tempreature_Humidity_PORT, Data_Tempreature_Humidity_NUM, CY_GPIO_DM_STRONG);
    
    Cy_GPIO_Write(Data_Tempreature_Humidity_PORT, Data_Tempreature_Humidity_NUM, 0);
    Cy_SysLib_Delay(RETENTION_TIME);
    Cy_GPIO_Write(Data_Tempreature_Humidity_PORT, Data_Tempreature_Humidity_NUM, 1);
    
    Cy_GPIO_SetDrivemode(Data_Tempreature_Humidity_PORT, Data_Tempreature_Humidity_NUM, CY_GPIO_DM_PULLUP);
    
    while(Cy_GPIO_Read(Data_Tempreature_Humidity_PORT, Data_Tempreature_Humidity_NUM) == 1UL){
        timeout++;
            if(timeout > MIN_INTERVAL){
                timeout = TIMEOUT;
                break;
            }
    };
    
    // First expect a low signal for ~80 microseconds followed by a high signal
    // for ~80 microseconds again.
    while(Cy_GPIO_Read(Data_Tempreature_Humidity_PORT, Data_Tempreature_Humidity_NUM) == 0UL){
        timeout++;
            if(timeout > MIN_INTERVAL*2){
                timeout = TIMEOUT;
                break;
        }
    };
    
    while(Cy_GPIO_Read(Data_Tempreature_Humidity_PORT, Data_Tempreature_Humidity_NUM) == 1UL){
        timeout++;
            if(timeout > MIN_INTERVAL*3){
                timeout = TIMEOUT;
                break;
        }
    };
    
    // Error handling when sensor doesn't respond
    if(timeout == TIMEOUT){
        handle_error();
        return data;
    }
    
    // Now read the 40 bits sent by the sensor.  Each bit is sent as a 50
    // microsecond low pulse followed by a variable length high pulse.  If the
    // high pulse is ~28 microseconds then it's a 0 and if it's ~70 microseconds
    // then it's a 1.  We measure the cycle count of the initial 50us low pulse
    // and use that to compare to the cycle count of the high pulse to determine
    // if the bit is a 0 (high state cycle count < low state cycle count), or a
    // 1 (high state cycle count > low state cycle count). Note that for speed
    // all the pulses are read into a array and then examined in a later step.
    for(int j = 0; j < 80; j+=2){
        cycles[j] = expectPulse(0UL);
        cycles[j+1] = expectPulse(1UL);
    }
    
    CyExitCriticalSection(state);
    
    // Timing critical code is now complete.
    
    // Inspect pulses and determine which ones are 0 (high state cycle count < low
    // state cycle count), or 1 (high state cycle count > low state cycle count).
    for(int j = 0; j < 40; j++){
        
        highCycle = cycles[2*j+1];
        lowCycle = cycles[2*j];
        
        // Error handling when sensor doesn't respond
        if((lowCycle == TIMEOUT) || (highCycle == TIMEOUT)){
            handle_error();
            return data;
        }
        
        data[j/8] <<= 1;
        
        // Now compare the low and high cycle times to see if the bit is a 0 or 1.
        if(highCycle > lowCycle){
            data[j/8] |=  1;
        }
    }
    
    // Check we read 40 bits and that the checksum matches.
    if(data[4]!=((data[0] + data[1] + data[2] + data[3]) & 0xFF)){
        handle_error();
    }
    
    //Revert line to default state
    Cy_GPIO_SetDrivemode(Data_Tempreature_Humidity_PORT, Data_Tempreature_Humidity_NUM, CY_GPIO_DM_STRONG);
    Cy_GPIO_Write(Data_Tempreature_Humidity_PORT, Data_Tempreature_Humidity_NUM, 1);
    
    return data;
    
}

/* Function to set error values when sensor doesn't respond */
void handle_error(){
    data[0]=data[1]=data[2]=data[3] = ERROR;
}

/* [] END OF FILE */
