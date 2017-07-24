/*
    INDI PLC Dome
    Copyright (C) 2017 Javier Martinez Gusano

    This library is free software; you can redistribute it and/or
    modify it under the terms of the GNU Lesser General Public
    License as published by the Free Software Foundation; either
    version 2.1 of the License, or (at your option) any later version.

    This library is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
    Lesser General Public License for more details.

    You should have received a copy of the GNU Lesser General Public
    License along with this library; if not, write to the Free Software
    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
*/

#ifndef PLCDOMEDRIVER_H
#define PLCDOMEDRIVER_H

#ifdef __cplusplus
extern "C" {
#endif

// Direction fo azimuth movement
#define PLCDOME_EW_DIR 0x01
#define PLCDOME_WE_DIR 0x02

// Azimuth motor status. When motor is idle, sometimes returns 0, sometimes 4. After connect, it returns 5
enum AZ_Status {As_IDLE = 1, As_MOVING_WE, As_MOVING_EW, As_IDEL2, As_ERROR};

// Shutter status
enum SH_Status {Ss_CLOSED = 0, Ss_OPENING, Ss_OPEN, Ss_CLOSING, Ss_ABORTED, Ss_ERROR};

extern const char *ErrorMessages[];

int Connect_PlcDome(const char *device); 
int Disconnect_PlcDome(int fd);

int Abort_Azimuth_PlcDome(int fd);
int Home_Azimuth_PlcDome(int fd);
int Goto_Azimuth_PlcDome(int fd, int nDir, int nTicks);
int Status_PlcDome(int fd, enum SH_Status *nShutterStatus, enum AZ_Status *nAzimuthStatus, unsigned *nAzimuthPosition, unsigned *nHomePosition);
int Ack_PlcDome(int fd);
int SetPark_PlcDome(int fd, int nParkOnShutter, int nTicks);
int SetTicksPerCount_PlcDome(int fd, int nTicks);
int Park_PlcDome(int fd);
//  Shutter commands
int Open_Shutter_PlcDome(int fd);
int Open_Upper_Shutter_Only_PlcDome(int fd);
int Close_Shutter_PlcDome(int fd);
int Abort_Shutter_PlcDome(int fd);
int Exit_Shutter_PlcDome(int fd);

#ifdef __cplusplus
}
#endif

#endif
