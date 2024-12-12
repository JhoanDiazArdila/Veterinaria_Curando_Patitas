
CREATE DATABASE Curando_Patitas; 

USE Curando_Patitas;

-- Database for Veterinary Clinic Management System

-- Veterinarian Table
CREATE TABLE Employees (
    employ_id VARCHAR(100) PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    phone VARCHAR(100) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    address VARCHAR(100) NOT NULL,
    digital_finger_print_url VARCHAR(255) UNIQUE NOT NULL,
    job_position ENUM('VETERINARIAN', 'RECEPTIONIST', 'VETERINARY_HEAD', 'ACCOUNTANT', 'LAWYER', 'GENERAL_ADMINISTRATOR', 'CLEANING'),
    employee_status ENUM('ACTIVE', 'INACTIVE', 'VACATIONS'),
    salary DECIMAL(10,2) NOT NULL
);

-- Owner Table
CREATE TABLE Owners (
    owner_id VARCHAR(100) PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    address VARCHAR(100) NOT NULL,
    phone VARCHAR(100) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    emergency_contact_name VARCHAR(100),
    emergency_contact_phone VARCHAR(100)
);

-- Pet Table
CREATE TABLE Pets (
    pet_id INT AUTO_INCREMENT PRIMARY KEY,
    owner_id VARCHAR(100),
    name VARCHAR(100) NOT NULL,
    behavior ENUM('AGGRESSIVE', 'PASSIVE'),
    species ENUM('MAMMAL', 'BIRD', 'REPTILE'),
    type ENUM('Dog','Cat','Parrot','Tortola','Snake','Turtle') NOT NULL,
    breed VARCHAR(100),
    age INT,
    birthdate DATE NOT NULL,
    sex ENUM('MALE', 'FEMALE') NOT NULL,
    microchip_number VARCHAR(100) UNIQUE,
    photo_path VARCHAR(255) UNIQUE,
    weight DECIMAL(10,2) NOT NULL,
    size ENUM('BIG', 'MEDIUM', 'SMALL'),
    allergies TEXT,
    medical_conditions TEXT,
    FOREIGN KEY (owner_id) REFERENCES Owners(owner_id)
);


CREATE TABLE Services(
    service_id INT AUTO_INCREMENT PRIMARY KEY,
    service_type ENUM('VACCINATION', 'ADDITIONAL_SERVICE', 'MEDICAL_CONSULTATIONS', 'SURGICAL_PROCEDURES', 'ADOPTIONS'),
    name VARCHAR(100) NOT NULL,
    description VARCHAR (100),
    standar_price DECIMAL(10,2) NOT NULL
);

CREATE TABLE pet_services_appoinment(
    appointment_pet_service_id INT AUTO_INCREMENT PRIMARY KEY,
    service_id INT NOT NULL,
    employ_id VARCHAR(100) NOT NULL,
    pet_id int NOT NULL,
    entry_date_time DATETIME NOT NULL,
    exit_date_time DATETIME NOT NUll,
    visit_reason TEXT NOT NULL,
    diagnosis VARCHAR(100),
    recomendations TEXT,
    prescription_medicines TEXT,
    apoimet_status ENUM('SCHEDULED', 'IN_PROGRESS', 'COMPLETED', 'CANCELLED') NOT NULL,    
    FOREIGN KEY (service_id) REFERENCES Services(service_id),
    FOREIGN KEY (employ_id) REFERENCES Employees(employ_id),
    FOREIGN KEY (pet_id) REFERENCES Pets(pet_id)
);


-- Vaccination History Table
CREATE TABLE Vaccination (
    service_id INT NOT NULL,
    vaccination_type VARCHAR(100) NOT NULL,
    observation VARCHAR(100),
    duration INT NOT NULL,
    FOREIGN KEY (service_id) REFERENCES services(service_id)
);

-- Surgical Procedures Table
CREATE TABLE Surgical_Procedures (
    service_id INT PRIMARY KEY,
    preoperative_details TEXT NOT NULL,
    procedure_details TEXT NOT NULL,
    postoperative_follow_up TEXT NOT NULL,
    recovery_estimated_time TEXT NOT NULL,
    FOREIGN KEY (service_id) REFERENCES services(service_id)
);
-- Inventory Table
CREATE TABLE Inventory (
    item_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    item_type ENUM('MEDICATION', 'VACCINE', 'MEDICAL_SUPPLY') NOT NULL,
    sub_type VARCHAR(100) NOT NULL,
    manufacturer VARCHAR(100) NOT NULL,
    lot_number VARCHAR(100) NOT NULL,
    sell_price DECIMAL(10,2) NOT NULL,
    purchase_price DECIMAL(10,2) NOT NULL,
    expiration_date DATE NOT NULL,
    quantity INT NOT NULL
);

CREATE TABLE Items_used_services(
    item_used_service_id INT AUTO_INCREMENT PRIMARY KEY,
    item_id INT NOT NULL,
    service_id INT NOT NULL,
    quantity INT NOT NULL,
    FOREIGN KEY (item_id) REFERENCES Inventory(item_id),
    FOREIGN KEY (service_id) REFERENCES services(service_id)
);

CREATE TABLE Suppliers(
    supplier_id VARCHAR(100) PRIMARY KEY,
    company_name VARCHAR(100) NOT NULL UNIQUE,
    contact_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(20) NOT NULL UNIQUE,
    address VARCHAR(200) NOT NULL
);
CREATE TABLE Supplier_invoices(
    supplier_invoice_id INT AUTO_INCREMENT PRIMARY KEY,
    supplier_id VARCHAR(100) NOT NULL,
    invoice_date DATE NOT NULL,
    tax_amount DECIMAL(10,2) NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (supplier_id) REFERENCES Suppliers(supplier_id)
);
CREATE TABLE Purchase_items(
    supplier_invoice_id INT NOT NULL,
    item_id INT NOT NULL,
    quantity INT NOT NULL,
    FOREIGN KEY (supplier_invoice_id) REFERENCES Supplier_invoices(supplier_invoice_id),
    FOREIGN KEY (item_id) REFERENCES Inventory(item_id),
    PRIMARY KEY(supplier_invoice_id, item_id)
);

-- Shedule Table
CREATE TABLE Schedule(
    employ_id VARCHAR(100) NOT NULL,
    day ENUM('MONDAY', 'TUESDAY', 'WEDNESDAY', 'THURSDAY', 'FRIDAY', 'SATURDAY', 'SUNDAY') NOT NULL,
    entry_time TIME NOT NULL,
    exit_time TIME NOT NULL,
    FOREIGN KEY (employ_id) REFERENCES Employees(employ_id),
    PRIMARY KEY(employ_id, day)
);

-- EVENTS
CREATE TABLE Events(
    event_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    address VARCHAR(100) NOT NULL,
    start_time DATETIME NOT NULL,
    end_time DATETIME NOT NULL
);

CREATE TABLE Medic_team(
    medic_team INT AUTO_INCREMENT PRIMARY KEY,
    employ_id VARCHAR(100) NOT NULL,
    event_id INT NOT NULL,
    FOREIGN KEY (employ_id) REFERENCES Employees(employ_id),
    FOREIGN KEY (event_id) REFERENCES Events(event_id)
);


-- Loyalty Program Table
CREATE TABLE Loyalty_Program (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    owner_id VARCHAR(100) NOT NULL,
    total_points INT DEFAULT 0,
    membership_level ENUM('BRONZE', 'SILVER', 'GOLD') DEFAULT 'Bronze',
    FOREIGN KEY (owner_id) REFERENCES Owners(owner_id)
);

CREATE TABLE Owners_notifications(
    owner_notification_id INT AUTO_INCREMENT PRIMARY KEY,
    owner_id VARCHAR(100) NOT NULL,
    subject TEXT NOT NULL,
    notification_date DATE NOT NULL,
    descripction TEXT NOT NULL,
    FOREIGN KEY (owner_id) REFERENCES Owners(owner_id)
);

-- Adoption Tracking Table
CREATE TABLE Adoptions (
    appointment_pet_service_id INT PRIMARY KEY,
    adoption_date DATE NOT NULL,
    owner_id VARCHAR(100) NOT NULL,
    contract_path VARCHAR(255),
    FOREIGN KEY (appointment_pet_service_id) REFERENCES pet_services_appoinment(appointment_pet_service_id),
    FOREIGN KEY (owner_id) REFERENCES Owners(owner_id)
);

CREATE TABLE Update_adoptions(
    appointment_pet_service_id INT NOT NULL,
    follow_up_date DATE NOT NULL,
    follow_up_notes TEXT NOT NULL,
    FOREIGN KEY (appointment_pet_service_id) REFERENCES pet_services_appoinment(appointment_pet_service_id)
);


CREATE TABLE Service_event(
    event_id INT PRIMARY KEY,
    pet_id INT NOT NULL,
    service_id INT NOT NULL,
    quantity INT NOT NULL,
    FOREIGN KEY (event_id)REFERENCES Events(event_id),
    FOREIGN KEY (pet_id) REFERENCES Pets(pet_id),
    FOREIGN KEY (service_id) REFERENCES Services(service_id)
);


CREATE TABLE Company_information(
    NIT VARCHAR(100) PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    address VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(100) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE
);
CREATE TABLE Company_notification(
    general_notification_id INT AUTO_INCREMENT PRIMARY KEY,
    NIT VARCHAR(100) NOT NULL,
    subject VARCHAR(100) NOT NULL,
    notification_date_time DATETIME NOT NULL,
    descripction TEXT
);

CREATE TABLE Payment_method(
    method_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

-- Invoices Table
CREATE TABLE Invoices (
    CUFE VARCHAR(100) PRIMARY KEY,
    owner_id VARCHAR(100) NOT NULL,
    NIT VARCHAR(100) NOT NULL,
    invoice_date DATE NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,
    tax_amount DECIMAL(10,2) NOT NULL,
    digital_stamp VARCHAR(255) NOT NULL UNIQUE,
    qr_code_path VARCHAR(255) NOT NULL UNIQUE,
    FOREIGN KEY (owner_id) REFERENCES Owners(owner_id),
    FOREIGN KEY (NIT) REFERENCES Company_information (NIT)
);
CREATE TABLE Transactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    method_id INT NOT NULL,
    CUFE INT NOT NULL,
    payment DECIMAL(10,2) NOT NULL,
    payment_date DATETIME NOT NULL,
    FOREIGN KEY (method_id) REFERENCES Payment_method(method_id)
);
-- Invoice Items Table
CREATE TABLE Invoice_services (
    service_id INT NOT NULL,
    CUFE VARCHAR(100) NOT NULL,
    description TEXT NOT NULL,
    quantity INT NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (CUFE) REFERENCES Invoices(CUFE),
    FOREIGN KEY (service_id) REFERENCES services(service_id),
    PRIMARY KEY(service_id, CUFE)
);

CREATE TABLE Invoice_item (
    item_id INT NOT NULL,
    CUFE VARCHAR(100) NOT NULL,
    description TEXT NOT NULL,
    quantity INT NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (CUFE) REFERENCES Invoices(CUFE),
    FOREIGN KEY (item_id) REFERENCES inventory(item_id),
    PRIMARY KEY(item_id, CUFE)
);

CREATE TABLE Additional_charges(
    charge_id INT AUTO_INCREMENT PRIMARY KEY,
    type ENUM('DOG','CAT','PARROT','TORTOLA','SNAKE','TURTLE') NOT NULL,
    size ENUM('BIG', 'MEDIUM', 'SMALL'),
    multiplier_value DECIMAL(10,2)
);







-- CONSULTA PARA VACUNAS

SELECT 
    p.pet_id, 
    p.name AS pet_name, 
    ps.entry_date_time AS vaccination_date, 
    v.vaccination_type, 
    v.duration AS duration_months, 
    DATE_ADD(ps.entry_date_time, INTERVAL v.duration MONTH) AS expiration_date
FROM Pets p
JOIN pet_services_appoinment ps ON p.pet_id = ps.pet_id
JOIN Vaccination v ON ps.service_id = v.service_id
WHERE p.pet_id = 1;



SELECT p.pet_id, p.name AS pet_name,s.name AS service_name,i.name AS item_name,i.lot_number,ps.entry_date_time AS aplication_date,ps.employ_id, e.full_name AS employee_name
FROM Pets p
JOIN pet_services_appoinment ps ON p.pet_id = ps.pet_id
JOIN Services s ON ps.service_id = s.service_id
JOIN Items_used_services ius ON ps.service_id = ius.service_id
JOIN Inventory i ON ius.item_id = i.item_id
JOIN Employees e ON ps.employ_id = e.employ_id
WHERE p.pet_id = 1 AND s.service_type = 'VACCINATION' AND i.item_type = 'VACCINE';




-- ISERCIONES

-- AJA
INSERT INTO Inventory (
    name, 
    item_type, 
    sub_type, 
    manufacturer, 
    lot_number, 
    sell_price, 
    purchase_price, 
    expiration_date, 
    quantity
) 
VALUES (
    'Rabia Vaccine', 
    'VACCINE', 
    'Rabia', 
    'Vaccine Corp', 
    'R12345', 
    30.00, 
    20.00, 
    '2025-12-31', 
    100
);

-- aja 2
INSERT INTO Items_used_services (
    item_id, 
    service_id, 
    quantity
) 
VALUES (
    1,  
    1,  
    1   
);



