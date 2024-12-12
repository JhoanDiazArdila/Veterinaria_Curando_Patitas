
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





-- INSERSIONS 


INSERT INTO Additional_charges (type, size, multiplier_value) VALUES ('DOG', 'BIG', 1.25);
INSERT INTO Additional_charges (type, size, multiplier_value) VALUES ('CAT', 'MEDIUM', 1.15);
INSERT INTO Additional_charges (type, size, multiplier_value) VALUES ('PARROT', 'SMALL', 0.75);
INSERT INTO Additional_charges (type, size, multiplier_value) VALUES ('TORTOLA', 'MEDIUM', 1.05);
INSERT INTO Additional_charges (type, size, multiplier_value) VALUES ('SNAKE', 'BIG', 1.35);
INSERT INTO Additional_charges (type, size, multiplier_value) VALUES ('TURTLE', 'SMALL', 0.95);

INSERT INTO Employees (employ_id, full_name, phone, address, email, digital_finger_print_url, job_position, employee_status, salary) 
VALUES ('EMP001', 'Juan Pérez', '3001234567', 'Calle 123 #45-67', 'juan.perez@example.com', 'https://example.com/fingerprint/juan', 'VETERINARIAN', 'ACTIVE', 3000.00);

INSERT INTO Employees (employ_id, full_name, phone, address, email, digital_finger_print_url, job_position, employee_status, salary) 
VALUES ('EMP002', 'Ana Gómez', '3007654321', 'Carrera 12 #34-56', 'ana.gomez@example.com', 'https://example.com/fingerprint/ana', 'RECEPTIONIST', 'VACATIONS', 2000.00);

INSERT INTO Employees (employ_id, full_name, phone, address, email, digital_finger_print_url, job_position, employee_status, salary) 
VALUES ('EMP003', 'Carlos López', '3001122334', 'Avenida 1 #23-45', 'carlos.lopez@example.com', 'https://example.com/fingerprint/carlos', 'VETERINARY HEAD', 'INACTIVE', 4000.00);

INSERT INTO Owners (owner_id, full_name, address, phone, email, emergency_contact_name, emergency_contact_phone) 
VALUES ('OWN001', 'Laura Martínez', 'Calle 101 #22-33', '3101234567', 'laura.martinez@example.com', 'Pedro López', '3107654321');

INSERT INTO Owners (owner_id, full_name, address, phone, email, emergency_contact_name, emergency_contact_phone) 
VALUES ('OWN002', 'Miguel Rodríguez', 'Carrera 45 #67-89', '3102345678', 'miguel.rodriguez@example.com', 'Ana García', '3108765432');

INSERT INTO Owners (owner_id, full_name, address, phone, email, emergency_contact_name, emergency_contact_phone) 
VALUES ('OWN003', 'Sofía Ramírez', 'Avenida 9 #10-11', '3103456789', 'sofia.ramirez@example.com', 'Carlos Pérez', '3109876543');
INSERT INTO Pets (owner_id, name, behavior, species, type, breed, age, birthdate, sex, microchip_number, photo_path, weight, size, allergies, medical_conditions) 
VALUES ('OWN001', 'Rex', 'AGGRESSIVE', 'MAMMAL', 'Dog', 'Labrador', 5, '2019-01-01', 'MALE', 'MICRO123', 'https://example.com/photos/rex.jpg', 25.50, 'BIG', 'None', 'None');

INSERT INTO Pets (owner_id, name, behavior, species, type, breed, age, birthdate, sex, microchip_number, photo_path, weight, size, allergies, medical_conditions) 
VALUES ('OWN002', 'Mia', 'PASSIVE', 'MAMMAL', 'Cat', 'Siamese', 3, '2021-06-15', 'FEMALE', 'MICRO456', 'https://example.com/photos/mia.jpg', 4.30, 'SMALL', 'Fish allergy', 'Asthma');

INSERT INTO Pets (owner_id, name, behavior, species, type, breed, age, birthdate, sex, microchip_number, photo_path, weight, size, allergies, medical_conditions) 
VALUES ('OWN003', 'Polly', 'PASSIVE', 'BIRD', 'Parrot', 'Macaw', 2, '2022-03-10', 'FEMALE', 'MICRO789', 'https://example.com/photos/polly.jpg', 1.20, 'SMALL', 'None', 'None');

INSERT INTO Services (service_type, name, description, standar_price) 
VALUES ('VACCINATION', 'Rabies Vaccine', 'Vaccine for rabies prevention', 50.00);

INSERT INTO Services (service_type, name, description, standar_price) 
VALUES ('ADDITIONAL_SERVICE', 'Grooming', 'Complete grooming service for pets', 30.00);

INSERT INTO Services (service_type, name, description, standar_price) 
VALUES ('MEDICAL_CONSULTATIONS', 'General Check-up', 'Routine medical examination', 70.00);

INSERT INTO Services (service_type, name, description, standar_price) 
VALUES ('SURGICAL_PROCEDURES', 'Spaying/Neutering', 'Surgical sterilization procedure', 150.00);

INSERT INTO Services (service_type, name, description, standar_price) 
VALUES ('ADOPTIONS', 'Pet Adoption', 'Adoption service for pets', 20.00);

INSERT INTO pet_services_appoinment (service_id, employ_id, pet_id, entry_date_time, exit_date_time, visit_reason, diagnosis, recomendations, prescription_medicines, apoimet_status) 
VALUES (1, 'EMP001', 1, '2024-12-01 09:00:00', '2024-12-01 10:00:00', 'Routine Check-up', 'Healthy', 'Keep up with regular check-ups', 'None', 'COMPLETED');

INSERT INTO pet_services_appoinment (service_id, employ_id, pet_id, entry_date_time, exit_date_time, visit_reason, diagnosis, recomendations, prescription_medicines, apoimet_status) 
VALUES (2, 'EMP002', 2, '2024-12-02 11:00:00', '2024-12-02 12:00:00', 'Vaccination', 'N/A', 'Ensure the next dose in one year', 'None', 'SCHEDULED');

INSERT INTO pet_services_appoinment (service_id, employ_id, pet_id, entry_date_time, exit_date_time, visit_reason, diagnosis, recomendations, prescription_medicines, apoimet_status) 
VALUES (3, 'EMP003', 3, '2024-12-03 13:00:00', '2024-12-03 14:30:00', 'Surgery for spaying', 'Successful', 'Rest and follow prescribed medication', 'Antibiotics', 'COMPLETED');

INSERT INTO Vaccination (service_id, vaccination_type, observation, duration) 
VALUES (1, 'Rabies', 'Annual booster required', 365);

INSERT INTO Vaccination (service_id, vaccination_type, observation, duration) 
VALUES (2, 'Distemper', 'Puppy shots', 60);

INSERT INTO Vaccination (service_id, vaccination_type, observation, duration) 
VALUES (3, 'Parvovirus', 'Adult vaccination', 365);

INSERT INTO Vaccination (service_id, vaccination_type, observation, duration) 
VALUES (4, 'Bordetella', 'Kennel cough prevention', 180);

INSERT INTO Surgical_Procedures (service_id, preoperative_details, procedure_details, postoperative_follow_up, recovery_estimated_time) 
VALUES (1, 'Fasting for 12 hours before surgery', 'Removal of tumor', 'Check incision site daily, keep the area clean and dry', '2 weeks');

INSERT INTO Surgical_Procedures (service_id, preoperative_details, procedure_details, postoperative_follow_up, recovery_estimated_time) 
VALUES (2, 'Blood tests required before surgery', 'Spaying/Neutering procedure', 'Administer prescribed medication, limit activity', '1 week');

INSERT INTO Surgical_Procedures (service_id, preoperative_details, procedure_details, postoperative_follow_up, recovery_estimated_time) 
VALUES (3, 'Ensure no food or water for 8 hours prior', 'Dental surgery to remove infected teeth', 'Monitor for signs of infection, soft food diet', '3 days');

INSERT INTO Surgical_Procedures (service_id, preoperative_details, procedure_details, postoperative_follow_up, recovery_estimated_time) 
VALUES (4, 'Complete pre-surgical examination', 'Fracture repair', 'Follow up in 1 week, avoid heavy activities', '4 weeks');

INSERT INTO Inventory (name, item_type, sub_type, manufacturer, lot_number, sell_price, purchase_price, expiration_date, quantity) 
VALUES ('Antibiotic', 'MEDICATION', 'Cephalosporin', 'Pharma Inc.', 'LOT123', 15.50, 10.00, '2025-12-01', 100);

INSERT INTO Inventory (name, item_type, sub_type, manufacturer, lot_number, sell_price, purchase_price, expiration_date, quantity) 
VALUES ('Rabies Vaccine', 'VACCINE', 'Rabies', 'VaccineCorp', 'LOT456', 30.00, 25.00, '2026-06-15', 50);

INSERT INTO Inventory (name, item_type, sub_type, manufacturer, lot_number, sell_price, purchase_price, expiration_date, quantity) 
VALUES ('Syringe', 'MEDICAL_SUPPLY', 'Injection', 'MedSupplies Co.', 'LOT789', 0.50, 0.30, '2027-01-10', 500);

INSERT INTO Inventory (name, item_type, sub_type, manufacturer, lot_number, sell_price, purchase_price, expiration_date, quantity) 
VALUES ('Pain Reliever', 'MEDICATION', 'NSAID', 'HealthPharma', 'LOT321', 20.00, 12.00, '2025-11-20', 200);

INSERT INTO Items_used_services (item_id, service_id, quantity) 
VALUES (1, 1, 10);

INSERT INTO Items_used_services (item_id, service_id, quantity) 
VALUES (2, 2, 5);

INSERT INTO Items_used_services (item_id, service_id, quantity) 
VALUES (3, 3, 15);

INSERT INTO Items_used_services (item_id, service_id, quantity) 
VALUES (4, 4, 20);

INSERT INTO Suppliers (supplier_id, company_name, contact_name, email, phone, address) 
VALUES ('SUP001', 'Pharma Inc.', 'Maria Torres', 'maria.torres@pharmainc.com', '3109876543', 'Avenida Principal #123');

INSERT INTO Suppliers (supplier_id, company_name, contact_name, email, phone, address) 
VALUES ('SUP002', 'VaccineCorp', 'Luis Rodríguez', 'luis.rodriguez@vaccinecorp.com', '3108765432', 'Calle Secundaria #456');

INSERT INTO Suppliers (supplier_id, company_name, contact_name, email, phone, address) 
VALUES ('SUP003', 'MedSupplies Co.', 'Ana García', 'ana.garcia@medsuppliesco.com', '3107654321', 'Carrera Terciaria #789');

INSERT INTO Suppliers (supplier_id, company_name, contact_name, email, phone, address) 
VALUES ('SUP004', 'HealthPharma', 'Carlos Pérez', 'carlos.perez@healthpharma.com', '3106543210', 'Boulevard Central #1011');
INSERT INTO Supplier_invoices (supplier_id, invoice_date, tax_amount, total_amount) 
VALUES ('SUP001', '2024-11-01', 500.00, 5500.00);

INSERT INTO Supplier_invoices (supplier_id, invoice_date, tax_amount, total_amount) 
VALUES ('SUP002', '2024-11-15', 300.00, 3300.00);

INSERT INTO Supplier_invoices (supplier_id, invoice_date, tax_amount, total_amount) 
VALUES ('SUP003', '2024-12-01', 200.00, 2200.00);

INSERT INTO Supplier_invoices (supplier_id, invoice_date, tax_amount, total_amount) 
VALUES ('SUP004', '2024-12-10', 450.00, 4950.00);
INSERT INTO Purchase_items (supplier_invoice_id, item_id, quantity) 
VALUES (1, 1, 50);

INSERT INTO Purchase_items (supplier_invoice_id, item_id, quantity) 
VALUES (2, 2, 100);

INSERT INTO Purchase_items (supplier_invoice_id, item_id, quantity) 
VALUES (3, 3, 200);

INSERT INTO Purchase_items (supplier_invoice_id, item_id, quantity) 
VALUES (4, 4, 150);
INSERT INTO Schedule (employ_id, day, entry_time, exit_time) 
VALUES ('EMP001', 'MONDAY', '08:00:00', '17:00:00');

INSERT INTO Schedule (employ_id, day, entry_time, exit_time) 
VALUES ('EMP002', 'TUESDAY', '09:00:00', '18:00:00');

INSERT INTO Schedule (employ_id, day, entry_time, exit_time) 
VALUES ('EMP003', 'WEDNESDAY', '10:00:00', '19:00:00');


INSERT INTO Events (name, address, start_time, end_time) 
VALUES ('Adoption Day', 'Calle 123 #45-67', '2024-12-20 09:00:00', '2024-12-20 17:00:00');

INSERT INTO Events (name, address, start_time, end_time) 
VALUES ('Pet Vaccination Campaign', 'Parque Central', '2024-12-25 08:00:00', '2024-12-25 15:00:00');

INSERT INTO Events (name, address, start_time, end_time) 
VALUES ('Fundraising Gala', 'Hotel Luxor', '2024-12-30 19:00:00', '2024-12-30 23:00:00');
INSERT INTO Medic_team (employ_id, event_id) 
VALUES ('EMP001', 1);

INSERT INTO Medic_team (employ_id, event_id) 
VALUES ('EMP002', 2);

INSERT INTO Medic_team (employ_id, event_id) 
VALUES ('EMP003', 3);
INSERT INTO Loyalty_Program (owner_id, total_points, membership_level) 
VALUES ('OWN001', 100, 'BRONZE');

INSERT INTO Loyalty_Program (owner_id, total_points, membership_level) 
VALUES ('OWN002', 200, 'SILVER');

INSERT INTO Loyalty_Program (owner_id, total_points, membership_level) 
VALUES ('OWN003', 300, 'GOLD');
INSERT INTO Owners_notifications (owner_id, subject, notification_date, descripction) 
VALUES ('OWN001', 'Vaccination Reminder', '2024-12-15', 'Your pet Rex is due for his annual rabies vaccination.');

INSERT INTO Owners_notifications (owner_id, subject, notification_date, descripction) 
VALUES ('OWN002', 'Appointment Confirmation', '2024-12-10', 'Your appointment for Mia\'s check-up has been confirmed for December 20, 2024.');

INSERT INTO Owners_notifications (owner_id, subject, notification_date, descripction) 
VALUES ('OWN003', 'Event Invitation', '2024-12-05', 'Join us for our Pet Adoption Day event on December 20, 2024, at Calle 123 #45-67.');
INSERT INTO Adoptions (appointment_pet_service_id, adoption_date, owner_id, contract_path) 
VALUES (1, '2024-12-15', 'OWN001', 'https://example.com/contracts/adoption1.pdf');

INSERT INTO Adoptions (appointment_pet_service_id, adoption_date, owner_id, contract_path) 
VALUES (2, '2024-12-20', 'OWN002', 'https://example.com/contracts/adoption2.pdf');

INSERT INTO Adoptions (appointment_pet_service_id, adoption_date, owner_id, contract_path) 
VALUES (3, '2024-12-25', 'OWN003', 'https://example.com/contracts/adoption3.pdf');
INSERT INTO Update_adoptions (appointment_pet_service_id, follow_up_date, follow_up_notes) 
VALUES (1, '2025-01-15', 'The pet is adapting well to the new home.');

INSERT INTO Update_adoptions (appointment_pet_service_id, follow_up_date, follow_up_notes) 
VALUES (2, '2025-01-20', 'The pet requires additional medical check-up.');

INSERT INTO Update_adoptions (appointment_pet_service_id, follow_up_date, follow_up_notes) 
VALUES (3, '2025-01-25', 'The pet and owner are bonding well, no issues reported.');
INSERT INTO Service_event (event_id, pet_id, service_id, quantity) 
VALUES (1, 1, 1, 10);

INSERT INTO Service_event (event_id, pet_id, service_id, quantity) 
VALUES (2, 2, 2, 5);


INSERT INTO Company_information (NIT, name, address, phone, email) 
VALUES ('NIT001', 'VetCare Inc.', 'Calle 123 #45-67', '3101234567', 'contact@vetcare.com');

INSERT INTO Company_information (NIT, name, address, phone, email) 
VALUES ('NIT002', 'Animal Health Co.', 'Avenida Principal #789', '3107654321', 'info@animalhealth.com');

INSERT INTO Company_information (NIT, name, address, phone, email) 
VALUES ('NIT003', 'PetWell Services', 'Carrera Secundaria #456', '3109876543', 'support@petwell.com');

INSERT INTO Company_information (NIT, name, address, phone, email) 
VALUES ('NIT004', 'Paws & Claws Ltd.', 'Boulevard Central #1011', '3106543210', 'hello@pawsandclaws.com');
INSERT INTO Company_notification (NIT, subject, notification_date_time, descripction) 
VALUES ('NIT001', 'Maintenance Notice', '2024-12-01 09:00:00', 'Scheduled maintenance on December 5th.');

INSERT INTO Company_notification (NIT, subject, notification_date_time, descripction) 
VALUES ('NIT002', 'Holiday Hours', '2024-12-10 10:00:00', 'Our offices will be closed on December 25th.');

INSERT INTO Company_notification (NIT, subject, notification_date_time, descripction) 
VALUES ('NIT003', 'New Services Available', '2024-12-15 11:00:00', 'We are excited to announce new services starting January 2025.');

INSERT INTO Company_notification (NIT, subject, notification_date_time, descripction) 
VALUES ('NIT004', 'Team Meeting', '2024-12-20 14:00:00', 'Monthly team meeting on December 22nd.');
INSERT INTO Payment_method (name) 
VALUES ('Credit Card');

INSERT INTO Payment_method (name) 
VALUES ('Debit Card');

INSERT INTO Payment_method (name) 
VALUES ('Cash');

INSERT INTO Payment_method (name) 
VALUES ('Bank Transfer');
INSERT INTO Invoices (CUFE, owner_id, NIT, invoice_date, total_amount, tax_amount, digital_stamp, qr_code_path) 
VALUES ('CUFE001', 'OWN001', 'NIT001', '2024-12-01', 5500.00, 500.00, 'https://example.com/stamps/stamp1.png', 'https://example.com/qrcodes/qr1.png');

INSERT INTO Invoices (CUFE, owner_id, NIT, invoice_date, total_amount, tax_amount, digital_stamp, qr_code_path) 
VALUES ('CUFE002', 'OWN002', 'NIT002', '2024-12-05', 3300.00, 300.00, 'https://example.com/stamps/stamp2.png', 'https://example.com/qrcodes/qr2.png');






