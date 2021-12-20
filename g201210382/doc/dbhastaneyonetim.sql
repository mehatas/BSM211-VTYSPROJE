--
-- PostgreSQL database dump
--

-- Dumped from database version 14.1
-- Dumped by pg_dump version 14.1

-- Started on 2021-12-19 23:48:32

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 226 (class 1255 OID 24965)
-- Name: bosodalarilistele(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.bosodalarilistele() RETURNS TABLE(odano integer, odadurumu text)
    LANGUAGE plpgsql
    AS $$
BEGIN
   RETURN QUERY SELECT
      "oda_no", 
      "oda_durumu"
   FROM
      "oda"
   WHERE
      "oda_durumu"='Boş' 
      order by oda_no asc;
END; $$;


ALTER FUNCTION public.bosodalarilistele() OWNER TO postgres;

--
-- TOC entry 227 (class 1255 OID 24966)
-- Name: doktor_eklerken(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.doktor_eklerken() RETURNS trigger
    LANGUAGE plpgsql
    AS $$ 
BEGIN 
NEW.ad=UPPER(NEW.ad);
NEW.soyad=UPPER(NEW.soyad);
return NEW;
end;
$$;


ALTER FUNCTION public.doktor_eklerken() OWNER TO postgres;

--
-- TOC entry 228 (class 1255 OID 24967)
-- Name: doluodalarilistele(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.doluodalarilistele() RETURNS TABLE(odano integer, odadurumu text)
    LANGUAGE plpgsql
    AS $$
BEGIN
   RETURN QUERY SELECT
      "oda_no", 
      "oda_durumu"
   FROM
      "oda"
   WHERE
      "oda_durumu"='Dolu'
      order by oda_no asc ;
END; $$;


ALTER FUNCTION public.doluodalarilistele() OWNER TO postgres;

--
-- TOC entry 233 (class 1255 OID 24968)
-- Name: duyuru_ekle(integer, text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.duyuru_ekle(id integer, baslik text, aciklama text) RETURNS void
    LANGUAGE plpgsql
    AS $_$
  begin
  INSERT INTO duyurular(id, baslik,aciklama)
   VALUES ($1,$2,$3); 
	END; 
	
$_$;


ALTER FUNCTION public.duyuru_ekle(id integer, baslik text, aciklama text) OWNER TO postgres;

--
-- TOC entry 229 (class 1255 OID 24969)
-- Name: hasta_sayisi(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.hasta_sayisi() RETURNS integer
    LANGUAGE plpgsql
    AS $$
	 DECLARE 
	    hasta_sayi integer;
	 BEGIN
	    SELECT count("tc_no") into hasta_sayi from "hasta";
	    RETURN hasta_sayi;
	END; 
	$$;


ALTER FUNCTION public.hasta_sayisi() OWNER TO postgres;

--
-- TOC entry 230 (class 1255 OID 24970)
-- Name: oda_cikis_hareketleri(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.oda_cikis_hareketleri() RETURNS trigger
    LANGUAGE plpgsql
    AS $$

	 BEGIN 
        insert into "oda_hareketleri"(odanumara,oda_cikis_tarihi) VALUES (OLD.oda_no,current_timestamp::timestamp);
    return old;
	END; 
	$$;


ALTER FUNCTION public.oda_cikis_hareketleri() OWNER TO postgres;

--
-- TOC entry 231 (class 1255 OID 24971)
-- Name: yatis_eklendiginde_dolu_yap(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.yatis_eklendiginde_dolu_yap() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	 DECLARE 
	  odano int;
	 BEGIN
 odano=NEW.oda_no ;
UPDATE oda set oda_durumu='Dolu' WHERE  
    oda_no=odano;
return NEW;
	END; 
	$$;


ALTER FUNCTION public.yatis_eklendiginde_dolu_yap() OWNER TO postgres;

--
-- TOC entry 232 (class 1255 OID 24972)
-- Name: yatis_silindiginde_bos_yap(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.yatis_silindiginde_bos_yap() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	 DECLARE 
	  odano int;
	 BEGIN
 odano=OLD.oda_no ;
UPDATE oda set oda_durumu='Boş' WHERE  
    oda_no=odano;
return OLD;
	END; 
	$$;


ALTER FUNCTION public.yatis_silindiginde_bos_yap() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 209 (class 1259 OID 24973)
-- Name: brans; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.brans (
    brans_adi text NOT NULL,
    brans_numarasi integer NOT NULL
);


ALTER TABLE public.brans OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 24978)
-- Name: dilek_sikayet; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dilek_sikayet (
    ad text NOT NULL,
    aciklama text NOT NULL,
    id integer NOT NULL,
    soyad text NOT NULL,
    baslik text NOT NULL
);


ALTER TABLE public.dilek_sikayet OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 24983)
-- Name: doktor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.doktor (
    id integer NOT NULL,
    ad text NOT NULL,
    soyad text NOT NULL,
    brans text NOT NULL,
    telefon text NOT NULL
);


ALTER TABLE public.doktor OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 24988)
-- Name: duyurular; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.duyurular (
    id integer NOT NULL,
    baslik text NOT NULL,
    aciklama text NOT NULL
);


ALTER TABLE public.duyurular OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 24993)
-- Name: hasta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hasta (
    tc_no bigint NOT NULL,
    ad text NOT NULL,
    soyad text NOT NULL,
    telefon text NOT NULL,
    ilce_id integer NOT NULL
);


ALTER TABLE public.hasta OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 24998)
-- Name: hemsire; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hemsire (
    id integer NOT NULL,
    ad text NOT NULL,
    soyad text NOT NULL,
    telefon text NOT NULL,
    brans text NOT NULL
);


ALTER TABLE public.hemsire OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 25003)
-- Name: il; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.il (
    ad character varying NOT NULL,
    id integer NOT NULL
);


ALTER TABLE public.il OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 25008)
-- Name: ilac; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ilac (
    ilac_adi text NOT NULL,
    kullanim_bilgi text NOT NULL
);


ALTER TABLE public.ilac OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 25013)
-- Name: ilce; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ilce (
    ilce_adi text NOT NULL,
    il_id integer NOT NULL,
    ilce_id integer NOT NULL
);


ALTER TABLE public.ilce OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 25018)
-- Name: muayene; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.muayene (
    doktor_id integer NOT NULL,
    hasta_tc bigint NOT NULL,
    muayene_id integer NOT NULL,
    teshis text NOT NULL
);


ALTER TABLE public.muayene OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 25023)
-- Name: oda; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oda (
    oda_no integer NOT NULL,
    oda_durumu text
);


ALTER TABLE public.oda OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 25028)
-- Name: oda_hareketleri; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oda_hareketleri (
    degisiklik_no integer NOT NULL,
    odanumara integer,
    oda_cikis_tarihi timestamp without time zone
);


ALTER TABLE public.oda_hareketleri OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 25031)
-- Name: oda_hareketleri_degisiklik_no_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oda_hareketleri_degisiklik_no_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.oda_hareketleri_degisiklik_no_seq OWNER TO postgres;

--
-- TOC entry 3470 (class 0 OID 0)
-- Dependencies: 221
-- Name: oda_hareketleri_degisiklik_no_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oda_hareketleri_degisiklik_no_seq OWNED BY public.oda_hareketleri.degisiklik_no;


--
-- TOC entry 222 (class 1259 OID 25032)
-- Name: randevu; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.randevu (
    hasta_tc bigint NOT NULL,
    doktor_id integer NOT NULL,
    tarih timestamp without time zone NOT NULL,
    randevu_id integer NOT NULL
);


ALTER TABLE public.randevu OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 25035)
-- Name: recete; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.recete (
    id integer NOT NULL,
    hasta_tc bigint NOT NULL,
    doktor_id integer NOT NULL
);


ALTER TABLE public.recete OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 25038)
-- Name: recete_ilac; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.recete_ilac (
    recete_id integer NOT NULL,
    ilac_adi text NOT NULL
);


ALTER TABLE public.recete_ilac OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 25043)
-- Name: yatis; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.yatis (
    hasta_tc bigint NOT NULL,
    oda_no integer NOT NULL,
    yatilacak_gun integer NOT NULL,
    id integer NOT NULL
);


ALTER TABLE public.yatis OWNER TO postgres;

--
-- TOC entry 3232 (class 2604 OID 25046)
-- Name: oda_hareketleri degisiklik_no; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oda_hareketleri ALTER COLUMN degisiklik_no SET DEFAULT nextval('public.oda_hareketleri_degisiklik_no_seq'::regclass);


--
-- TOC entry 3448 (class 0 OID 24973)
-- Dependencies: 209
-- Data for Name: brans; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.brans (brans_adi, brans_numarasi) VALUES ('ODYOLOJİ', 1);
INSERT INTO public.brans (brans_adi, brans_numarasi) VALUES ('PEDİYATRİ', 3);
INSERT INTO public.brans (brans_adi, brans_numarasi) VALUES ('DAHİLİYE', 2);
INSERT INTO public.brans (brans_adi, brans_numarasi) VALUES ('GENEL CERRAHİ', 4);
INSERT INTO public.brans (brans_adi, brans_numarasi) VALUES ('PSİKİYATRİ', 5);
INSERT INTO public.brans (brans_adi, brans_numarasi) VALUES ('NÖROLOJİ', 6);
INSERT INTO public.brans (brans_adi, brans_numarasi) VALUES ('FİZYOTERAPİ', 7);
INSERT INTO public.brans (brans_adi, brans_numarasi) VALUES ('KULAK BURUN BOĞAZ', 8);
INSERT INTO public.brans (brans_adi, brans_numarasi) VALUES ('ORTOPEDİ', 9);
INSERT INTO public.brans (brans_adi, brans_numarasi) VALUES ('ÜROLOJİ', 10);
INSERT INTO public.brans (brans_adi, brans_numarasi) VALUES ('ACİL', 11);
INSERT INTO public.brans (brans_adi, brans_numarasi) VALUES ('KARDİYOLOJİ', 12);
INSERT INTO public.brans (brans_adi, brans_numarasi) VALUES ('GÖZ HASTALIKLARI', 13);


--
-- TOC entry 3449 (class 0 OID 24978)
-- Dependencies: 210
-- Data for Name: dilek_sikayet; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.dilek_sikayet (ad, aciklama, id, soyad, baslik) VALUES ('HAKAN', 'HASTANENİZDE YETERLİ HİJYENİN SAĞLANMADAIĞINI DÜŞÜNÜYORUM.', 1, 'UZUNGÖL', 'HİJYEN');
INSERT INTO public.dilek_sikayet (ad, aciklama, id, soyad, baslik) VALUES ('AYGÜL', 'DAHA ERKEN TARİHLERDE RANDEVU ALMAK İSTİYORUM.', 2, 'KAÇAR', 'RANDEVULAR');
INSERT INTO public.dilek_sikayet (ad, aciklama, id, soyad, baslik) VALUES ('KAAN', 'HASTANE GİRİŞİNDE HASTALARA MASKE DAĞITILMASINI İSTİYORUM.', 3, 'TANGÖZE', 'MASKE');


--
-- TOC entry 3450 (class 0 OID 24983)
-- Dependencies: 211
-- Data for Name: doktor; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.doktor (id, ad, soyad, brans, telefon) VALUES (2, 'HAKAN', 'ZAMAN', 'PSİKİYATRİ', '05376951425');
INSERT INTO public.doktor (id, ad, soyad, brans, telefon) VALUES (3, 'ALİNA', 'BOZ', 'ODYOLOJİ', '05527891425');
INSERT INTO public.doktor (id, ad, soyad, brans, telefon) VALUES (4, 'DİLAN', 'AKBEL', 'DAHİLİYE', '05362587825');
INSERT INTO public.doktor (id, ad, soyad, brans, telefon) VALUES (5, 'MERT', 'ÖZMEN', 'GENEL CERRAHİ', '05398746985');
INSERT INTO public.doktor (id, ad, soyad, brans, telefon) VALUES (6, 'YAĞMUR', 'ATAY', 'NÖROLOJİ', '05367845149');
INSERT INTO public.doktor (id, ad, soyad, brans, telefon) VALUES (7, 'EYLÜL', 'ŞAHİN', 'KULAK BURUN BOĞAZ', '05326591486');
INSERT INTO public.doktor (id, ad, soyad, brans, telefon) VALUES (8, 'CEM', 'ITIR', 'ORTOPEDİ', '05348654769');
INSERT INTO public.doktor (id, ad, soyad, brans, telefon) VALUES (9, 'BEYZA', 'ÇİMEN', 'ÜROLOJİ', '05447846985');
INSERT INTO public.doktor (id, ad, soyad, brans, telefon) VALUES (1, 'MEHMET', 'ENDER', 'PEDİYATRİ', '05475691258');
INSERT INTO public.doktor (id, ad, soyad, brans, telefon) VALUES (10, 'ALİ', 'HÜDAVERDİ', 'ACİL', '05378965428');
INSERT INTO public.doktor (id, ad, soyad, brans, telefon) VALUES (11, 'ZEHRA', 'YALÇIN', 'KARDİYOLOJİ', '05456985652');
INSERT INTO public.doktor (id, ad, soyad, brans, telefon) VALUES (12, 'MERVE', 'DAMAR', 'GÖZ HASTALIKLARI', '05513659874');
INSERT INTO public.doktor (id, ad, soyad, brans, telefon) VALUES (13, 'ÖMER', 'SAYAR', 'FİZYOTERAPİ', '05323689654');


--
-- TOC entry 3451 (class 0 OID 24988)
-- Dependencies: 212
-- Data for Name: duyurular; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.duyurular (id, baslik, aciklama) VALUES (3, 'Kan Arama', 'Acil olarak 0rh+ kan aranmaktadır.');
INSERT INTO public.duyurular (id, baslik, aciklama) VALUES (2, 'Randevular', 'Sistemdeki yapılacak olan bakım nedeniyle 01.01.2022 tarihinde randevu verilmeyecektir.');
INSERT INTO public.duyurular (id, baslik, aciklama) VALUES (1, 'Bilgilendirme', 'Psikiyatri servisimiz bugün öğleden sonra hizmet vermeyecektir.');


--
-- TOC entry 3452 (class 0 OID 24993)
-- Dependencies: 213
-- Data for Name: hasta; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.hasta (tc_no, ad, soyad, telefon, ilce_id) VALUES (23574896879, 'DİLARA', 'SU', '05389871456', 7);
INSERT INTO public.hasta (tc_no, ad, soyad, telefon, ilce_id) VALUES (23457896102, 'ALİ', 'DOĞAN', '05311379847', 5);
INSERT INTO public.hasta (tc_no, ad, soyad, telefon, ilce_id) VALUES (45785487120, 'ARİFHAN', 'ŞENER', '05311897456', 10);
INSERT INTO public.hasta (tc_no, ad, soyad, telefon, ilce_id) VALUES (65432198675, 'BUSE', 'SAKARYA', '05324589614', 9);
INSERT INTO public.hasta (tc_no, ad, soyad, telefon, ilce_id) VALUES (23484712149, 'SÜLEYMAN', 'YOLCU', '05369874561', 1);
INSERT INTO public.hasta (tc_no, ad, soyad, telefon, ilce_id) VALUES (16987542964, 'AHMET', 'ALTINKAYA', '05373569875', 4);
INSERT INTO public.hasta (tc_no, ad, soyad, telefon, ilce_id) VALUES (65493187654, 'KAYRA', 'ASAN', '05396541425', 7);
INSERT INTO public.hasta (tc_no, ad, soyad, telefon, ilce_id) VALUES (27865493816, 'ELİF', 'ALEMDAR', '05373164879', 3);
INSERT INTO public.hasta (tc_no, ad, soyad, telefon, ilce_id) VALUES (36547895426, 'ERKAN', 'SÖNMEZ', '05377271286', 8);


--
-- TOC entry 3453 (class 0 OID 24998)
-- Dependencies: 214
-- Data for Name: hemsire; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.hemsire (id, ad, soyad, telefon, brans) VALUES (1, 'KADRİYE', 'GÜMÜŞ', '05369864578', 'GENEL CERRAHİ');
INSERT INTO public.hemsire (id, ad, soyad, telefon, brans) VALUES (2, 'AHMET', 'SARI', '05315986547', 'KULAK BURUN BOĞAZ');
INSERT INTO public.hemsire (id, ad, soyad, telefon, brans) VALUES (3, 'BEYZA', 'AKGÖL', '05389654758', 'NÖROLOJİ');
INSERT INTO public.hemsire (id, ad, soyad, telefon, brans) VALUES (5, 'TUĞÇE', 'KURT', '05342657814', 'FİZYOTERAPİ');
INSERT INTO public.hemsire (id, ad, soyad, telefon, brans) VALUES (4, 'SAMET', 'YILMAZ', '05364875698', 'ORTOPEDİ');
INSERT INTO public.hemsire (id, ad, soyad, telefon, brans) VALUES (6, 'SEDA', 'AKTÜRK', '05369874587', 'PSİKİYATRİ');
INSERT INTO public.hemsire (id, ad, soyad, telefon, brans) VALUES (7, 'SERCAN', 'YILDIZ', '05368796547', 'KULAK BURUN BOĞAZ');
INSERT INTO public.hemsire (id, ad, soyad, telefon, brans) VALUES (8, 'IRMAK', 'DENİZ', '05321458514', 'DAHİLİYE');
INSERT INTO public.hemsire (id, ad, soyad, telefon, brans) VALUES (9, 'YAREN', 'KARAKUŞ', '05348689823', 'GÖZ HASTALIKLARI');
INSERT INTO public.hemsire (id, ad, soyad, telefon, brans) VALUES (10, 'GAYE', 'GÜRBÜZ', '05387965874', 'PEDİYATRİ');
INSERT INTO public.hemsire (id, ad, soyad, telefon, brans) VALUES (11, 'EFE', 'AYAZ', '05389845213', 'ODYOLOJİ');
INSERT INTO public.hemsire (id, ad, soyad, telefon, brans) VALUES (12, 'TUĞBA', 'İPEK', '05489657845', 'ÜROLOJİ');
INSERT INTO public.hemsire (id, ad, soyad, telefon, brans) VALUES (13, 'EBRAR', 'ÖZEN', '05512364801', 'ACİL');


--
-- TOC entry 3454 (class 0 OID 25003)
-- Dependencies: 215
-- Data for Name: il; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.il (ad, id) VALUES ('Mersin
', 33);
INSERT INTO public.il (ad, id) VALUES ('Adana', 1);


--
-- TOC entry 3455 (class 0 OID 25008)
-- Dependencies: 216
-- Data for Name: ilac; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.ilac (ilac_adi, kullanim_bilgi) VALUES ('GRİPİN', 'günde 2 kez');
INSERT INTO public.ilac (ilac_adi, kullanim_bilgi) VALUES ('ASPİRİN', 'günde 1 kez');
INSERT INTO public.ilac (ilac_adi, kullanim_bilgi) VALUES ('MUSCOFLEX', 'günde 3 kez');
INSERT INTO public.ilac (ilac_adi, kullanim_bilgi) VALUES ('KATARİN', 'günde 3 kez');
INSERT INTO public.ilac (ilac_adi, kullanim_bilgi) VALUES ('PAROL', '12 saate 1 kez');
INSERT INTO public.ilac (ilac_adi, kullanim_bilgi) VALUES ('AFERİN', 'günde 1 defa');
INSERT INTO public.ilac (ilac_adi, kullanim_bilgi) VALUES ('AVMİGRAN', 'günde 2 defa');


--
-- TOC entry 3456 (class 0 OID 25013)
-- Dependencies: 217
-- Data for Name: ilce; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.ilce (ilce_adi, il_id, ilce_id) VALUES ('Tarsus', 33, 7);
INSERT INTO public.ilce (ilce_adi, il_id, ilce_id) VALUES ('Mezitli', 33, 8);
INSERT INTO public.ilce (ilce_adi, il_id, ilce_id) VALUES ('Akdeniz', 33, 9);
INSERT INTO public.ilce (ilce_adi, il_id, ilce_id) VALUES ('Mut', 33, 10);
INSERT INTO public.ilce (ilce_adi, il_id, ilce_id) VALUES ('Ceyhan', 1, 1);
INSERT INTO public.ilce (ilce_adi, il_id, ilce_id) VALUES ('Seyhan', 1, 2);
INSERT INTO public.ilce (ilce_adi, il_id, ilce_id) VALUES ('Aladağ', 1, 3);
INSERT INTO public.ilce (ilce_adi, il_id, ilce_id) VALUES ('Kozan', 1, 4);
INSERT INTO public.ilce (ilce_adi, il_id, ilce_id) VALUES ('Pozantı
', 1, 5);
INSERT INTO public.ilce (ilce_adi, il_id, ilce_id) VALUES ('Karataş
', 1, 6);


--
-- TOC entry 3457 (class 0 OID 25018)
-- Dependencies: 218
-- Data for Name: muayene; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.muayene (doktor_id, hasta_tc, muayene_id, teshis) VALUES (3, 27865493816, 1, 'İÇ KULAK İLTİHABI');
INSERT INTO public.muayene (doktor_id, hasta_tc, muayene_id, teshis) VALUES (2, 65432198675, 2, 'OKB');
INSERT INTO public.muayene (doktor_id, hasta_tc, muayene_id, teshis) VALUES (8, 45785487120, 3, 'KIRIK');


--
-- TOC entry 3458 (class 0 OID 25023)
-- Dependencies: 219
-- Data for Name: oda; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.oda (oda_no, oda_durumu) VALUES (7, 'Boş');
INSERT INTO public.oda (oda_no, oda_durumu) VALUES (8, 'Boş');
INSERT INTO public.oda (oda_no, oda_durumu) VALUES (15, 'Boş');
INSERT INTO public.oda (oda_no, oda_durumu) VALUES (13, 'Boş');
INSERT INTO public.oda (oda_no, oda_durumu) VALUES (11, 'Boş');
INSERT INTO public.oda (oda_no, oda_durumu) VALUES (3, 'Boş');
INSERT INTO public.oda (oda_no, oda_durumu) VALUES (4, 'Boş');
INSERT INTO public.oda (oda_no, oda_durumu) VALUES (6, 'Boş');
INSERT INTO public.oda (oda_no, oda_durumu) VALUES (5, 'Boş');
INSERT INTO public.oda (oda_no, oda_durumu) VALUES (17, 'Boş');
INSERT INTO public.oda (oda_no, oda_durumu) VALUES (16, 'Boş');
INSERT INTO public.oda (oda_no, oda_durumu) VALUES (9, 'Boş');
INSERT INTO public.oda (oda_no, oda_durumu) VALUES (10, 'Boş');
INSERT INTO public.oda (oda_no, oda_durumu) VALUES (1, 'Dolu');
INSERT INTO public.oda (oda_no, oda_durumu) VALUES (2, 'Dolu');
INSERT INTO public.oda (oda_no, oda_durumu) VALUES (18, 'Boş');
INSERT INTO public.oda (oda_no, oda_durumu) VALUES (19, 'Boş');
INSERT INTO public.oda (oda_no, oda_durumu) VALUES (20, 'Boş');
INSERT INTO public.oda (oda_no, oda_durumu) VALUES (22, 'Boş');
INSERT INTO public.oda (oda_no, oda_durumu) VALUES (23, 'Boş');
INSERT INTO public.oda (oda_no, oda_durumu) VALUES (24, 'Boş');
INSERT INTO public.oda (oda_no, oda_durumu) VALUES (25, 'Boş');
INSERT INTO public.oda (oda_no, oda_durumu) VALUES (21, 'Dolu');
INSERT INTO public.oda (oda_no, oda_durumu) VALUES (14, 'Boş');
INSERT INTO public.oda (oda_no, oda_durumu) VALUES (26, 'Boş');
INSERT INTO public.oda (oda_no, oda_durumu) VALUES (27, 'Boş');
INSERT INTO public.oda (oda_no, oda_durumu) VALUES (28, 'Boş');
INSERT INTO public.oda (oda_no, oda_durumu) VALUES (29, 'Boş');
INSERT INTO public.oda (oda_no, oda_durumu) VALUES (30, 'Boş');
INSERT INTO public.oda (oda_no, oda_durumu) VALUES (31, 'Boş');
INSERT INTO public.oda (oda_no, oda_durumu) VALUES (32, 'Boş');
INSERT INTO public.oda (oda_no, oda_durumu) VALUES (33, 'Boş');
INSERT INTO public.oda (oda_no, oda_durumu) VALUES (34, 'Boş');
INSERT INTO public.oda (oda_no, oda_durumu) VALUES (35, 'Boş');
INSERT INTO public.oda (oda_no, oda_durumu) VALUES (36, 'Boş');
INSERT INTO public.oda (oda_no, oda_durumu) VALUES (37, 'Boş');
INSERT INTO public.oda (oda_no, oda_durumu) VALUES (38, 'Boş');
INSERT INTO public.oda (oda_no, oda_durumu) VALUES (39, 'Boş');
INSERT INTO public.oda (oda_no, oda_durumu) VALUES (40, 'Boş');


--
-- TOC entry 3459 (class 0 OID 25028)
-- Dependencies: 220
-- Data for Name: oda_hareketleri; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.oda_hareketleri (degisiklik_no, odanumara, oda_cikis_tarihi) VALUES (1, 5, '2020-12-28 23:50:27.829352');
INSERT INTO public.oda_hareketleri (degisiklik_no, odanumara, oda_cikis_tarihi) VALUES (2, 11, '2020-12-28 23:51:02.580178');
INSERT INTO public.oda_hareketleri (degisiklik_no, odanumara, oda_cikis_tarihi) VALUES (3, 1, '2020-12-29 18:14:35.032395');
INSERT INTO public.oda_hareketleri (degisiklik_no, odanumara, oda_cikis_tarihi) VALUES (4, 2, '2020-12-29 18:14:35.032395');
INSERT INTO public.oda_hareketleri (degisiklik_no, odanumara, oda_cikis_tarihi) VALUES (5, 8, '2020-12-29 18:14:35.032395');
INSERT INTO public.oda_hareketleri (degisiklik_no, odanumara, oda_cikis_tarihi) VALUES (6, 15, '2020-12-29 18:14:35.032395');
INSERT INTO public.oda_hareketleri (degisiklik_no, odanumara, oda_cikis_tarihi) VALUES (7, 6, '2020-12-29 21:00:20.785655');
INSERT INTO public.oda_hareketleri (degisiklik_no, odanumara, oda_cikis_tarihi) VALUES (8, 11, '2020-12-29 21:05:07.298947');
INSERT INTO public.oda_hareketleri (degisiklik_no, odanumara, oda_cikis_tarihi) VALUES (9, 6, '2020-12-29 21:12:37.87675');
INSERT INTO public.oda_hareketleri (degisiklik_no, odanumara, oda_cikis_tarihi) VALUES (10, 6, '2020-12-29 21:20:21.77982');
INSERT INTO public.oda_hareketleri (degisiklik_no, odanumara, oda_cikis_tarihi) VALUES (11, 6, '2020-12-29 21:27:02.477871');
INSERT INTO public.oda_hareketleri (degisiklik_no, odanumara, oda_cikis_tarihi) VALUES (12, 5, '2020-12-29 22:05:12.65025');
INSERT INTO public.oda_hareketleri (degisiklik_no, odanumara, oda_cikis_tarihi) VALUES (13, 5, '2020-12-29 23:10:27.559889');
INSERT INTO public.oda_hareketleri (degisiklik_no, odanumara, oda_cikis_tarihi) VALUES (14, 5, '2020-12-29 23:37:38.264808');
INSERT INTO public.oda_hareketleri (degisiklik_no, odanumara, oda_cikis_tarihi) VALUES (15, 2, '2021-12-19 15:19:12.684218');
INSERT INTO public.oda_hareketleri (degisiklik_no, odanumara, oda_cikis_tarihi) VALUES (16, 16, '2021-12-19 15:19:43.161484');
INSERT INTO public.oda_hareketleri (degisiklik_no, odanumara, oda_cikis_tarihi) VALUES (17, 9, '2021-12-19 15:20:09.829327');
INSERT INTO public.oda_hareketleri (degisiklik_no, odanumara, oda_cikis_tarihi) VALUES (18, 10, '2021-12-19 15:20:16.513217');


--
-- TOC entry 3461 (class 0 OID 25032)
-- Dependencies: 222
-- Data for Name: randevu; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.randevu (hasta_tc, doktor_id, tarih, randevu_id) VALUES (23574896879, 3, '2022-01-15 00:00:00', 1);
INSERT INTO public.randevu (hasta_tc, doktor_id, tarih, randevu_id) VALUES (65432198675, 1, '2022-02-01 00:00:00', 2);
INSERT INTO public.randevu (hasta_tc, doktor_id, tarih, randevu_id) VALUES (65493187654, 5, '2021-12-27 00:00:00', 4);
INSERT INTO public.randevu (hasta_tc, doktor_id, tarih, randevu_id) VALUES (36547895426, 7, '2021-12-25 00:00:00', 5);
INSERT INTO public.randevu (hasta_tc, doktor_id, tarih, randevu_id) VALUES (27865493816, 6, '2022-01-03 00:00:00', 3);


--
-- TOC entry 3462 (class 0 OID 25035)
-- Dependencies: 223
-- Data for Name: recete; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.recete (id, hasta_tc, doktor_id) VALUES (1, 16987542964, 6);


--
-- TOC entry 3463 (class 0 OID 25038)
-- Dependencies: 224
-- Data for Name: recete_ilac; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.recete_ilac (recete_id, ilac_adi) VALUES (1, 'PAROL');
INSERT INTO public.recete_ilac (recete_id, ilac_adi) VALUES (1, 'MUSCOFLEX');
INSERT INTO public.recete_ilac (recete_id, ilac_adi) VALUES (1, 'AVMİGRAN');


--
-- TOC entry 3464 (class 0 OID 25043)
-- Dependencies: 225
-- Data for Name: yatis; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.yatis (hasta_tc, oda_no, yatilacak_gun, id) VALUES (45785487120, 1, 15, 2);
INSERT INTO public.yatis (hasta_tc, oda_no, yatilacak_gun, id) VALUES (16987542964, 2, 36, 1);
INSERT INTO public.yatis (hasta_tc, oda_no, yatilacak_gun, id) VALUES (23484712149, 21, 10, 3);
INSERT INTO public.yatis (hasta_tc, oda_no, yatilacak_gun, id) VALUES (23574896879, 14, 7, 5);


--
-- TOC entry 3471 (class 0 OID 0)
-- Dependencies: 221
-- Name: oda_hareketleri_degisiklik_no_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oda_hareketleri_degisiklik_no_seq', 18, true);


--
-- TOC entry 3234 (class 2606 OID 25048)
-- Name: brans Brans_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.brans
    ADD CONSTRAINT "Brans_pkey" PRIMARY KEY (brans_adi);


--
-- TOC entry 3244 (class 2606 OID 25050)
-- Name: doktor Doktor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.doktor
    ADD CONSTRAINT "Doktor_pkey" PRIMARY KEY (id);


--
-- TOC entry 3250 (class 2606 OID 25052)
-- Name: hasta Hasta_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hasta
    ADD CONSTRAINT "Hasta_pkey" PRIMARY KEY (tc_no);


--
-- TOC entry 3258 (class 2606 OID 25054)
-- Name: il Il_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.il
    ADD CONSTRAINT "Il_pkey" PRIMARY KEY (id);


--
-- TOC entry 3278 (class 2606 OID 25056)
-- Name: randevu Randevu_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.randevu
    ADD CONSTRAINT "Randevu_pkey" PRIMARY KEY (randevu_id);


--
-- TOC entry 3240 (class 2606 OID 25058)
-- Name: dilek_sikayet dilek_sikayet_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dilek_sikayet
    ADD CONSTRAINT dilek_sikayet_pkey PRIMARY KEY (id);


--
-- TOC entry 3248 (class 2606 OID 25060)
-- Name: duyurular duyurular_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.duyurular
    ADD CONSTRAINT duyurular_pkey PRIMARY KEY (id);


--
-- TOC entry 3254 (class 2606 OID 25062)
-- Name: hemsire hemsire_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hemsire
    ADD CONSTRAINT hemsire_pkey PRIMARY KEY (id);


--
-- TOC entry 3262 (class 2606 OID 25064)
-- Name: ilac ilac_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ilac
    ADD CONSTRAINT ilac_pkey PRIMARY KEY (ilac_adi);


--
-- TOC entry 3266 (class 2606 OID 25066)
-- Name: ilce ilce_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ilce
    ADD CONSTRAINT ilce_pkey PRIMARY KEY (ilce_id);


--
-- TOC entry 3270 (class 2606 OID 25068)
-- Name: muayene muayene_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.muayene
    ADD CONSTRAINT muayene_pkey PRIMARY KEY (muayene_id);


--
-- TOC entry 3276 (class 2606 OID 25070)
-- Name: oda_hareketleri oda_hareketleri_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oda_hareketleri
    ADD CONSTRAINT oda_hareketleri_pkey PRIMARY KEY (degisiklik_no);


--
-- TOC entry 3272 (class 2606 OID 25072)
-- Name: oda oda_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oda
    ADD CONSTRAINT oda_pkey PRIMARY KEY (oda_no);


--
-- TOC entry 3286 (class 2606 OID 25074)
-- Name: recete_ilac recete_ilac_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recete_ilac
    ADD CONSTRAINT recete_ilac_pkey PRIMARY KEY (recete_id, ilac_adi);


--
-- TOC entry 3282 (class 2606 OID 25076)
-- Name: recete recete_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recete
    ADD CONSTRAINT recete_pkey PRIMARY KEY (id);


--
-- TOC entry 3236 (class 2606 OID 25078)
-- Name: brans unique_Brans_Ad; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.brans
    ADD CONSTRAINT "unique_Brans_Ad" UNIQUE (brans_adi);


--
-- TOC entry 3246 (class 2606 OID 25080)
-- Name: doktor unique_Doktor_ID; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.doktor
    ADD CONSTRAINT "unique_Doktor_ID" UNIQUE (id);


--
-- TOC entry 3252 (class 2606 OID 25082)
-- Name: hasta unique_Hasta_TCNo; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hasta
    ADD CONSTRAINT "unique_Hasta_TCNo" UNIQUE (tc_no);


--
-- TOC entry 3260 (class 2606 OID 25084)
-- Name: il unique_Il_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.il
    ADD CONSTRAINT "unique_Il_id" UNIQUE (id);


--
-- TOC entry 3280 (class 2606 OID 25086)
-- Name: randevu unique_Randevu_Tarih; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.randevu
    ADD CONSTRAINT "unique_Randevu_Tarih" UNIQUE (tarih);


--
-- TOC entry 3238 (class 2606 OID 25088)
-- Name: brans unique_brans_brans_numarasi; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.brans
    ADD CONSTRAINT unique_brans_brans_numarasi UNIQUE (brans_numarasi);


--
-- TOC entry 3242 (class 2606 OID 25090)
-- Name: dilek_sikayet unique_dilek_sikayet_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dilek_sikayet
    ADD CONSTRAINT unique_dilek_sikayet_id UNIQUE (id);


--
-- TOC entry 3256 (class 2606 OID 25092)
-- Name: hemsire unique_hemsire_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hemsire
    ADD CONSTRAINT unique_hemsire_id UNIQUE (id);


--
-- TOC entry 3264 (class 2606 OID 25094)
-- Name: ilac unique_ilac_ilac_adi; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ilac
    ADD CONSTRAINT unique_ilac_ilac_adi UNIQUE (ilac_adi);


--
-- TOC entry 3268 (class 2606 OID 25096)
-- Name: ilce unique_ilce_ilce_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ilce
    ADD CONSTRAINT unique_ilce_ilce_id UNIQUE (ilce_id);


--
-- TOC entry 3274 (class 2606 OID 25098)
-- Name: oda unique_oda_oda_no; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oda
    ADD CONSTRAINT unique_oda_oda_no UNIQUE (oda_no);


--
-- TOC entry 3284 (class 2606 OID 25100)
-- Name: recete unique_recete_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recete
    ADD CONSTRAINT unique_recete_id UNIQUE (id);


--
-- TOC entry 3288 (class 2606 OID 25102)
-- Name: yatis unique_yatis_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.yatis
    ADD CONSTRAINT unique_yatis_id UNIQUE (id);


--
-- TOC entry 3290 (class 2606 OID 25104)
-- Name: yatis yatis_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.yatis
    ADD CONSTRAINT yatis_pkey PRIMARY KEY (id);


--
-- TOC entry 3305 (class 2620 OID 25105)
-- Name: doktor doktor_eklerken_kontrol; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER doktor_eklerken_kontrol BEFORE INSERT OR UPDATE ON public.doktor FOR EACH ROW EXECUTE FUNCTION public.doktor_eklerken();


--
-- TOC entry 3306 (class 2620 OID 25106)
-- Name: yatis oda_cikis_yapildiginda; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER oda_cikis_yapildiginda AFTER DELETE ON public.yatis FOR EACH ROW EXECUTE FUNCTION public.oda_cikis_hareketleri();


--
-- TOC entry 3307 (class 2620 OID 25107)
-- Name: yatis yatis_eklendiginde_dolu; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER yatis_eklendiginde_dolu AFTER INSERT OR UPDATE ON public.yatis FOR EACH ROW EXECUTE FUNCTION public.yatis_eklendiginde_dolu_yap();


--
-- TOC entry 3308 (class 2620 OID 25108)
-- Name: yatis yatis_silindiginde_boş; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "yatis_silindiginde_boş" AFTER DELETE OR UPDATE ON public.yatis FOR EACH ROW EXECUTE FUNCTION public.yatis_silindiginde_bos_yap();


--
-- TOC entry 3293 (class 2606 OID 25109)
-- Name: hemsire brans_hemsire_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hemsire
    ADD CONSTRAINT brans_hemsire_fkey FOREIGN KEY (brans) REFERENCES public.brans(brans_adi) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3295 (class 2606 OID 25114)
-- Name: muayene doktor-muayene-fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.muayene
    ADD CONSTRAINT "doktor-muayene-fkey" FOREIGN KEY (doktor_id) REFERENCES public.doktor(id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3291 (class 2606 OID 25119)
-- Name: doktor doktorbrans_pkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.doktor
    ADD CONSTRAINT doktorbrans_pkey FOREIGN KEY (brans) REFERENCES public.brans(brans_adi) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3297 (class 2606 OID 25124)
-- Name: randevu doktorrandevu_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.randevu
    ADD CONSTRAINT doktorrandevu_fkey FOREIGN KEY (doktor_id) REFERENCES public.doktor(id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3299 (class 2606 OID 25129)
-- Name: recete doktorrecete-fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recete
    ADD CONSTRAINT "doktorrecete-fkey" FOREIGN KEY (doktor_id) REFERENCES public.doktor(id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3296 (class 2606 OID 25134)
-- Name: muayene hasta-muayene-fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.muayene
    ADD CONSTRAINT "hasta-muayene-fkey" FOREIGN KEY (hasta_tc) REFERENCES public.hasta(tc_no) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3292 (class 2606 OID 25139)
-- Name: hasta hastailce-fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hasta
    ADD CONSTRAINT "hastailce-fkey" FOREIGN KEY (ilce_id) REFERENCES public.ilce(ilce_id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3298 (class 2606 OID 25144)
-- Name: randevu hastarandevu_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.randevu
    ADD CONSTRAINT hastarandevu_fkey FOREIGN KEY (hasta_tc) REFERENCES public.hasta(tc_no) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3303 (class 2606 OID 25149)
-- Name: yatis hastayatis_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.yatis
    ADD CONSTRAINT hastayatis_fkey FOREIGN KEY (hasta_tc) REFERENCES public.hasta(tc_no) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3294 (class 2606 OID 25154)
-- Name: ilce ilIlce_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ilce
    ADD CONSTRAINT "ilIlce_fkey" FOREIGN KEY (il_id) REFERENCES public.il(id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3301 (class 2606 OID 25159)
-- Name: recete_ilac ilac-recete-fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recete_ilac
    ADD CONSTRAINT "ilac-recete-fkey" FOREIGN KEY (ilac_adi) REFERENCES public.ilac(ilac_adi) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3304 (class 2606 OID 25164)
-- Name: yatis odayatis_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.yatis
    ADD CONSTRAINT odayatis_fkey FOREIGN KEY (oda_no) REFERENCES public.oda(oda_no) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3300 (class 2606 OID 25169)
-- Name: recete recete-hasta-fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recete
    ADD CONSTRAINT "recete-hasta-fkey" FOREIGN KEY (hasta_tc) REFERENCES public.hasta(tc_no) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3302 (class 2606 OID 25174)
-- Name: recete_ilac recte-ilac-fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recete_ilac
    ADD CONSTRAINT "recte-ilac-fkey" FOREIGN KEY (recete_id) REFERENCES public.recete(id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


-- Completed on 2021-12-19 23:48:33

--
-- PostgreSQL database dump complete
--

