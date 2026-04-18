# Rideau Canal Skateway Real-Time Monitor

Student Name: Naveed Hossain

Student ID: 041081882

https://github.com/NaveedHossain2026/rideau-canal-sensor-simulation

https://github.com/NaveedHossain2026/rideau-canal-dashboard


## Scenario Overview

Problem Statement: The Rideau Canal Skateway requires precise, real-time monitoring of ice thickness and surface temperature across multiple sections (Dow's Lake, Fifth Avenue, and the NAC) to ensure public safety and optimize maintenance.

__System Objectives:__

- Automate telemetry collection from remote locations.

- Process data streams to determine "Safe," "Caution," or "Unsafe" conditions.

- Provide a historical and real-time visual dashboard for officials and the public.


## System Architecture

### Architecture diagram

![image alt](https://github.com/NaveedHossain2026/rideau-canal-monitoring/blob/ff022cb4dd624195d9cf23febc095c673d068601/architecture/architecture-diagram.png)

This architecture simulates an IoT-based safety monitoring system where multiple sensors, such as those representing Dow’s Lake, Fifth Avenue, and the NAC, generate telemetry data in JSON format every 10 seconds using Python. This data is sent to Azure IoT Hub, which acts as the main entry point. It is then processed in real time by Azure Stream Analytics, where it is processed in a 5-minute tumbling window to aggregate and summarize the incoming data, such as calculating averages or determining safety status for each location. The processed data is then routed to two destinations: Azure Cosmos DB for fast access by the dashboard, while Azure Blob Storage keeps a long-term archival copy of historical data. A web dashboard hosted on Azure App Service retrieves the processed data from Cosmos DB and presents it to users in a browser, displaying safety statuses such as safe, caution, or unsafe.

## Implementation Overview

__IoT Sensor Simulation__

The system starts with a Python-based IoT simulator that acts like real sensors along the Rideau Canal. Using asynchronous tasks, it simulates three locations: Dow’s Lake, Fifth Avenue, and the NAC—running at the same time. Each sensor generates realistic data like ice thickness, temperature, and snow levels, then sends it as JSON using MQTT. This setup allows continuous data streaming without delays.

__Azure IoT Hub configuration__

Azure IoT Hub is used as the central entry point for all this data. It securely manages each device, making sure only trusted data is accepted. It also handles the high volume of incoming messages and passes them to other services for real-time processing and storage, ensuring the system runs smoothly and reliably.

__Stream Analytics job (include query)__

 Azure Stream Analytics is the brain of the system, which processes the data in real time. It groups incoming sensor data into a Tumbling Window(5 minutes) and calculates averages. Using a simple SQL query, it also determines a safety status: if the ice is thick enough (30 cm or more) and the temperature is cold enough (−2°C or lower), it’s marked “Safe”; otherwise, it is labeled “Caution” or “Unsafe” based on the conditions.

__Cosmos DB setup and Blob Storage configuration__

The system uses two types of storage for different needs. Azure Cosmos DB stores the latest processed data so the dashboard can load quickly and show real-time updates. At the same time, Azure Blob Storage saves all the raw sensor data for long-term storage. This way, the app stays fast while still keeping a full history for future analysis.


__Web Dashboard and Azure App Service deployment (link to repo)__

The user interface is a Node.js and Express web app that shows real-time canal conditions. The backend uses a query that groups data by location, so each part of the dashboard shows the latest update without duplicates. It is hosted on Azure App Service and uses GitHub Actions for automatic deployment whenever code is updated. The frontend uses Chart.js to display simple, interactive charts showing how ice conditions change over time.

## Repository Links

### 1. Sensor Simulation Repository
- **URL:** https://github.com/NaveedHossain2026/rideau-canal-sensor-simulation
- **Description:** IoT sensor simulator code

### 2. Web Dashboard Repository
- **URL:** https://github.com/NaveedHossain2026/rideau-canal-dashboard
- **Description:** Web dashboard application

### 3. Live Dashboard Deployment 
- **URL:** [rideau-canal-dashboard-ddbqa8hndpaebcbg.canadacentral-01.azurewebsites.net](https://rideau-canal-dashboard-ddbqa8hndpaebcbg.canadacentral-01.azurewebsites.net/) 
- **Description:** The live deployment of the dashboard application
- **Note:** The live deployment uses Azure Free Tier resources to avoid costs. So the live site may go offline if the daily free compute quota is reached.

## Video Demonstration

https://www.youtube.com/watch?v=fS4D2X9BBHs

## Setup Instructions

__Prerequisites__

To run this system, you need:

Accounts: An Azure Subscription (Free/Student) and a GitHub account.

Software: Python 3.9+ (for sensors) and Node.js 18+ (for the dashboard).

Tools: Git for cloning repositories and VS Code for configuration.

__High-Level Setup Steps__

Azure Infrastructure: Create an IoT Hub to receive data, Cosmos DB to store it, and Blob Storage to archive it.

Data Logic: Set up a Stream Analytics Job to bridge the Hub and the Database using the provided SQL query.

Deploy Sensors: Clone the Simulation Repo, update the connection string, and run the Python script to start sending data.

Deploy Dashboard: Clone the Web Repo, connect it to your Cosmos DB, and deploy it to an Azure App Service.


## Results and Analysis

__Sample Outputs and Screenshots__

The system successfully visualizes telemetry from three distinct canal sectors: Dow's Lake, Fifth Avenue, and the NAC.

Real-Time Cards: Change color (Green/Orange/Red) instantly based on safety thresholds.

Historical Trending: The chart tracks ice thickness over time, showing how the data "tumbles" into averages.

__Data analysis__

Using tumbling windows was key because they filter out small fluctuations (noise) and focus on stable 5-minute averages. During testing, when ice thickness dropped below 25 cm, the system correctly triggered an “Unsafe” alert on the dashboard within one refresh cycle.

## AI Tools Disclosure

### AI Tools Used

- **Tool:** Gemini (Google), Claude
- **Purpose:** Architecture design, Code generation, debugging, and documentation structuring.
- **Extent:** AI was used to generate code to assist with the development of the sensor simulation and web dashboard, structure the project documentation, and assist in designing the system architecture diagrams. All Azure resource provisioning and final system integration were performed manually.

