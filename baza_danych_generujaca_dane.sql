-- Utwórz bazę danych, jeśli nie istnieje
CREATE DATABASE IF NOT EXISTS biuro_ubezpieczen;

-- Wybierz bazę danych
USE biuro_ubezpieczen;

-- Usuń istniejące procedury
DROP PROCEDURE IF EXISTS generate_clients;
DROP PROCEDURE IF EXISTS generate_contracts;
DROP PROCEDURE IF EXISTS generate_payments;

-- Usuń istniejące tabele, jeśli istnieją w odpowiedniej kolejności
DROP TABLE IF EXISTS oplaty_skladki;
DROP TABLE IF EXISTS umowy_klientow;
DROP TABLE IF EXISTS pracownicy;
DROP TABLE IF EXISTS klienci;
DROP TABLE IF EXISTS firmy_ubezpieczeniowe;

-- Tabela: firmy_ubezpieczeniowe
CREATE TABLE firmy_ubezpieczeniowe (
    firma_id INT PRIMARY KEY AUTO_INCREMENT,
    nazwa VARCHAR(100),
    data_rozpoczecia_wspolpracy DATE,
    adres VARCHAR(100)
);

INSERT INTO firmy_ubezpieczeniowe (nazwa, data_rozpoczecia_wspolpracy, adres) VALUES
('PZU', '2010-05-15', 'ul. Prosta 18, Warszawa'),
('Allianz', '2012-06-20', 'ul. Kwiatowa 25, Kraków'),
('Warta', '2015-01-10', 'ul. Długa 12, Poznań'),
('Ergo Hestia', '2018-03-05', 'ul. Morska 8, Gdynia'),
('Generali', '2016-07-12', 'ul. Leśna 9, Katowice'),
('AXA', '2014-09-01', 'ul. Ogrodowa 5, Wrocław'),
('Compensa', '2013-11-22', 'ul. Spacerowa 11, Łódź'),
('InterRisk', '2017-04-18', 'ul. Kasztanowa 15, Gdańsk'),
('TUW', '2019-05-30', 'ul. Lipowa 20, Szczecin'),
('HDI', '2020-12-10', 'ul. Jesionowa 7, Bydgoszcz');

-- Tabela: klienci
CREATE TABLE klienci (
    klient_id INT PRIMARY KEY AUTO_INCREMENT,
    imie VARCHAR(50),
    nazwisko VARCHAR(50),
    data_pierwszej_umowy DATE,
    rok_urodzenia INT,
    adres VARCHAR(100)
);

-- Dodanie 150 klientów z realistycznymi danymi
INSERT INTO klienci (imie, nazwisko, data_pierwszej_umowy, rok_urodzenia, adres) VALUES
('Jan', 'Kowalski', '2022-01-15', 1985, 'ul. Polna 10, Warszawa'),
('Anna', 'Nowak', '2023-03-10', 1990, 'ul. Słoneczna 5, Kraków'),
('Piotr', 'Wiśnia', '2021-07-22', 1978, 'ul. Lipowa 3, Gdańsk'),
('Ewa', 'Sikora', '2020-11-30', 1983, 'ul. Klonowa 4, Wrocław'),
('Marek', 'Zielak', '2019-05-20', 1975, 'ul. Jesionowa 7, Łódź'),
('Magdalena', 'Jabłoń', '2021-04-17', 1992, 'ul. Akacjowa 2, Katowice'),
('Paweł', 'Krawczyk', '2022-01-05', 1988, 'ul. Dębowa 12, Szczecin'),
('Karolina', 'Woźniak', '2018-03-14', 1979, 'ul. Świerkowa 8, Poznań'),
('Tomasz', 'Kaczmarek', '2020-08-19', 1984, 'ul. Bukowa 6, Bydgoszcz'),
('Agata', 'Zając', '2019-11-25', 1991, 'ul. Sosnowa 15, Lublin');

-- Procedura do dodania większej liczby klientów z realistycznymi danymi
DELIMITER $$
CREATE PROCEDURE generate_clients()
BEGIN
    DECLARE i INT DEFAULT 11;
    DECLARE imiona VARCHAR(50);
    DECLARE nazwiska VARCHAR(50);
    DECLARE miasta VARCHAR(50);
    DECLARE ulice VARCHAR(50);
    WHILE i <= 150 DO
        SET imiona = (SELECT ELT(FLOOR(RAND() * 10) + 1, 'Krzysztof', 'Marek', 'Tomasz', 'Ewa', 'Magdalena', 'Piotr', 'Joanna', 'Adam', 'Marcin', 'Anna'));
        SET nazwiska = (SELECT ELT(FLOOR(RAND() * 10) + 1, 'Kwiatkowski', 'Wiśniewska', 'Zielińska', 'Lewandowska', 'Kamińska', 'Wójcik', 'Kowalczyk', 'Dąbrowski', 'Zieliński', 'Jabłońska'));
        SET miasta = (SELECT ELT(FLOOR(RAND() * 10) + 1, 'Warszawa', 'Kraków', 'Gdańsk', 'Wrocław', 'Łódź', 'Poznań', 'Szczecin', 'Katowice', 'Lublin', 'Bydgoszcz'));
        SET ulice = (SELECT ELT(FLOOR(RAND() * 10) + 1, 'Polna', 'Słoneczna', 'Lipowa', 'Klonowa', 'Jesionowa', 'Akacjowa', 'Dębowa', 'Świerkowa', 'Bukowa', 'Sosnowa'));
        INSERT INTO klienci (imie, nazwisko, data_pierwszej_umowy, rok_urodzenia, adres) VALUES
        (imiona, nazwiska, DATE_ADD('2020-01-01', INTERVAL FLOOR(RAND() * 730) DAY), FLOOR(RAND() * 60 + 1960), CONCAT('ul. ', ulice, ' ', FLOOR(RAND() * 100 + 1), ', ', miasta));
        SET i = i + 1;
    END WHILE;
END$$
DELIMITER ;

CALL generate_clients();

-- Tabela: pracownicy
CREATE TABLE pracownicy (
    pracownik_id INT PRIMARY KEY AUTO_INCREMENT,
    imie VARCHAR(50),
    nazwisko VARCHAR(50),
    data_zatrudnienia DATE,
    plec CHAR(1),
    rok_urodzenia INT
);

-- Dodanie 10 pracowników z realistycznymi danymi
INSERT INTO pracownicy (imie, nazwisko, data_zatrudnienia, plec, rok_urodzenia) VALUES
('Marcin', 'Kowalczyk', '2020-02-01', 'M', 1980),
('Katarzyna', 'Lewandowska', '2019-08-15', 'F', 1985),
('Tomasz', 'Mazur', '2018-11-20', 'M', 1975),
('Agnieszka', 'Nowicka', '2017-04-25', 'F', 1990),
('Paweł', 'Dąbrowski', '2021-01-30', 'M', 1982),
('Ewelina', 'Kamińska', '2020-10-10', 'F', 1988),
('Adam', 'Nowak', '2019-03-12', 'M', 1991),
('Monika', 'Kowalska', '2018-07-19', 'F', 1987),
('Michał', 'Wiśniewski', '2020-11-30', 'M', 1983),
('Joanna', 'Zielińska', '2021-05-22', 'F', 1995);

-- Tabela: umowy_klientow
CREATE TABLE umowy_klientow (
    umowa_id INT PRIMARY KEY AUTO_INCREMENT,
    klient_id INT,
    firma_id INT,
    pracownik_id INT,
    data_zawarcia DATE,
    data_wygasniecia DATE,
    typ_umowy ENUM('leasing', 'ubezpieczenie na życie', 'ubezpieczenie majątkowe', 'ubezpieczenie turystyczne'),
    FOREIGN KEY (klient_id) REFERENCES klienci(klient_id),
    FOREIGN KEY (firma_id) REFERENCES firmy_ubezpieczeniowe(firma_id),
    FOREIGN KEY (pracownik_id) REFERENCES pracownicy(pracownik_id)
);

-- Dodanie 250 umów klientów
DELIMITER $$
CREATE PROCEDURE generate_contracts()
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE client_id INT;
    DECLARE firm_id INT;
    DECLARE employee_id INT;
    DECLARE typ_umowy ENUM('leasing', 'ubezpieczenie na życie', 'ubezpieczenie majątkowe', 'ubezpieczenie turystyczne');
    WHILE i <= 250 DO
        SET client_id = FLOOR(RAND() * 150 + 1);
        SET firm_id = FLOOR(RAND() * 10 + 1);
        SET employee_id = FLOOR(RAND() * 10 + 1);
        SET typ_umowy = (SELECT ELT(FLOOR(RAND() * 4) + 1, 'leasing', 'ubezpieczenie na życie', 'ubezpieczenie majątkowe', 'ubezpieczenie turystyczne'));
        INSERT INTO umowy_klientow (klient_id, firma_id, pracownik_id, data_zawarcia, data_wygasniecia, typ_umowy) VALUES
        (client_id, firm_id, employee_id, DATE_ADD('2020-01-01', INTERVAL FLOOR(RAND() * 730) DAY), DATE_ADD(DATE_ADD('2020-01-01', INTERVAL FLOOR(RAND() * 730) DAY), INTERVAL 1 YEAR), typ_umowy);
        SET i = i + 1;
    END WHILE;
END$$
DELIMITER ;

CALL generate_contracts();

-- Tabela: opłacone składki
CREATE TABLE oplaty_skladki (
    skladka_id INT PRIMARY KEY AUTO_INCREMENT,
    umowa_id INT,
    data_platnosci DATE,
    kwota DECIMAL(10, 2),
    podatek DECIMAL(10, 2),
    waluta VARCHAR(10),
    FOREIGN KEY (umowa_id) REFERENCES umowy_klientow(umowa_id)
);

-- Dodanie 400 opłaconych składek
DELIMITER $$
CREATE PROCEDURE generate_payments()
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE contract_id INT;
    WHILE i <= 400 DO
        SET contract_id = FLOOR(RAND() * 250 + 1);
        INSERT INTO oplaty_skladki (umowa_id, data_platnosci, kwota, podatek, waluta) VALUES
        (contract_id, DATE_ADD('2020-01-01', INTERVAL FLOOR(RAND() * 730) DAY), FLOOR(RAND() * 3000 + 500), FLOOR(RAND() * 300 + 50), 'PLN');
        SET i = i + 1;
    END WHILE;
END$$
DELIMITER ;

CALL generate_payments();

-- Usuwanie procedur
DROP PROCEDURE IF EXISTS generate_clients;
DROP PROCEDURE IF EXISTS generate_contracts;
DROP PROCEDURE IF EXISTS generate_payments;
