# Project :paw_prints: Veterinary Management System - Curando Patitas

## 🔗 Table of Contents

| Index | Title |
| --- | --- |
| 📍 | Project Description |
| 📦 | Implemented Features |
| 🛠️ | Installation and Setup |
| 🛡️ | User Roles and Permissions |
| ⚙️ | Procedures, Functions, Triggers, and Events |
| 🤝 | Contributions |

---

## 📍 Project Description

### Veterinary Management System

The project aims to develop an integrated system for managing the operations of a veterinary clinic. This system covers the administration of information about pets, owners, health history, inventory of medications and vaccines, medical consultation scheduling, and billing. Additionally, it includes extra functionalities like grooming and bathing services, daycare, and mass adoption or vaccination events.

#### System Purpose

The system was designed to:

- **Optimize Pet and Owner Management:** Detailed registration of pets and their owners, including medical data, vaccination history, and consultations.
- **Facilitate Health and Vaccination Control:** Tracking vaccines, antiparasitic treatments, and automated reminders.
- **Manage Medication Inventory:** Management of medical supplies, expiration control, and automatic replenishment.
- **Organize Veterinary Services:** Efficient scheduling of medical appointments, additional services (grooming, daycare), and postoperative follow-ups.
- **Generate Electronic Billing:** Compliant with DIAN regulations in Colombia, including tax details and digital signature.
- **Provide Analysis and Reports:** Generate reports on the clinic’s operations, statistics on care, inventory, and staff performance.

---

## 📦 Implemented Features

The system includes:

- **Pet and Owner Management:**
  - Full registration of pets with basic data, medical information, and unique identification (name, species, age, medical history).
  - Pet-owner association and responsibility transfer.
  - Ownership transfer in case of adoption.
- **Health and Vaccination Control:**
  - Registration of vaccines and deworming treatments with automated alerts.
  - History of medical consultations, diagnoses, and treatments.
- **Medication Inventory:**
  - Stock control, expiration dates, and replenishment.
  - Supplier records and automatic purchase orders.
- **Service Scheduling:**
  - Management of medical appointments, grooming, and daycare services.
  - Record of surgeries and special procedures.
  - Registration of additional services such as bathing, grooming, daycare, and training.
- **Electronic Billing:**
  - Generation of invoices in PDF/PNG format with complete fiscal data, compliant with Colombian regulations.
- **Reports:**
  - Reports on pets treated, inventory, billing, and services.
  - Analysis of veterinary team performance.

---

## 🛠️ Installation and Setup

### System Requirements

- **Operating System:** Windows, macOS, or Linux.
- **Necessary Software:**
  - JDK 17 for Java.
  - MySQL 8.0 or higher.
  - IDE such as IntelliJ IDEA or Eclipse.
  - MySQL Workbench.

### Setup Steps

1. **Install Java and MySQL:**
   - Download and install JDK 17 from [Oracle](https://www.oracle.com/java/technologies/javase-downloads.html).
   - Install MySQL Server and Workbench from [MySQL](https://dev.mysql.com/downloads/).

2. **Configure the Database:**
   - Create the database by running the `ddl.sql` file in MySQL Workbench.
     ```sql
     SOURCE /path/to/your/ddl.sql;
     ```
   - Load initial data by running `dml.sql`:
     ```sql
     SOURCE /path/to/your/dml.sql;
     ```

3. **Run the Java Project:**
   - Open the project in your IDE and configure the JDBC connection with your MySQL server details.
   - Run the main class to start the system.

4. **Configure Logs:**
   - Errors and important events will be logged in a log file located in the main project directory.

---

## 🛡️ User Roles and Permissions

### 1. Administrator User 🧡
- **Username:** admin
- **Permissions:** Full control of the system: users, inventory, billing, and reports.

### 2. Veterinarian User 🐱
- **Username:** veterinarian
- **Permissions:** Management of consultations, diagnoses, and medical procedures.

### 3. Receptionist User 📞
- **Username:** receptionist
- **Permissions:** Scheduling appointments, registering additional services, and registering new clients and billing.

### 4. Inventory Manager User 📦
- **Username:** inventory
- **Permissions:** Register, control, and replenish medication and supply stock.

---

## ⚙️ Procedures, Functions, Triggers, and Events

### Procedures
- Register Pets: Inserts detailed information for new pets.
- Update Inventory: Adjusts stock quantities after each consultation or procedure.

### Functions
- Age Calculation: Determines the age of a pet based on its birth date.
- Medication Availability Check: Verifies whether a medication is available before use.
- Invoice Calculation: Computes subtotal, taxes, and total for an invoice.
- Calculate Remaining Time for Next Dose: Determines the number of days until the next dose.
- Vaccine Expiry Check: Verifies if a vaccine has expired based on the current date.

### Triggers
- Date Validation: Ensures that medication expiration dates are later than the current date.
- Automatic Update: Adjusts inventory after registering a procedure.

### Events
- Vaccination Reminder: Sends automatic alerts for upcoming vaccinations.
- Deworming Reminder: Sends automatic alerts for upcoming deworming treatments.
- Medical Appointment Reminder: Sends automatic alerts for upcoming medical appointments.
- Automatic Inventory Replenishment Notifications.

## 🤝 Contributions

- The project was developed in collaboration by:

   - Jhoan Sebastián Díaz Ardila: Architecture and database design.
   - María Camila Díaz Toledo: Backend development in Java.

- Both contributors worked equally to ensure the success of the system. ✨



