-- 9)
select *, pe.kwota as pensja
from ksiegowosc.pracownicy p
join ksiegowosc.wynagrodzenie w on p.id_pracownika = w.id_pracownika
join ksiegowosc.pensja pe on w.id_pensji = pe.id_pensji
order by pe.kwota desc;

-- 10)
select *,
    case 
        when pr.id_premii is null then pe.kwota
        else pe.kwota + pr.kwota
    end as kwota_wynagrodzenia
from ksiegowosc.pracownicy p
join ksiegowosc.wynagrodzenie w on p.id_pracownika = w.id_pracownika
join ksiegowosc.pensja pe on w.id_pensji = pe.id_pensji
left join ksiegowosc.premia pr on w.id_premii = pr.id_premii
order by kwota_wynagrodzenia desc;

-- 11) 
select pe.stanowisko,
count(w.id_pracownika) as liczba_pracownikow
from ksiegowosc.wynagrodzenie w
join ksiegowosc.pensja pe on w.id_pensji = pe.id_pensji
group by pe.stanowisko
order by liczba_pracownikow desc;

-- 12)
select 
avg(pe.kwota) as srednia_pensja,
min(pe.kwota) as minimalna_pensja,
max(pe.kwota) as maksymalna_pensja
from ksiegowosc.wynagrodzenie w
join ksiegowosc.pensja pe on w.id_pensji = pe.id_pensji
where pe.stanowisko = 'Programista';

-- 13)
select sum(p.kwota + pr.kwota) as suma_wszystkich_wynagrodzen
from ksiegowosc.wynagrodzenie w
join ksiegowosc.pensja p on w.id_pensji = p.id_pensji
left join ksiegowosc.premia pr on w.id_premii = pr.id_premii;

-- 14)
select p.stanowisko,
    sum(case 
            when pr.id_premii is null then p.kwota
            else p.kwota + pr.kwota
        end) as suma_wszystkich_wynagrodzen
from ksiegowosc.wynagrodzenie w
join ksiegowosc.pensja p on w.id_pensji = p.id_pensji
left join ksiegowosc.premia pr on w.id_premii = pr.id_premii
group by p.stanowisko;

-- 15) 
select p.stanowisko, count(pr.id_premii) as liczba_premii
from ksiegowosc.wynagrodzenie w
join ksiegowosc.pensja p on w.id_pensji = p.id_pensji
left join ksiegowosc.premia pr on w.id_premii = pr.id_premii
group by p.stanowisko
order by liczba_premii desc;

-- 16)
delete w
from ksiegowosc.wynagrodzenie w
join ksiegowosc.pensja p on w.id_pensji = p.id_pensji
where p.kwota < 1200;
