
-- Создать схему HOMELIB
-- Заходить под пользователем HOMELIB

DROP TABLE FILMS CASCADE CONSTRAINTS PURGE
/

--
-- FILMS  (Table) 
--
CREATE TABLE FILMS
(
  ID       NUMBER(10)                           NOT NULL,
  TITLE    VARCHAR2(100 BYTE)                   NOT NULL,
  YEAR     NUMBER(10),
  GENRE    VARCHAR2(20 BYTE),
  WATCHED  NUMBER(1)                            DEFAULT 0
)
LOGGING 
NOCOMPRESS 
NO INMEMORY
NOCACHE
RESULT_CACHE (MODE DEFAULT)
NOPARALLEL
/


ALTER TABLE FILMS ADD (
  CONSTRAINT CHK_FILMS_WATCHED
  CHECK (watched in (1,0))
  ENABLE VALIDATE)
/


DROP TABLE LIB CASCADE CONSTRAINTS PURGE
/

--
-- LIB  (Table) 
--
CREATE TABLE LIB
(
  LIBRARYNO    NUMBER                           NOT NULL,
  LIBRARYNAME  VARCHAR2(255 BYTE)               NOT NULL,
  LIBRARYDESC  VARCHAR2(2000 BYTE),
  CREATEDATE   DATE                             DEFAULT trunc(sysdate)        NOT NULL
)
LOGGING 
NOCOMPRESS 
NO INMEMORY
NOCACHE
RESULT_CACHE (MODE DEFAULT)
NOPARALLEL
/


--
-- PK_LIB  (Index) 
--
CREATE UNIQUE INDEX PK_LIB ON LIB
(LIBRARYNO)
LOGGING
NOPARALLEL
/

ALTER TABLE LIB ADD (
  CONSTRAINT PK_LIB
  PRIMARY KEY
  (LIBRARYNO)
  USING INDEX PK_LIB
  ENABLE VALIDATE)
/


DROP TABLE LIBITEM CASCADE CONSTRAINTS PURGE
/

--
-- LIBITEM  (Table) 
--
CREATE TABLE LIBITEM
(
  LIBRARYITEMNO  NUMBER                         NOT NULL,
  LIBRARYNO      NUMBER                         NOT NULL,
  ITEMNAME       VARCHAR2(2000 BYTE)            NOT NULL,
  ITEMAUTHOR     VARCHAR2(255 BYTE),
  GENRE          VARCHAR2(255 BYTE),
  ITEMDESC       VARCHAR2(4000 BYTE),
  ITEMYEAR       NUMBER(4),
  PUBLISHERNAME  VARCHAR2(500 BYTE),
  PAGES          NUMBER,
  ADDINGDATE     DATE                           DEFAULT trunc(sysdate)
)
LOGGING 
NOCOMPRESS 
NO INMEMORY
NOCACHE
RESULT_CACHE (MODE DEFAULT)
NOPARALLEL
/

-- Add comments to the columns 
comment on column LIBITEM.itemname
  is 'Наименование экземпляра';
/
comment on column LIBITEM.itemauthor
  is 'Автор';
/
comment on column LIBITEM.genre
  is 'Жанр литературы';
/
comment on column LIBITEM.publishername
  is 'Издатель';
/
comment on column LIBITEM.pages
  is 'Страниц';
/
comment on column LIBITEM.addingdate
  is 'Дата добавления';
/


--
-- PK_LIBITEM  (Index) 
--
CREATE UNIQUE INDEX PK_LIBITEM ON LIBITEM
(LIBRARYITEMNO)
LOGGING
NOPARALLEL
/

ALTER TABLE LIBITEM ADD (
  CONSTRAINT PK_LIBITEM
  PRIMARY KEY
  (LIBRARYITEMNO)
  USING INDEX PK_LIBITEM
  ENABLE VALIDATE)
/


DROP TABLE LIBITEMIMAGE CASCADE CONSTRAINTS PURGE
/

--
-- LIBITEMIMAGE  (Table) 
--
CREATE TABLE LIBITEMIMAGE
(
  LIBITEMIMAGENO  NUMBER                        NOT NULL,
  LIBITEMNO       NUMBER                        NOT NULL,
  IMAGE           BLOB                          NOT NULL,
  ORDERNO         NUMBER,
  ADDINGDATE      DATE                          DEFAULT trunc(sysdate)        NOT NULL,
  FILENAME        VARCHAR2(450 BYTE),
  FILEEXT         VARCHAR2(50 BYTE)             DEFAULT 'jpg'                 NOT NULL,
  FILESIZE        NUMBER
)
LOGGING 
NOCOMPRESS 
NO INMEMORY
NOCACHE
RESULT_CACHE (MODE DEFAULT)
NOPARALLEL
/

-- Add comments to the columns 
comment on column LIBITEMIMAGE.addingdate
  is 'Дата добавления';
/


--
-- PK_LIBITEMIMAGE  (Index) 
--
CREATE UNIQUE INDEX PK_LIBITEMIMAGE ON LIBITEMIMAGE
(LIBITEMIMAGENO)
LOGGING
NOPARALLEL
/

ALTER TABLE LIBITEMIMAGE ADD (
  CONSTRAINT PK_LIBITEMIMAGE
  PRIMARY KEY
  (LIBITEMIMAGENO)
  USING INDEX PK_LIBITEMIMAGE
  ENABLE VALIDATE)
/


DROP TABLE USERACCOUNT CASCADE CONSTRAINTS PURGE
/

--
-- USERACCOUNT  (Table) 
--
CREATE TABLE USERACCOUNT
(
  USERACCOUNTNO  NUMBER                         NOT NULL,
  LOGIN          VARCHAR2(50 BYTE)              NOT NULL,
  USERNAME       VARCHAR2(255 BYTE),
  CREATEDATE     DATE                           DEFAULT trunc(sysdate)        NOT NULL,
  USERPASS       VARCHAR2(255 BYTE),
  ISADMIN        NUMBER(1)                      DEFAULT 0                     NOT NULL
)
LOGGING 
NOCOMPRESS 
NO INMEMORY
NOCACHE
RESULT_CACHE (MODE DEFAULT)
NOPARALLEL
/


--
-- PK_USERACCOUNT  (Index) 
--
CREATE UNIQUE INDEX PK_USERACCOUNT ON USERACCOUNT
(USERACCOUNTNO)
LOGGING
NOPARALLEL
/

ALTER TABLE USERACCOUNT ADD (
  CONSTRAINT PK_USERACCOUNT
  PRIMARY KEY
  (USERACCOUNTNO)
  USING INDEX PK_USERACCOUNT
  ENABLE VALIDATE)
/


--
-- TR_FILMS_BI  (Trigger) 
--
CREATE OR REPLACE TRIGGER TR_FILMS_BI
BEFORE INSERT
ON FILMS
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
BEGIN
    IF :new.id IS NULL
    THEN
        :new.id := filmsIDSEQ.NEXTVAL;
    END IF;
END TR_FILMS_BI;
/


--
-- TR_LIB_BI  (Trigger) 
--
CREATE OR REPLACE TRIGGER TR_LIB_BI
  before insert
  ON LIB
  for each row
begin
  if :new.libraryno is null then
    :new.libraryno := LIBSEQ.NEXTVAL;
  end if;
end TR_LIB_BI;
/


--
-- TR_LIBITEM_BI  (Trigger) 
--
CREATE OR REPLACE TRIGGER TR_LIBITEM_BI
  before insert
  ON LIBITEM
  for each row
declare
begin
  if :new.libraryitemno is null then
    :new.libraryitemno := LIBITEMSEQ.NEXTVAL;
  end if;
end TR_LIBITEM_BI;
/


--
-- TR_LIBITEMIMAGE_AI  (Trigger) 
--
CREATE OR REPLACE TRIGGER TR_LIBITEMIMAGE_AI
  before insert or update
  on LIBITEMIMAGE 
  for each row
declare
  nm_filesize number;
begin
  -- При обновлении файла обновляет поле размер файла
  if (:new.FILESIZE is null or length(:new.IMAGE) <> length(:old.IMAGE))then 
    nm_filesize := length(:new.IMAGE);
    :new.FILESIZE := nm_filesize;
  end if;
end TR_LIBITEMIMAGE_AI;
/


--
-- TR_LIBITEMIMAGE_BI  (Trigger) 
--
CREATE OR REPLACE TRIGGER TR_LIBITEMIMAGE_BI
  before insert
  ON LIBITEMIMAGE
  for each row
declare
begin
  if :new.libitemimageno is null then
    :new.libitemimageno := LIBITEMIMAGESEQ.nextval;
  end if;
end TR_LIBITEMIMAGE_BI;
/


--
-- TR_USERACCOUNT_BI  (Trigger) 
--
CREATE OR REPLACE TRIGGER TR_USERACCOUNT_BI
  before insert
  ON USERACCOUNT
  for each row
declare
begin
  if :new.USERACCOUNTNO is null then
    :new.USERACCOUNTNO := USERACCOUNTSEQ.nextval;
  end if;
end TR_USERACCOUNT_BI;
/


ALTER TABLE LIBITEMIMAGE ADD (
  CONSTRAINT FK_LIBITEMIMAGE_ITM 
  FOREIGN KEY (LIBITEMNO) 
  REFERENCES LIBITEM (LIBRARYITEMNO)
  ON DELETE CASCADE
  ENABLE VALIDATE)
/


ALTER TABLE LIBITEMIMAGE ADD (
  CONSTRAINT FK_LIBITEMIMAGE_ITM 
  FOREIGN KEY (LIBITEMNO) 
  REFERENCES LIBITEM (LIBRARYITEMNO)
  ON DELETE CASCADE)
/
DROP TRIGGER TR_FILMS_BI
/

--
-- TR_FILMS_BI  (Trigger) 
--
CREATE OR REPLACE TRIGGER TR_FILMS_BI
BEFORE INSERT
ON FILMS
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
BEGIN
    IF :new.id IS NULL
    THEN
        :new.id := filmsIDSEQ.NEXTVAL;
    END IF;
END TR_FILMS_BI;
/


DROP TRIGGER TR_LIB_BI
/

--
-- TR_LIB_BI  (Trigger) 
--
CREATE OR REPLACE TRIGGER TR_LIB_BI
  before insert
  ON LIB
  for each row
begin
  if :new.libraryno is null then
    :new.libraryno := LIBSEQ.NEXTVAL;
  end if;
end TR_LIB_BI;
/


DROP TRIGGER TR_LIBITEM_BI
/

--
-- TR_LIBITEM_BI  (Trigger) 
--
CREATE OR REPLACE TRIGGER TR_LIBITEM_BI
  before insert
  ON LIBITEM
  for each row
declare
begin
  if :new.libraryitemno is null then
    :new.libraryitemno := LIBITEMSEQ.NEXTVAL;
  end if;
end TR_LIBITEM_BI;
/


DROP TRIGGER TR_LIBITEMIMAGE_AI
/

--
-- TR_LIBITEMIMAGE_AI  (Trigger) 
--
CREATE OR REPLACE TRIGGER TR_LIBITEMIMAGE_AI
  before insert or update
  on LIBITEMIMAGE 
  for each row
declare
  nm_filesize number;
begin
  -- При обновлении файла обновляет поле размер файла
  if (:new.FILESIZE is null or length(:new.IMAGE) <> length(:old.IMAGE))then 
    nm_filesize := length(:new.IMAGE);
    :new.FILESIZE := nm_filesize;
  end if;
end TR_LIBITEMIMAGE_AI;
/


DROP TRIGGER TR_LIBITEMIMAGE_BI
/

--
-- TR_LIBITEMIMAGE_BI  (Trigger) 
--
CREATE OR REPLACE TRIGGER TR_LIBITEMIMAGE_BI
  before insert
  ON LIBITEMIMAGE
  for each row
declare
begin
  if :new.libitemimageno is null then
    :new.libitemimageno := LIBITEMIMAGESEQ.nextval;
  end if;
end TR_LIBITEMIMAGE_BI;
/


DROP TRIGGER TR_USERACCOUNT_BI
/

--
-- TR_USERACCOUNT_BI  (Trigger) 
--
CREATE OR REPLACE TRIGGER TR_USERACCOUNT_BI
  before insert
  ON USERACCOUNT
  for each row
declare
begin
  if :new.USERACCOUNTNO is null then
    :new.USERACCOUNTNO := USERACCOUNTSEQ.nextval;
  end if;
end TR_USERACCOUNT_BI;
/

DROP INDEX PK_LIB
/

--
-- PK_LIB  (Index) 
--
CREATE UNIQUE INDEX PK_LIB ON LIB
(LIBRARYNO)
LOGGING
NOPARALLEL
/

DROP INDEX PK_LIBITEM
/

--
-- PK_LIBITEM  (Index) 
--
CREATE UNIQUE INDEX PK_LIBITEM ON LIBITEM
(LIBRARYITEMNO)
LOGGING
NOPARALLEL
/

DROP INDEX PK_LIBITEMIMAGE
/

--
-- PK_LIBITEMIMAGE  (Index) 
--
CREATE UNIQUE INDEX PK_LIBITEMIMAGE ON LIBITEMIMAGE
(LIBITEMIMAGENO)
LOGGING
NOPARALLEL
/

DROP INDEX PK_USERACCOUNT
/

--
-- PK_USERACCOUNT  (Index) 
--
CREATE UNIQUE INDEX PK_USERACCOUNT ON USERACCOUNT
(USERACCOUNTNO)
LOGGING
NOPARALLEL
/

ALTER TABLE FILMS
  DROP CONSTRAINT CHK_FILMS_WATCHED
/

ALTER TABLE FILMS MODIFY 
  ID NULL
/

ALTER TABLE FILMS MODIFY 
  TITLE NULL
/

ALTER TABLE FILMS ADD (
  CONSTRAINT CHK_FILMS_WATCHED
  CHECK (watched in (1,0))
  ENABLE VALIDATE)
/

ALTER TABLE FILMS MODIFY 
  ID NOT NULL
  ENABLE VALIDATE
/

ALTER TABLE FILMS MODIFY 
  TITLE NOT NULL
  ENABLE VALIDATE
/


ALTER TABLE LIB MODIFY 
  LIBRARYNO NULL
/

ALTER TABLE LIB MODIFY 
  LIBRARYNAME NULL
/

ALTER TABLE LIB MODIFY 
  CREATEDATE NULL
/

ALTER TABLE LIB
  DROP CONSTRAINT PK_LIB
/

ALTER TABLE LIB MODIFY 
  LIBRARYNO NOT NULL
  ENABLE VALIDATE
/

ALTER TABLE LIB MODIFY 
  LIBRARYNAME NOT NULL
  ENABLE VALIDATE
/

ALTER TABLE LIB MODIFY 
  CREATEDATE NOT NULL
  ENABLE VALIDATE
/

ALTER TABLE LIB ADD (
  CONSTRAINT PK_LIB
  PRIMARY KEY
  (LIBRARYNO)
  ENABLE VALIDATE)
/


ALTER TABLE LIBITEM MODIFY 
  LIBRARYITEMNO NULL
/

ALTER TABLE LIBITEM MODIFY 
  LIBRARYNO NULL
/

ALTER TABLE LIBITEM MODIFY 
  ITEMNAME NULL
/

ALTER TABLE LIBITEM
  DROP CONSTRAINT PK_LIBITEM
/

ALTER TABLE LIBITEM MODIFY 
  LIBRARYITEMNO NOT NULL
  ENABLE VALIDATE
/

ALTER TABLE LIBITEM MODIFY 
  LIBRARYNO NOT NULL
  ENABLE VALIDATE
/

ALTER TABLE LIBITEM MODIFY 
  ITEMNAME NOT NULL
  ENABLE VALIDATE
/

ALTER TABLE LIBITEM ADD (
  CONSTRAINT PK_LIBITEM
  PRIMARY KEY
  (LIBRARYITEMNO)
  ENABLE VALIDATE)
/


ALTER TABLE LIBITEMIMAGE
  DROP CONSTRAINT FK_LIBITEMIMAGE_ITM
/

ALTER TABLE LIBITEMIMAGE MODIFY 
  LIBITEMIMAGENO NULL
/

ALTER TABLE LIBITEMIMAGE MODIFY 
  LIBITEMNO NULL
/

ALTER TABLE LIBITEMIMAGE MODIFY 
  IMAGE NULL
/

ALTER TABLE LIBITEMIMAGE MODIFY 
  ADDINGDATE NULL
/

ALTER TABLE LIBITEMIMAGE MODIFY 
  FILEEXT NULL
/

ALTER TABLE LIBITEMIMAGE
  DROP CONSTRAINT PK_LIBITEMIMAGE
/

ALTER TABLE LIBITEMIMAGE MODIFY 
  LIBITEMIMAGENO NOT NULL
  ENABLE VALIDATE
/

ALTER TABLE LIBITEMIMAGE MODIFY 
  LIBITEMNO NOT NULL
  ENABLE VALIDATE
/

ALTER TABLE LIBITEMIMAGE MODIFY 
  IMAGE NOT NULL
  ENABLE VALIDATE
/

ALTER TABLE LIBITEMIMAGE MODIFY 
  ADDINGDATE NOT NULL
  ENABLE VALIDATE
/

ALTER TABLE LIBITEMIMAGE MODIFY 
  FILEEXT NOT NULL
  ENABLE VALIDATE
/

ALTER TABLE LIBITEMIMAGE ADD (
  CONSTRAINT PK_LIBITEMIMAGE
  PRIMARY KEY
  (LIBITEMIMAGENO)
  ENABLE VALIDATE)
/


ALTER TABLE USERACCOUNT MODIFY 
  USERACCOUNTNO NULL
/

ALTER TABLE USERACCOUNT MODIFY 
  LOGIN NULL
/

ALTER TABLE USERACCOUNT MODIFY 
  CREATEDATE NULL
/

ALTER TABLE USERACCOUNT MODIFY 
  ISADMIN NULL
/

ALTER TABLE USERACCOUNT
  DROP CONSTRAINT PK_USERACCOUNT
/

ALTER TABLE USERACCOUNT MODIFY 
  USERACCOUNTNO NOT NULL
  ENABLE VALIDATE
/

ALTER TABLE USERACCOUNT MODIFY 
  LOGIN NOT NULL
  ENABLE VALIDATE
/

ALTER TABLE USERACCOUNT MODIFY 
  CREATEDATE NOT NULL
  ENABLE VALIDATE
/

ALTER TABLE USERACCOUNT MODIFY 
  ISADMIN NOT NULL
  ENABLE VALIDATE
/

ALTER TABLE USERACCOUNT ADD (
  CONSTRAINT PK_USERACCOUNT
  PRIMARY KEY
  (USERACCOUNTNO)
  ENABLE VALIDATE)
/


ALTER TABLE LIBITEMIMAGE ADD (
  CONSTRAINT FK_LIBITEMIMAGE_ITM 
  FOREIGN KEY (LIBITEMNO) 
  REFERENCES LIBITEM (LIBRARYITEMNO)
  ON DELETE CASCADE
  ENABLE VALIDATE)
/


SET DEFINE OFF;
Insert into FILMS
   (ID, TITLE, YEAR, GENRE, WATCHED)
 Values
   (2, 'Достучаться до небес', 1997, 'Comedy', NULL);
Insert into FILMS
   (ID, TITLE, YEAR, GENRE, WATCHED)
 Values
   (21, 'Inception', 2010, 'sci-fi', 1);
Insert into FILMS
   (ID, TITLE, YEAR, GENRE, WATCHED)
 Values
   (22, 'The Lord of the Rings: The Fellowship of the Ring', 2001, 'fantasy2', NULL);
Insert into FILMS
   (ID, TITLE, YEAR, GENRE, WATCHED)
 Values
   (23, 'Tag', 2018, 'comedy', 0);
Insert into FILMS
   (ID, TITLE, YEAR, GENRE, WATCHED)
 Values
   (24, 'Gunfight at the O.K. Corral', 1957, 'western', 0);
Insert into FILMS
   (ID, TITLE, YEAR, GENRE, WATCHED)
 Values
   (25, 'Die Hard', 1988, 'action', 1);
Insert into FILMS
   (ID, TITLE, YEAR, GENRE, WATCHED)
 Values
   (26, '6', 1988, 'action', 1);
Insert into FILMS
   (ID, TITLE, YEAR, GENRE, WATCHED)
 Values
   (27, '7', 1988, 'action', 1);
Insert into FILMS
   (ID, TITLE, YEAR, GENRE, WATCHED)
 Values
   (28, '8', 1988, 'action', 1);
Insert into FILMS
   (ID, TITLE, YEAR, GENRE, WATCHED)
 Values
   (29, '9', 1988, 'action', 1);
Insert into FILMS
   (ID, TITLE, YEAR, GENRE, WATCHED)
 Values
   (30, '10', 1988, 'action', 1);
Insert into FILMS
   (ID, TITLE, YEAR, GENRE, WATCHED)
 Values
   (31, '11', 1988, 'action', 1);
Insert into FILMS
   (ID, TITLE, YEAR, GENRE, WATCHED)
 Values
   (32, '12', 1988, 'action', 1);
Insert into FILMS
   (ID, TITLE, YEAR, GENRE, WATCHED)
 Values
   (33, '13', 1988, 'action', 1);
Insert into FILMS
   (ID, TITLE, YEAR, GENRE, WATCHED)
 Values
   (34, '14', 1988, 'action', 1);
Insert into FILMS
   (ID, TITLE, YEAR, GENRE, WATCHED)
 Values
   (35, '15', 1988, 'action', 1);
Insert into FILMS
   (ID, TITLE, YEAR, GENRE, WATCHED)
 Values
   (36, '16', 1988, 'action', 1);
Insert into FILMS
   (ID, TITLE, YEAR, GENRE, WATCHED)
 Values
   (37, '17', 1988, 'action', 1);
Insert into FILMS
   (ID, TITLE, YEAR, GENRE, WATCHED)
 Values
   (38, '18', 1988, 'action', 1);
Insert into FILMS
   (ID, TITLE, YEAR, GENRE, WATCHED)
 Values
   (39, '19', 1988, 'action', 1);
Insert into FILMS
   (ID, TITLE, YEAR, GENRE, WATCHED)
 Values
   (40, '20', 1988, 'action', 1);
Insert into FILMS
   (ID, TITLE, YEAR, GENRE, WATCHED)
 Values
   (41, '21', 1988, 'action', 1);
Insert into FILMS
   (ID, TITLE, YEAR, GENRE, WATCHED)
 Values
   (42, '22', 1988, 'action', 1);
Insert into FILMS
   (ID, TITLE, YEAR, GENRE, WATCHED)
 Values
   (43, '23', 1988, 'action', 1);
Insert into FILMS
   (ID, TITLE, YEAR, GENRE, WATCHED)
 Values
   (44, '24', 1988, 'action', 1);
Insert into FILMS
   (ID, TITLE, YEAR, GENRE, WATCHED)
 Values
   (45, '25', 1988, 'action', 1);
Insert into FILMS
   (ID, TITLE, YEAR, GENRE, WATCHED)
 Values
   (46, '26', 1988, 'action', 1);
Insert into FILMS
   (ID, TITLE, YEAR, GENRE, WATCHED)
 Values
   (47, '27', 1988, 'action', 1);
Insert into FILMS
   (ID, TITLE, YEAR, GENRE, WATCHED)
 Values
   (48, '28', 1988, 'action', 1);
Insert into FILMS
   (ID, TITLE, YEAR, GENRE, WATCHED)
 Values
   (49, '29', 1988, 'action', 1);
Insert into FILMS
   (ID, TITLE, YEAR, GENRE, WATCHED)
 Values
   (50, '30', 1988, 'action', NULL);
Insert into FILMS
   (ID, TITLE, YEAR, GENRE, WATCHED)
 Values
   (51, '31', 1988, 'action', 1);
Insert into FILMS
   (ID, TITLE, YEAR, GENRE, WATCHED)
 Values
   (52, '32', 1988, 'action', 1);
Insert into FILMS
   (ID, TITLE, YEAR, GENRE, WATCHED)
 Values
   (53, '33', 1988, 'action', 1);
Insert into FILMS
   (ID, TITLE, YEAR, GENRE, WATCHED)
 Values
   (54, '34', 1988, 'action', 1);
Insert into FILMS
   (ID, TITLE, YEAR, GENRE, WATCHED)
 Values
   (55, '35', 1988, 'action', 1);
Insert into FILMS
   (ID, TITLE, YEAR, GENRE, WATCHED)
 Values
   (56, '36', 1988, 'action', 1);
Insert into FILMS
   (ID, TITLE, YEAR, GENRE, WATCHED)
 Values
   (57, '37', 1988, 'action', 1);
Insert into FILMS
   (ID, TITLE, YEAR, GENRE, WATCHED)
 Values
   (58, '38', 1988, 'action', 1);
Insert into FILMS
   (ID, TITLE, YEAR, GENRE, WATCHED)
 Values
   (59, '39', 1988, 'action', 1);
Insert into FILMS
   (ID, TITLE, YEAR, GENRE, WATCHED)
 Values
   (60, '40', 1988, 'action', 1);
Insert into FILMS
   (ID, TITLE, YEAR, GENRE, WATCHED)
 Values
   (61, '41', 1988, 'action', 1);
Insert into FILMS
   (ID, TITLE, YEAR, GENRE, WATCHED)
 Values
   (62, '42', 1988, 'action', 1);
Insert into FILMS
   (ID, TITLE, YEAR, GENRE, WATCHED)
 Values
   (63, '43', 1988, 'action', 1);
Insert into FILMS
   (ID, TITLE, YEAR, GENRE, WATCHED)
 Values
   (64, '44', 1988, 'action', 1);
Insert into FILMS
   (ID, TITLE, YEAR, GENRE, WATCHED)
 Values
   (65, '45', 1988, 'action', 1);
Insert into FILMS
   (ID, TITLE, YEAR, GENRE, WATCHED)
 Values
   (66, '46', 1988, 'action', 1);
Insert into FILMS
   (ID, TITLE, YEAR, GENRE, WATCHED)
 Values
   (67, '47', 1988, 'action', 1);
Insert into FILMS
   (ID, TITLE, YEAR, GENRE, WATCHED)
 Values
   (68, '48', 1988, 'action', 1);
Insert into FILMS
   (ID, TITLE, YEAR, GENRE, WATCHED)
 Values
   (69, '49', 1988, 'action', 1);
Insert into FILMS
   (ID, TITLE, YEAR, GENRE, WATCHED)
 Values
   (70, '50', 1988, 'action', 1);
Insert into FILMS
   (ID, TITLE, YEAR, GENRE, WATCHED)
 Values
   (71, '51', 1988, 'action', 1);
Insert into FILMS
   (ID, TITLE, YEAR, GENRE, WATCHED)
 Values
   (72, '52', 1988, 'action', 1);
Insert into FILMS
   (ID, TITLE, YEAR, GENRE, WATCHED)
 Values
   (73, '53', 1988, 'action', 1);
Insert into FILMS
   (ID, TITLE, YEAR, GENRE, WATCHED)
 Values
   (74, '54', 1988, 'action', 1);
Insert into FILMS
   (ID, TITLE, YEAR, GENRE, WATCHED)
 Values
   (75, '55', 1988, 'action', 1);
Insert into FILMS
   (ID, TITLE, YEAR, GENRE, WATCHED)
 Values
   (76, '56', 1988, 'action', 1);
Insert into FILMS
   (ID, TITLE, YEAR, GENRE, WATCHED)
 Values
   (77, '57', 1988, 'action', 1);
Insert into FILMS
   (ID, TITLE, YEAR, GENRE, WATCHED)
 Values
   (78, '58', 1988, 'action', 1);
Insert into FILMS
   (ID, TITLE, YEAR, GENRE, WATCHED)
 Values
   (79, '59', 1988, 'action', 1);
Insert into FILMS
   (ID, TITLE, YEAR, GENRE, WATCHED)
 Values
   (80, '60', 1988, 'action', 1);
Insert into FILMS
   (ID, TITLE, YEAR, GENRE, WATCHED)
 Values
   (81, '61', 1988, 'action', 1);
Insert into FILMS
   (ID, TITLE, YEAR, GENRE, WATCHED)
 Values
   (82, '62', 1988, 'action', 1);
Insert into FILMS
   (ID, TITLE, YEAR, GENRE, WATCHED)
 Values
   (83, '63', 1988, 'action', 1);
Insert into FILMS
   (ID, TITLE, YEAR, GENRE, WATCHED)
 Values
   (84, '64', 1988, 'action', 1);
Insert into FILMS
   (ID, TITLE, YEAR, GENRE, WATCHED)
 Values
   (85, '65', 1988, 'action', 1);
Insert into FILMS
   (ID, TITLE, YEAR, GENRE, WATCHED)
 Values
   (86, '66', 1988, 'action', 1);
Insert into FILMS
   (ID, TITLE, YEAR, GENRE, WATCHED)
 Values
   (87, '67', 1988, 'action', 1);
Insert into FILMS
   (ID, TITLE, YEAR, GENRE, WATCHED)
 Values
   (88, '68', 1988, 'action', 1);
Insert into FILMS
   (ID, TITLE, YEAR, GENRE, WATCHED)
 Values
   (89, '69', 1988, 'action', 1);
Insert into FILMS
   (ID, TITLE, YEAR, GENRE, WATCHED)
 Values
   (90, '70', 1988, 'action', 1);
Insert into FILMS
   (ID, TITLE, YEAR, GENRE, WATCHED)
 Values
   (141, '12312', -1, 'asd', 1);
Insert into FILMS
   (ID, TITLE, YEAR, GENRE, WATCHED)
 Values
   (161, 'aaa', 123, '123', NULL);
COMMIT;


SET DEFINE OFF;
Insert into LIBITEMIMAGE
   (LIBITEMIMAGENO, LIBITEMNO, ORDERNO, ADDINGDATE, FILENAME, 
    FILEEXT, FILESIZE)
 Values
   (1, 1, 1, TO_DATE('05/01/2022', 'DD/MM/YYYY'), NULL, 
    'jpg', 274166);
Insert into LIBITEMIMAGE
   (LIBITEMIMAGENO, LIBITEMNO, ORDERNO, ADDINGDATE, FILENAME, 
    FILEEXT, FILESIZE)
 Values
   (2, 1, 2, TO_DATE('05/01/2022', 'DD/MM/YYYY'), NULL, 
    'jpg', 211543);
Insert into LIBITEMIMAGE
   (LIBITEMIMAGENO, LIBITEMNO, ORDERNO, ADDINGDATE, FILENAME, 
    FILEEXT, FILESIZE)
 Values
   (3, 2, 1, TO_DATE('05/01/2022', 'DD/MM/YYYY'), NULL, 
    'jpg', NULL);
Insert into LIBITEMIMAGE
   (LIBITEMIMAGENO, LIBITEMNO, ORDERNO, ADDINGDATE, FILENAME, 
    FILEEXT, FILESIZE)
 Values
   (4, 2, 2, TO_DATE('05/01/2022', 'DD/MM/YYYY'), NULL, 
    'jpg', NULL);
Insert into LIBITEMIMAGE
   (LIBITEMIMAGENO, LIBITEMNO, ORDERNO, ADDINGDATE, FILENAME, 
    FILEEXT, FILESIZE)
 Values
   (5, 3, 1, TO_DATE('05/01/2022', 'DD/MM/YYYY'), NULL, 
    'jpg', NULL);
Insert into LIBITEMIMAGE
   (LIBITEMIMAGENO, LIBITEMNO, ORDERNO, ADDINGDATE, FILENAME, 
    FILEEXT, FILESIZE)
 Values
   (6, 3, 2, TO_DATE('05/01/2022', 'DD/MM/YYYY'), NULL, 
    'jpg', NULL);
Insert into LIBITEMIMAGE
   (LIBITEMIMAGENO, LIBITEMNO, ORDERNO, ADDINGDATE, FILENAME, 
    FILEEXT, FILESIZE)
 Values
   (7, 3, 3, TO_DATE('05/01/2022', 'DD/MM/YYYY'), NULL, 
    'jpg', NULL);
COMMIT;


SET DEFINE OFF;
Insert into LIB
   (LIBRARYNO, LIBRARYNAME, LIBRARYDESC, CREATEDATE)
 Values
   (5, 'Пример 1', 'Описание', TO_DATE('07/01/2022', 'DD/MM/YYYY'));
Insert into LIB
   (LIBRARYNO, LIBRARYNAME, LIBRARYDESC, CREATEDATE)
 Values
   (31, 'Пример 1', 'Описание', TO_DATE('07/01/2022', 'DD/MM/YYYY'));
Insert into LIB
   (LIBRARYNO, LIBRARYNAME, LIBRARYDESC, CREATEDATE)
 Values
   (1, 'Библиотека по-умолчанию', NULL, TO_DATE('05/01/2022', 'DD/MM/YYYY'));
Insert into LIB
   (LIBRARYNO, LIBRARYNAME, LIBRARYDESC, CREATEDATE)
 Values
   (2, 'Вторая библиотека', 'Используется дополнительно', TO_DATE('05/01/2022', 'DD/MM/YYYY'));
Insert into LIB
   (LIBRARYNO, LIBRARYNAME, LIBRARYDESC, CREATEDATE)
 Values
   (3, 'Пример 1', 'Описание', TO_DATE('07/01/2022', 'DD/MM/YYYY'));
Insert into LIB
   (LIBRARYNO, LIBRARYNAME, LIBRARYDESC, CREATEDATE)
 Values
   (4, 'Пример 1', 'Описание', TO_DATE('07/01/2022', 'DD/MM/YYYY'));
Insert into LIB
   (LIBRARYNO, LIBRARYNAME, LIBRARYDESC, CREATEDATE)
 Values
   (6, 'Библиотека 6', 'Описание', TO_DATE('07/01/2022', 'DD/MM/YYYY'));
Insert into LIB
   (LIBRARYNO, LIBRARYNAME, LIBRARYDESC, CREATEDATE)
 Values
   (30, 'Пример 1', 'Описание', TO_DATE('07/01/2022', 'DD/MM/YYYY'));
COMMIT;


SET DEFINE OFF;
Insert into LIBITEM
   (LIBRARYITEMNO, LIBRARYNO, ITEMNAME, ITEMAUTHOR, GENRE, 
    ITEMDESC, ITEMYEAR, PUBLISHERNAME, PAGES, ADDINGDATE)
 Values
   (3, 1, 'Экономикс', 'К.Р. Макконнелл, С.Л. Брю', 'Экономика', 
    '17-е издание', NULL, 'Инфра-М, Москва', 916, TO_DATE('05/01/2022', 'DD/MM/YYYY'));
Insert into LIBITEM
   (LIBRARYITEMNO, LIBRARYNO, ITEMNAME, ITEMAUTHOR, GENRE, 
    ITEMDESC, ITEMYEAR, PUBLISHERNAME, PAGES, ADDINGDATE)
 Values
   (1, 1, 'От руси до России', 'Лев Гумилев', 'История', 
    'Очерки этнической истории', 2002, 'Айрис пресс, Рольф, Москва', 320, TO_DATE('05/01/2022', 'DD/MM/YYYY'));
Insert into LIBITEM
   (LIBRARYITEMNO, LIBRARYNO, ITEMNAME, ITEMAUTHOR, GENRE, 
    ITEMDESC, ITEMYEAR, PUBLISHERNAME, PAGES, ADDINGDATE)
 Values
   (2, 1, 'История России с древнейших времен', 'С.М. Соловьев', 'История', 
    NULL, 2019, 'Эксмо, Москва', 1024, TO_DATE('05/01/2022', 'DD/MM/YYYY'));
Insert into LIBITEM
   (LIBRARYITEMNO, LIBRARYNO, ITEMNAME, ITEMAUTHOR, GENRE, 
    ITEMDESC, ITEMYEAR, PUBLISHERNAME, PAGES, ADDINGDATE)
 Values
   (124, 1, 'Тестовая книга', 'Автор', 'Жанр', 
    'Описание книги', 2022, 'Издательство', 305, TO_DATE('07/01/2022', 'DD/MM/YYYY'));
Insert into LIBITEM
   (LIBRARYITEMNO, LIBRARYNO, ITEMNAME, ITEMAUTHOR, GENRE, 
    ITEMDESC, ITEMYEAR, PUBLISHERNAME, PAGES, ADDINGDATE)
 Values
   (503, 3, 'Тестовая книга 3', '11', '11', 
    '11', 11, '11', 11, TO_DATE('17/01/2022', 'DD/MM/YYYY'));
Insert into LIBITEM
   (LIBRARYITEMNO, LIBRARYNO, ITEMNAME, ITEMAUTHOR, GENRE, 
    ITEMDESC, ITEMYEAR, PUBLISHERNAME, PAGES, ADDINGDATE)
 Values
   (83, 1, 'Походная подготовка разведчика', 'А.Е. Тарас (общая редакция)', 'Хрестоматия', 
    NULL, 2015, 'Харвест', 576, TO_DATE('05/01/2022', 'DD/MM/YYYY'));
Insert into LIBITEM
   (LIBRARYITEMNO, LIBRARYNO, ITEMNAME, ITEMAUTHOR, GENRE, 
    ITEMDESC, ITEMYEAR, PUBLISHERNAME, PAGES, ADDINGDATE)
 Values
   (528, 1, 'Икона', 'А. С. Кравченко', NULL, 
    NULL, 1993, 'Стайл А ЛТД', 256, TO_DATE('17/01/2022', 'DD/MM/YYYY'));
Insert into LIBITEM
   (LIBRARYITEMNO, LIBRARYNO, ITEMNAME, ITEMAUTHOR, GENRE, 
    ITEMDESC, ITEMYEAR, PUBLISHERNAME, PAGES, ADDINGDATE)
 Values
   (483, 1, 'Наследники Чегевары', 'Андрей Манчук', NULL, 
    NULL, NULL, 'Москва ', 272, TO_DATE('17/01/2022', 'DD/MM/YYYY'));
Insert into LIBITEM
   (LIBRARYITEMNO, LIBRARYNO, ITEMNAME, ITEMAUTHOR, GENRE, 
    ITEMDESC, ITEMYEAR, PUBLISHERNAME, PAGES, ADDINGDATE)
 Values
   (65, 2, 'Моя книга', 'Автор', 'Биллетристика', 
    '123', NULL, 'АСТ', 10, TO_DATE('05/01/2022', 'DD/MM/YYYY'));
COMMIT;


SET DEFINE OFF;
Insert into USERACCOUNT
   (USERACCOUNTNO, LOGIN, USERNAME, CREATEDATE, USERPASS, 
    ISADMIN)
 Values
   (2, 'vova', 'Владимир', TO_DATE('05/01/2022', 'DD/MM/YYYY'), '123', 
    0);
Insert into USERACCOUNT
   (USERACCOUNTNO, LOGIN, USERNAME, CREATEDATE, USERPASS, 
    ISADMIN)
 Values
   (3, 'anna', 'Анна', TO_DATE('05/01/2022', 'DD/MM/YYYY'), NULL, 
    0);
Insert into USERACCOUNT
   (USERACCOUNTNO, LOGIN, USERNAME, CREATEDATE, USERPASS, 
    ISADMIN)
 Values
   (21, 'петр', 'Петр', TO_DATE('05/01/2022', 'DD/MM/YYYY'), NULL, 
    0);
Insert into USERACCOUNT
   (USERACCOUNTNO, LOGIN, USERNAME, CREATEDATE, USERPASS, 
    ISADMIN)
 Values
   (1, 'admin', 'Администратор', TO_DATE('05/01/2022', 'DD/MM/YYYY'), 'admin', 
    1);
COMMIT;
