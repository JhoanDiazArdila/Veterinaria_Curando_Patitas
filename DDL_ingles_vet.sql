
CREATE DATABASE Curando_Patitas; 

USE Curando_Patitas;

-- Database for Veterinary Clinic Management System

-- Veterinarian Table
CREATE TABLE Additional_charges(
    charge_id INT AUTO_INCREMENT PRIMARY KEY,
    type ENUM('DOG','CAT','PARROT','TORTOLA','SNAKE','TURTLE') NOT NULL,
    size ENUM('BIG', 'MEDIUM', 'SMALL'),
    multiplier_value DECIMAL(10,2)
);
CREATE TABLE Employees (
    employ_id VARCHAR(100) PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    phone VARCHAR(100) NOT NULL UNIQUE,
    address VARCHAR(100) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
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
    PRIMARY KEY(employ_id,day)
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
    charge_id INT, -- Nuevo campo para referenciar cargos adicionales
    FOREIGN KEY (CUFE) REFERENCES Invoices(CUFE),
    FOREIGN KEY (service_id) REFERENCES services(service_id),
    FOREIGN KEY (charge_id) REFERENCES Additional_charges(charge_id),
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





-- --------------------------------  COREGIDO -----
DELIMITER $$
CREATE TRIGGER update_invoice_total
AFTER INSERT ON Invoice_services
FOR EACH ROW
BEGIN
    DECLARE aditional DECIMAL(10,2) DEFAULT 0.00;
    DECLARE service_price DECIMAL(10,2) DEFAULT 0.00;

    -- Obtener el precio del servicio
    SELECT s.standar_price INTO service_price
    FROM Services s
    WHERE s.service_id = NEW.service_id;

    -- Obtener el valor adicional si corresponde
    SELECT ad.multiplier_value INTO aditional
    FROM Additional_charges ad
    WHERE ad.charge_id = NEW.charge_id;

    -- Actualizar el total de la factura
    UPDATE Invoices
    SET total_amount = total_amount + (service_price * NEW.quantity) + (aditional * NEW.quantity)
    WHERE CUFE = NEW.CUFE;
END $$
DELIMITER ;


-- -----------------------------------------------------
DELIMITER $$
CREATE TRIGGER update_invoice_total_after_item_insert
AFTER INSERT ON Invoice_item
FOR EACH ROW
BEGIN
    DECLARE item_price DECIMAL(10,2) DEFAULT 0.00;

    -- Obtener el precio del item
    SELECT i.sell_price INTO item_price
    FROM Inventory i
    WHERE i.item_id = NEW.item_id;

    -- Actualizar el total de la factura
    UPDATE Invoices
    SET total_amount = total_amount + (item_price * NEW.quantity)
    WHERE CUFE = NEW.CUFE;
END $$
DELIMITER ;











