-- 1)
select id_pracownika, nazwisko
from ksiegowosc.pracownicy;

-- 2) zwiêkszono p³acê do 10000
select w.id_pracownika, (p.kwota + pr.kwota) as kwota_wynagrodzenia
from ksiegowosc.wynagrodzenie w
join ksiegowosc.pensja p on w.id_pensji = p.id_pensji
join ksiegowosc.premia pr on w.id_premii = pr.id_premii
where (p.kwota + pr.kwota) > 10000;

--3) zwiêkszono p³acê do 5000
select w.id_pracownika, p.kwota
from ksiegowosc.wynagrodzenie w
join ksiegowosc.pensja p on w.id_pensji = p.id_pensji
where w.id_premii is null and p.kwota > 5000;

--4)
select *
from ksiegowosc.pracownicy
where imie like 'J%';

--5) imie ma 'n', nazwisko koñczy siê na a
select *
from ksiegowosc.pracownicy
where imie like '%n%' and nazwisko like '%a';

-- 6)
select p.imie, p.nazwisko, sum(g.liczba_godzin) - 160 as nadgodziny
from ksiegowosc.pracownicy p
join ksiegowosc.godziny g on p.id_pracownika = g.id_pracownika
where g.liczba_godzin > 160
group by p.imie, p.nazwisko;

--7) zmieniono przedzia³ na miêdzy 5000 a 10000
select w.id_pracownika, (p.kwota + pr.kwota) as kwota_wynagrodzenia
from ksiegowosc.wynagrodzenie w
join ksiegowosc.pensja p on w.id_pensji = p.id_pensji
join ksiegowosc.premia pr on w.id_premii = pr.id_premii
where (p.kwota + pr.kwota) between 5000 and 10000;

--8)
select p.imie, p.nazwisko, sum(g.liczba_godzin) - 160 as nadgodziny
from ksiegowosc.pracownicy p
join ksiegowosc.wynagrodzenie w on p.id_pracownika = w.id_pracownika
join ksiegowosc.godziny g on w.id_godziny = g.id_godziny
join ksiegowosc.pensja pe on w.id_pensji = pe.id_pensji
where w.id_premii is null and g.liczba_godzin > 160
group by p.imie, p.nazwisko