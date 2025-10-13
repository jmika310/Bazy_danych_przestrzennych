insert into ksiegowosc.pracownicy (imie, nazwisko, adres, telefon) values
('Anna','Kowalska','ul. Lipowa 12, Warszawa','600111222'),
('Piotr','Nowak','ul. D³uga 5, Kraków','600333444'),
('W³odzimierz','Bia³y','ul. S³oneczna 8, Gdañsk','600555666'),
('Katarzyna','Wójcik','ul. Polna 3, Wroc³aw','600777888'),
('Marek','Marucha','ul. Ogrodowa 7, Poznañ','600999000'),
('Monika','Mazurska','ul. Krótka 10, £ódŸ','601111222'),
('Adam','Lewandowski','ul. Leœna 4, Lublin','601333444'),
('Joanna','Kamiñska','ul. Rynek 1, Szczecin','601555666'),
('Pawe³','Zieliñski','ul. Wiosenna 6, Katowice','601777888'),
('Magdalena','Szymañska','ul. Polna 9, Bia³ystok','601999000');

insert into ksiegowosc.pensja (stanowisko, kwota) values
('Programista',8000.00),
('Ksiêgowy',6000.00),
('Menad¿er',12000.00),
('Asystent',4000.00),
('HR',5500.00),
('Tester',5000.00),
('Analityk',7000.00),
('Specjalista IT',7500.00),
('Marketing',6500.00),
('Sprzeda¿',6000.00);

insert into ksiegowosc.premia (rodzaj, kwota) values
('Roczna',3000.00),
('Miesiêczna',500.00),
('Projektowa',1500.00),
('Okolicznoœciowa',700.00),
('Lojalnoœciowa',2000.00),
('Wydajnoœciowa',1000.00),
('Œwi¹teczna',800.00),
('Specjalna',1200.00),
('Motywacyjna',600.00),
('Nagroda',900.00);

insert into ksiegowosc.godziny (data, liczba_godzin, id_pracownika) values
('2025-10-01',160.00,1),
('2025-10-01',164.00,2),
('2025-10-01',180.00,3),
('2025-10-01',126.00,4),
('2025-10-01',120.00,5),
('2025-10-01',117.00,6),
('2025-10-01',158.50,7),
('2025-10-01',167.75,8),
('2025-10-01',148.00,9),
('2025-10-01',200.00,10);

insert into ksiegowosc.wynagrodzenie (data, id_pracownika, id_godziny, id_pensji, id_premii) values
('2025-10-01', 1, 1, 1, 3),
('2025-10-01', 2, 2, 2, NULL),
('2025-10-01', 3, 3, 3, 1),
('2025-10-01', 4, 4, 4, NULL),
('2025-10-01', 5, 5, 1, 5),
('2025-10-01', 6, 6, 6, NULL),
('2025-10-01', 7, 7, 6, 2),
('2025-10-01', 8, 8, 8, NULL),
('2025-10-01', 9, 9, 7, 4),
('2025-10-01', 10, 10, 4, NULL);