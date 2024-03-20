import serial
import pandas as pd
import time
from openpyxl import Workbook
from openpyxl import load_workbook

# Serial port settings
COM_PORT = 'COM4'  # Change this to match your Arduino's COM port
BAUD_RATE = 9600  # Change this to match your Arduino's baud rate

t= 5; 

# Excel file path
OUTPUT_FILE = 'C:\\Users\pawar\Desktop\GestureReadings\ThirdReadings\Bavly\Bavly35.xlsx'

# Connect to Arduino
arduino = serial.Serial(COM_PORT, BAUD_RATE)

# Create an Excel workbook
workbook = Workbook()
worksheet = workbook.active

# Write column heading
worksheet['A1'] = 'Time'
worksheet['B1'] = 'EMG1'
worksheet['C1'] = 'EMG2'

# Excel row index
row_index = 2

# Sampling interval in seconds (1 / 200 readings per second)
sampling_interval = 1 / 200

# Flag to indicate if data reception is active
receiving_data = False

while True:
    # Prompt user for input
    user_input = input("Enter 'start' to begin receiving data and exporting to Excel, or 'quit' to exit the program: ")

    if user_input.lower() == 'start':
        if receiving_data:
            print("Data reception is already active.")
        else:
            # Start data reception
            receiving_data = True
            print("Data reception started.")

            start_time = time.time()
            next_sample_time = start_time + sampling_interval

            try:
                while receiving_data:
                    # Read data from Arduino if it's time for the next sample
                    if time.time() >= next_sample_time:
                        next_sample_time += sampling_interval

                        # Read data from Arduino
                        data = arduino.readline().decode().strip()

                        # Calculate elapsed time
                        elapsed_time = time.time() - start_time

                        # Split the data into EMG1 and EMG2 values
                        emg1, emg2 = map(int, data.split(','))

                        # Print the data
                        print(f"Time: {elapsed_time:.2f}, EMG1: {emg1}, EMG2: {emg2}")

                        # Write the data to Excel
                        worksheet[f'A{row_index}'] = elapsed_time
                        worksheet[f'B{row_index}'] = emg1
                        worksheet[f'C{row_index}'] = emg2

                        # Increment the row index
                        row_index += 1

                        if elapsed_time >= t:
                            # Save the workbook
                            workbook.save(OUTPUT_FILE)
                            workbook.close()

                            print("Exported data to Excel.")
                            receiving_data = False

            except KeyboardInterrupt:
                # Keyboard interrupt to stop the program
                receiving_data = False
                print("Data reception stopped.")

    elif user_input.lower() == 'quit':
        # Close the serial connection
        arduino.close()
        print("Program exited.")
        break

    else:
        print("Invalid input. Please try again.")
