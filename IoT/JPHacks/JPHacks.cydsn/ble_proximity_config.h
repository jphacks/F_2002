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
#ifndef BLE_CUSTOM_SERVICES_H
#define BLE_CUSTOM_SERVICES_H

/* Header file includes */
#include "project.h"    
    
/* Redefinition of long custom service macros for better readability of the
   code */
#define PROXIMITY_CCCD_HANDLE      \
(CY_BLE_CAPSENSE_PROXIMITY_CAPSENSE_PROXIMITY_CLIENT_CHARACTERISTIC_CONFIGURATION_DESC_HANDLE)
#define PROXIMITY_CHAR_HANDLE      \
(CY_BLE_CAPSENSE_PROXIMITY_CAPSENSE_PROXIMITY_CHAR_HANDLE)    

/* For more details on the data formats of CapSense button, CapSense slider and 
   RGB LED Custom BLE Profiles provided by Cypress, see Cypress custom profile
   specifications available at:
   http://www.cypress.com/documentation/software-and-drivers/cypresss-custom-ble-profiles-and-services
*/
    
/* Size of Proximity characteristics data in bytes */
#define PROXIMITY_DATA_LEN    (uint8_t) (0x01u)

#endif /* BLE_CUSTOM_SERVICES_H */   

/* [] END OF FILE */
