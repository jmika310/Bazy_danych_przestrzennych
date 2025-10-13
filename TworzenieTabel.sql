create table ksiegowosc.pracownicy (
    id_pracownika int identity(1,1) primary key,
    imie nvarchar(50) not null,
    nazwisko nvarchar(50) not null,
    adres nvarchar(100),
    telefon nvarchar(15));
exec sp_addextendedproperty 
    @name = N'ms_description', 
    @value = N'Tabela zawieraj¹ca dane pracowników firmy.', 
    @level0type = N'schema', @level0name = 'ksiegowosc',
    @level1type = N'table', @level1name = 'pracownicy';

create table ksiegowosc.godziny (
    id_godziny int identity(1,1) primary key,
    data date not null,
    liczba_godzin decimal(10,2),
    id_pracownika int not null,
    foreign key (id_pracownika) references ksiegowosc.pracownicy(id_pracownika));
exec sp_addextendedproperty 
    @name = N'ms_description', 
    @value = N'Tabela rejestruj¹ca przepracowane godziny poszczególnych pracowników.', 
    @level0type = N'schema', @level0name = 'ksiegowosc',
    @level1type = N'table', @level1name = 'godziny';

create table ksiegowosc.pensja (
    id_pensji int identity(1,1) primary key,
    stanowisko nvarchar(50) not null,
    kwota decimal(10,2));
exec sp_addextendedproperty 
    @name = N'ms_description', 
    @value = N'Tabela zawieraj¹ca informacje o pensjach przypisanych do stanowisk.', 
    @level0type = N'schema', @level0name = 'ksiegowosc',
    @level1type = N'table', @level1name = 'pensja';

create table ksiegowosc.premia (
    id_premii int identity(1,1) primary key,
    rodzaj nvarchar(50),
    kwota decimal(10,2));
exec sp_addextendedproperty 
    @name = N'ms_description', 
    @value = N'Tabela zawieraj¹ca informacje o premiach przyznawanych pracownikom.', 
    @level0type = N'schema', @level0name = 'ksiegowosc',
    @level1type = N'table', @level1name = 'premia';

create table ksiegowosc.wynagrodzenie (
    id_wynagrodzenia int identity(1,1) primary key,
    data date not null,
    id_pracownika int not null,
    id_godziny int null,
    id_pensji int null,
    id_premii int null,
    foreign key (id_pracownika) references ksiegowosc.pracownicy(id_pracownika),
    foreign key (id_godziny) references ksiegowosc.godziny(id_godziny),
    foreign key (id_pensji) references ksiegowosc.pensja(id_pensji),
    foreign key (id_premii) references ksiegowosc.premia(id_premii));
exec sp_addextendedproperty 
    @name = N'ms_description', 
    @value = N'Tabela zawieraj¹ca pe³ne informacje o wynagrodzeniach pracowników (pensje, godziny, premie).', 
    @level0type = N'schema', @level0name = 'ksiegowosc',
    @level1type = N'table', @level1name = 'wynagrodzenie';