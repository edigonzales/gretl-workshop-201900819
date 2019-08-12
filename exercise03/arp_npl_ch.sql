CREATE SCHEMA IF NOT EXISTS arp_npl_ch;
CREATE SEQUENCE arp_npl_ch.t_ili2db_seq;;
-- Nutzungsplanung_Hauptnutzung_V1_1.Hauptnutzung_CH.Hauptnutzung_CH
CREATE TABLE arp_npl_ch.hauptnutzung_ch_hauptnutzung_ch (
  T_Id bigint PRIMARY KEY DEFAULT nextval('arp_npl_ch.t_ili2db_seq')
  ,T_Ili_Tid varchar(200) NULL
  ,acode integer NOT NULL
  ,bezeichnung varchar(80) NOT NULL
)
;
-- Nutzungsplanung_LV95_V1_1.LocalisedUri
CREATE TABLE arp_npl_ch.localiseduri (
  T_Id bigint PRIMARY KEY DEFAULT nextval('arp_npl_ch.t_ili2db_seq')
  ,T_Seq bigint NULL
  ,alanguage varchar(255) NULL
  ,atext varchar(1023) NOT NULL
  ,multilingualuri_localisedtext bigint NULL
)
;
CREATE INDEX localiseduri_multilingualuri_loclsdtext_idx ON arp_npl_ch.localiseduri ( multilingualuri_localisedtext );
-- Nutzungsplanung_LV95_V1_1.MultilingualUri
CREATE TABLE arp_npl_ch.multilingualuri (
  T_Id bigint PRIMARY KEY DEFAULT nextval('arp_npl_ch.t_ili2db_seq')
  ,T_Seq bigint NULL
  ,rechtsvrschrftn_dkment_textimweb bigint NULL
  ,transfermetadaten_amt_amtimweb bigint NULL
)
;
CREATE INDEX multilingualuri_rechtsvrschrfdkmnt_txtmweb_idx ON arp_npl_ch.multilingualuri ( rechtsvrschrftn_dkment_textimweb );
CREATE INDEX multilingualuri_transfermetadatn_mt_mtmweb_idx ON arp_npl_ch.multilingualuri ( transfermetadaten_amt_amtimweb );
-- Nutzungsplanung_LV95_V1_1.Rechtsvorschriften.Dokument
CREATE TABLE arp_npl_ch.rechtsvorschrften_dokument (
  T_Id bigint PRIMARY KEY DEFAULT nextval('arp_npl_ch.t_ili2db_seq')
  ,T_Type varchar(60) NOT NULL
  ,titel varchar(80) NOT NULL
  ,offiziellertitel text NULL
  ,abkuerzung varchar(12) NULL
  ,offiziellenr varchar(20) NULL
  ,kanton varchar(255) NULL
  ,gemeinde integer NULL
  ,publiziertab date NOT NULL
  ,rechtsstatus varchar(255) NOT NULL
  ,bemerkungen text NULL
)
;
-- Nutzungsplanung_LV95_V1_1.Rechtsvorschriften.HinweisWeitereDokumente
CREATE TABLE arp_npl_ch.rechtsvorschrften_hinweisweiteredokumente (
  T_Id bigint PRIMARY KEY DEFAULT nextval('arp_npl_ch.t_ili2db_seq')
  ,ursprung bigint NOT NULL
  ,hinweis bigint NOT NULL
)
;
CREATE INDEX rechtsvrschrfhnwswtrdkmnte_ursprung_idx ON arp_npl_ch.rechtsvorschrften_hinweisweiteredokumente ( ursprung );
CREATE INDEX rechtsvrschrfhnwswtrdkmnte_hinweis_idx ON arp_npl_ch.rechtsvorschrften_hinweisweiteredokumente ( hinweis );
-- Nutzungsplanung_LV95_V1_1.Geobasisdaten.Typ
CREATE TABLE arp_npl_ch.geobasisdaten_typ (
  T_Id bigint PRIMARY KEY DEFAULT nextval('arp_npl_ch.t_ili2db_seq')
  ,acode varchar(12) NOT NULL
  ,bezeichnung varchar(80) NOT NULL
  ,abkuerzung varchar(12) NULL
  ,verbindlichkeit varchar(255) NOT NULL
  ,nutzungsziffer decimal(3,2) NULL
  ,nutzungsziffer_art varchar(40) NULL
  ,bemerkungen text NULL
  ,symbol bytea NULL
  ,typ_kt bigint NOT NULL
)
;
CREATE INDEX geobasisdaten_typ_typ_kt_idx ON arp_npl_ch.geobasisdaten_typ ( typ_kt );
-- Nutzungsplanung_LV95_V1_1.Geobasisdaten.Typ_Kt
CREATE TABLE arp_npl_ch.geobasisdaten_typ_kt (
  T_Id bigint PRIMARY KEY DEFAULT nextval('arp_npl_ch.t_ili2db_seq')
  ,acode varchar(12) NOT NULL
  ,bezeichnung varchar(80) NOT NULL
  ,abkuerzung varchar(12) NULL
  ,bemerkungen text NULL
  ,hauptnutzung_ch bigint NOT NULL
)
;
CREATE INDEX geobasisdaten_typ_kt_hauptnutzung_ch_idx ON arp_npl_ch.geobasisdaten_typ_kt ( hauptnutzung_ch );
-- Nutzungsplanung_LV95_V1_1.Geobasisdaten.Grundnutzung_Zonenflaeche
CREATE TABLE arp_npl_ch.geobasisdaten_grundnutzung_zonenflaeche (
  T_Id bigint PRIMARY KEY DEFAULT nextval('arp_npl_ch.t_ili2db_seq')
  ,geometrie geometry(CURVEPOLYGON,2056) NOT NULL
  ,publiziertab date NOT NULL
  ,rechtsstatus varchar(255) NOT NULL
  ,bemerkungen text NULL
  ,typ bigint NULL
)
;
CREATE INDEX geobssdtn_grntzng_znnflche_geometrie_idx ON arp_npl_ch.geobasisdaten_grundnutzung_zonenflaeche USING GIST ( geometrie );
CREATE INDEX geobssdtn_grntzng_znnflche_typ_idx ON arp_npl_ch.geobasisdaten_grundnutzung_zonenflaeche ( typ );
-- Nutzungsplanung_LV95_V1_1.Geobasisdaten.Linienbezogene_Festlegung
CREATE TABLE arp_npl_ch.geobasisdaten_linienbezogene_festlegung (
  T_Id bigint PRIMARY KEY DEFAULT nextval('arp_npl_ch.t_ili2db_seq')
  ,geometrie geometry(COMPOUNDCURVE,2056) NOT NULL
  ,publiziertab date NOT NULL
  ,rechtsstatus varchar(255) NOT NULL
  ,bemerkungen text NULL
  ,typ bigint NULL
)
;
CREATE INDEX geobssdtn_lnnbzgn_fstlgung_geometrie_idx ON arp_npl_ch.geobasisdaten_linienbezogene_festlegung USING GIST ( geometrie );
CREATE INDEX geobssdtn_lnnbzgn_fstlgung_typ_idx ON arp_npl_ch.geobasisdaten_linienbezogene_festlegung ( typ );
-- Nutzungsplanung_LV95_V1_1.Geobasisdaten.Objektbezogene_Festlegung
CREATE TABLE arp_npl_ch.geobasisdaten_objektbezogene_festlegung (
  T_Id bigint PRIMARY KEY DEFAULT nextval('arp_npl_ch.t_ili2db_seq')
  ,geometrie geometry(POINT,2056) NOT NULL
  ,publiziertab date NOT NULL
  ,rechtsstatus varchar(255) NOT NULL
  ,bemerkungen text NULL
  ,typ bigint NULL
)
;
CREATE INDEX geobssdtn_bjkbzgn_fstlgung_geometrie_idx ON arp_npl_ch.geobasisdaten_objektbezogene_festlegung USING GIST ( geometrie );
CREATE INDEX geobssdtn_bjkbzgn_fstlgung_typ_idx ON arp_npl_ch.geobasisdaten_objektbezogene_festlegung ( typ );
-- Nutzungsplanung_LV95_V1_1.Geobasisdaten.Ueberlagernde_Festlegung
CREATE TABLE arp_npl_ch.geobasisdaten_ueberlagernde_festlegung (
  T_Id bigint PRIMARY KEY DEFAULT nextval('arp_npl_ch.t_ili2db_seq')
  ,geometrie geometry(CURVEPOLYGON,2056) NOT NULL
  ,publiziertab date NOT NULL
  ,rechtsstatus varchar(255) NOT NULL
  ,bemerkungen text NULL
  ,typ bigint NULL
)
;
CREATE INDEX geobssdtn_brlgrnd_fstlgung_geometrie_idx ON arp_npl_ch.geobasisdaten_ueberlagernde_festlegung USING GIST ( geometrie );
CREATE INDEX geobssdtn_brlgrnd_fstlgung_typ_idx ON arp_npl_ch.geobasisdaten_ueberlagernde_festlegung ( typ );
-- Nutzungsplanung_LV95_V1_1.Geobasisdaten.Typ_Dokument
CREATE TABLE arp_npl_ch.geobasisdaten_typ_dokument (
  T_Id bigint PRIMARY KEY DEFAULT nextval('arp_npl_ch.t_ili2db_seq')
  ,typ bigint NOT NULL
  ,vorschrift bigint NOT NULL
)
;
CREATE INDEX geobasisdaten_typ_dokument_typ_idx ON arp_npl_ch.geobasisdaten_typ_dokument ( typ );
CREATE INDEX geobasisdaten_typ_dokument_vorschrift_idx ON arp_npl_ch.geobasisdaten_typ_dokument ( vorschrift );
-- Nutzungsplanung_LV95_V1_1.TransferMetadaten.Amt
CREATE TABLE arp_npl_ch.transfermetadaten_amt (
  T_Id bigint PRIMARY KEY DEFAULT nextval('arp_npl_ch.t_ili2db_seq')
  ,aname varchar(80) NOT NULL
  ,auid varchar(12) NULL
)
;
-- Nutzungsplanung_LV95_V1_1.TransferMetadaten.Datenbestand
CREATE TABLE arp_npl_ch.transfermetadaten_datenbestand (
  T_Id bigint PRIMARY KEY DEFAULT nextval('arp_npl_ch.t_ili2db_seq')
  ,basketid varchar(20) NOT NULL
  ,stand date NOT NULL
  ,lieferdatum date NULL
  ,bemerkungen text NULL
  ,zustaendigestelle bigint NOT NULL
)
;
CREATE INDEX transfermetadatn_dtnbstand_zustaendigestelle_idx ON arp_npl_ch.transfermetadaten_datenbestand ( zustaendigestelle );
CREATE TABLE arp_npl_ch.T_ILI2DB_BASKET (
  T_Id bigint PRIMARY KEY
  ,dataset bigint NULL
  ,topic varchar(200) NOT NULL
  ,T_Ili_Tid varchar(200) NULL
  ,attachmentKey varchar(200) NOT NULL
  ,domains varchar(1024) NULL
)
;
CREATE INDEX T_ILI2DB_BASKET_dataset_idx ON arp_npl_ch.t_ili2db_basket ( dataset );
CREATE TABLE arp_npl_ch.T_ILI2DB_DATASET (
  T_Id bigint PRIMARY KEY
  ,datasetName varchar(200) NULL
)
;
CREATE TABLE arp_npl_ch.T_ILI2DB_IMPORT (
  T_Id bigint PRIMARY KEY
  ,dataset bigint NOT NULL
  ,importDate timestamp NOT NULL
  ,importUser varchar(40) NOT NULL
  ,importFile varchar(200) NULL
)
;
CREATE INDEX T_ILI2DB_IMPORT_dataset_idx ON arp_npl_ch.t_ili2db_import ( dataset );
CREATE TABLE arp_npl_ch.T_ILI2DB_IMPORT_BASKET (
  T_Id bigint PRIMARY KEY
  ,importrun bigint NOT NULL
  ,basket bigint NOT NULL
  ,objectCount integer NULL
)
;
CREATE INDEX T_ILI2DB_IMPORT_BASKET_importrun_idx ON arp_npl_ch.t_ili2db_import_basket ( importrun );
CREATE INDEX T_ILI2DB_IMPORT_BASKET_basket_idx ON arp_npl_ch.t_ili2db_import_basket ( basket );
CREATE TABLE arp_npl_ch.T_ILI2DB_INHERITANCE (
  thisClass varchar(1024) PRIMARY KEY
  ,baseClass varchar(1024) NULL
)
;
CREATE TABLE arp_npl_ch.T_ILI2DB_SETTINGS (
  tag varchar(60) PRIMARY KEY
  ,setting varchar(1024) NULL
)
;
CREATE TABLE arp_npl_ch.T_ILI2DB_TRAFO (
  iliname varchar(1024) NOT NULL
  ,tag varchar(1024) NOT NULL
  ,setting varchar(1024) NOT NULL
)
;
CREATE TABLE arp_npl_ch.T_ILI2DB_MODEL (
  filename varchar(250) NOT NULL
  ,iliversion varchar(3) NOT NULL
  ,modelName text NOT NULL
  ,content text NOT NULL
  ,importDate timestamp NOT NULL
  ,PRIMARY KEY (iliversion,modelName)
)
;
CREATE TABLE arp_npl_ch.languagecode_iso639_1 (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,inactive boolean NOT NULL
  ,dispName varchar(250) NOT NULL
  ,description varchar(1024) NULL
)
;
CREATE TABLE arp_npl_ch.verbindlichkeit (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,inactive boolean NOT NULL
  ,dispName varchar(250) NOT NULL
  ,description varchar(1024) NULL
)
;
CREATE TABLE arp_npl_ch.rechtsstatus (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,inactive boolean NOT NULL
  ,dispName varchar(250) NOT NULL
  ,description varchar(1024) NULL
)
;
CREATE TABLE arp_npl_ch.chcantoncode (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,inactive boolean NOT NULL
  ,dispName varchar(250) NOT NULL
  ,description varchar(1024) NULL
)
;
CREATE TABLE arp_npl_ch.T_ILI2DB_CLASSNAME (
  IliName varchar(1024) PRIMARY KEY
  ,SqlName varchar(1024) NOT NULL
)
;
CREATE TABLE arp_npl_ch.T_ILI2DB_ATTRNAME (
  IliName varchar(1024) NOT NULL
  ,SqlName varchar(1024) NOT NULL
  ,ColOwner varchar(1024) NOT NULL
  ,Target varchar(1024) NULL
  ,PRIMARY KEY (SqlName,ColOwner)
)
;
CREATE TABLE arp_npl_ch.T_ILI2DB_COLUMN_PROP (
  tablename varchar(255) NOT NULL
  ,subtype varchar(255) NULL
  ,columnname varchar(255) NOT NULL
  ,tag varchar(1024) NOT NULL
  ,setting varchar(1024) NOT NULL
)
;
CREATE TABLE arp_npl_ch.T_ILI2DB_TABLE_PROP (
  tablename varchar(255) NOT NULL
  ,tag varchar(1024) NOT NULL
  ,setting varchar(1024) NOT NULL
)
;
CREATE TABLE arp_npl_ch.T_ILI2DB_META_ATTRS (
  ilielement varchar(255) NOT NULL
  ,attr_name varchar(1024) NOT NULL
  ,attr_value varchar(1024) NOT NULL
)
;
ALTER TABLE arp_npl_ch.hauptnutzung_ch_hauptnutzung_ch ADD CONSTRAINT hauptntzng_ch_hptntzng_ch_acode_check CHECK( acode BETWEEN 11 AND 99);
ALTER TABLE arp_npl_ch.localiseduri ADD CONSTRAINT localiseduri_multilingualuri_loclsdtext_fkey FOREIGN KEY ( multilingualuri_localisedtext ) REFERENCES arp_npl_ch.multilingualuri DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE arp_npl_ch.multilingualuri ADD CONSTRAINT multilingualuri_rechtsvrschrfdkmnt_txtmweb_fkey FOREIGN KEY ( rechtsvrschrftn_dkment_textimweb ) REFERENCES arp_npl_ch.rechtsvorschrften_dokument DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE arp_npl_ch.multilingualuri ADD CONSTRAINT multilingualuri_transfermetadatn_mt_mtmweb_fkey FOREIGN KEY ( transfermetadaten_amt_amtimweb ) REFERENCES arp_npl_ch.transfermetadaten_amt DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE arp_npl_ch.rechtsvorschrften_dokument ADD CONSTRAINT rechtsvorschrften_dokment_gemeinde_check CHECK( gemeinde BETWEEN 1 AND 9999);
ALTER TABLE arp_npl_ch.rechtsvorschrften_hinweisweiteredokumente ADD CONSTRAINT rechtsvrschrfhnwswtrdkmnte_ursprung_fkey FOREIGN KEY ( ursprung ) REFERENCES arp_npl_ch.rechtsvorschrften_dokument DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE arp_npl_ch.rechtsvorschrften_hinweisweiteredokumente ADD CONSTRAINT rechtsvrschrfhnwswtrdkmnte_hinweis_fkey FOREIGN KEY ( hinweis ) REFERENCES arp_npl_ch.rechtsvorschrften_dokument DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE arp_npl_ch.geobasisdaten_typ ADD CONSTRAINT geobasisdaten_typ_nutzungsziffer_check CHECK( nutzungsziffer BETWEEN 0.0 AND 9.0);
ALTER TABLE arp_npl_ch.geobasisdaten_typ ADD CONSTRAINT geobasisdaten_typ_typ_kt_fkey FOREIGN KEY ( typ_kt ) REFERENCES arp_npl_ch.geobasisdaten_typ_kt DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE arp_npl_ch.geobasisdaten_typ_kt ADD CONSTRAINT geobasisdaten_typ_kt_hauptnutzung_ch_fkey FOREIGN KEY ( hauptnutzung_ch ) REFERENCES arp_npl_ch.hauptnutzung_ch_hauptnutzung_ch DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE arp_npl_ch.geobasisdaten_grundnutzung_zonenflaeche ADD CONSTRAINT geobssdtn_grntzng_znnflche_typ_fkey FOREIGN KEY ( typ ) REFERENCES arp_npl_ch.geobasisdaten_typ DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE arp_npl_ch.geobasisdaten_linienbezogene_festlegung ADD CONSTRAINT geobssdtn_lnnbzgn_fstlgung_typ_fkey FOREIGN KEY ( typ ) REFERENCES arp_npl_ch.geobasisdaten_typ DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE arp_npl_ch.geobasisdaten_objektbezogene_festlegung ADD CONSTRAINT geobssdtn_bjkbzgn_fstlgung_typ_fkey FOREIGN KEY ( typ ) REFERENCES arp_npl_ch.geobasisdaten_typ DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE arp_npl_ch.geobasisdaten_ueberlagernde_festlegung ADD CONSTRAINT geobssdtn_brlgrnd_fstlgung_typ_fkey FOREIGN KEY ( typ ) REFERENCES arp_npl_ch.geobasisdaten_typ DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE arp_npl_ch.geobasisdaten_typ_dokument ADD CONSTRAINT geobasisdaten_typ_dokument_typ_fkey FOREIGN KEY ( typ ) REFERENCES arp_npl_ch.geobasisdaten_typ DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE arp_npl_ch.geobasisdaten_typ_dokument ADD CONSTRAINT geobasisdaten_typ_dokument_vorschrift_fkey FOREIGN KEY ( vorschrift ) REFERENCES arp_npl_ch.rechtsvorschrften_dokument DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE arp_npl_ch.transfermetadaten_datenbestand ADD CONSTRAINT transfermetadatn_dtnbstand_zustaendigestelle_fkey FOREIGN KEY ( zustaendigestelle ) REFERENCES arp_npl_ch.transfermetadaten_amt DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE arp_npl_ch.T_ILI2DB_BASKET ADD CONSTRAINT T_ILI2DB_BASKET_dataset_fkey FOREIGN KEY ( dataset ) REFERENCES arp_npl_ch.T_ILI2DB_DATASET DEFERRABLE INITIALLY DEFERRED;
CREATE UNIQUE INDEX T_ILI2DB_DATASET_datasetName_key ON arp_npl_ch.T_ILI2DB_DATASET (datasetName)
;
ALTER TABLE arp_npl_ch.T_ILI2DB_IMPORT_BASKET ADD CONSTRAINT T_ILI2DB_IMPORT_BASKET_importrun_fkey FOREIGN KEY ( importrun ) REFERENCES arp_npl_ch.T_ILI2DB_IMPORT DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE arp_npl_ch.T_ILI2DB_IMPORT_BASKET ADD CONSTRAINT T_ILI2DB_IMPORT_BASKET_basket_fkey FOREIGN KEY ( basket ) REFERENCES arp_npl_ch.T_ILI2DB_BASKET DEFERRABLE INITIALLY DEFERRED;
CREATE UNIQUE INDEX T_ILI2DB_MODEL_iliversion_modelName_key ON arp_npl_ch.T_ILI2DB_MODEL (iliversion,modelName)
;
CREATE UNIQUE INDEX T_ILI2DB_ATTRNAME_SqlName_ColOwner_key ON arp_npl_ch.T_ILI2DB_ATTRNAME (SqlName,ColOwner)
;
INSERT INTO arp_npl_ch.T_ILI2DB_CLASSNAME (IliName,SqlName) VALUES ('Nutzungsplanung_LV95_V1_1.Geobasisdaten.Ueberlagernde_Festlegung','geobasisdaten_ueberlagernde_festlegung');
INSERT INTO arp_npl_ch.T_ILI2DB_CLASSNAME (IliName,SqlName) VALUES ('InternationalCodes_V1.LanguageCode_ISO639_1','languagecode_iso639_1');
INSERT INTO arp_npl_ch.T_ILI2DB_CLASSNAME (IliName,SqlName) VALUES ('Nutzungsplanung_LV95_V1_1.Geobasisdaten.Typ','geobasisdaten_typ');
INSERT INTO arp_npl_ch.T_ILI2DB_CLASSNAME (IliName,SqlName) VALUES ('Nutzungsplanung_LV95_V1_1.Geobasisdaten.Geometrie','geobasisdaten_geometrie');
INSERT INTO arp_npl_ch.T_ILI2DB_CLASSNAME (IliName,SqlName) VALUES ('Nutzungsplanung_LV95_V1_1.TransferMetadaten.Datenbestand','transfermetadaten_datenbestand');
INSERT INTO arp_npl_ch.T_ILI2DB_CLASSNAME (IliName,SqlName) VALUES ('Nutzungsplanung_LV95_V1_1.Geobasisdaten.Linienbezogene_Festlegung','geobasisdaten_linienbezogene_festlegung');
INSERT INTO arp_npl_ch.T_ILI2DB_CLASSNAME (IliName,SqlName) VALUES ('Nutzungsplanung_LV95_V1_1.Geobasisdaten.Typ_Geometrie','geobasisdaten_typ_geometrie');
INSERT INTO arp_npl_ch.T_ILI2DB_CLASSNAME (IliName,SqlName) VALUES ('Nutzungsplanung_LV95_V1_1.TransferMetadaten.zustStelle_Daten','transfermetadaten_zuststelle_daten');
INSERT INTO arp_npl_ch.T_ILI2DB_CLASSNAME (IliName,SqlName) VALUES ('Nutzungsplanung_LV95_V1_1.Geobasisdaten.Typ_Typ_Kt','geobasisdaten_typ_typ_kt');
INSERT INTO arp_npl_ch.T_ILI2DB_CLASSNAME (IliName,SqlName) VALUES ('Nutzungsplanung_LV95_V1_1.Rechtsvorschriften.Rechtsvorschrift','rechtsvorschrften_rechtsvorschrift');
INSERT INTO arp_npl_ch.T_ILI2DB_CLASSNAME (IliName,SqlName) VALUES ('Nutzungsplanung_LV95_V1_1.Rechtsvorschriften.Dokument','rechtsvorschrften_dokument');
INSERT INTO arp_npl_ch.T_ILI2DB_CLASSNAME (IliName,SqlName) VALUES ('Nutzungsplanung_LV95_V1_1.Rechtsstatus','rechtsstatus');
INSERT INTO arp_npl_ch.T_ILI2DB_CLASSNAME (IliName,SqlName) VALUES ('Nutzungsplanung_LV95_V1_1.Verbindlichkeit','verbindlichkeit');
INSERT INTO arp_npl_ch.T_ILI2DB_CLASSNAME (IliName,SqlName) VALUES ('Nutzungsplanung_LV95_V1_1.Geobasisdaten.Typ_Dokument','geobasisdaten_typ_dokument');
INSERT INTO arp_npl_ch.T_ILI2DB_CLASSNAME (IliName,SqlName) VALUES ('Nutzungsplanung_LV95_V1_1.Geobasisdaten.Typ_Kt','geobasisdaten_typ_kt');
INSERT INTO arp_npl_ch.T_ILI2DB_CLASSNAME (IliName,SqlName) VALUES ('Nutzungsplanung_LV95_V1_1.LocalisedUri','localiseduri');
INSERT INTO arp_npl_ch.T_ILI2DB_CLASSNAME (IliName,SqlName) VALUES ('Nutzungsplanung_LV95_V1_1.MultilingualUri','multilingualuri');
INSERT INTO arp_npl_ch.T_ILI2DB_CLASSNAME (IliName,SqlName) VALUES ('Nutzungsplanung_LV95_V1_1.Geobasisdaten.TypKt_HauptnCH','geobasisdaten_typkt_hauptnch');
INSERT INTO arp_npl_ch.T_ILI2DB_CLASSNAME (IliName,SqlName) VALUES ('CHAdminCodes_V1.CHCantonCode','chcantoncode');
INSERT INTO arp_npl_ch.T_ILI2DB_CLASSNAME (IliName,SqlName) VALUES ('Nutzungsplanung_LV95_V1_1.Rechtsvorschriften.HinweisWeitereDokumente','rechtsvorschrften_hinweisweiteredokumente');
INSERT INTO arp_npl_ch.T_ILI2DB_CLASSNAME (IliName,SqlName) VALUES ('Nutzungsplanung_Hauptnutzung_V1_1.Hauptnutzung_CH.Hauptnutzung_CH','hauptnutzung_ch_hauptnutzung_ch');
INSERT INTO arp_npl_ch.T_ILI2DB_CLASSNAME (IliName,SqlName) VALUES ('Nutzungsplanung_LV95_V1_1.Geobasisdaten.Grundnutzung_Zonenflaeche','geobasisdaten_grundnutzung_zonenflaeche');
INSERT INTO arp_npl_ch.T_ILI2DB_CLASSNAME (IliName,SqlName) VALUES ('Nutzungsplanung_LV95_V1_1.Geobasisdaten.Objektbezogene_Festlegung','geobasisdaten_objektbezogene_festlegung');
INSERT INTO arp_npl_ch.T_ILI2DB_CLASSNAME (IliName,SqlName) VALUES ('Nutzungsplanung_LV95_V1_1.TransferMetadaten.Amt','transfermetadaten_amt');
INSERT INTO arp_npl_ch.T_ILI2DB_ATTRNAME (IliName,SqlName,ColOwner,Target) VALUES ('Nutzungsplanung_LV95_V1_1.Geobasisdaten.Typ.Code','acode','geobasisdaten_typ',NULL);
INSERT INTO arp_npl_ch.T_ILI2DB_ATTRNAME (IliName,SqlName,ColOwner,Target) VALUES ('Nutzungsplanung_LV95_V1_1.Geobasisdaten.Typ_Typ_Kt.Typ_Kt','typ_kt','geobasisdaten_typ','geobasisdaten_typ_kt');
INSERT INTO arp_npl_ch.T_ILI2DB_ATTRNAME (IliName,SqlName,ColOwner,Target) VALUES ('Nutzungsplanung_LV95_V1_1.Geobasisdaten.Geometrie.publiziertAb','publiziertab','geobasisdaten_ueberlagernde_festlegung',NULL);
INSERT INTO arp_npl_ch.T_ILI2DB_ATTRNAME (IliName,SqlName,ColOwner,Target) VALUES ('Nutzungsplanung_LV95_V1_1.Geobasisdaten.Typ.Bemerkungen','bemerkungen','geobasisdaten_typ',NULL);
INSERT INTO arp_npl_ch.T_ILI2DB_ATTRNAME (IliName,SqlName,ColOwner,Target) VALUES ('Nutzungsplanung_LV95_V1_1.TransferMetadaten.Amt.AmtImWeb','transfermetadaten_amt_amtimweb','multilingualuri','transfermetadaten_amt');
INSERT INTO arp_npl_ch.T_ILI2DB_ATTRNAME (IliName,SqlName,ColOwner,Target) VALUES ('Nutzungsplanung_LV95_V1_1.Geobasisdaten.Geometrie.Rechtsstatus','rechtsstatus','geobasisdaten_linienbezogene_festlegung',NULL);
INSERT INTO arp_npl_ch.T_ILI2DB_ATTRNAME (IliName,SqlName,ColOwner,Target) VALUES ('Nutzungsplanung_LV95_V1_1.Geobasisdaten.Geometrie.Bemerkungen','bemerkungen','geobasisdaten_linienbezogene_festlegung',NULL);
INSERT INTO arp_npl_ch.T_ILI2DB_ATTRNAME (IliName,SqlName,ColOwner,Target) VALUES ('Nutzungsplanung_LV95_V1_1.Rechtsvorschriften.Dokument.Kanton','kanton','rechtsvorschrften_dokument',NULL);
INSERT INTO arp_npl_ch.T_ILI2DB_ATTRNAME (IliName,SqlName,ColOwner,Target) VALUES ('Nutzungsplanung_LV95_V1_1.Geobasisdaten.Geometrie.publiziertAb','publiziertab','geobasisdaten_objektbezogene_festlegung',NULL);
INSERT INTO arp_npl_ch.T_ILI2DB_ATTRNAME (IliName,SqlName,ColOwner,Target) VALUES ('Nutzungsplanung_Hauptnutzung_V1_1.Hauptnutzung_CH.Hauptnutzung_CH.Bezeichnung','bezeichnung','hauptnutzung_ch_hauptnutzung_ch',NULL);
INSERT INTO arp_npl_ch.T_ILI2DB_ATTRNAME (IliName,SqlName,ColOwner,Target) VALUES ('Nutzungsplanung_LV95_V1_1.Geobasisdaten.Geometrie.Rechtsstatus','rechtsstatus','geobasisdaten_objektbezogene_festlegung',NULL);
INSERT INTO arp_npl_ch.T_ILI2DB_ATTRNAME (IliName,SqlName,ColOwner,Target) VALUES ('Nutzungsplanung_LV95_V1_1.Rechtsvorschriften.Dokument.Abkuerzung','abkuerzung','rechtsvorschrften_dokument',NULL);
INSERT INTO arp_npl_ch.T_ILI2DB_ATTRNAME (IliName,SqlName,ColOwner,Target) VALUES ('Nutzungsplanung_LV95_V1_1.Geobasisdaten.Ueberlagernde_Festlegung.Geometrie','geometrie','geobasisdaten_ueberlagernde_festlegung',NULL);
INSERT INTO arp_npl_ch.T_ILI2DB_ATTRNAME (IliName,SqlName,ColOwner,Target) VALUES ('Nutzungsplanung_LV95_V1_1.Geobasisdaten.Typ_Kt.Bezeichnung','bezeichnung','geobasisdaten_typ_kt',NULL);
INSERT INTO arp_npl_ch.T_ILI2DB_ATTRNAME (IliName,SqlName,ColOwner,Target) VALUES ('Nutzungsplanung_LV95_V1_1.Geobasisdaten.Geometrie.Rechtsstatus','rechtsstatus','geobasisdaten_ueberlagernde_festlegung',NULL);
INSERT INTO arp_npl_ch.T_ILI2DB_ATTRNAME (IliName,SqlName,ColOwner,Target) VALUES ('Nutzungsplanung_LV95_V1_1.Rechtsvorschriften.Dokument.TextImWeb','rechtsvrschrftn_dkment_textimweb','multilingualuri','rechtsvorschrften_dokument');
INSERT INTO arp_npl_ch.T_ILI2DB_ATTRNAME (IliName,SqlName,ColOwner,Target) VALUES ('Nutzungsplanung_LV95_V1_1.LocalisedUri.Text','atext','localiseduri',NULL);
INSERT INTO arp_npl_ch.T_ILI2DB_ATTRNAME (IliName,SqlName,ColOwner,Target) VALUES ('Nutzungsplanung_LV95_V1_1.Rechtsvorschriften.HinweisWeitereDokumente.Hinweis','hinweis','rechtsvorschrften_hinweisweiteredokumente','rechtsvorschrften_dokument');
INSERT INTO arp_npl_ch.T_ILI2DB_ATTRNAME (IliName,SqlName,ColOwner,Target) VALUES ('Nutzungsplanung_LV95_V1_1.Geobasisdaten.Typ_Kt.Abkuerzung','abkuerzung','geobasisdaten_typ_kt',NULL);
INSERT INTO arp_npl_ch.T_ILI2DB_ATTRNAME (IliName,SqlName,ColOwner,Target) VALUES ('Nutzungsplanung_LV95_V1_1.Geobasisdaten.Typ_Dokument.Vorschrift','vorschrift','geobasisdaten_typ_dokument','rechtsvorschrften_dokument');
INSERT INTO arp_npl_ch.T_ILI2DB_ATTRNAME (IliName,SqlName,ColOwner,Target) VALUES ('Nutzungsplanung_LV95_V1_1.TransferMetadaten.Amt.Name','aname','transfermetadaten_amt',NULL);
INSERT INTO arp_npl_ch.T_ILI2DB_ATTRNAME (IliName,SqlName,ColOwner,Target) VALUES ('Nutzungsplanung_LV95_V1_1.Geobasisdaten.Typ_Geometrie.Typ','typ','geobasisdaten_grundnutzung_zonenflaeche','geobasisdaten_typ');
INSERT INTO arp_npl_ch.T_ILI2DB_ATTRNAME (IliName,SqlName,ColOwner,Target) VALUES ('Nutzungsplanung_LV95_V1_1.Rechtsvorschriften.Dokument.publiziertAb','publiziertab','rechtsvorschrften_dokument',NULL);
INSERT INTO arp_npl_ch.T_ILI2DB_ATTRNAME (IliName,SqlName,ColOwner,Target) VALUES ('Nutzungsplanung_LV95_V1_1.Geobasisdaten.Typ.Verbindlichkeit','verbindlichkeit','geobasisdaten_typ',NULL);
INSERT INTO arp_npl_ch.T_ILI2DB_ATTRNAME (IliName,SqlName,ColOwner,Target) VALUES ('Nutzungsplanung_LV95_V1_1.Geobasisdaten.Typ.Nutzungsziffer','nutzungsziffer','geobasisdaten_typ',NULL);
INSERT INTO arp_npl_ch.T_ILI2DB_ATTRNAME (IliName,SqlName,ColOwner,Target) VALUES ('Nutzungsplanung_LV95_V1_1.Geobasisdaten.Typ_Kt.Code','acode','geobasisdaten_typ_kt',NULL);
INSERT INTO arp_npl_ch.T_ILI2DB_ATTRNAME (IliName,SqlName,ColOwner,Target) VALUES ('Nutzungsplanung_LV95_V1_1.Geobasisdaten.Geometrie.publiziertAb','publiziertab','geobasisdaten_grundnutzung_zonenflaeche',NULL);
INSERT INTO arp_npl_ch.T_ILI2DB_ATTRNAME (IliName,SqlName,ColOwner,Target) VALUES ('Nutzungsplanung_LV95_V1_1.Geobasisdaten.Linienbezogene_Festlegung.Geometrie','geometrie','geobasisdaten_linienbezogene_festlegung',NULL);
INSERT INTO arp_npl_ch.T_ILI2DB_ATTRNAME (IliName,SqlName,ColOwner,Target) VALUES ('Nutzungsplanung_LV95_V1_1.Rechtsvorschriften.Dokument.Rechtsstatus','rechtsstatus','rechtsvorschrften_dokument',NULL);
INSERT INTO arp_npl_ch.T_ILI2DB_ATTRNAME (IliName,SqlName,ColOwner,Target) VALUES ('Nutzungsplanung_LV95_V1_1.Geobasisdaten.Typ_Geometrie.Typ','typ','geobasisdaten_objektbezogene_festlegung','geobasisdaten_typ');
INSERT INTO arp_npl_ch.T_ILI2DB_ATTRNAME (IliName,SqlName,ColOwner,Target) VALUES ('Nutzungsplanung_LV95_V1_1.Geobasisdaten.TypKt_HauptnCH.Hauptnutzung_CH','hauptnutzung_ch','geobasisdaten_typ_kt','hauptnutzung_ch_hauptnutzung_ch');
INSERT INTO arp_npl_ch.T_ILI2DB_ATTRNAME (IliName,SqlName,ColOwner,Target) VALUES ('Nutzungsplanung_LV95_V1_1.Rechtsvorschriften.Dokument.Gemeinde','gemeinde','rechtsvorschrften_dokument',NULL);
INSERT INTO arp_npl_ch.T_ILI2DB_ATTRNAME (IliName,SqlName,ColOwner,Target) VALUES ('Nutzungsplanung_Hauptnutzung_V1_1.Hauptnutzung_CH.Hauptnutzung_CH.Code','acode','hauptnutzung_ch_hauptnutzung_ch',NULL);
INSERT INTO arp_npl_ch.T_ILI2DB_ATTRNAME (IliName,SqlName,ColOwner,Target) VALUES ('Nutzungsplanung_LV95_V1_1.Geobasisdaten.Typ.Abkuerzung','abkuerzung','geobasisdaten_typ',NULL);
INSERT INTO arp_npl_ch.T_ILI2DB_ATTRNAME (IliName,SqlName,ColOwner,Target) VALUES ('Nutzungsplanung_LV95_V1_1.Geobasisdaten.Geometrie.Rechtsstatus','rechtsstatus','geobasisdaten_grundnutzung_zonenflaeche',NULL);
INSERT INTO arp_npl_ch.T_ILI2DB_ATTRNAME (IliName,SqlName,ColOwner,Target) VALUES ('Nutzungsplanung_LV95_V1_1.Geobasisdaten.Objektbezogene_Festlegung.Geometrie','geometrie','geobasisdaten_objektbezogene_festlegung',NULL);
INSERT INTO arp_npl_ch.T_ILI2DB_ATTRNAME (IliName,SqlName,ColOwner,Target) VALUES ('Nutzungsplanung_LV95_V1_1.Geobasisdaten.Typ_Dokument.Typ','typ','geobasisdaten_typ_dokument','geobasisdaten_typ');
INSERT INTO arp_npl_ch.T_ILI2DB_ATTRNAME (IliName,SqlName,ColOwner,Target) VALUES ('Nutzungsplanung_LV95_V1_1.TransferMetadaten.Datenbestand.BasketID','basketid','transfermetadaten_datenbestand',NULL);
INSERT INTO arp_npl_ch.T_ILI2DB_ATTRNAME (IliName,SqlName,ColOwner,Target) VALUES ('Nutzungsplanung_LV95_V1_1.Geobasisdaten.Geometrie.Bemerkungen','bemerkungen','geobasisdaten_grundnutzung_zonenflaeche',NULL);
INSERT INTO arp_npl_ch.T_ILI2DB_ATTRNAME (IliName,SqlName,ColOwner,Target) VALUES ('Nutzungsplanung_LV95_V1_1.MultilingualUri.LocalisedText','multilingualuri_localisedtext','localiseduri','multilingualuri');
INSERT INTO arp_npl_ch.T_ILI2DB_ATTRNAME (IliName,SqlName,ColOwner,Target) VALUES ('Nutzungsplanung_LV95_V1_1.Geobasisdaten.Typ_Geometrie.Typ','typ','geobasisdaten_ueberlagernde_festlegung','geobasisdaten_typ');
INSERT INTO arp_npl_ch.T_ILI2DB_ATTRNAME (IliName,SqlName,ColOwner,Target) VALUES ('Nutzungsplanung_LV95_V1_1.TransferMetadaten.Amt.UID','auid','transfermetadaten_amt',NULL);
INSERT INTO arp_npl_ch.T_ILI2DB_ATTRNAME (IliName,SqlName,ColOwner,Target) VALUES ('Nutzungsplanung_LV95_V1_1.Rechtsvorschriften.Dokument.OffizielleNr','offiziellenr','rechtsvorschrften_dokument',NULL);
INSERT INTO arp_npl_ch.T_ILI2DB_ATTRNAME (IliName,SqlName,ColOwner,Target) VALUES ('Nutzungsplanung_LV95_V1_1.Geobasisdaten.Typ.Nutzungsziffer_Art','nutzungsziffer_art','geobasisdaten_typ',NULL);
INSERT INTO arp_npl_ch.T_ILI2DB_ATTRNAME (IliName,SqlName,ColOwner,Target) VALUES ('Nutzungsplanung_LV95_V1_1.TransferMetadaten.Datenbestand.Lieferdatum','lieferdatum','transfermetadaten_datenbestand',NULL);
INSERT INTO arp_npl_ch.T_ILI2DB_ATTRNAME (IliName,SqlName,ColOwner,Target) VALUES ('Nutzungsplanung_LV95_V1_1.TransferMetadaten.Datenbestand.Bemerkungen','bemerkungen','transfermetadaten_datenbestand',NULL);
INSERT INTO arp_npl_ch.T_ILI2DB_ATTRNAME (IliName,SqlName,ColOwner,Target) VALUES ('Nutzungsplanung_LV95_V1_1.Geobasisdaten.Grundnutzung_Zonenflaeche.Geometrie','geometrie','geobasisdaten_grundnutzung_zonenflaeche',NULL);
INSERT INTO arp_npl_ch.T_ILI2DB_ATTRNAME (IliName,SqlName,ColOwner,Target) VALUES ('Nutzungsplanung_LV95_V1_1.Rechtsvorschriften.Dokument.OffiziellerTitel','offiziellertitel','rechtsvorschrften_dokument',NULL);
INSERT INTO arp_npl_ch.T_ILI2DB_ATTRNAME (IliName,SqlName,ColOwner,Target) VALUES ('Nutzungsplanung_LV95_V1_1.Rechtsvorschriften.Dokument.Bemerkungen','bemerkungen','rechtsvorschrften_dokument',NULL);
INSERT INTO arp_npl_ch.T_ILI2DB_ATTRNAME (IliName,SqlName,ColOwner,Target) VALUES ('Nutzungsplanung_LV95_V1_1.Geobasisdaten.Typ_Geometrie.Typ','typ','geobasisdaten_linienbezogene_festlegung','geobasisdaten_typ');
INSERT INTO arp_npl_ch.T_ILI2DB_ATTRNAME (IliName,SqlName,ColOwner,Target) VALUES ('Nutzungsplanung_LV95_V1_1.Geobasisdaten.Geometrie.Bemerkungen','bemerkungen','geobasisdaten_ueberlagernde_festlegung',NULL);
INSERT INTO arp_npl_ch.T_ILI2DB_ATTRNAME (IliName,SqlName,ColOwner,Target) VALUES ('Nutzungsplanung_LV95_V1_1.Rechtsvorschriften.Dokument.Titel','titel','rechtsvorschrften_dokument',NULL);
INSERT INTO arp_npl_ch.T_ILI2DB_ATTRNAME (IliName,SqlName,ColOwner,Target) VALUES ('Nutzungsplanung_LV95_V1_1.LocalisedUri.Language','alanguage','localiseduri',NULL);
INSERT INTO arp_npl_ch.T_ILI2DB_ATTRNAME (IliName,SqlName,ColOwner,Target) VALUES ('Nutzungsplanung_LV95_V1_1.Geobasisdaten.Typ.Symbol','symbol','geobasisdaten_typ',NULL);
INSERT INTO arp_npl_ch.T_ILI2DB_ATTRNAME (IliName,SqlName,ColOwner,Target) VALUES ('Nutzungsplanung_LV95_V1_1.Rechtsvorschriften.HinweisWeitereDokumente.Ursprung','ursprung','rechtsvorschrften_hinweisweiteredokumente','rechtsvorschrften_dokument');
INSERT INTO arp_npl_ch.T_ILI2DB_ATTRNAME (IliName,SqlName,ColOwner,Target) VALUES ('Nutzungsplanung_LV95_V1_1.Geobasisdaten.Geometrie.publiziertAb','publiziertab','geobasisdaten_linienbezogene_festlegung',NULL);
INSERT INTO arp_npl_ch.T_ILI2DB_ATTRNAME (IliName,SqlName,ColOwner,Target) VALUES ('Nutzungsplanung_LV95_V1_1.TransferMetadaten.Datenbestand.Stand','stand','transfermetadaten_datenbestand',NULL);
INSERT INTO arp_npl_ch.T_ILI2DB_ATTRNAME (IliName,SqlName,ColOwner,Target) VALUES ('Nutzungsplanung_LV95_V1_1.TransferMetadaten.zustStelle_Daten.zustaendigeStelle','zustaendigestelle','transfermetadaten_datenbestand','transfermetadaten_amt');
INSERT INTO arp_npl_ch.T_ILI2DB_ATTRNAME (IliName,SqlName,ColOwner,Target) VALUES ('Nutzungsplanung_LV95_V1_1.Geobasisdaten.Typ_Kt.Bemerkungen','bemerkungen','geobasisdaten_typ_kt',NULL);
INSERT INTO arp_npl_ch.T_ILI2DB_ATTRNAME (IliName,SqlName,ColOwner,Target) VALUES ('Nutzungsplanung_LV95_V1_1.Geobasisdaten.Geometrie.Bemerkungen','bemerkungen','geobasisdaten_objektbezogene_festlegung',NULL);
INSERT INTO arp_npl_ch.T_ILI2DB_ATTRNAME (IliName,SqlName,ColOwner,Target) VALUES ('Nutzungsplanung_LV95_V1_1.Geobasisdaten.Typ.Bezeichnung','bezeichnung','geobasisdaten_typ',NULL);
INSERT INTO arp_npl_ch.T_ILI2DB_TRAFO (iliname,tag,setting) VALUES ('Nutzungsplanung_LV95_V1_1.Geobasisdaten.Ueberlagernde_Festlegung','ch.ehi.ili2db.inheritance','newClass');
INSERT INTO arp_npl_ch.T_ILI2DB_TRAFO (iliname,tag,setting) VALUES ('Nutzungsplanung_LV95_V1_1.Geobasisdaten.Typ','ch.ehi.ili2db.inheritance','newClass');
INSERT INTO arp_npl_ch.T_ILI2DB_TRAFO (iliname,tag,setting) VALUES ('Nutzungsplanung_LV95_V1_1.Geobasisdaten.Geometrie','ch.ehi.ili2db.inheritance','subClass');
INSERT INTO arp_npl_ch.T_ILI2DB_TRAFO (iliname,tag,setting) VALUES ('Nutzungsplanung_LV95_V1_1.TransferMetadaten.Datenbestand','ch.ehi.ili2db.inheritance','newClass');
INSERT INTO arp_npl_ch.T_ILI2DB_TRAFO (iliname,tag,setting) VALUES ('Nutzungsplanung_LV95_V1_1.Geobasisdaten.Linienbezogene_Festlegung','ch.ehi.ili2db.inheritance','newClass');
INSERT INTO arp_npl_ch.T_ILI2DB_TRAFO (iliname,tag,setting) VALUES ('Nutzungsplanung_LV95_V1_1.Geobasisdaten.Typ_Geometrie','ch.ehi.ili2db.inheritance','embedded');
INSERT INTO arp_npl_ch.T_ILI2DB_TRAFO (iliname,tag,setting) VALUES ('Nutzungsplanung_LV95_V1_1.TransferMetadaten.zustStelle_Daten','ch.ehi.ili2db.inheritance','embedded');
INSERT INTO arp_npl_ch.T_ILI2DB_TRAFO (iliname,tag,setting) VALUES ('Nutzungsplanung_LV95_V1_1.Geobasisdaten.Typ_Typ_Kt','ch.ehi.ili2db.inheritance','embedded');
INSERT INTO arp_npl_ch.T_ILI2DB_TRAFO (iliname,tag,setting) VALUES ('Nutzungsplanung_LV95_V1_1.Rechtsvorschriften.Rechtsvorschrift','ch.ehi.ili2db.inheritance','superClass');
INSERT INTO arp_npl_ch.T_ILI2DB_TRAFO (iliname,tag,setting) VALUES ('Nutzungsplanung_LV95_V1_1.Rechtsvorschriften.Dokument','ch.ehi.ili2db.inheritance','newClass');
INSERT INTO arp_npl_ch.T_ILI2DB_TRAFO (iliname,tag,setting) VALUES ('Nutzungsplanung_LV95_V1_1.Geobasisdaten.Typ_Dokument','ch.ehi.ili2db.inheritance','newClass');
INSERT INTO arp_npl_ch.T_ILI2DB_TRAFO (iliname,tag,setting) VALUES ('Nutzungsplanung_LV95_V1_1.Geobasisdaten.Typ_Kt','ch.ehi.ili2db.inheritance','newClass');
INSERT INTO arp_npl_ch.T_ILI2DB_TRAFO (iliname,tag,setting) VALUES ('Nutzungsplanung_LV95_V1_1.LocalisedUri','ch.ehi.ili2db.inheritance','newClass');
INSERT INTO arp_npl_ch.T_ILI2DB_TRAFO (iliname,tag,setting) VALUES ('Nutzungsplanung_LV95_V1_1.MultilingualUri','ch.ehi.ili2db.inheritance','newClass');
INSERT INTO arp_npl_ch.T_ILI2DB_TRAFO (iliname,tag,setting) VALUES ('Nutzungsplanung_LV95_V1_1.Geobasisdaten.TypKt_HauptnCH','ch.ehi.ili2db.inheritance','embedded');
INSERT INTO arp_npl_ch.T_ILI2DB_TRAFO (iliname,tag,setting) VALUES ('Nutzungsplanung_LV95_V1_1.Rechtsvorschriften.HinweisWeitereDokumente','ch.ehi.ili2db.inheritance','newClass');
INSERT INTO arp_npl_ch.T_ILI2DB_TRAFO (iliname,tag,setting) VALUES ('Nutzungsplanung_Hauptnutzung_V1_1.Hauptnutzung_CH.Hauptnutzung_CH','ch.ehi.ili2db.inheritance','newClass');
INSERT INTO arp_npl_ch.T_ILI2DB_TRAFO (iliname,tag,setting) VALUES ('Nutzungsplanung_LV95_V1_1.Geobasisdaten.Grundnutzung_Zonenflaeche','ch.ehi.ili2db.inheritance','newClass');
INSERT INTO arp_npl_ch.T_ILI2DB_TRAFO (iliname,tag,setting) VALUES ('Nutzungsplanung_LV95_V1_1.Geobasisdaten.Objektbezogene_Festlegung','ch.ehi.ili2db.inheritance','newClass');
INSERT INTO arp_npl_ch.T_ILI2DB_TRAFO (iliname,tag,setting) VALUES ('Nutzungsplanung_LV95_V1_1.TransferMetadaten.Amt','ch.ehi.ili2db.inheritance','newClass');
INSERT INTO arp_npl_ch.T_ILI2DB_INHERITANCE (thisClass,baseClass) VALUES ('Nutzungsplanung_LV95_V1_1.Geobasisdaten.Typ_Kt',NULL);
INSERT INTO arp_npl_ch.T_ILI2DB_INHERITANCE (thisClass,baseClass) VALUES ('Nutzungsplanung_LV95_V1_1.Geobasisdaten.TypKt_HauptnCH',NULL);
INSERT INTO arp_npl_ch.T_ILI2DB_INHERITANCE (thisClass,baseClass) VALUES ('Nutzungsplanung_LV95_V1_1.Geobasisdaten.Objektbezogene_Festlegung','Nutzungsplanung_LV95_V1_1.Geobasisdaten.Geometrie');
INSERT INTO arp_npl_ch.T_ILI2DB_INHERITANCE (thisClass,baseClass) VALUES ('Nutzungsplanung_LV95_V1_1.Rechtsvorschriften.Dokument',NULL);
INSERT INTO arp_npl_ch.T_ILI2DB_INHERITANCE (thisClass,baseClass) VALUES ('Nutzungsplanung_LV95_V1_1.Geobasisdaten.Geometrie',NULL);
INSERT INTO arp_npl_ch.T_ILI2DB_INHERITANCE (thisClass,baseClass) VALUES ('Nutzungsplanung_LV95_V1_1.MultilingualUri',NULL);
INSERT INTO arp_npl_ch.T_ILI2DB_INHERITANCE (thisClass,baseClass) VALUES ('Nutzungsplanung_LV95_V1_1.Rechtsvorschriften.HinweisWeitereDokumente',NULL);
INSERT INTO arp_npl_ch.T_ILI2DB_INHERITANCE (thisClass,baseClass) VALUES ('Nutzungsplanung_LV95_V1_1.Geobasisdaten.Typ_Geometrie',NULL);
INSERT INTO arp_npl_ch.T_ILI2DB_INHERITANCE (thisClass,baseClass) VALUES ('Nutzungsplanung_LV95_V1_1.Geobasisdaten.Typ_Dokument',NULL);
INSERT INTO arp_npl_ch.T_ILI2DB_INHERITANCE (thisClass,baseClass) VALUES ('Nutzungsplanung_LV95_V1_1.LocalisedUri',NULL);
INSERT INTO arp_npl_ch.T_ILI2DB_INHERITANCE (thisClass,baseClass) VALUES ('Nutzungsplanung_LV95_V1_1.Geobasisdaten.Typ_Typ_Kt',NULL);
INSERT INTO arp_npl_ch.T_ILI2DB_INHERITANCE (thisClass,baseClass) VALUES ('Nutzungsplanung_LV95_V1_1.Geobasisdaten.Ueberlagernde_Festlegung','Nutzungsplanung_LV95_V1_1.Geobasisdaten.Geometrie');
INSERT INTO arp_npl_ch.T_ILI2DB_INHERITANCE (thisClass,baseClass) VALUES ('Nutzungsplanung_LV95_V1_1.Rechtsvorschriften.Rechtsvorschrift','Nutzungsplanung_LV95_V1_1.Rechtsvorschriften.Dokument');
INSERT INTO arp_npl_ch.T_ILI2DB_INHERITANCE (thisClass,baseClass) VALUES ('Nutzungsplanung_LV95_V1_1.TransferMetadaten.Datenbestand',NULL);
INSERT INTO arp_npl_ch.T_ILI2DB_INHERITANCE (thisClass,baseClass) VALUES ('Nutzungsplanung_LV95_V1_1.TransferMetadaten.zustStelle_Daten',NULL);
INSERT INTO arp_npl_ch.T_ILI2DB_INHERITANCE (thisClass,baseClass) VALUES ('Nutzungsplanung_Hauptnutzung_V1_1.Hauptnutzung_CH.Hauptnutzung_CH',NULL);
INSERT INTO arp_npl_ch.T_ILI2DB_INHERITANCE (thisClass,baseClass) VALUES ('Nutzungsplanung_LV95_V1_1.Geobasisdaten.Typ',NULL);
INSERT INTO arp_npl_ch.T_ILI2DB_INHERITANCE (thisClass,baseClass) VALUES ('Nutzungsplanung_LV95_V1_1.Geobasisdaten.Linienbezogene_Festlegung','Nutzungsplanung_LV95_V1_1.Geobasisdaten.Geometrie');
INSERT INTO arp_npl_ch.T_ILI2DB_INHERITANCE (thisClass,baseClass) VALUES ('Nutzungsplanung_LV95_V1_1.TransferMetadaten.Amt',NULL);
INSERT INTO arp_npl_ch.T_ILI2DB_INHERITANCE (thisClass,baseClass) VALUES ('Nutzungsplanung_LV95_V1_1.Geobasisdaten.Grundnutzung_Zonenflaeche','Nutzungsplanung_LV95_V1_1.Geobasisdaten.Geometrie');
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'de',0,'de',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'fr',1,'fr',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'it',2,'it',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'rm',3,'rm',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'en',4,'en',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'aa',5,'aa',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'ab',6,'ab',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'af',7,'af',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'am',8,'am',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'ar',9,'ar',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'as',10,'as',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'ay',11,'ay',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'az',12,'az',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'ba',13,'ba',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'be',14,'be',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'bg',15,'bg',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'bh',16,'bh',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'bi',17,'bi',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'bn',18,'bn',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'bo',19,'bo',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'br',20,'br',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'ca',21,'ca',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'co',22,'co',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'cs',23,'cs',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'cy',24,'cy',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'da',25,'da',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'dz',26,'dz',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'el',27,'el',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'eo',28,'eo',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'es',29,'es',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'et',30,'et',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'eu',31,'eu',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'fa',32,'fa',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'fi',33,'fi',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'fj',34,'fj',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'fo',35,'fo',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'fy',36,'fy',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'ga',37,'ga',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'gd',38,'gd',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'gl',39,'gl',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'gn',40,'gn',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'gu',41,'gu',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'ha',42,'ha',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'he',43,'he',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'hi',44,'hi',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'hr',45,'hr',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'hu',46,'hu',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'hy',47,'hy',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'ia',48,'ia',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'id',49,'id',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'ie',50,'ie',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'ik',51,'ik',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'is',52,'is',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'iu',53,'iu',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'ja',54,'ja',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'jw',55,'jw',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'ka',56,'ka',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'kk',57,'kk',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'kl',58,'kl',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'km',59,'km',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'kn',60,'kn',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'ko',61,'ko',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'ks',62,'ks',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'ku',63,'ku',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'ky',64,'ky',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'la',65,'la',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'ln',66,'ln',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'lo',67,'lo',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'lt',68,'lt',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'lv',69,'lv',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'mg',70,'mg',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'mi',71,'mi',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'mk',72,'mk',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'ml',73,'ml',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'mn',74,'mn',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'mo',75,'mo',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'mr',76,'mr',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'ms',77,'ms',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'mt',78,'mt',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'my',79,'my',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'na',80,'na',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'ne',81,'ne',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'nl',82,'nl',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'no',83,'no',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'oc',84,'oc',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'om',85,'om',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'or',86,'or',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'pa',87,'pa',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'pl',88,'pl',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'ps',89,'ps',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'pt',90,'pt',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'qu',91,'qu',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'rn',92,'rn',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'ro',93,'ro',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'ru',94,'ru',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'rw',95,'rw',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'sa',96,'sa',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'sd',97,'sd',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'sg',98,'sg',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'sh',99,'sh',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'si',100,'si',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'sk',101,'sk',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'sl',102,'sl',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'sm',103,'sm',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'sn',104,'sn',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'so',105,'so',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'sq',106,'sq',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'sr',107,'sr',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'ss',108,'ss',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'st',109,'st',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'su',110,'su',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'sv',111,'sv',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'sw',112,'sw',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'ta',113,'ta',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'te',114,'te',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'tg',115,'tg',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'th',116,'th',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'ti',117,'ti',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'tk',118,'tk',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'tl',119,'tl',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'tn',120,'tn',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'to',121,'to',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'tr',122,'tr',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'ts',123,'ts',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'tt',124,'tt',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'tw',125,'tw',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'ug',126,'ug',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'uk',127,'uk',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'ur',128,'ur',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'uz',129,'uz',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'vi',130,'vi',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'vo',131,'vo',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'wo',132,'wo',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'xh',133,'xh',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'yi',134,'yi',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'yo',135,'yo',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'za',136,'za',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'zh',137,'zh',FALSE,NULL);
INSERT INTO arp_npl_ch.languagecode_iso639_1 (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'zu',138,'zu',FALSE,NULL);
INSERT INTO arp_npl_ch.verbindlichkeit (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'Nutzungsplanfestlegung',0,'Nutzungsplanfestlegung',FALSE,NULL);
INSERT INTO arp_npl_ch.verbindlichkeit (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'orientierend',1,'orientierend',FALSE,NULL);
INSERT INTO arp_npl_ch.verbindlichkeit (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'hinweisend',2,'hinweisend',FALSE,NULL);
INSERT INTO arp_npl_ch.verbindlichkeit (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'wegleitend',3,'wegleitend',FALSE,NULL);
INSERT INTO arp_npl_ch.rechtsstatus (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'inKraft',0,'inKraft',FALSE,NULL);
INSERT INTO arp_npl_ch.rechtsstatus (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'laufendeAenderung',1,'laufendeAenderung',FALSE,NULL);
INSERT INTO arp_npl_ch.chcantoncode (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'ZH',0,'ZH',FALSE,NULL);
INSERT INTO arp_npl_ch.chcantoncode (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'BE',1,'BE',FALSE,NULL);
INSERT INTO arp_npl_ch.chcantoncode (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'LU',2,'LU',FALSE,NULL);
INSERT INTO arp_npl_ch.chcantoncode (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'UR',3,'UR',FALSE,NULL);
INSERT INTO arp_npl_ch.chcantoncode (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'SZ',4,'SZ',FALSE,NULL);
INSERT INTO arp_npl_ch.chcantoncode (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'OW',5,'OW',FALSE,NULL);
INSERT INTO arp_npl_ch.chcantoncode (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'NW',6,'NW',FALSE,NULL);
INSERT INTO arp_npl_ch.chcantoncode (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'GL',7,'GL',FALSE,NULL);
INSERT INTO arp_npl_ch.chcantoncode (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'ZG',8,'ZG',FALSE,NULL);
INSERT INTO arp_npl_ch.chcantoncode (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'FR',9,'FR',FALSE,NULL);
INSERT INTO arp_npl_ch.chcantoncode (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'SO',10,'SO',FALSE,NULL);
INSERT INTO arp_npl_ch.chcantoncode (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'BS',11,'BS',FALSE,NULL);
INSERT INTO arp_npl_ch.chcantoncode (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'BL',12,'BL',FALSE,NULL);
INSERT INTO arp_npl_ch.chcantoncode (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'SH',13,'SH',FALSE,NULL);
INSERT INTO arp_npl_ch.chcantoncode (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'AR',14,'AR',FALSE,NULL);
INSERT INTO arp_npl_ch.chcantoncode (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'AI',15,'AI',FALSE,NULL);
INSERT INTO arp_npl_ch.chcantoncode (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'SG',16,'SG',FALSE,NULL);
INSERT INTO arp_npl_ch.chcantoncode (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'GR',17,'GR',FALSE,NULL);
INSERT INTO arp_npl_ch.chcantoncode (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'AG',18,'AG',FALSE,NULL);
INSERT INTO arp_npl_ch.chcantoncode (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'TG',19,'TG',FALSE,NULL);
INSERT INTO arp_npl_ch.chcantoncode (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'TI',20,'TI',FALSE,NULL);
INSERT INTO arp_npl_ch.chcantoncode (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'VD',21,'VD',FALSE,NULL);
INSERT INTO arp_npl_ch.chcantoncode (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'VS',22,'VS',FALSE,NULL);
INSERT INTO arp_npl_ch.chcantoncode (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'NE',23,'NE',FALSE,NULL);
INSERT INTO arp_npl_ch.chcantoncode (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'GE',24,'GE',FALSE,NULL);
INSERT INTO arp_npl_ch.chcantoncode (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'JU',25,'JU',FALSE,NULL);
INSERT INTO arp_npl_ch.chcantoncode (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'FL',26,'FL',FALSE,NULL);
INSERT INTO arp_npl_ch.chcantoncode (seq,iliCode,itfCode,dispName,inactive,description) VALUES (NULL,'CH',27,'CH',FALSE,NULL);
INSERT INTO arp_npl_ch.T_ILI2DB_COLUMN_PROP (tablename,subtype,columnname,tag,setting) VALUES ('geobasisdaten_objektbezogene_festlegung',NULL,'geometrie','ch.ehi.ili2db.c1Max','2870000.000');
INSERT INTO arp_npl_ch.T_ILI2DB_COLUMN_PROP (tablename,subtype,columnname,tag,setting) VALUES ('geobasisdaten_grundnutzung_zonenflaeche',NULL,'bemerkungen','ch.ehi.ili2db.textKind','MTEXT');
INSERT INTO arp_npl_ch.T_ILI2DB_COLUMN_PROP (tablename,subtype,columnname,tag,setting) VALUES ('geobasisdaten_ueberlagernde_festlegung',NULL,'geometrie','ch.ehi.ili2db.c2Max','1310000.000');
INSERT INTO arp_npl_ch.T_ILI2DB_COLUMN_PROP (tablename,subtype,columnname,tag,setting) VALUES ('multilingualuri',NULL,'rechtsvrschrftn_dkment_textimweb','ch.ehi.ili2db.foreignKey','rechtsvorschrften_dokument');
INSERT INTO arp_npl_ch.T_ILI2DB_COLUMN_PROP (tablename,subtype,columnname,tag,setting) VALUES ('geobasisdaten_grundnutzung_zonenflaeche',NULL,'geometrie','ch.ehi.ili2db.c1Max','2870000.000');
INSERT INTO arp_npl_ch.T_ILI2DB_COLUMN_PROP (tablename,subtype,columnname,tag,setting) VALUES ('geobasisdaten_ueberlagernde_festlegung',NULL,'geometrie','ch.ehi.ili2db.c1Min','2460000.000');
INSERT INTO arp_npl_ch.T_ILI2DB_COLUMN_PROP (tablename,subtype,columnname,tag,setting) VALUES ('geobasisdaten_linienbezogene_festlegung',NULL,'bemerkungen','ch.ehi.ili2db.textKind','MTEXT');
INSERT INTO arp_npl_ch.T_ILI2DB_COLUMN_PROP (tablename,subtype,columnname,tag,setting) VALUES ('geobasisdaten_linienbezogene_festlegung',NULL,'geometrie','ch.ehi.ili2db.coordDimension','2');
INSERT INTO arp_npl_ch.T_ILI2DB_COLUMN_PROP (tablename,subtype,columnname,tag,setting) VALUES ('geobasisdaten_objektbezogene_festlegung',NULL,'geometrie','ch.ehi.ili2db.coordDimension','2');
INSERT INTO arp_npl_ch.T_ILI2DB_COLUMN_PROP (tablename,subtype,columnname,tag,setting) VALUES ('geobasisdaten_linienbezogene_festlegung',NULL,'geometrie','ch.ehi.ili2db.c1Min','2460000.000');
INSERT INTO arp_npl_ch.T_ILI2DB_COLUMN_PROP (tablename,subtype,columnname,tag,setting) VALUES ('geobasisdaten_objektbezogene_festlegung',NULL,'geometrie','ch.ehi.ili2db.c2Max','1310000.000');
INSERT INTO arp_npl_ch.T_ILI2DB_COLUMN_PROP (tablename,subtype,columnname,tag,setting) VALUES ('rechtsvorschrften_dokument',NULL,'T_Type','ch.ehi.ili2db.types','["rechtsvorschrften_dokument","rechtsvorschrften_rechtsvorschrift"]');
INSERT INTO arp_npl_ch.T_ILI2DB_COLUMN_PROP (tablename,subtype,columnname,tag,setting) VALUES ('geobasisdaten_linienbezogene_festlegung',NULL,'geometrie','ch.ehi.ili2db.srid','2056');
INSERT INTO arp_npl_ch.T_ILI2DB_COLUMN_PROP (tablename,subtype,columnname,tag,setting) VALUES ('rechtsvorschrften_hinweisweiteredokumente',NULL,'ursprung','ch.ehi.ili2db.foreignKey','rechtsvorschrften_dokument');
INSERT INTO arp_npl_ch.T_ILI2DB_COLUMN_PROP (tablename,subtype,columnname,tag,setting) VALUES ('geobasisdaten_objektbezogene_festlegung',NULL,'typ','ch.ehi.ili2db.foreignKey','geobasisdaten_typ');
INSERT INTO arp_npl_ch.T_ILI2DB_COLUMN_PROP (tablename,subtype,columnname,tag,setting) VALUES ('geobasisdaten_typ_dokument',NULL,'vorschrift','ch.ehi.ili2db.foreignKey','rechtsvorschrften_dokument');
INSERT INTO arp_npl_ch.T_ILI2DB_COLUMN_PROP (tablename,subtype,columnname,tag,setting) VALUES ('geobasisdaten_ueberlagernde_festlegung',NULL,'geometrie','ch.ehi.ili2db.coordDimension','2');
INSERT INTO arp_npl_ch.T_ILI2DB_COLUMN_PROP (tablename,subtype,columnname,tag,setting) VALUES ('localiseduri',NULL,'multilingualuri_localisedtext','ch.ehi.ili2db.foreignKey','multilingualuri');
INSERT INTO arp_npl_ch.T_ILI2DB_COLUMN_PROP (tablename,subtype,columnname,tag,setting) VALUES ('geobasisdaten_typ',NULL,'bemerkungen','ch.ehi.ili2db.textKind','MTEXT');
INSERT INTO arp_npl_ch.T_ILI2DB_COLUMN_PROP (tablename,subtype,columnname,tag,setting) VALUES ('rechtsvorschrften_dokument',NULL,'bemerkungen','ch.ehi.ili2db.textKind','MTEXT');
INSERT INTO arp_npl_ch.T_ILI2DB_COLUMN_PROP (tablename,subtype,columnname,tag,setting) VALUES ('geobasisdaten_typ_kt',NULL,'bemerkungen','ch.ehi.ili2db.textKind','MTEXT');
INSERT INTO arp_npl_ch.T_ILI2DB_COLUMN_PROP (tablename,subtype,columnname,tag,setting) VALUES ('geobasisdaten_objektbezogene_festlegung',NULL,'geometrie','ch.ehi.ili2db.srid','2056');
INSERT INTO arp_npl_ch.T_ILI2DB_COLUMN_PROP (tablename,subtype,columnname,tag,setting) VALUES ('geobasisdaten_ueberlagernde_festlegung',NULL,'bemerkungen','ch.ehi.ili2db.textKind','MTEXT');
INSERT INTO arp_npl_ch.T_ILI2DB_COLUMN_PROP (tablename,subtype,columnname,tag,setting) VALUES ('geobasisdaten_grundnutzung_zonenflaeche',NULL,'geometrie','ch.ehi.ili2db.c2Min','1045000.000');
INSERT INTO arp_npl_ch.T_ILI2DB_COLUMN_PROP (tablename,subtype,columnname,tag,setting) VALUES ('geobasisdaten_objektbezogene_festlegung',NULL,'geometrie','ch.ehi.ili2db.geomType','POINT');
INSERT INTO arp_npl_ch.T_ILI2DB_COLUMN_PROP (tablename,subtype,columnname,tag,setting) VALUES ('geobasisdaten_grundnutzung_zonenflaeche',NULL,'geometrie','ch.ehi.ili2db.geomType','CURVEPOLYGON');
INSERT INTO arp_npl_ch.T_ILI2DB_COLUMN_PROP (tablename,subtype,columnname,tag,setting) VALUES ('geobasisdaten_grundnutzung_zonenflaeche',NULL,'typ','ch.ehi.ili2db.foreignKey','geobasisdaten_typ');
INSERT INTO arp_npl_ch.T_ILI2DB_COLUMN_PROP (tablename,subtype,columnname,tag,setting) VALUES ('geobasisdaten_linienbezogene_festlegung',NULL,'typ','ch.ehi.ili2db.foreignKey','geobasisdaten_typ');
INSERT INTO arp_npl_ch.T_ILI2DB_COLUMN_PROP (tablename,subtype,columnname,tag,setting) VALUES ('geobasisdaten_linienbezogene_festlegung',NULL,'geometrie','ch.ehi.ili2db.geomType','COMPOUNDCURVE');
INSERT INTO arp_npl_ch.T_ILI2DB_COLUMN_PROP (tablename,subtype,columnname,tag,setting) VALUES ('geobasisdaten_linienbezogene_festlegung',NULL,'geometrie','ch.ehi.ili2db.c1Max','2870000.000');
INSERT INTO arp_npl_ch.T_ILI2DB_COLUMN_PROP (tablename,subtype,columnname,tag,setting) VALUES ('geobasisdaten_objektbezogene_festlegung',NULL,'bemerkungen','ch.ehi.ili2db.textKind','MTEXT');
INSERT INTO arp_npl_ch.T_ILI2DB_COLUMN_PROP (tablename,subtype,columnname,tag,setting) VALUES ('geobasisdaten_grundnutzung_zonenflaeche',NULL,'geometrie','ch.ehi.ili2db.c1Min','2460000.000');
INSERT INTO arp_npl_ch.T_ILI2DB_COLUMN_PROP (tablename,subtype,columnname,tag,setting) VALUES ('geobasisdaten_linienbezogene_festlegung',NULL,'geometrie','ch.ehi.ili2db.c2Max','1310000.000');
INSERT INTO arp_npl_ch.T_ILI2DB_COLUMN_PROP (tablename,subtype,columnname,tag,setting) VALUES ('geobasisdaten_linienbezogene_festlegung',NULL,'geometrie','ch.ehi.ili2db.c2Min','1045000.000');
INSERT INTO arp_npl_ch.T_ILI2DB_COLUMN_PROP (tablename,subtype,columnname,tag,setting) VALUES ('geobasisdaten_grundnutzung_zonenflaeche',NULL,'geometrie','ch.ehi.ili2db.c2Max','1310000.000');
INSERT INTO arp_npl_ch.T_ILI2DB_COLUMN_PROP (tablename,subtype,columnname,tag,setting) VALUES ('rechtsvorschrften_hinweisweiteredokumente',NULL,'hinweis','ch.ehi.ili2db.foreignKey','rechtsvorschrften_dokument');
INSERT INTO arp_npl_ch.T_ILI2DB_COLUMN_PROP (tablename,subtype,columnname,tag,setting) VALUES ('geobasisdaten_typ',NULL,'typ_kt','ch.ehi.ili2db.foreignKey','geobasisdaten_typ_kt');
INSERT INTO arp_npl_ch.T_ILI2DB_COLUMN_PROP (tablename,subtype,columnname,tag,setting) VALUES ('transfermetadaten_datenbestand',NULL,'zustaendigestelle','ch.ehi.ili2db.foreignKey','transfermetadaten_amt');
INSERT INTO arp_npl_ch.T_ILI2DB_COLUMN_PROP (tablename,subtype,columnname,tag,setting) VALUES ('geobasisdaten_ueberlagernde_festlegung',NULL,'geometrie','ch.ehi.ili2db.srid','2056');
INSERT INTO arp_npl_ch.T_ILI2DB_COLUMN_PROP (tablename,subtype,columnname,tag,setting) VALUES ('transfermetadaten_datenbestand',NULL,'bemerkungen','ch.ehi.ili2db.textKind','MTEXT');
INSERT INTO arp_npl_ch.T_ILI2DB_COLUMN_PROP (tablename,subtype,columnname,tag,setting) VALUES ('geobasisdaten_objektbezogene_festlegung',NULL,'geometrie','ch.ehi.ili2db.c2Min','1045000.000');
INSERT INTO arp_npl_ch.T_ILI2DB_COLUMN_PROP (tablename,subtype,columnname,tag,setting) VALUES ('geobasisdaten_ueberlagernde_festlegung',NULL,'geometrie','ch.ehi.ili2db.c1Max','2870000.000');
INSERT INTO arp_npl_ch.T_ILI2DB_COLUMN_PROP (tablename,subtype,columnname,tag,setting) VALUES ('geobasisdaten_ueberlagernde_festlegung',NULL,'geometrie','ch.ehi.ili2db.c2Min','1045000.000');
INSERT INTO arp_npl_ch.T_ILI2DB_COLUMN_PROP (tablename,subtype,columnname,tag,setting) VALUES ('geobasisdaten_ueberlagernde_festlegung',NULL,'geometrie','ch.ehi.ili2db.geomType','CURVEPOLYGON');
INSERT INTO arp_npl_ch.T_ILI2DB_COLUMN_PROP (tablename,subtype,columnname,tag,setting) VALUES ('geobasisdaten_grundnutzung_zonenflaeche',NULL,'geometrie','ch.ehi.ili2db.srid','2056');
INSERT INTO arp_npl_ch.T_ILI2DB_COLUMN_PROP (tablename,subtype,columnname,tag,setting) VALUES ('multilingualuri',NULL,'transfermetadaten_amt_amtimweb','ch.ehi.ili2db.foreignKey','transfermetadaten_amt');
INSERT INTO arp_npl_ch.T_ILI2DB_COLUMN_PROP (tablename,subtype,columnname,tag,setting) VALUES ('geobasisdaten_ueberlagernde_festlegung',NULL,'typ','ch.ehi.ili2db.foreignKey','geobasisdaten_typ');
INSERT INTO arp_npl_ch.T_ILI2DB_COLUMN_PROP (tablename,subtype,columnname,tag,setting) VALUES ('geobasisdaten_typ_kt',NULL,'hauptnutzung_ch','ch.ehi.ili2db.foreignKey','hauptnutzung_ch_hauptnutzung_ch');
INSERT INTO arp_npl_ch.T_ILI2DB_COLUMN_PROP (tablename,subtype,columnname,tag,setting) VALUES ('geobasisdaten_typ_dokument',NULL,'typ','ch.ehi.ili2db.foreignKey','geobasisdaten_typ');
INSERT INTO arp_npl_ch.T_ILI2DB_COLUMN_PROP (tablename,subtype,columnname,tag,setting) VALUES ('geobasisdaten_grundnutzung_zonenflaeche',NULL,'geometrie','ch.ehi.ili2db.coordDimension','2');
INSERT INTO arp_npl_ch.T_ILI2DB_COLUMN_PROP (tablename,subtype,columnname,tag,setting) VALUES ('geobasisdaten_objektbezogene_festlegung',NULL,'geometrie','ch.ehi.ili2db.c1Min','2460000.000');
INSERT INTO arp_npl_ch.T_ILI2DB_TABLE_PROP (tablename,tag,setting) VALUES ('localiseduri','ch.ehi.ili2db.tableKind','STRUCTURE');
INSERT INTO arp_npl_ch.T_ILI2DB_TABLE_PROP (tablename,tag,setting) VALUES ('rechtsstatus','ch.ehi.ili2db.tableKind','ENUM');
INSERT INTO arp_npl_ch.T_ILI2DB_TABLE_PROP (tablename,tag,setting) VALUES ('geobasisdaten_typ_dokument','ch.ehi.ili2db.tableKind','ASSOCIATION');
INSERT INTO arp_npl_ch.T_ILI2DB_TABLE_PROP (tablename,tag,setting) VALUES ('multilingualuri','ch.ehi.ili2db.tableKind','STRUCTURE');
INSERT INTO arp_npl_ch.T_ILI2DB_TABLE_PROP (tablename,tag,setting) VALUES ('languagecode_iso639_1','ch.ehi.ili2db.tableKind','ENUM');
INSERT INTO arp_npl_ch.T_ILI2DB_TABLE_PROP (tablename,tag,setting) VALUES ('rechtsvorschrften_hinweisweiteredokumente','ch.ehi.ili2db.tableKind','ASSOCIATION');
INSERT INTO arp_npl_ch.T_ILI2DB_TABLE_PROP (tablename,tag,setting) VALUES ('verbindlichkeit','ch.ehi.ili2db.tableKind','ENUM');
INSERT INTO arp_npl_ch.T_ILI2DB_TABLE_PROP (tablename,tag,setting) VALUES ('chcantoncode','ch.ehi.ili2db.tableKind','ENUM');
INSERT INTO arp_npl_ch.T_ILI2DB_MODEL (filename,iliversion,modelName,content,importDate) VALUES ('CHBase_Part4_ADMINISTRATIVEUNITS_20110830.ili','2.3','CHAdminCodes_V1 AdministrativeUnits_V1{ CHAdminCodes_V1 InternationalCodes_V1 Dictionaries_V1 Localisation_V1 INTERLIS} AdministrativeUnitsCH_V1{ CHAdminCodes_V1 InternationalCodes_V1 LocalisationCH_V1 AdministrativeUnits_V1 INTERLIS}','/* ########################################################################
   CHBASE - BASE MODULES OF THE SWISS FEDERATION FOR MINIMAL GEODATA MODELS
   ======
   BASISMODULE DES BUNDES           MODULES DE BASE DE LA CONFEDERATION
   FÜR MINIMALE GEODATENMODELLE     POUR LES MODELES DE GEODONNEES MINIMAUX
   
   PROVIDER: GKG/KOGIS - GCS/COSIG             CONTACT: models@geo.admin.ch
   PUBLISHED: 2011-08-30
   ########################################################################
*/

INTERLIS 2.3;

/* ########################################################################
   ########################################################################
   PART IV -- ADMINISTRATIVE UNITS
   - Package CHAdminCodes
   - Package AdministrativeUnits
   - Package AdministrativeUnitsCH
*/

!! Version    | Who   | Modification
!!------------------------------------------------------------------------------
!! 2018-02-19 | KOGIS | CHCantonCode adapted (FL and CH added) (line 34)

!! ########################################################################
!!@technicalContact=models@geo.admin.ch
!!@furtherInformation=https://www.geo.admin.ch/de/geoinformation-schweiz/geobasisdaten/geodata-models.html
TYPE MODEL CHAdminCodes_V1 (en)
  AT "http://www.geo.admin.ch" VERSION "2018-02-19" =

  DOMAIN
    CHCantonCode = (ZH,BE,LU,UR,SZ,OW,NW,GL,ZG,FR,SO,BS,BL,SH,AR,AI,SG,
                    GR,AG,TG,TI,VD,VS,NE,GE,JU,FL,CH);

    CHMunicipalityCode = 1..9999;  !! BFS-Nr

END CHAdminCodes_V1.

!! ########################################################################
!!@technicalContact=models@geo.admin.ch
!!@furtherInformation=http://www.geo.admin.ch/internet/geoportal/de/home/topics/geobasedata/models.html
MODEL AdministrativeUnits_V1 (en)
  AT "http://www.geo.admin.ch" VERSION "2011-08-30" =

  IMPORTS UNQUALIFIED INTERLIS;
  IMPORTS UNQUALIFIED CHAdminCodes_V1;
  IMPORTS UNQUALIFIED InternationalCodes_V1;
  IMPORTS Localisation_V1;
  IMPORTS Dictionaries_V1;

  TOPIC AdministrativeUnits (ABSTRACT) =

    CLASS AdministrativeElement (ABSTRACT) =
    END AdministrativeElement;

    CLASS AdministrativeUnit (ABSTRACT) EXTENDS AdministrativeElement =
    END AdministrativeUnit;

    ASSOCIATION Hierarchy =
      UpperLevelUnit (EXTERNAL) -<> {0..1} AdministrativeUnit;
      LowerLevelUnit -- AdministrativeUnit;
    END Hierarchy;

    CLASS AdministrativeUnion (ABSTRACT) EXTENDS AdministrativeElement =
    END AdministrativeUnion;

    ASSOCIATION UnionMembers =
      Union -<> AdministrativeUnion;
      Member -- AdministrativeElement; 
    END UnionMembers;

  END AdministrativeUnits;

  TOPIC Countries EXTENDS AdministrativeUnits =

    CLASS Country EXTENDS AdministrativeUnit =
      Code: MANDATORY CountryCode_ISO3166_1;
    UNIQUE Code;
    END Country;

  END Countries;

  TOPIC CountryNames EXTENDS Dictionaries_V1.Dictionaries =
    DEPENDS ON AdministrativeUnits_V1.Countries;

    STRUCTURE CountryName EXTENDS Entry =
      Code: MANDATORY CountryCode_ISO3166_1;
    END CountryName;
      
    CLASS CountryNamesTranslation EXTENDS Dictionary  =
      Entries(EXTENDED): LIST OF CountryName;
    UNIQUE Entries->Code;
    EXISTENCE CONSTRAINT
      Entries->Code REQUIRED IN AdministrativeUnits_V1.Countries.Country: Code;
    END CountryNamesTranslation;

  END CountryNames;

  TOPIC Agencies (ABSTRACT) =
    DEPENDS ON AdministrativeUnits_V1.AdministrativeUnits;

    CLASS Agency (ABSTRACT) =
    END Agency;

    ASSOCIATION Authority =
      Supervisor (EXTERNAL) -<> {1..1} Agency OR AdministrativeUnits_V1.AdministrativeUnits.AdministrativeElement;
      Agency -- Agency;
    END Authority;

    ASSOCIATION Organisation =
      Orderer (EXTERNAL) -- Agency OR AdministrativeUnits_V1.AdministrativeUnits.AdministrativeElement;
      Executor -- Agency;
    END Organisation;

  END Agencies;

END AdministrativeUnits_V1.

!! ########################################################################
!!@technicalContact=models@geo.admin.ch
!!@furtherInformation=http://www.geo.admin.ch/internet/geoportal/de/home/topics/geobasedata/models.html
MODEL AdministrativeUnitsCH_V1 (en)
  AT "http://www.geo.admin.ch" VERSION "2011-08-30" =

  IMPORTS UNQUALIFIED INTERLIS;
  IMPORTS UNQUALIFIED CHAdminCodes_V1;
  IMPORTS UNQUALIFIED InternationalCodes_V1;
  IMPORTS LocalisationCH_V1;
  IMPORTS AdministrativeUnits_V1;

  TOPIC CHCantons EXTENDS AdministrativeUnits_V1.AdministrativeUnits =
    DEPENDS ON AdministrativeUnits_V1.Countries;

    CLASS CHCanton EXTENDS AdministrativeUnit =
      Code: MANDATORY CHCantonCode;
      Name: LocalisationCH_V1.MultilingualText;
      Web: URI;
    UNIQUE Code;
    END CHCanton;

    ASSOCIATION Hierarchy (EXTENDED) =
      UpperLevelUnit (EXTENDED, EXTERNAL) -<> {1..1} AdministrativeUnits_V1.Countries.Country;
      LowerLevelUnit (EXTENDED) -- CHCanton;
    MANDATORY CONSTRAINT
      UpperLevelUnit->Code == "CHE";
    END Hierarchy;

  END CHCantons;

  TOPIC CHDistricts EXTENDS AdministrativeUnits_V1.AdministrativeUnits =
    DEPENDS ON AdministrativeUnitsCH_V1.CHCantons;

    CLASS CHDistrict EXTENDS AdministrativeUnit =
      ShortName: MANDATORY TEXT*20;
      Name: LocalisationCH_V1.MultilingualText;
      Web: MANDATORY URI;
    END CHDistrict;

    ASSOCIATION Hierarchy (EXTENDED) =
      UpperLevelUnit (EXTENDED, EXTERNAL) -<> {1..1} AdministrativeUnitsCH_V1.CHCantons.CHCanton;
      LowerLevelUnit (EXTENDED) -- CHDistrict;
    UNIQUE UpperLevelUnit->Code, LowerLevelUnit->ShortName;
    END Hierarchy;

  END CHDistricts;

  TOPIC CHMunicipalities EXTENDS AdministrativeUnits_V1.AdministrativeUnits =
    DEPENDS ON AdministrativeUnitsCH_V1.CHCantons;
    DEPENDS ON AdministrativeUnitsCH_V1.CHDistricts;

    CLASS CHMunicipality EXTENDS AdministrativeUnit =
      Code: MANDATORY CHMunicipalityCode;
      Name: LocalisationCH_V1.MultilingualText;
      Web: URI;
    UNIQUE Code;
    END CHMunicipality;

    ASSOCIATION Hierarchy (EXTENDED) =
      UpperLevelUnit (EXTENDED, EXTERNAL) -<> {1..1} AdministrativeUnitsCH_V1.CHCantons.CHCanton
      OR AdministrativeUnitsCH_V1.CHDistricts.CHDistrict;
      LowerLevelUnit (EXTENDED) -- CHMunicipality;
    END Hierarchy;

  END CHMunicipalities;

  TOPIC CHAdministrativeUnions EXTENDS AdministrativeUnits_V1.AdministrativeUnits =
    DEPENDS ON AdministrativeUnits_V1.Countries;
    DEPENDS ON AdministrativeUnitsCH_V1.CHCantons;
    DEPENDS ON AdministrativeUnitsCH_V1.CHDistricts;
    DEPENDS ON AdministrativeUnitsCH_V1.CHMunicipalities;

    CLASS AdministrativeUnion (EXTENDED) =
    OID AS UUIDOID;
      Name: LocalisationCH_V1.MultilingualText;
      Web: URI;
      Description: LocalisationCH_V1.MultilingualMText;
    END AdministrativeUnion;

  END CHAdministrativeUnions;

  TOPIC CHAgencies EXTENDS AdministrativeUnits_V1.Agencies =
    DEPENDS ON AdministrativeUnits_V1.Countries;
    DEPENDS ON AdministrativeUnitsCH_V1.CHCantons;
    DEPENDS ON AdministrativeUnitsCH_V1.CHDistricts;
    DEPENDS ON AdministrativeUnitsCH_V1.CHMunicipalities;

    CLASS Agency (EXTENDED) =
    OID AS UUIDOID;
      Name: LocalisationCH_V1.MultilingualText;
      Web: URI;
      Description: LocalisationCH_V1.MultilingualMText;
    END Agency;

  END CHAgencies;

END AdministrativeUnitsCH_V1.

!! ########################################################################
','2019-08-12 10:37:35.52');
INSERT INTO arp_npl_ch.T_ILI2DB_MODEL (filename,iliversion,modelName,content,importDate) VALUES ('Units-20120220.ili','2.3','Units','!! File Units.ili Release 2012-02-20

INTERLIS 2.3;

!! 2012-02-20 definition of "Bar [bar]" corrected
!!@precursorVersion = 2005-06-06

CONTRACTED TYPE MODEL Units (en) AT "http://www.interlis.ch/models"
  VERSION "2012-02-20" =

  UNIT
    !! abstract Units
    Area (ABSTRACT) = (INTERLIS.LENGTH*INTERLIS.LENGTH);
    Volume (ABSTRACT) = (INTERLIS.LENGTH*INTERLIS.LENGTH*INTERLIS.LENGTH);
    Velocity (ABSTRACT) = (INTERLIS.LENGTH/INTERLIS.TIME);
    Acceleration (ABSTRACT) = (Velocity/INTERLIS.TIME);
    Force (ABSTRACT) = (INTERLIS.MASS*INTERLIS.LENGTH/INTERLIS.TIME/INTERLIS.TIME);
    Pressure (ABSTRACT) = (Force/Area);
    Energy (ABSTRACT) = (Force*INTERLIS.LENGTH);
    Power (ABSTRACT) = (Energy/INTERLIS.TIME);
    Electric_Potential (ABSTRACT) = (Power/INTERLIS.ELECTRIC_CURRENT);
    Frequency (ABSTRACT) = (INTERLIS.DIMENSIONLESS/INTERLIS.TIME);

    Millimeter [mm] = 0.001 [INTERLIS.m];
    Centimeter [cm] = 0.01 [INTERLIS.m];
    Decimeter [dm] = 0.1 [INTERLIS.m];
    Kilometer [km] = 1000 [INTERLIS.m];

    Square_Meter [m2] EXTENDS Area = (INTERLIS.m*INTERLIS.m);
    Cubic_Meter [m3] EXTENDS Volume = (INTERLIS.m*INTERLIS.m*INTERLIS.m);

    Minute [min] = 60 [INTERLIS.s];
    Hour [h] = 60 [min];
    Day [d] = 24 [h];

    Kilometer_per_Hour [kmh] EXTENDS Velocity = (km/h);
    Meter_per_Second [ms] = 3.6 [kmh];
    Newton [N] EXTENDS Force = (INTERLIS.kg*INTERLIS.m/INTERLIS.s/INTERLIS.s);
    Pascal [Pa] EXTENDS Pressure = (N/m2);
    Joule [J] EXTENDS Energy = (N*INTERLIS.m);
    Watt [W] EXTENDS Power = (J/INTERLIS.s);
    Volt [V] EXTENDS Electric_Potential = (W/INTERLIS.A);

    Inch [in] = 2.54 [cm];
    Foot [ft] = 0.3048 [INTERLIS.m];
    Mile [mi] = 1.609344 [km];

    Are [a] = 100 [m2];
    Hectare [ha] = 100 [a];
    Square_Kilometer [km2] = 100 [ha];
    Acre [acre] = 4046.873 [m2];

    Liter [L] = 1 / 1000 [m3];
    US_Gallon [USgal] = 3.785412 [L];

    Angle_Degree = 180 / PI [INTERLIS.rad];
    Angle_Minute = 1 / 60 [Angle_Degree];
    Angle_Second = 1 / 60 [Angle_Minute];

    Gon = 200 / PI [INTERLIS.rad];

    Gram [g] = 1 / 1000 [INTERLIS.kg];
    Ton [t] = 1000 [INTERLIS.kg];
    Pound [lb] = 0.4535924 [INTERLIS.kg];

    Calorie [cal] = 4.1868 [J];
    Kilowatt_Hour [kWh] = 0.36E7 [J];

    Horsepower = 746 [W];

    Techn_Atmosphere [at] = 98066.5 [Pa];
    Atmosphere [atm] = 101325 [Pa];
    Bar [bar] = 100000 [Pa];
    Millimeter_Mercury [mmHg] = 133.3224 [Pa];
    Torr = 133.3224 [Pa]; !! Torr = [mmHg]

    Decibel [dB] = FUNCTION // 10**(dB/20) * 0.00002 // [Pa];

    Degree_Celsius [oC] = FUNCTION // oC+273.15 // [INTERLIS.K];
    Degree_Fahrenheit [oF] = FUNCTION // (oF+459.67)/1.8 // [INTERLIS.K];

    CountedObjects EXTENDS INTERLIS.DIMENSIONLESS;

    Hertz [Hz] EXTENDS Frequency = (CountedObjects/INTERLIS.s);
    KiloHertz [KHz] = 1000 [Hz];
    MegaHertz [MHz] = 1000 [KHz];

    Percent = 0.01 [CountedObjects];
    Permille = 0.001 [CountedObjects];

    !! ISO 4217 Currency Abbreviation
    USDollar [USD] EXTENDS INTERLIS.MONEY;
    Euro [EUR] EXTENDS INTERLIS.MONEY;
    SwissFrancs [CHF] EXTENDS INTERLIS.MONEY;

END Units.

','2019-08-12 10:37:35.52');
INSERT INTO arp_npl_ch.T_ILI2DB_MODEL (filename,iliversion,modelName,content,importDate) VALUES ('Nutzungsplanung_V1_1.ili','2.3','Nutzungsplanung_Hauptnutzung_V1_1 Nutzungsplanung_LV03_V1_1{ CHAdminCodes_V1 InternationalCodes_V1 GeometryCHLV03_V1 Nutzungsplanung_Hauptnutzung_V1_1} Nutzungsplanung_LV95_V1_1{ GeometryCHLV95_V1 CHAdminCodes_V1 InternationalCodes_V1 Nutzungsplanung_Hauptnutzung_V1_1}','INTERLIS 2.3;

/** Minimales Geodatenmodell
 *  Nutzungsplanung (kantonal / kommunal)
 *  Geobasisdatensatz Nr. 73
 */

!! Version    | Who   | Modification
!!------------------------------------------------------------------------------
!! 2018-12-17 | KOGIS | OID-Definition angepasst (TypID)
!!------------------------------------------------------------------------------
!! 2017-02-16 | ARE   | Version 1.1
!!                    | (Folge des geänderten ÖREB-Rahmenmodells V1.1 vom 20.08.2016)
!!                    | - MODEL Nutzungsplanung_Hauptnutzung_V1_1:
!!                    |   eigenes Modell mit Klasse Hauptnutzung_CH, damit Katalogfile
!!                    |   Hauptnutzung_CH.xml für LV03 und LV95 nur einmal definiert werden muss
!!                    | - MODEL Nutzungsplanung_LV03_V1_1: Bezugsrahmen LV03
!!                    | - MODEL Nutzungsplanung_LV95_V1_1: Bezugsrahmen LV95
!!                    | - STRUCTURE LocalisedUri: neue Struktur für mehrsprachige URI
!!                    | - STRUCTURE MultilingualUri: neue Struktur für mehrsprachige URI
!!                    | - CLASS Hauptnutzung_CH: neu mit OID
!!                    | - CLASS Dokument: Attribut TextImWeb neu vom Typ MultilingualUri
!!                    | - CLASS Typ: neues Attribut Symbol
!!                    | - CLASS Amt: neues Attribut UID
!!                    | - CLASS Amt: Attribut TextImWeb neu vom Typ MultilingualUri
!!                    | - CLASS Datenbestand: neues Attribut BasketID
!!------------------------------------------------------------------------------
!! 2016-04-15 | KOGIS | Geometriedefinitionen angepasst
!!                    | - DOMAIN Einzelflaeche
!!                    | - DOMAIN Gebietseinteilung
!!------------------------------------------------------------------------------
!! 2011-12-12 | ARE   | Version 1.0
!!------------------------------------------------------------------------------

!!@ technicalContact=mailto:info@are.admin.ch
!!@ furtherInformation=https://www.are.admin.ch/mgm
!!@ IDGeoIV=73
MODEL Nutzungsplanung_Hauptnutzung_V1_1 (de)
AT "http://models.geo.admin.ch/ARE"
VERSION "2018-12-17"  =

  DOMAIN

    TypID = OID TEXT*60;

  TOPIC Hauptnutzung_CH =

    CLASS Hauptnutzung_CH (FINAL) =
      OID AS TypID;
      Code : MANDATORY 11 .. 99;
      Bezeichnung : MANDATORY TEXT*80;
    END Hauptnutzung_CH;

  END Hauptnutzung_CH;

END Nutzungsplanung_Hauptnutzung_V1_1.


!!@ technicalContact=mailto:info@are.admin.ch
!!@ furtherInformation=https://www.are.admin.ch/mgm
!!@ IDGeoIV=73
MODEL Nutzungsplanung_LV03_V1_1 (de)
AT "http://models.geo.admin.ch/ARE"
VERSION "2017-02-16"  =
  IMPORTS CHAdminCodes_V1,GeometryCHLV03_V1,InternationalCodes_V1,Nutzungsplanung_Hauptnutzung_V1_1;

  DOMAIN

    Einzelflaeche = SURFACE WITH (ARCS,STRAIGHTS) VERTEX GeometryCHLV03_V1.Coord2 WITHOUT OVERLAPS>0.05;

    Gebietseinteilung = AREA WITH (ARCS,STRAIGHTS) VERTEX GeometryCHLV03_V1.Coord2 WITHOUT OVERLAPS>0.05;

    Rechtsstatus = (
      inKraft,
      laufendeAenderung
    );

    Verbindlichkeit = (
      Nutzungsplanfestlegung,
      orientierend,
      hinweisend,
      wegleitend
    );

  STRUCTURE LocalisedUri =
    Language : InternationalCodes_V1.LanguageCode_ISO639_1;
    Text : MANDATORY URI;
  END LocalisedUri;

  STRUCTURE MultilingualUri =
    LocalisedText : BAG {1..*} OF Nutzungsplanung_LV03_V1_1.LocalisedUri;
    UNIQUE (LOCAL) LocalisedText: Language;
  END MultilingualUri;

  TOPIC Rechtsvorschriften =

    CLASS Dokument =
      Titel : MANDATORY TEXT*80;
      OffiziellerTitel : TEXT;
      Abkuerzung : TEXT*12;
      OffizielleNr : TEXT*20;
      Kanton : CHAdminCodes_V1.CHCantonCode;
      Gemeinde : CHAdminCodes_V1.CHMunicipalityCode;
      publiziertAb : MANDATORY INTERLIS.XMLDate;
      Rechtsstatus : MANDATORY Nutzungsplanung_LV03_V1_1.Rechtsstatus;
      TextImWeb : Nutzungsplanung_LV03_V1_1.MultilingualUri;
      Bemerkungen : MTEXT;
    END Dokument;

    CLASS Rechtsvorschrift
    EXTENDS Dokument =
    END Rechtsvorschrift;

    ASSOCIATION HinweisWeitereDokumente =
      Ursprung -- {0..*} Dokument;
      Hinweis -- {0..*} Dokument;
    END HinweisWeitereDokumente;

  END Rechtsvorschriften;

  TOPIC Geobasisdaten =
    DEPENDS ON Nutzungsplanung_LV03_V1_1.Rechtsvorschriften,Nutzungsplanung_Hauptnutzung_V1_1.Hauptnutzung_CH;

    CLASS Geometrie (ABSTRACT) =
      publiziertAb : MANDATORY INTERLIS.XMLDate;
      Rechtsstatus : MANDATORY Nutzungsplanung_LV03_V1_1.Rechtsstatus;
      Bemerkungen : MTEXT;
    END Geometrie;

    CLASS Typ =
      Code : MANDATORY TEXT*12;
      Bezeichnung : MANDATORY TEXT*80;
      Abkuerzung : TEXT*12;
      Verbindlichkeit : MANDATORY Nutzungsplanung_LV03_V1_1.Verbindlichkeit;
      Nutzungsziffer : 0.00 .. 9.00;
      Nutzungsziffer_Art : TEXT*40;
      Bemerkungen : MTEXT;
      Symbol : BLACKBOX BINARY;
    END Typ;

    CLASS Typ_Kt =
      Code : MANDATORY TEXT*12;
      Bezeichnung : MANDATORY TEXT*80;
      Abkuerzung : TEXT*12;
      Bemerkungen : MTEXT;
    END Typ_Kt;

    CLASS Grundnutzung_Zonenflaeche
    EXTENDS Geometrie =
      Geometrie : MANDATORY Nutzungsplanung_LV03_V1_1.Gebietseinteilung;
    END Grundnutzung_Zonenflaeche;

    CLASS Linienbezogene_Festlegung
    EXTENDS Geometrie =
      Geometrie : MANDATORY GeometryCHLV03_V1.Line;
    END Linienbezogene_Festlegung;

    CLASS Objektbezogene_Festlegung
    EXTENDS Geometrie =
      Geometrie : MANDATORY GeometryCHLV03_V1.Coord2;
    END Objektbezogene_Festlegung;

    CLASS Ueberlagernde_Festlegung
    EXTENDS Geometrie =
      Geometrie : MANDATORY Nutzungsplanung_LV03_V1_1.Einzelflaeche;
    END Ueberlagernde_Festlegung;

    ASSOCIATION Typ_Dokument =
      Typ -- {0..*} Typ;
      Vorschrift (EXTERNAL) -- {0..*} Nutzungsplanung_LV03_V1_1.Rechtsvorschriften.Dokument;
    END Typ_Dokument;

    ASSOCIATION Typ_Geometrie =
      Geometrie -- {0..*} Geometrie;
      Typ -<> {1} Typ;
    END Typ_Geometrie;

    ASSOCIATION Typ_Typ_Kt =
      Typ -- {0..*} Typ;
      Typ_Kt (EXTERNAL) -<> {1} Typ_Kt;
    END Typ_Typ_Kt;

    ASSOCIATION TypKt_HauptnCH =
      Typ_Kt -- {0..*} Typ_Kt;
      Hauptnutzung_CH (EXTERNAL) -- {1} Nutzungsplanung_Hauptnutzung_V1_1.Hauptnutzung_CH.Hauptnutzung_CH;
    END TypKt_HauptnCH;

  END Geobasisdaten;

  TOPIC TransferMetadaten =
    DEPENDS ON Nutzungsplanung_LV03_V1_1.Geobasisdaten;

    CLASS Amt =
      Name : MANDATORY TEXT*80;
      AmtImWeb : Nutzungsplanung_LV03_V1_1.MultilingualUri;
      UID : TEXT*12;
    END Amt;

    CLASS Datenbestand =
      BasketID : MANDATORY TEXT*20;
      Stand : MANDATORY INTERLIS.XMLDate;
      Lieferdatum : INTERLIS.XMLDate;
      Bemerkungen : MTEXT;
    END Datenbestand;

    ASSOCIATION zustStelle_Daten =
      zustaendigeStelle -<> {1} Amt;
      Datenbestand -- {0..*} Datenbestand;
    END zustStelle_Daten;

  END TransferMetadaten;

END Nutzungsplanung_LV03_V1_1.

!!@ technicalContact=mailto:info@are.admin.ch
!!@ furtherInformation=https://www.are.admin.ch/mgm
!!@ IDGeoIV=73
MODEL Nutzungsplanung_LV95_V1_1 (de)
AT "http://models.geo.admin.ch/ARE"
VERSION "2017-02-16"  =
  IMPORTS CHAdminCodes_V1,GeometryCHLV95_V1,InternationalCodes_V1,Nutzungsplanung_Hauptnutzung_V1_1;

  DOMAIN

    Einzelflaeche = SURFACE WITH (ARCS,STRAIGHTS) VERTEX GeometryCHLV95_V1.Coord2 WITHOUT OVERLAPS>0.05;

    Gebietseinteilung = AREA WITH (ARCS,STRAIGHTS) VERTEX GeometryCHLV95_V1.Coord2 WITHOUT OVERLAPS>0.05;

    Rechtsstatus = (
      inKraft,
      laufendeAenderung
    );

    Verbindlichkeit = (
      Nutzungsplanfestlegung,
      orientierend,
      hinweisend,
      wegleitend
    );

  STRUCTURE LocalisedUri =
    Language : InternationalCodes_V1.LanguageCode_ISO639_1;
    Text : MANDATORY URI;
  END LocalisedUri;

  STRUCTURE MultilingualUri =
    LocalisedText : BAG {1..*} OF Nutzungsplanung_LV95_V1_1.LocalisedUri;
    UNIQUE (LOCAL) LocalisedText: Language;
  END MultilingualUri;

  TOPIC Rechtsvorschriften =

    CLASS Dokument =
      Titel : MANDATORY TEXT*80;
      OffiziellerTitel : TEXT;
      Abkuerzung : TEXT*12;
      OffizielleNr : TEXT*20;
      Kanton : CHAdminCodes_V1.CHCantonCode;
      Gemeinde : CHAdminCodes_V1.CHMunicipalityCode;
      publiziertAb : MANDATORY INTERLIS.XMLDate;
      Rechtsstatus : MANDATORY Nutzungsplanung_LV95_V1_1.Rechtsstatus;
      TextImWeb : Nutzungsplanung_LV95_V1_1.MultilingualUri;
      Bemerkungen : MTEXT;
    END Dokument;

    CLASS Rechtsvorschrift
    EXTENDS Dokument =
    END Rechtsvorschrift;

    ASSOCIATION HinweisWeitereDokumente =
      Ursprung -- {0..*} Dokument;
      Hinweis -- {0..*} Dokument;
    END HinweisWeitereDokumente;

  END Rechtsvorschriften;

  TOPIC Geobasisdaten =
    DEPENDS ON Nutzungsplanung_LV95_V1_1.Rechtsvorschriften,Nutzungsplanung_Hauptnutzung_V1_1.Hauptnutzung_CH;

    CLASS Geometrie (ABSTRACT) =
      publiziertAb : MANDATORY INTERLIS.XMLDate;
      Rechtsstatus : MANDATORY Nutzungsplanung_LV95_V1_1.Rechtsstatus;
      Bemerkungen : MTEXT;
    END Geometrie;

    CLASS Typ =
      Code : MANDATORY TEXT*12;
      Bezeichnung : MANDATORY TEXT*80;
      Abkuerzung : TEXT*12;
      Verbindlichkeit : MANDATORY Nutzungsplanung_LV95_V1_1.Verbindlichkeit;
      Nutzungsziffer : 0.00 .. 9.00;
      Nutzungsziffer_Art : TEXT*40;
      Bemerkungen : MTEXT;
      Symbol : BLACKBOX BINARY;
    END Typ;

    CLASS Typ_Kt =
      Code : MANDATORY TEXT*12;
      Bezeichnung : MANDATORY TEXT*80;
      Abkuerzung : TEXT*12;
      Bemerkungen : MTEXT;
    END Typ_Kt;

    CLASS Grundnutzung_Zonenflaeche
    EXTENDS Geometrie =
      Geometrie : MANDATORY Nutzungsplanung_LV95_V1_1.Gebietseinteilung;
    END Grundnutzung_Zonenflaeche;

    CLASS Linienbezogene_Festlegung
    EXTENDS Geometrie =
      Geometrie : MANDATORY GeometryCHLV95_V1.Line;
    END Linienbezogene_Festlegung;

    CLASS Objektbezogene_Festlegung
    EXTENDS Geometrie =
      Geometrie : MANDATORY GeometryCHLV95_V1.Coord2;
    END Objektbezogene_Festlegung;

    CLASS Ueberlagernde_Festlegung
    EXTENDS Geometrie =
      Geometrie : MANDATORY Nutzungsplanung_LV95_V1_1.Einzelflaeche;
    END Ueberlagernde_Festlegung;

    ASSOCIATION Typ_Dokument =
      Typ -- {0..*} Typ;
      Vorschrift (EXTERNAL) -- {0..*} Nutzungsplanung_LV95_V1_1.Rechtsvorschriften.Dokument;
    END Typ_Dokument;

    ASSOCIATION Typ_Geometrie =
      Geometrie -- {0..*} Geometrie;
      Typ -<> {1} Typ;
    END Typ_Geometrie;

    ASSOCIATION Typ_Typ_Kt =
      Typ -- {0..*} Typ;
      Typ_Kt (EXTERNAL) -<> {1} Typ_Kt;
    END Typ_Typ_Kt;

    ASSOCIATION TypKt_HauptnCH =
      Typ_Kt -- {0..*} Typ_Kt;
      Hauptnutzung_CH (EXTERNAL) -- {1} Nutzungsplanung_Hauptnutzung_V1_1.Hauptnutzung_CH.Hauptnutzung_CH;
    END TypKt_HauptnCH;

  END Geobasisdaten;

  TOPIC TransferMetadaten =
    DEPENDS ON Nutzungsplanung_LV95_V1_1.Geobasisdaten;

    CLASS Amt =
      Name : MANDATORY TEXT*80;
      AmtImWeb : Nutzungsplanung_LV95_V1_1.MultilingualUri;
      UID : TEXT*12;
    END Amt;

    CLASS Datenbestand =
      BasketID : MANDATORY TEXT*20;
      Stand : MANDATORY INTERLIS.XMLDate;
      Lieferdatum : INTERLIS.XMLDate;
      Bemerkungen : MTEXT;
    END Datenbestand;

    ASSOCIATION zustStelle_Daten =
      zustaendigeStelle -<> {1} Amt;
      Datenbestand -- {0..*} Datenbestand;
    END zustStelle_Daten;

  END TransferMetadaten;

END Nutzungsplanung_LV95_V1_1.
','2019-08-12 10:37:35.52');
INSERT INTO arp_npl_ch.T_ILI2DB_MODEL (filename,iliversion,modelName,content,importDate) VALUES ('CHBase_Part2_LOCALISATION_20110830.ili','2.3','InternationalCodes_V1 Localisation_V1{ InternationalCodes_V1} LocalisationCH_V1{ InternationalCodes_V1 Localisation_V1} Dictionaries_V1{ InternationalCodes_V1} DictionariesCH_V1{ InternationalCodes_V1 Dictionaries_V1}','/* ########################################################################
   CHBASE - BASE MODULES OF THE SWISS FEDERATION FOR MINIMAL GEODATA MODELS
   ======
   BASISMODULE DES BUNDES           MODULES DE BASE DE LA CONFEDERATION
   FÜR MINIMALE GEODATENMODELLE     POUR LES MODELES DE GEODONNEES MINIMAUX
   
   PROVIDER: GKG/KOGIS - GCS/COSIG             CONTACT: models@geo.admin.ch
   PUBLISHED: 2011-08-30
   ########################################################################
*/

INTERLIS 2.3;

/* ########################################################################
   ########################################################################
   PART II -- LOCALISATION
   - Package InternationalCodes
   - Packages Localisation, LocalisationCH
   - Packages Dictionaries, DictionariesCH
*/

!! ########################################################################
!!@technicalContact=models@geo.admin.ch
!!@furtherInformation=http://www.geo.admin.ch/internet/geoportal/de/home/topics/geobasedata/models.html
TYPE MODEL InternationalCodes_V1 (en)
  AT "http://www.geo.admin.ch" VERSION "2011-08-30" =

  DOMAIN
    LanguageCode_ISO639_1 = (de,fr,it,rm,en,
      aa,ab,af,am,ar,as,ay,az,ba,be,bg,bh,bi,bn,bo,br,ca,co,cs,cy,da,dz,el,
      eo,es,et,eu,fa,fi,fj,fo,fy,ga,gd,gl,gn,gu,ha,he,hi,hr,hu,hy,ia,id,ie,
      ik,is,iu,ja,jw,ka,kk,kl,km,kn,ko,ks,ku,ky,la,ln,lo,lt,lv,mg,mi,mk,ml,
      mn,mo,mr,ms,mt,my,na,ne,nl,no,oc,om,or,pa,pl,ps,pt,qu,rn,ro,ru,rw,sa,
      sd,sg,sh,si,sk,sl,sm,sn,so,sq,sr,ss,st,su,sv,sw,ta,te,tg,th,ti,tk,tl,
      tn,to,tr,ts,tt,tw,ug,uk,ur,uz,vi,vo,wo,xh,yi,yo,za,zh,zu);

    CountryCode_ISO3166_1 = (CHE,
      ABW,AFG,AGO,AIA,ALA,ALB,AND_,ANT,ARE,ARG,ARM,ASM,ATA,ATF,ATG,AUS,
      AUT,AZE,BDI,BEL,BEN,BFA,BGD,BGR,BHR,BHS,BIH,BLR,BLZ,BMU,BOL,BRA,
      BRB,BRN,BTN,BVT,BWA,CAF,CAN,CCK,CHL,CHN,CIV,CMR,COD,COG,COK,COL,
      COM,CPV,CRI,CUB,CXR,CYM,CYP,CZE,DEU,DJI,DMA,DNK,DOM,DZA,ECU,EGY,
      ERI,ESH,ESP,EST,ETH,FIN,FJI,FLK,FRA,FRO,FSM,GAB,GBR,GEO,GGY,GHA,
      GIB,GIN,GLP,GMB,GNB,GNQ,GRC,GRD,GRL,GTM,GUF,GUM,GUY,HKG,HMD,HND,
      HRV,HTI,HUN,IDN,IMN,IND,IOT,IRL,IRN,IRQ,ISL,ISR,ITA,JAM,JEY,JOR,
      JPN,KAZ,KEN,KGZ,KHM,KIR,KNA,KOR,KWT,LAO,LBN,LBR,LBY,LCA,LIE,LKA,
      LSO,LTU,LUX,LVA,MAC,MAR,MCO,MDA,MDG,MDV,MEX,MHL,MKD,MLI,MLT,MMR,
      MNE,MNG,MNP,MOZ,MRT,MSR,MTQ,MUS,MWI,MYS,MYT,NAM,NCL,NER,NFK,NGA,
      NIC,NIU,NLD,NOR,NPL,NRU,NZL,OMN,PAK,PAN,PCN,PER,PHL,PLW,PNG,POL,
      PRI,PRK,PRT,PRY,PSE,PYF,QAT,REU,ROU,RUS,RWA,SAU,SDN,SEN,SGP,SGS,
      SHN,SJM,SLB,SLE,SLV,SMR,SOM,SPM,SRB,STP,SUR,SVK,SVN,SWE,SWZ,SYC,
      SYR,TCA,TCD,TGO,THA,TJK,TKL,TKM,TLS,TON,TTO,TUN,TUR,TUV,TWN,TZA,
      UGA,UKR,UMI,URY,USA,UZB,VAT,VCT,VEN,VGB,VIR,VNM,VUT,WLF,WSM,YEM,
      ZAF,ZMB,ZWE);

END InternationalCodes_V1.

!! ########################################################################
!!@technicalContact=models@geo.admin.ch
!!@furtherInformation=http://www.geo.admin.ch/internet/geoportal/de/home/topics/geobasedata/models.html
TYPE MODEL Localisation_V1 (en)
  AT "http://www.geo.admin.ch" VERSION "2011-08-30" =

  IMPORTS UNQUALIFIED InternationalCodes_V1;

  STRUCTURE LocalisedText =
    Language: LanguageCode_ISO639_1;
    Text: MANDATORY TEXT;
  END LocalisedText;
  
  STRUCTURE LocalisedMText =
    Language: LanguageCode_ISO639_1;
    Text: MANDATORY MTEXT;
  END LocalisedMText;

  STRUCTURE MultilingualText =
    LocalisedText : BAG {1..*} OF LocalisedText;
    UNIQUE (LOCAL) LocalisedText:Language;
  END MultilingualText;  
  
  STRUCTURE MultilingualMText =
    LocalisedText : BAG {1..*} OF LocalisedMText;
    UNIQUE (LOCAL) LocalisedText:Language;
  END MultilingualMText;

END Localisation_V1.

!! ########################################################################
!!@technicalContact=models@geo.admin.ch
!!@furtherInformation=http://www.geo.admin.ch/internet/geoportal/de/home/topics/geobasedata/models.html
TYPE MODEL LocalisationCH_V1 (en)
  AT "http://www.geo.admin.ch" VERSION "2011-08-30" =

  IMPORTS UNQUALIFIED InternationalCodes_V1;
  IMPORTS Localisation_V1;

  STRUCTURE LocalisedText EXTENDS Localisation_V1.LocalisedText =
  MANDATORY CONSTRAINT
    Language == #de OR
    Language == #fr OR
    Language == #it OR
    Language == #rm OR
    Language == #en;
  END LocalisedText;
  
  STRUCTURE LocalisedMText EXTENDS Localisation_V1.LocalisedMText =
  MANDATORY CONSTRAINT
    Language == #de OR
    Language == #fr OR
    Language == #it OR
    Language == #rm OR
    Language == #en;
  END LocalisedMText;

  STRUCTURE MultilingualText EXTENDS Localisation_V1.MultilingualText =
    LocalisedText(EXTENDED) : BAG {1..*} OF LocalisedText;
  END MultilingualText;  
  
  STRUCTURE MultilingualMText EXTENDS Localisation_V1.MultilingualMText =
    LocalisedText(EXTENDED) : BAG {1..*} OF LocalisedMText;
  END MultilingualMText;

END LocalisationCH_V1.

!! ########################################################################
!!@technicalContact=models@geo.admin.ch
!!@furtherInformation=http://www.geo.admin.ch/internet/geoportal/de/home/topics/geobasedata/models.html
MODEL Dictionaries_V1 (en)
  AT "http://www.geo.admin.ch" VERSION "2011-08-30" =

  IMPORTS UNQUALIFIED InternationalCodes_V1;

  TOPIC Dictionaries (ABSTRACT) =

    STRUCTURE Entry (ABSTRACT) =
      Text: MANDATORY TEXT;
    END Entry;
      
    CLASS Dictionary =
      Language: MANDATORY LanguageCode_ISO639_1;
      Entries: LIST OF Entry;
    END Dictionary;

  END Dictionaries;

END Dictionaries_V1.

!! ########################################################################
!!@technicalContact=models@geo.admin.ch
!!@furtherInformation=http://www.geo.admin.ch/internet/geoportal/de/home/topics/geobasedata/models.html
MODEL DictionariesCH_V1 (en)
  AT "http://www.geo.admin.ch" VERSION "2011-08-30" =

  IMPORTS UNQUALIFIED InternationalCodes_V1;
  IMPORTS Dictionaries_V1;

  TOPIC Dictionaries (ABSTRACT) EXTENDS Dictionaries_V1.Dictionaries =

    CLASS Dictionary (EXTENDED) =
    MANDATORY CONSTRAINT
      Language == #de OR
      Language == #fr OR
      Language == #it OR
      Language == #rm OR
      Language == #en;
    END Dictionary;

  END Dictionaries;

END DictionariesCH_V1.

!! ########################################################################
','2019-08-12 10:37:35.52');
INSERT INTO arp_npl_ch.T_ILI2DB_MODEL (filename,iliversion,modelName,content,importDate) VALUES ('CoordSys-20151124.ili','2.3','CoordSys','!! File CoordSys.ili Release 2015-11-24

INTERLIS 2.3;

!! 2015-11-24 Cardinalities adapted (line 122, 123, 124, 132, 133, 134, 142, 143,
!!                                   148, 149, 163, 164, 168, 169, 206 and 207)
!!@precursorVersion = 2005-06-16

REFSYSTEM MODEL CoordSys (en) AT "http://www.interlis.ch/models"
  VERSION "2015-11-24" =

  UNIT
    Angle_Degree = 180 / PI [INTERLIS.rad];
    Angle_Minute = 1 / 60 [Angle_Degree];
    Angle_Second = 1 / 60 [Angle_Minute];

  STRUCTURE Angle_DMS_S =
    Degrees: -180 .. 180 CIRCULAR [Angle_Degree];
    CONTINUOUS SUBDIVISION Minutes: 0 .. 59 CIRCULAR [Angle_Minute];
    CONTINUOUS SUBDIVISION Seconds: 0.000 .. 59.999 CIRCULAR [Angle_Second];
  END Angle_DMS_S;

  DOMAIN
    Angle_DMS = FORMAT BASED ON Angle_DMS_S (Degrees ":" Minutes ":" Seconds);
    Angle_DMS_90 EXTENDS Angle_DMS = "-90:00:00.000" .. "90:00:00.000";


  TOPIC CoordsysTopic =

    !! Special space aspects to be referenced
    !! **************************************

    CLASS Ellipsoid EXTENDS INTERLIS.REFSYSTEM =
      EllipsoidAlias: TEXT*70;
      SemiMajorAxis: MANDATORY 6360000.0000 .. 6390000.0000 [INTERLIS.m];
      InverseFlattening: MANDATORY 0.00000000 .. 350.00000000;
      !! The inverse flattening 0 characterizes the 2-dim sphere
      Remarks: TEXT*70;
    END Ellipsoid;

    CLASS GravityModel EXTENDS INTERLIS.REFSYSTEM =
      GravityModAlias: TEXT*70;
      Definition: TEXT*70;
    END GravityModel;

    CLASS GeoidModel EXTENDS INTERLIS.REFSYSTEM =
      GeoidModAlias: TEXT*70;
      Definition: TEXT*70;
    END GeoidModel;


    !! Coordinate systems for geodetic purposes
    !! ****************************************

    STRUCTURE LengthAXIS EXTENDS INTERLIS.AXIS =
      ShortName: TEXT*12;
      Description: TEXT*255;
    PARAMETER
      Unit (EXTENDED): NUMERIC [INTERLIS.LENGTH];
    END LengthAXIS;

    STRUCTURE AngleAXIS EXTENDS INTERLIS.AXIS =
      ShortName: TEXT*12;
      Description: TEXT*255;
    PARAMETER
      Unit (EXTENDED): NUMERIC [INTERLIS.ANGLE];
    END AngleAXIS;

    CLASS GeoCartesian1D EXTENDS INTERLIS.COORDSYSTEM =
      Axis (EXTENDED): LIST {1} OF LengthAXIS;
    END GeoCartesian1D;

    CLASS GeoHeight EXTENDS GeoCartesian1D =
      System: MANDATORY (
        normal,
        orthometric,
        ellipsoidal,
        other);
      ReferenceHeight: MANDATORY -10000.000 .. +10000.000 [INTERLIS.m];
      ReferenceHeightDescr: TEXT*70;
    END GeoHeight;

    ASSOCIATION HeightEllips =
      GeoHeightRef -- {*} GeoHeight;
      EllipsoidRef -- {1} Ellipsoid;
    END HeightEllips;

    ASSOCIATION HeightGravit =
      GeoHeightRef -- {*} GeoHeight;
      GravityRef -- {1} GravityModel;
    END HeightGravit;

    ASSOCIATION HeightGeoid =
      GeoHeightRef -- {*} GeoHeight;
      GeoidRef -- {1} GeoidModel;
    END HeightGeoid;

    CLASS GeoCartesian2D EXTENDS INTERLIS.COORDSYSTEM =
      Definition: TEXT*70;
      Axis (EXTENDED): LIST {2} OF LengthAXIS;
    END GeoCartesian2D;

    CLASS GeoCartesian3D EXTENDS INTERLIS.COORDSYSTEM =
      Definition: TEXT*70;
      Axis (EXTENDED): LIST {3} OF LengthAXIS;
    END GeoCartesian3D;

    CLASS GeoEllipsoidal EXTENDS INTERLIS.COORDSYSTEM =
      Definition: TEXT*70;
      Axis (EXTENDED): LIST {2} OF AngleAXIS;
    END GeoEllipsoidal;

    ASSOCIATION EllCSEllips =
      GeoEllipsoidalRef -- {*} GeoEllipsoidal;
      EllipsoidRef -- {1} Ellipsoid;
    END EllCSEllips;


    !! Mappings between coordinate systems
    !! ***********************************

    ASSOCIATION ToGeoEllipsoidal =
      From -- {0..*} GeoCartesian3D;
      To -- {0..*} GeoEllipsoidal;
      ToHeight -- {0..*} GeoHeight;
    MANDATORY CONSTRAINT
      ToHeight -> System == #ellipsoidal;
    MANDATORY CONSTRAINT
      To -> EllipsoidRef -> Name == ToHeight -> EllipsoidRef -> Name;
    END ToGeoEllipsoidal;

    ASSOCIATION ToGeoCartesian3D =
      From2 -- {0..*} GeoEllipsoidal;
      FromHeight-- {0..*} GeoHeight;
      To3 -- {0..*} GeoCartesian3D;
    MANDATORY CONSTRAINT
      FromHeight -> System == #ellipsoidal;
    MANDATORY CONSTRAINT
      From2 -> EllipsoidRef -> Name == FromHeight -> EllipsoidRef -> Name;
    END ToGeoCartesian3D;

    ASSOCIATION BidirectGeoCartesian2D =
      From -- {0..*} GeoCartesian2D;
      To -- {0..*} GeoCartesian2D;
    END BidirectGeoCartesian2D;

    ASSOCIATION BidirectGeoCartesian3D =
      From -- {0..*} GeoCartesian3D;
      To2 -- {0..*} GeoCartesian3D;
      Precision: MANDATORY (
        exact,
        measure_based);
      ShiftAxis1: MANDATORY -10000.000 .. 10000.000 [INTERLIS.m];
      ShiftAxis2: MANDATORY -10000.000 .. 10000.000 [INTERLIS.m];
      ShiftAxis3: MANDATORY -10000.000 .. 10000.000 [INTERLIS.m];
      RotationAxis1: Angle_DMS_90;
      RotationAxis2: Angle_DMS_90;
      RotationAxis3: Angle_DMS_90;
      NewScale: 0.000001 .. 1000000.000000;
    END BidirectGeoCartesian3D;

    ASSOCIATION BidirectGeoEllipsoidal =
      From4 -- {0..*} GeoEllipsoidal;
      To4 -- {0..*} GeoEllipsoidal;
    END BidirectGeoEllipsoidal;

    ASSOCIATION MapProjection (ABSTRACT) =
      From5 -- {0..*} GeoEllipsoidal;
      To5 -- {0..*} GeoCartesian2D;
      FromCo1_FundPt: MANDATORY Angle_DMS_90;
      FromCo2_FundPt: MANDATORY Angle_DMS_90;
      ToCoord1_FundPt: MANDATORY -10000000 .. +10000000 [INTERLIS.m];
      ToCoord2_FundPt: MANDATORY -10000000 .. +10000000 [INTERLIS.m];
    END MapProjection;

    ASSOCIATION TransverseMercator EXTENDS MapProjection =
    END TransverseMercator;

    ASSOCIATION SwissProjection EXTENDS MapProjection =
      IntermFundP1: MANDATORY Angle_DMS_90;
      IntermFundP2: MANDATORY Angle_DMS_90;
    END SwissProjection;

    ASSOCIATION Mercator EXTENDS MapProjection =
    END Mercator;

    ASSOCIATION ObliqueMercator EXTENDS MapProjection =
    END ObliqueMercator;

    ASSOCIATION Lambert EXTENDS MapProjection =
    END Lambert;

    ASSOCIATION Polyconic EXTENDS MapProjection =
    END Polyconic;

    ASSOCIATION Albus EXTENDS MapProjection =
    END Albus;

    ASSOCIATION Azimutal EXTENDS MapProjection =
    END Azimutal;

    ASSOCIATION Stereographic EXTENDS MapProjection =
    END Stereographic;

    ASSOCIATION HeightConversion =
      FromHeight -- {0..*} GeoHeight;
      ToHeight -- {0..*} GeoHeight;
      Definition: TEXT*70;
    END HeightConversion;

  END CoordsysTopic;

END CoordSys.

','2019-08-12 10:37:35.52');
INSERT INTO arp_npl_ch.T_ILI2DB_MODEL (filename,iliversion,modelName,content,importDate) VALUES ('CHBase_Part1_GEOMETRY_20110830.ili','2.3','GeometryCHLV03_V1{ CoordSys Units INTERLIS} GeometryCHLV95_V1{ CoordSys Units INTERLIS}','/* ########################################################################
   CHBASE - BASE MODULES OF THE SWISS FEDERATION FOR MINIMAL GEODATA MODELS
   ======
   BASISMODULE DES BUNDES           MODULES DE BASE DE LA CONFEDERATION
   FÜR MINIMALE GEODATENMODELLE     POUR LES MODELES DE GEODONNEES MINIMAUX
   
   PROVIDER: GKG/KOGIS - GCS/COSIG             CONTACT: models@geo.admin.ch
   PUBLISHED: 2011-0830
   ########################################################################
*/

INTERLIS 2.3;

/* ########################################################################
   ########################################################################
   PART I -- GEOMETRY
   - Package GeometryCHLV03
   - Package GeometryCHLV95
*/

!! ########################################################################

!! Version    | Who   | Modification
!!------------------------------------------------------------------------------
!! 2015-02-20 | KOGIS | WITHOUT OVERLAPS added (line 57, 58, 65 and 66)
!! 2015-11-12 | KOGIS | WITHOUT OVERLAPS corrected (line 57 and 58)
!! 2017-11-27 | KOGIS | Meta-Attributes @furtherInformation adapted and @CRS added (line 31, 44 and 50)
!! 2017-12-04 | KOGIS | Meta-Attribute @CRS corrected

!!@technicalContact=models@geo.admin.ch
!!@furtherInformation=https://www.geo.admin.ch/de/geoinformation-schweiz/geobasisdaten/geodata-models.html
TYPE MODEL GeometryCHLV03_V1 (en)
  AT "http://www.geo.admin.ch" VERSION "2017-12-04" =

  IMPORTS UNQUALIFIED INTERLIS;
  IMPORTS Units;
  IMPORTS CoordSys;

  REFSYSTEM BASKET BCoordSys ~ CoordSys.CoordsysTopic
    OBJECTS OF GeoCartesian2D: CHLV03
    OBJECTS OF GeoHeight: SwissOrthometricAlt;

  DOMAIN
    !!@CRS=EPSG:21781
    Coord2 = COORD
      460000.000 .. 870000.000 [m] {CHLV03[1]},
       45000.000 .. 310000.000 [m] {CHLV03[2]},
      ROTATION 2 -> 1;

    !!@CRS=EPSG:21781
    Coord3 = COORD
      460000.000 .. 870000.000 [m] {CHLV03[1]},
       45000.000 .. 310000.000 [m] {CHLV03[2]},
        -200.000 ..   5000.000 [m] {SwissOrthometricAlt[1]},
      ROTATION 2 -> 1;

    Surface = SURFACE WITH (STRAIGHTS, ARCS) VERTEX Coord2 WITHOUT OVERLAPS > 0.001;
    Area = AREA WITH (STRAIGHTS, ARCS) VERTEX Coord2 WITHOUT OVERLAPS > 0.001;
    Line = POLYLINE WITH (STRAIGHTS, ARCS) VERTEX Coord2;
    DirectedLine EXTENDS Line = DIRECTED POLYLINE;
    LineWithAltitude = POLYLINE WITH (STRAIGHTS, ARCS) VERTEX Coord3;
    DirectedLineWithAltitude = DIRECTED POLYLINE WITH (STRAIGHTS, ARCS) VERTEX Coord3;
    
    /* minimal overlaps only (2mm) */
    SurfaceWithOverlaps2mm = SURFACE WITH (STRAIGHTS, ARCS) VERTEX Coord2 WITHOUT OVERLAPS > 0.002;
    AreaWithOverlaps2mm = AREA WITH (STRAIGHTS, ARCS) VERTEX Coord2 WITHOUT OVERLAPS > 0.002;

    Orientation = 0.00000 .. 359.99999 CIRCULAR [Units.Angle_Degree] <Coord2>;

    Accuracy = (cm, cm50, m, m10, m50, vague);
    Method = (measured, sketched, calculated);

    STRUCTURE LineStructure = 
      Line: Line;
    END LineStructure;

    STRUCTURE DirectedLineStructure =
      Line: DirectedLine;
    END DirectedLineStructure;

    STRUCTURE MultiLine =
      Lines: BAG {1..*} OF LineStructure;
    END MultiLine;

    STRUCTURE MultiDirectedLine =
      Lines: BAG {1..*} OF DirectedLineStructure;
    END MultiDirectedLine;

    STRUCTURE SurfaceStructure =
      Surface: Surface;
    END SurfaceStructure;

    STRUCTURE MultiSurface =
      Surfaces: BAG {1..*} OF SurfaceStructure;
    END MultiSurface;

END GeometryCHLV03_V1.

!! ########################################################################

!! Version    | Who   | Modification
!!------------------------------------------------------------------------------
!! 2015-02-20 | KOGIS | WITHOUT OVERLAPS added (line 135, 136, 143 and 144)
!! 2015-11-12 | KOGIS | WITHOUT OVERLAPS corrected (line 135 and 136)
!! 2017-11-27 | KOGIS | Meta-Attributes @furtherInformation adapted and @CRS added (line 109, 122 and 128)
!! 2017-12-04 | KOGIS | Meta-Attribute @CRS corrected

!!@technicalContact=models@geo.admin.ch
!!@furtherInformation=https://www.geo.admin.ch/de/geoinformation-schweiz/geobasisdaten/geodata-models.html
TYPE MODEL GeometryCHLV95_V1 (en)
  AT "http://www.geo.admin.ch" VERSION "2017-12-04" =

  IMPORTS UNQUALIFIED INTERLIS;
  IMPORTS Units;
  IMPORTS CoordSys;

  REFSYSTEM BASKET BCoordSys ~ CoordSys.CoordsysTopic
    OBJECTS OF GeoCartesian2D: CHLV95
    OBJECTS OF GeoHeight: SwissOrthometricAlt;

  DOMAIN
    !!@CRS=EPSG:2056
    Coord2 = COORD
      2460000.000 .. 2870000.000 [m] {CHLV95[1]},
      1045000.000 .. 1310000.000 [m] {CHLV95[2]},
      ROTATION 2 -> 1;

    !!@CRS=EPSG:2056
    Coord3 = COORD
      2460000.000 .. 2870000.000 [m] {CHLV95[1]},
      1045000.000 .. 1310000.000 [m] {CHLV95[2]},
         -200.000 ..   5000.000 [m] {SwissOrthometricAlt[1]},
      ROTATION 2 -> 1;

    Surface = SURFACE WITH (STRAIGHTS, ARCS) VERTEX Coord2 WITHOUT OVERLAPS > 0.001;
    Area = AREA WITH (STRAIGHTS, ARCS) VERTEX Coord2 WITHOUT OVERLAPS > 0.001;
    Line = POLYLINE WITH (STRAIGHTS, ARCS) VERTEX Coord2;
    DirectedLine EXTENDS Line = DIRECTED POLYLINE;
    LineWithAltitude = POLYLINE WITH (STRAIGHTS, ARCS) VERTEX Coord3;
    DirectedLineWithAltitude = DIRECTED POLYLINE WITH (STRAIGHTS, ARCS) VERTEX Coord3;
    
    /* minimal overlaps only (2mm) */
    SurfaceWithOverlaps2mm = SURFACE WITH (STRAIGHTS, ARCS) VERTEX Coord2 WITHOUT OVERLAPS > 0.002;
    AreaWithOverlaps2mm = AREA WITH (STRAIGHTS, ARCS) VERTEX Coord2 WITHOUT OVERLAPS > 0.002;

    Orientation = 0.00000 .. 359.99999 CIRCULAR [Units.Angle_Degree] <Coord2>;

    Accuracy = (cm, cm50, m, m10, m50, vague);
    Method = (measured, sketched, calculated);

    STRUCTURE LineStructure = 
      Line: Line;
    END LineStructure;

    STRUCTURE DirectedLineStructure =
      Line: DirectedLine;
    END DirectedLineStructure;

    STRUCTURE MultiLine =
      Lines: BAG {1..*} OF LineStructure;
    END MultiLine;

    STRUCTURE MultiDirectedLine =
      Lines: BAG {1..*} OF DirectedLineStructure;
    END MultiDirectedLine;

    STRUCTURE SurfaceStructure =
      Surface: Surface;
    END SurfaceStructure;

    STRUCTURE MultiSurface =
      Surfaces: BAG {1..*} OF SurfaceStructure;
    END MultiSurface;

END GeometryCHLV95_V1.

!! ########################################################################
','2019-08-12 10:37:35.52');
INSERT INTO arp_npl_ch.T_ILI2DB_SETTINGS (tag,setting) VALUES ('ch.ehi.ili2db.createMetaInfo','True');
INSERT INTO arp_npl_ch.T_ILI2DB_SETTINGS (tag,setting) VALUES ('ch.ehi.ili2db.beautifyEnumDispName','underscore');
INSERT INTO arp_npl_ch.T_ILI2DB_SETTINGS (tag,setting) VALUES ('ch.interlis.ili2c.ilidirs','%ILI_FROM_DB;%XTF_DIR;http://models.interlis.ch/;%JAR_DIR');
INSERT INTO arp_npl_ch.T_ILI2DB_SETTINGS (tag,setting) VALUES ('ch.ehi.ili2db.arrayTrafo','coalesce');
INSERT INTO arp_npl_ch.T_ILI2DB_SETTINGS (tag,setting) VALUES ('ch.ehi.ili2db.createForeignKeyIndex','yes');
INSERT INTO arp_npl_ch.T_ILI2DB_SETTINGS (tag,setting) VALUES ('ch.ehi.ili2db.importTabs','simple');
INSERT INTO arp_npl_ch.T_ILI2DB_SETTINGS (tag,setting) VALUES ('ch.ehi.ili2db.nameOptimization','topic');
INSERT INTO arp_npl_ch.T_ILI2DB_SETTINGS (tag,setting) VALUES ('ch.ehi.ili2db.jsonTrafo','coalesce');
INSERT INTO arp_npl_ch.T_ILI2DB_SETTINGS (tag,setting) VALUES ('ch.ehi.ili2db.numericCheckConstraints','create');
INSERT INTO arp_npl_ch.T_ILI2DB_SETTINGS (tag,setting) VALUES ('ch.ehi.ili2db.sender','ili2pg-4.1.0-aa1d00a37ee431852bdee6b990f34b3620f9c1c1');
INSERT INTO arp_npl_ch.T_ILI2DB_SETTINGS (tag,setting) VALUES ('ch.ehi.ili2db.createForeignKey','yes');
INSERT INTO arp_npl_ch.T_ILI2DB_SETTINGS (tag,setting) VALUES ('ch.ehi.sqlgen.createGeomIndex','True');
INSERT INTO arp_npl_ch.T_ILI2DB_SETTINGS (tag,setting) VALUES ('ch.ehi.ili2db.defaultSrsAuthority','EPSG');
INSERT INTO arp_npl_ch.T_ILI2DB_SETTINGS (tag,setting) VALUES ('ch.ehi.ili2db.defaultSrsCode','2056');
INSERT INTO arp_npl_ch.T_ILI2DB_SETTINGS (tag,setting) VALUES ('ch.ehi.ili2db.createEnumDefs','multiTable');
INSERT INTO arp_npl_ch.T_ILI2DB_SETTINGS (tag,setting) VALUES ('ch.ehi.ili2db.maxSqlNameLength','60');
INSERT INTO arp_npl_ch.T_ILI2DB_SETTINGS (tag,setting) VALUES ('ch.ehi.ili2db.uuidDefaultValue','uuid_generate_v4()');
INSERT INTO arp_npl_ch.T_ILI2DB_SETTINGS (tag,setting) VALUES ('ch.ehi.ili2db.inheritanceTrafo','smart1');
INSERT INTO arp_npl_ch.T_ILI2DB_SETTINGS (tag,setting) VALUES ('ch.ehi.ili2db.catalogueRefTrafo','coalesce');
INSERT INTO arp_npl_ch.T_ILI2DB_SETTINGS (tag,setting) VALUES ('ch.ehi.ili2db.multiPointTrafo','coalesce');
INSERT INTO arp_npl_ch.T_ILI2DB_SETTINGS (tag,setting) VALUES ('ch.ehi.ili2db.multiLineTrafo','coalesce');
INSERT INTO arp_npl_ch.T_ILI2DB_SETTINGS (tag,setting) VALUES ('ch.ehi.ili2db.multiSurfaceTrafo','coalesce');
INSERT INTO arp_npl_ch.T_ILI2DB_SETTINGS (tag,setting) VALUES ('ch.ehi.ili2db.multilingualTrafo','expand');
INSERT INTO arp_npl_ch.T_ILI2DB_META_ATTRS (ilielement,attr_name,attr_value) VALUES ('Dictionaries_V1','furtherInformation','http://www.geo.admin.ch/internet/geoportal/de/home/topics/geobasedata/models.html');
INSERT INTO arp_npl_ch.T_ILI2DB_META_ATTRS (ilielement,attr_name,attr_value) VALUES ('Dictionaries_V1','technicalContact','models@geo.admin.ch');
INSERT INTO arp_npl_ch.T_ILI2DB_META_ATTRS (ilielement,attr_name,attr_value) VALUES ('DictionariesCH_V1','furtherInformation','http://www.geo.admin.ch/internet/geoportal/de/home/topics/geobasedata/models.html');
INSERT INTO arp_npl_ch.T_ILI2DB_META_ATTRS (ilielement,attr_name,attr_value) VALUES ('DictionariesCH_V1','technicalContact','models@geo.admin.ch');
INSERT INTO arp_npl_ch.T_ILI2DB_META_ATTRS (ilielement,attr_name,attr_value) VALUES ('AdministrativeUnits_V1','furtherInformation','http://www.geo.admin.ch/internet/geoportal/de/home/topics/geobasedata/models.html');
INSERT INTO arp_npl_ch.T_ILI2DB_META_ATTRS (ilielement,attr_name,attr_value) VALUES ('AdministrativeUnits_V1','technicalContact','models@geo.admin.ch');
INSERT INTO arp_npl_ch.T_ILI2DB_META_ATTRS (ilielement,attr_name,attr_value) VALUES ('AdministrativeUnitsCH_V1','furtherInformation','http://www.geo.admin.ch/internet/geoportal/de/home/topics/geobasedata/models.html');
INSERT INTO arp_npl_ch.T_ILI2DB_META_ATTRS (ilielement,attr_name,attr_value) VALUES ('AdministrativeUnitsCH_V1','technicalContact','models@geo.admin.ch');
INSERT INTO arp_npl_ch.T_ILI2DB_META_ATTRS (ilielement,attr_name,attr_value) VALUES ('Nutzungsplanung_Hauptnutzung_V1_1','furtherInformation','https://www.are.admin.ch/mgm');
INSERT INTO arp_npl_ch.T_ILI2DB_META_ATTRS (ilielement,attr_name,attr_value) VALUES ('Nutzungsplanung_Hauptnutzung_V1_1','IDGeoIV','73');
INSERT INTO arp_npl_ch.T_ILI2DB_META_ATTRS (ilielement,attr_name,attr_value) VALUES ('Nutzungsplanung_Hauptnutzung_V1_1','technicalContact','mailto:info@are.admin.ch');
INSERT INTO arp_npl_ch.T_ILI2DB_META_ATTRS (ilielement,attr_name,attr_value) VALUES ('Nutzungsplanung_LV03_V1_1','furtherInformation','https://www.are.admin.ch/mgm');
INSERT INTO arp_npl_ch.T_ILI2DB_META_ATTRS (ilielement,attr_name,attr_value) VALUES ('Nutzungsplanung_LV03_V1_1','IDGeoIV','73');
INSERT INTO arp_npl_ch.T_ILI2DB_META_ATTRS (ilielement,attr_name,attr_value) VALUES ('Nutzungsplanung_LV03_V1_1','technicalContact','mailto:info@are.admin.ch');
INSERT INTO arp_npl_ch.T_ILI2DB_META_ATTRS (ilielement,attr_name,attr_value) VALUES ('Nutzungsplanung_LV95_V1_1','furtherInformation','https://www.are.admin.ch/mgm');
INSERT INTO arp_npl_ch.T_ILI2DB_META_ATTRS (ilielement,attr_name,attr_value) VALUES ('Nutzungsplanung_LV95_V1_1','IDGeoIV','73');
INSERT INTO arp_npl_ch.T_ILI2DB_META_ATTRS (ilielement,attr_name,attr_value) VALUES ('Nutzungsplanung_LV95_V1_1','technicalContact','mailto:info@are.admin.ch');
