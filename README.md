# Rideau Canal Skateway Real-Time Monitor

Student Name: Naveed Hossain

Student ID: [Your ID]

## Scenario Overview

Problem Statement: The Rideau Canal Skateway requires precise, real-time monitoring of ice thickness and surface temperature across multiple sections (Dow's Lake, Fifth Avenue, and the NAC) to ensure public safety and optimize maintenance.

System Objectives:

- Automate telemetry collection from remote locations.

- Process data streams to determine "Safe," "Caution," or "Unsafe" conditions.

- Provide a historical and real-time visual dashboard for officials and the public.


## System Architecture

![image alt](https://github.com/NaveedHossain2026/rideau-canal-monitoring/blob/ff022cb4dd624195d9cf23febc095c673d068601/architecture/architecture-diagram.png)

This architecture simulates an IoT-based safety monitoring system where multiple sensors, such as those representing Dow’s Lake, Fifth Avenue, and the NAC, generate telemetry data in JSON format every 10 seconds using Python. This data is sent to Azure IoT Hub, which acts as the main entry point. It is then processed in real time by Azure Stream Analytics, where it is processed in real time using a 5-minute tumbling window to aggregate and summarize the incoming data, such as calculating averages or determining safety status for each location. The processed data is then routed to two destinations: Azure Cosmos DB for fast access by the dashboard, while Azure Blob Storage keeps a long-term archival copy of historical data. A web dashboard hosted on Azure App Service retrieves the processed data from Cosmos DB and presents it to users in a browser, displaying safety statuses such as safe, caution, or unsafe.
