prompt PL/SQL Developer import file
prompt Created on יום רביעי 24 יולי 2024 by USER
set feedback off
set define off
prompt Creating CUSTOMERS...
create table CUSTOMERS
(
  customersname  VARCHAR2(50),
  idco           INTEGER not null,
  customersphone INTEGER,
  customerstype  VARCHAR2(50),
  customersmail  VARCHAR2(50)
)
;
alter table CUSTOMERS
  add primary key (IDCO);

prompt Creating TRANSPORTATION...
create table TRANSPORTATION
(
  number_of_passengers NUMBER not null,
  driver               VARCHAR2(15) not null,
  id_transportation    NUMBER not null,
  duration_time        DATE not null
)
;
alter table TRANSPORTATION
  add primary key (ID_TRANSPORTATION);

prompt Creating TRIP...
create table TRIP
(
  name              VARCHAR2(15) not null,
  id_trip           NUMBER not null,
  price             NUMBER not null,
  id_transportation NUMBER,
  trip_date         DATE not null
)
;
alter table TRIP
  add primary key (ID_TRIP);
alter table TRIP
  add foreign key (ID_TRANSPORTATION)
  references TRANSPORTATION (ID_TRANSPORTATION) on delete cascade;

prompt Creating DESTINATIONS...
create table DESTINATIONS
(
  name            VARCHAR2(15) not null,
  id_destinations NUMBER not null,
  description     VARCHAR2(100) not null,
  id_trip         NUMBER not null
)
;
alter table DESTINATIONS
  add primary key (ID_DESTINATIONS);
alter table DESTINATIONS
  add foreign key (ID_TRIP)
  references TRIP (ID_TRIP) on delete cascade;

prompt Creating GUARD...
create table GUARD
(
  name         VARCHAR2(15) not null,
  id_guard     NUMBER not null,
  number_phone VARCHAR2(15) not null
)
;
alter table GUARD
  add primary key (ID_GUARD);

prompt Creating GUIDED_BY...
create table GUIDED_BY
(
  price    NUMBER not null,
  id_trip  NUMBER not null,
  id_guard NUMBER not null
)
;
alter table GUIDED_BY
  add primary key (ID_TRIP, ID_GUARD);
alter table GUIDED_BY
  add foreign key (ID_TRIP)
  references TRIP (ID_TRIP) on delete cascade;
alter table GUIDED_BY
  add foreign key (ID_GUARD)
  references GUARD (ID_GUARD) on delete cascade;

prompt Creating NEWCATALOG...
create table NEWCATALOG
(
  newcatalognumber INTEGER not null,
  newcatalogname   VARCHAR2(50),
  priceperunit     INTEGER
)
;
alter table NEWCATALOG
  add primary key (NEWCATALOGNUMBER);

prompt Creating INVENTORY...
create table INVENTORY
(
  shelf         INTEGER,
  unitsinstock  NUMBER default 0,
  inventoryid   INTEGER not null,
  catalognumber INTEGER not null
)
;
alter table INVENTORY
  add primary key (INVENTORYID);
alter table INVENTORY
  add foreign key (CATALOGNUMBER)
  references NEWCATALOG (NEWCATALOGNUMBER);

prompt Creating PERSON...
create table PERSON
(
  id_person     INTEGER not null,
  name          VARCHAR2(50) not null,
  year_of_birth NUMBER,
  phone         VARCHAR2(15),
  email         VARCHAR2(50)
)
;
alter table PERSON
  add constraint PK_PERSON primary key (ID_PERSON);

prompt Creating WORKERS...
create table WORKERS
(
  workersrole  VARCHAR2(50),
  wage         INTEGER,
  workersmail  VARCHAR2(50),
  workersphone INTEGER,
  shift        VARCHAR2(50),
  idwo         INTEGER not null,
  workersname  VARCHAR2(50),
  id_person    INTEGER
)
;
alter table WORKERS
  add primary key (IDWO);
alter table WORKERS
  add constraint FK_WORKERS_PERSON foreign key (ID_PERSON)
  references PERSON (ID_PERSON);
alter table WORKERS
  add constraint CHECKWORKERSROLENOTNULL
  check (WorkersRole IS NOT NULL);

prompt Creating ORDERS...
create table ORDERS
(
  amount        INTEGER,
  dateofsupply  DATE,
  orderdate     DATE,
  orderid       INTEGER not null,
  idwo          INTEGER not null,
  catalognumber INTEGER not null,
  inventoryid   INTEGER not null,
  idco          INTEGER not null,
  id_person     INTEGER
)
;
alter table ORDERS
  add primary key (ORDERID);
alter table ORDERS
  add constraint FK_ORDERS_PERSON foreign key (ID_PERSON)
  references PERSON (ID_PERSON);
alter table ORDERS
  add foreign key (IDWO)
  references WORKERS (IDWO);
alter table ORDERS
  add foreign key (CATALOGNUMBER)
  references NEWCATALOG (NEWCATALOGNUMBER);
alter table ORDERS
  add foreign key (INVENTORYID)
  references INVENTORY (INVENTORYID);
alter table ORDERS
  add foreign key (IDCO)
  references CUSTOMERS (IDCO);

prompt Creating PAYMENTS...
create table PAYMENTS
(
  paymentdate         DATE,
  numberoftransaction INTEGER,
  status              VARCHAR2(50),
  paymenttype         VARCHAR2(50),
  paymentid           INTEGER not null,
  idco                INTEGER
)
;
alter table PAYMENTS
  add primary key (PAYMENTID);
alter table PAYMENTS
  add foreign key (IDCO)
  references CUSTOMERS (IDCO);

prompt Creating TRAVELERS...
create table TRAVELERS
(
  name          VARCHAR2(15) not null,
  year_of_birth NUMBER not null,
  id_travels    NUMBER not null,
  id_person     INTEGER
)
;
alter table TRAVELERS
  add primary key (ID_TRAVELS);
alter table TRAVELERS
  add constraint FK_TRAVELERS_PERSON foreign key (ID_PERSON)
  references PERSON (ID_PERSON);

prompt Creating TRAVELERS_LIST...
create table TRAVELERS_LIST
(
  id_travelers_list NUMBER not null,
  price             NUMBER not null,
  id_trip           NUMBER not null,
  id_travels        NUMBER not null,
  id_person         INTEGER
)
;
alter table TRAVELERS_LIST
  add primary key (ID_TRAVELERS_LIST);
alter table TRAVELERS_LIST
  add unique (ID_TRIP, ID_TRAVELS);
alter table TRAVELERS_LIST
  add constraint FK_TRAVELERS_LIST_PERSON foreign key (ID_PERSON)
  references PERSON (ID_PERSON);
alter table TRAVELERS_LIST
  add foreign key (ID_TRIP)
  references TRIP (ID_TRIP) on delete cascade;
alter table TRAVELERS_LIST
  add foreign key (ID_TRAVELS)
  references TRAVELERS (ID_TRAVELS) on delete cascade;

prompt Creating WORKER_TRAVEL...
create table WORKER_TRAVEL
(
  worker_id NUMBER not null,
  travel_id NUMBER not null
)
;
alter table WORKER_TRAVEL
  add constraint PK_WORKER_TRAVEL primary key (WORKER_ID, TRAVEL_ID);
alter table WORKER_TRAVEL
  add constraint FK_TRAVEL foreign key (TRAVEL_ID)
  references TRAVELERS (ID_TRAVELS);
alter table WORKER_TRAVEL
  add constraint FK_WORKER foreign key (WORKER_ID)
  references WORKERS (IDWO);

prompt Disabling triggers for CUSTOMERS...
alter table CUSTOMERS disable all triggers;
prompt Disabling triggers for TRANSPORTATION...
alter table TRANSPORTATION disable all triggers;
prompt Disabling triggers for TRIP...
alter table TRIP disable all triggers;
prompt Disabling triggers for DESTINATIONS...
alter table DESTINATIONS disable all triggers;
prompt Disabling triggers for GUARD...
alter table GUARD disable all triggers;
prompt Disabling triggers for GUIDED_BY...
alter table GUIDED_BY disable all triggers;
prompt Disabling triggers for NEWCATALOG...
alter table NEWCATALOG disable all triggers;
prompt Disabling triggers for INVENTORY...
alter table INVENTORY disable all triggers;
prompt Disabling triggers for PERSON...
alter table PERSON disable all triggers;
prompt Disabling triggers for WORKERS...
alter table WORKERS disable all triggers;
prompt Disabling triggers for ORDERS...
alter table ORDERS disable all triggers;
prompt Disabling triggers for PAYMENTS...
alter table PAYMENTS disable all triggers;
prompt Disabling triggers for TRAVELERS...
alter table TRAVELERS disable all triggers;
prompt Disabling triggers for TRAVELERS_LIST...
alter table TRAVELERS_LIST disable all triggers;
prompt Disabling triggers for WORKER_TRAVEL...
alter table WORKER_TRAVEL disable all triggers;
prompt Disabling foreign key constraints for TRIP...
alter table TRIP disable constraint SYS_C007855;
prompt Disabling foreign key constraints for DESTINATIONS...
alter table DESTINATIONS disable constraint SYS_C007861;
prompt Disabling foreign key constraints for GUIDED_BY...
alter table GUIDED_BY disable constraint SYS_C007870;
alter table GUIDED_BY disable constraint SYS_C007871;
prompt Disabling foreign key constraints for INVENTORY...
alter table INVENTORY disable constraint SYS_C007828;
prompt Disabling foreign key constraints for WORKERS...
alter table WORKERS disable constraint FK_WORKERS_PERSON;
prompt Disabling foreign key constraints for ORDERS...
alter table ORDERS disable constraint FK_ORDERS_PERSON;
alter table ORDERS disable constraint SYS_C007838;
alter table ORDERS disable constraint SYS_C007839;
alter table ORDERS disable constraint SYS_C007840;
alter table ORDERS disable constraint SYS_C007841;
prompt Disabling foreign key constraints for PAYMENTS...
alter table PAYMENTS disable constraint SYS_C007844;
prompt Disabling foreign key constraints for TRAVELERS...
alter table TRAVELERS disable constraint FK_TRAVELERS_PERSON;
prompt Disabling foreign key constraints for TRAVELERS_LIST...
alter table TRAVELERS_LIST disable constraint FK_TRAVELERS_LIST_PERSON;
alter table TRAVELERS_LIST disable constraint SYS_C007882;
alter table TRAVELERS_LIST disable constraint SYS_C007883;
prompt Disabling foreign key constraints for WORKER_TRAVEL...
alter table WORKER_TRAVEL disable constraint FK_TRAVEL;
alter table WORKER_TRAVEL disable constraint FK_WORKER;
prompt Deleting WORKER_TRAVEL...
delete from WORKER_TRAVEL;
prompt Deleting TRAVELERS_LIST...
delete from TRAVELERS_LIST;
prompt Deleting TRAVELERS...
delete from TRAVELERS;
prompt Deleting PAYMENTS...
delete from PAYMENTS;
prompt Deleting ORDERS...
delete from ORDERS;
prompt Deleting WORKERS...
delete from WORKERS;
prompt Deleting PERSON...
delete from PERSON;
prompt Deleting INVENTORY...
delete from INVENTORY;
prompt Deleting NEWCATALOG...
delete from NEWCATALOG;
prompt Deleting GUIDED_BY...
delete from GUIDED_BY;
prompt Deleting GUARD...
delete from GUARD;
prompt Deleting DESTINATIONS...
delete from DESTINATIONS;
prompt Deleting TRIP...
delete from TRIP;
prompt Deleting TRANSPORTATION...
delete from TRANSPORTATION;
prompt Deleting CUSTOMERS...
delete from CUSTOMERS;
prompt Loading CUSTOMERS...
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Goran-Wincott', 619, 502249716, 'private', 'gwincott@aoe.dk');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Rueben-Furtado', 620, 543289420, 'school', 'rueben@yes.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Kid-Ramis', 621, 526790131, 'office', 'kid@spenser.nl');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Diamond-Adler', 622, 549194942, 'office', 'diamond.adler@nuinfosystems.au');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Geoff-McPherson', 623, 568778325, 'private', 'geoff.mcpherson@usgovernment.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Loreena-Clinton', 624, 573253051, 'school', 'loreena.clinton@ceom.au');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Colm-Cube', 625, 521654449, 'office', 'ccube@gulfmarkoffshore.mx');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Nigel-Popper', 626, 507679081, 'office', 'nigel@fra.il');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Mos-Cagle', 627, 512636214, 'private', 'mos.cagle@sfgo.hu');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Edie-Keener', 628, 561411821, 'private', 'ekeener@mms.ch');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Max-Sainte-Marie', 629, 568174115, 'school', 'max.s@baesch.uk');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Nils-Depp', 630, 559071098, 'school', 'nils.depp@spectrum.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Ali-Stormare', 631, 519165802, 'office', 'ali.stormare@fmt.de');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Gin-Luongo', 632, 509960964, 'school', 'gluongo@medsource.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Bernard-Hackman', 633, 564455789, 'private', 'bernard@gagwear.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Jena-Himmelman', 634, 581246872, 'private', 'jhimmelman@astafunding.nl');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Judd-Sedaka', 635, 502613029, 'private', 'judd.sedaka@simplycertificates.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Donald-Drive', 636, 500604408, 'office', 'donald.drive@montpelierplastics.at');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Aimee-Nightingale', 637, 595590639, 'private', 'a.nightingale@consultants.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Rich-Balaban', 638, 556928695, 'office', 'rich.balaban@ksj.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Gary-Ryder', 639, 533494892, 'private', 'gary.ryder@stmaryland.it');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Millie-Stallone', 640, 553876151, 'private', 'millie.stallone@streetglow.br');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Cuba-Willis', 641, 572921648, 'office', 'cuba.willis@tmt.es');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Jose-Apple', 642, 552519727, 'private', 'j.apple@tripwire.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Lauren-Worrell', 643, 566750779, 'private', 'lauren.w@dataprise.it');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Thelma-Red', 644, 568235070, 'private', 'thelma.red@sweetproductions.jp');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Robby-Rebhorn', 645, 577009638, 'private', 'r.rebhorn@evinco.nl');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Rosanna-Carnes', 646, 542790240, 'private', 'rosannac@qls.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Eddie-Jonze', 647, 522912952, 'school', 'eddie@restaurantpartners.ca');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Chubby-Johnson', 648, 556444346, 'school', 'chubby.johnson@pharmafab.ch');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Stevie-Hynde', 649, 569673692, 'office', 'stevie.hynde@maverick.dk');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Gin-Dzundza', 650, 575977036, 'private', 'gin@aquascapedesigns.de');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Gladys-Madonna', 651, 525351395, 'office', 'gladys@smi.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Jeanne-Ojeda', 652, 513147157, 'office', 'jojeda@ceo.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Marie-Scheider', 653, 561355406, 'school', 'marie@swi.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Radney-Daniels', 654, 588400485, 'school', 'radney.daniels@keymark.jp');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Antonio-Crow', 655, 546670288, 'office', 'antonio.crow@restaurantpartners.ch');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Mandy-Conlee', 656, 548388180, 'private', 'mandyc@loreal.tw');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Seth-Leary', 657, 580206726, 'private', 'seth.leary@maverick.ar');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('King-Hewitt', 658, 505150308, 'private', 'king.h@newtoninteractive.ca');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Brooke-Skarsgard', 659, 516924404, 'office', 'brooke.skarsgard@prosum.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('King-Carrey', 660, 588452879, 'private', 'king.carrey@fds.es');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Stephanie-Stoltz', 661, 577975133, 'office', 'stephanie.stoltz@tarragonrealty.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Joshua-Miller', 662, 589140751, 'office', 'j.miller@bowman.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Ricky-Perry', 663, 588637018, 'private', 'ricky.perry@visionarysystems.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Emily-Boone', 664, 551802834, 'school', 'emily@bps.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Embeth-Avalon', 665, 530628197, 'office', 'e.avalon@ceb.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Simon-Dushku', 666, 531672267, 'office', 'simon.dushku@csi.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Sonny-Malkovich', 667, 518106107, 'school', 'sonny.malkovich@aoe.za');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Thora-Karyo', 668, 512107015, 'school', 'thorak@lifelinesystems.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Franz-Gere', 669, 517500613, 'school', 'franz.gere@accuship.hk');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Geoffrey-Englund', 670, 590750162, 'school', 'geoffrey.englund@asa.fr');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Olympia-Washington', 671, 535501852, 'school', 'olympia.w@unilever.at');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Spencer-Rudd', 672, 512767899, 'private', 'spencer.rudd@randomwalk.de');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Thin-Aykroyd', 673, 590674227, 'private', 'thin.aykroyd@taycorfinancial.it');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Dar-Blackwell', 674, 553397511, 'private', 'dar.blackwell@ass.jp');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Denis-Meniketti', 675, 553224404, 'school', 'd.meniketti@mss.be');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Richard-Patrick', 676, 542640768, 'private', 'richard.patrick@air.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Elisabeth-Lunch', 677, 592159020, 'private', 'elisabeth.lunch@marketfirst.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Chrissie-Law', 678, 593068121, 'office', 'chrissie.law@saksinc.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Maxine-Pfeiffer', 679, 561029762, 'school', 'm.pfeiffer@hps.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Heather-Karyo', 680, 556164774, 'private', 'heather@tps.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Emm-Matthau', 681, 533983286, 'school', 'emm@digitalmotorworks.de');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Catherine-Cronin', 682, 579253842, 'private', 'catherine.c@oneidafinancial.be');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Davis-Hurley', 683, 553456749, 'office', 'davis.hurley@boldtechsystems.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Collin-Wiedlin', 684, 588514391, 'office', 'collin.wiedlin@bowman.fi');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Pablo-Orbit', 685, 533133836, 'office', 'pablo.orbit@nestle.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Josh-Dorff', 686, 555678624, 'school', 'josh.dorff@serentec.fr');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Leo-Venora', 687, 563070541, 'office', 'leo.venora@atg.es');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Terry-Greenwood', 688, 540156930, 'school', 'tgreenwood@emt.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Julianne-Coward', 689, 553689457, 'school', 'julianne.coward@elmco.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Jean-Clooney', 690, 559192716, 'office', 'jean.clooney@sps.se');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Dermot-Janney', 691, 540357563, 'private', 'dermot.janney@chipssolutions.no');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Tara-Sinatra', 692, 589900978, 'private', 'tara@atg.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Veruca-Deejay', 693, 522597759, 'school', 'veruca.deejay@parksite.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Seann-Dern', 694, 545557836, 'office', 'seann.dern@north.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Parker-Sandler', 695, 523921646, 'office', 'parker@carboceramics.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Jeffery-Lipnicki', 696, 539026666, 'school', 'jeffery.l@americanexpress.it');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Noah-Donelly', 697, 535168024, 'private', 'noah.donelly@egroup.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Nils-Thomas', 698, 592949047, 'office', 'nils.thomas@tama.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Maggie-Watson', 699, 582542225, 'school', 'maggie@toyotamotor.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Colleen-Heston', 700, 597681619, 'school', 'colleen.h@dbprofessionals.uk');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Austin-Rickles', 701, 571898330, 'private', 'austin.rickles@priorityleasing.ca');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Eileen-Sinatra', 702, 588064812, 'private', 'eileen@jma.fr');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Goldie-Stuart', 703, 549059853, 'office', 'goldie.stuart@surmodics.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Bret-Tippe', 704, 539442681, 'school', 'bret.tippe@palmbeachtan.li');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Embeth-Glover', 705, 531105314, 'school', 'embeth@accuship.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Tracy-Tinsley', 706, 552558468, 'office', 'tracy.tinsley@sci.au');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Scarlett-Rodriguez', 707, 584220538, 'school', 'scarlett@mse.jp');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Buffy-Schwimmer', 708, 594464824, 'school', 'b.schwimmer@sears.in');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Brenda-Woodard', 709, 584809157, 'school', 'bwoodard@prahs.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Red-Rebhorn', 710, 555748978, 'school', 'red.rebhorn@ibfh.jp');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Merrilee-Domino', 711, 511098312, 'private', 'merrilee.domino@ecopy.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Dan-Watson', 712, 544652463, 'office', 'dan.watson@daimlerchrysler.be');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Heather-Faithfull', 713, 551820820, 'office', 'heather.faithfull@capellaeducation.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Embeth-Puckett', 714, 582180835, 'school', 'embeth.puckett@saralee.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Ali-Mattea', 715, 523710914, 'private', 'ali.mattea@ezecastlesoftware.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Humberto-Blaine', 716, 561580604, 'office', 'humberto.blaine@gillette.ch');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Miles-Branagh', 717, 513844529, 'private', 'milesb@usphysicaltherapy.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Kathy-Church', 718, 527036012, 'office', 'kathy.church@air.br');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Tal-Jackson', 719, 506038166, 'school', 'tal@als.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Hank-Puckett', 720, 574822152, 'school', 'hpuckett@bioanalytical.de');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Andy-Baldwin', 721, 543554136, 'school', 'andy.baldwin@sps.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Anthony-Dolenz', 722, 555059599, 'private', 'adolenz@innovativelighting.be');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Jean-Claude-Curry', 723, 555172674, 'school', 'jeanclaude.curry@stm.de');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Edwin-Lucas', 724, 514920546, 'private', 'edwin.lucas@smg.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Madeleine-Suvari', 725, 579653230, 'office', 'madeleine.suvari@clorox.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Candice-Pollak', 726, 547118602, 'office', 'c.pollak@spenser.si');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Patricia-urban', 727, 568142286, 'private', 'patriciau@cima.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Dermot-Dunst', 728, 588912942, 'school', 'dermot.dunst@myricom.be');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Miriam-Lennix', 729, 560637795, 'private', 'miriam@bestever.uk');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Nathan-Graham', 730, 580378730, 'private', 'nathan@pharmacia.ca');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Jonny-Caviezel', 510, 568788520, 'private', 'jonnyc@columbiabancorp.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Kieran-Matarazzo', 511, 584528373, 'private', 'kieranm@at.br');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Cate-Chung', 512, 597057342, 'private', 'cate.c@outsourcegroup.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Barbara-Elizondo', 513, 559826878, 'school', 'barbara.elizondo@esoftsolutions.uk');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Pelvic-Hawthorne', 514, 595997674, 'private', 'pelvic.h@mercantilebank.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Diamond-McGill', 515, 547873982, 'school', 'diamond.mcgill@oriservices.dk');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Samuel-Gayle', 516, 568363789, 'school', 'samuel.gayle@mercantilebank.sg');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Vince-Womack', 517, 572511257, 'private', 'vince@pioneermortgage.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Benjamin-Allison', 518, 536076205, 'school', 'benjamin@ositissoftware.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Janeane-Van Shelton', 519, 549177111, 'private', 'janeane.vanshelton@verizon.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Tim-Carmen', 520, 575725897, 'school', 'tim.carmen@exinomtechnologies.ch');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Pierce-Meniketti', 521, 501835540, 'office', 'pmeniketti@waltdisney.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Bob-Atlas', 522, 519081786, 'school', 'batlas@pragmatechsoftware.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Ricardo-Campbell', 523, 567370688, 'school', 'ricardoc@kis.au');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Machine-Solido', 524, 531925029, 'school', 'machine.solido@multimedialive.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Judi-Hedaya', 525, 542692910, 'office', 'judi@componentgraphics.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Isaiah-Snow', 526, 599200080, 'school', 'isaiah.s@prp.es');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Alan-Cumming', 527, 570966307, 'private', 'alan.cumming@kwraf.ar');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Lynn-Oakenfold', 528, 558982028, 'office', 'lynn.oakenfold@hotmail.jp');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Nick-Hamilton', 529, 536173651, 'school', 'nick.hamilton@prp.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Jonathan-Rush', 530, 546564448, 'school', 'jrush@yashtechnologies.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Sander-Gallagher', 531, 518378374, 'private', 'sgallagher@summitenergy.ca');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Christopher-Quinn', 532, 558685291, 'school', 'christopher.quinn@insurmark.it');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Isaac-Duke', 533, 544135691, 'office', 'isaac.duke@mattel.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Pat-Shue', 534, 502049568, 'private', 'pshue@diamondtechnologies.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Johnnie-Westerberg', 535, 576801271, 'school', 'johnnie.westerberg@cyberthink.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Mitchell-Lauper', 536, 572860564, 'school', 'mitchell.lauper@mds.br');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Carol-English', 537, 535149723, 'school', 'carol.english@atxforms.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Ewan-Unger', 538, 550108574, 'office', 'ewan.unger@gsat.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Corey-Heron', 539, 512559653, 'private', 'corey.heron@volkswagen.de');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Marlon-Skerritt', 540, 590240692, 'private', 'm.skerritt@anworthmortgage.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Saffron-Hobson', 541, 511257510, 'office', 'saffron.h@larkinenterprises.ch');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Alice-Stormare', 542, 522345018, 'private', 'alice.stormare@taycorfinancial.de');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Ernest-Rydell', 543, 597075958, 'school', 'ernest.rydell@qas.br');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Courtney-Lorenz', 544, 588846794, 'school', 'courtney.l@mls.de');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Milla-Posey', 545, 552385879, 'school', 'milla.posey@innovativelighting.jp');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Josh-Shaw', 546, 529119308, 'office', 'josh.shaw@bestbuy.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Shannyn-Hawkins', 547, 560539784, 'private', 'shannyn.hawkins@base.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Harrison-Gere', 548, 568344802, 'private', 'harrison.gere@portosan.de');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Ed-Mattea', 549, 579067862, 'office', 'ed.mattea@ipsadvisory.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Lucy-O''Donnell', 550, 514992992, 'private', 'lucy.odonnell@neogen.li');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Clint-Arkenstone', 551, 509194227, 'school', 'clint@idlabel.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Kitty-Pony', 552, 535222774, 'private', 'kitty.pony@royalgold.ca');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Randall-Kidman', 553, 513744211, 'school', 'r.kidman@nlx.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Timothy-Jamal', 554, 599154120, 'private', 'timothy.j@pioneermortgage.is');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Chloe-Weisberg', 555, 567179595, 'private', 'chloe.weisberg@ceo.ch');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Hugo-Venora', 556, 502210165, 'private', 'hugo.venora@valleyoaksystems.be');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Marlon-LaSalle', 557, 513127183, 'office', 'marlon@epamsystems.pl');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Lauren-Beatty', 558, 591190005, 'private', 'lauren.beatty@smartronix.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Mika-Austin', 559, 551963377, 'office', 'mika.austin@greenmountain.de');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Merillee-Graham', 560, 598688006, 'school', 'merilleeg@qls.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Harry-Neville', 561, 583231735, 'office', 'harry.n@coadvantageresources.de');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Sal-Shearer', 562, 527290008, 'school', 'sal.shearer@gillette.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Harvey-McDonnell', 563, 573674419, 'private', 'harvey.m@servicelink.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Sal-Cale', 564, 547069715, 'office', 'sal.cale@fflcbancorp.uk');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Trey-Bandy', 565, 512603023, 'private', 'trey.bandy@mqsoftware.uk');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Rickie-Eastwood', 566, 517228362, 'office', 'rickie.eastwood@tmaresources.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Sander-Cetera', 567, 508856448, 'school', 'sander.c@manhattanassociates.au');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Nils-Morton', 568, 566212913, 'school', 'nils@cns.uk');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Ike-Atlas', 569, 534307377, 'school', 'ike.atlas@abatix.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Gwyneth-Rea', 570, 511271596, 'school', 'gwyneth.rea@marathonheater.ar');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Remy-Starr', 571, 569457944, 'private', 'remy.starr@novartis.br');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Lily-Matheson', 572, 516707864, 'school', 'lily@oneidafinancial.sg');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Holly-Stoltz', 573, 590355037, 'office', 'holly.stoltz@glaxosmithkline.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Salma-Henstridge', 574, 544627671, 'office', 'salma.henstridge@generalmills.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Cary-Steenburgen', 575, 569398511, 'school', 'carys@stonetechprofessional.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Bobby-Elizabeth', 576, 567809214, 'office', 'bobby.elizabeth@teamstudio.pt');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Robbie-Meniketti', 577, 539115190, 'private', 'robbie@ceo.id');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Reese-Hoffman', 578, 501637820, 'school', 'reese.h@usdairyproducers.uk');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Oliver-Craven', 579, 557452111, 'office', 'ocraven@jma.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Whoopi-Oates', 580, 566512855, 'private', 'whoopi.o@servicelink.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Solomon-Cazale', 581, 546957779, 'private', 'solomon.cazale@tigris.jp');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Devon-Atlas', 582, 523248613, 'private', 'devon.atlas@keymark.nl');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Bryan-Paul', 583, 501984556, 'office', 'bryan.paul@vesta.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Dave-Thomson', 584, 518374896, 'private', 'dave.thomson@yes.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Sammy-Reeves', 585, 594774336, 'private', 's.reeves@advancedneuromodulation.br');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Wesley-Savage', 586, 590245281, 'school', 'w.savage@meritagetechnologies.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Toni-Gleeson', 587, 597118191, 'office', 'toni.gleeson@globalwireless.jp');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Lennie-Jackman', 588, 561594475, 'office', 'ljackman@ccfholding.uk');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Edie-Hart', 589, 550990425, 'school', 'edie.h@outsourcegroup.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Ronny-Roberts', 590, 564318255, 'private', 'ronny@healthscribe.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Charles-Lipnicki', 591, 521262464, 'private', 'charles.lipnicki@millersystems.no');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Desmond-Garcia', 592, 556693152, 'office', 'desmond.g@taycorfinancial.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Lila-Makeba', 593, 542907650, 'school', 'lila.m@hiltonhotels.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Rosanna-Lindo', 594, 503635765, 'school', 'rosanna.lindo@newhorizons.uk');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Xander-Lachey', 595, 593345741, 'office', 'xanderl@lloydgroup.au');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Sander-Pastore', 596, 531781708, 'office', 'spastore@democracydata.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Donald-Shorter', 597, 574594414, 'private', 'dshorter@surmodics.ca');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Night-Nolte', 598, 596511811, 'private', 'night.n@fds.hk');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Micky-Biehn', 599, 547017150, 'school', 'micky.biehn@spectrum.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Colin-Close', 600, 574447014, 'private', 'colinc@nsd.br');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Peabo-Hyde', 601, 515016014, 'school', 'peabo.hyde@datawarehouse.uk');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Kirsten-Domino', 602, 557160250, 'private', 'kirsten.domino@invisioncom.es');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Tia-Frost', 603, 584667543, 'private', 't.frost@spenser.no');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Bebe-Firth', 604, 516068512, 'office', 'bebe@sds.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Lydia-McGregor', 605, 504980698, 'school', 'lydia.m@fnb.it');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Fisher-Ticotin', 606, 573330179, 'office', 'fisher.ticotin@vertexsolutions.tr');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Ellen-Flemyng', 607, 541466363, 'office', 'ellen.flemyng@unitedasset.se');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Teri-McGill', 608, 568460644, 'school', 't.mcgill@totalentertainment.br');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Chuck-Shand', 609, 540848133, 'school', 'c.shand@infovision.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Sammy-Schwarzenegger', 610, 582408440, 'office', 'sammy.schwarzenegger@ams.uk');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Randall-Atkins', 611, 573494688, 'office', 'ratkins@ceb.gr');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Chaka-Burrows', 612, 507709188, 'school', 'chaka.burrows@gna.no');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Colin-Hershey', 613, 536841171, 'school', 'c.hershey@trusecure.fr');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Percy-Matthau', 614, 524679874, 'office', 'percy.m@adolph.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Vendetta-Karyo', 615, 546684712, 'private', 'vendetta@hiltonhotels.ch');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Kid-Payne', 616, 526896139, 'office', 'k.payne@alohanysystems.br');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Kirsten-Costello', 617, 548350593, 'school', 'kirsten.costello@sony.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Pete-Morse', 618, 555050513, 'office', 'pete.morse@qssgroup.de');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Mitchell-Frakes', 401, 597223983, 'private', 'mitchellf@mindworks.se');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Rhys-Manning', 402, 513497584, 'office', 'rhys@tilsonhr.at');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Domingo-Nolte', 403, 534012577, 'school', 'domingon@nrae.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Mia-Del Toro', 404, 539168893, 'office', 'mia.deltoro@cws.de');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Mac-Balk', 405, 568362445, 'office', 'mac.balk@healthscribe.fr');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Garland-Orbit', 406, 565434672, 'office', 'garland.orbit@talx.de');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Julie-Gleeson', 407, 528795835, 'private', 'julie.g@shar.ca');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Ann-Van Helden', 408, 501048244, 'school', 'ann.vanhelden@adeasolutions.ca');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Ethan-Oldman', 409, 501812851, 'office', 'ethan.oldman@glmt.ca');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Merrill-Mould', 410, 532418671, 'school', 'merrill.mould@labradanutrition.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Hank-Wagner', 411, 574169027, 'office', 'h.wagner@envisiontelephony.at');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Ned-Cleary', 412, 533262434, 'school', 'ned.c@fds.jp');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Gates-Calle', 413, 579134318, 'private', 'gates.calle@nha.de');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Goran-Carlton', 414, 507250283, 'private', 'goran.carlton@bioanalytical.de');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Tyrone-Paquin', 415, 582234932, 'school', 'tyrone.paquin@integratelecom.hu');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Tal-Rubinek', 416, 561797293, 'office', 'tal.rubinek@capstone.at');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Collective-Isaacs', 417, 584721628, 'school', 'collective.isaacs@pfizer.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('CeCe-Stills', 418, 564893655, 'office', 'cece.stills@csi.il');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Chant׳³ֲ³׳’ג€ֲ¢-Ledger', 419, 583801842, 'private', 'chant.l@inzone.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Lizzy-Boorem', 420, 589617575, 'private', 'lizzy.boorem@ciwservices.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Suzanne-Dunaway', 421, 567547439, 'school', 'sdunaway@tracertechnologies.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Stevie-Oates', 422, 561830186, 'office', 's.oates@tarragonrealty.uk');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Danny-Lewis', 423, 562764359, 'school', 'danny.lewis@mercantilebank.uk');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Clint-Love', 424, 532821679, 'office', 'c.love@baesch.ch');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Sandra-Wright', 425, 520249329, 'school', 'sandra@lms.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Wang-McDiarmid', 426, 567515700, 'private', 'wang.m@spd.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Alannah-Cleese', 427, 572863192, 'office', 'alannah.cleese@stmaryland.li');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Renee-Arkin', 428, 550210621, 'private', 'renee.arkin@ubp.dk');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Wang-Viterelli', 429, 501532229, 'office', 'wangv@spenser.de');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Daryl-Hannah', 430, 510479613, 'office', 'darylh@dcgroup.ar');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Ossie-Atkins', 431, 538089016, 'school', 'ossie.a@ppr.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Chubby-Dillon', 432, 569393674, 'school', 'chubby.dillon@bluffcitysteel.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Petula-Cockburn', 433, 579379241, 'private', 'petula.cockburn@yes.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Natacha-Stiles', 434, 512912100, 'school', 'nstiles@travizon.ch');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Dermot-Weller', 435, 588279578, 'office', 'd.weller@ungertechnologies.in');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Jean-Niven', 436, 522569462, 'private', 'jean@mls.it');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Judge-Krumholtz', 437, 559135870, 'private', 'judge.krumholtz@shar.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Morris-Harrelson', 438, 513559185, 'private', 'mharrelson@dell.no');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Tim-Stallone', 439, 578075585, 'school', 'tstallone@fds.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Benjamin-Linney', 440, 543955269, 'school', 'benjamin.linney@gdi.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Gilbert-Vicious', 441, 536627373, 'private', 'gilbert@pioneermortgage.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Bridget-Tilly', 442, 582252457, 'private', 'bridget.tilly@johnkeeler.il');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Lari-Winslet', 443, 561663957, 'school', 'lariw@faef.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Cathy-Patton', 444, 545717753, 'office', 'c.patton@ahl.de');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Albert-LaPaglia', 445, 553640458, 'school', 'albert.lapaglia@abatix.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Lynn-Diffie', 446, 542103649, 'office', 'lynn@hitechpharmacal.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Illeana-Feliciano', 447, 561155269, 'private', 'illeana@mms.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Wendy-Van Helden', 448, 591660523, 'school', 'wendy.vanhelden@its.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Jody-Silverman', 449, 569143730, 'school', 'jody.silverman@gsat.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Keith-Head', 450, 588019846, 'office', 'keith.head@sps.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Kurtwood-Mifune', 451, 536130707, 'private', 'kurtwood.mifune@conquest.it');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Natasha-Wagner', 452, 576699260, 'private', 'natasha.wagner@glacierbancorp.uk');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Bonnie-Reubens', 453, 507718078, 'school', 'bonnie.reubens@mms.uk');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Thin-Pigott-Smith', 454, 569212332, 'office', 'tpigottsmith@prahs.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Earl-Kretschmann', 455, 591741172, 'school', 'earl.kretschmann@waltdisney.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Charlize-Osborne', 456, 561050587, 'school', 'charlizeo@cis.uk');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Elisabeth-Popper', 457, 530538286, 'private', 'elisabeth@envisiontelephony.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Vern-Simpson', 458, 580780147, 'office', 'vern.s@asapstaffing.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Darren-Hatchet', 459, 509672638, 'private', 'darren@usgovernment.nl');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Keanu-Berkoff', 460, 537933779, 'school', 'keanu.berkoff@americanexpress.de');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Jamie-Herrmann', 461, 597034061, 'office', 'jherrmann@interfacesoftware.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Dwight-Cleese', 462, 552540780, 'office', 'dcleese@cima.uk');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Taylor-Postlethwaite', 463, 550232464, 'office', 'taylor.postlethwaite@pepsico.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Josh-Derringer', 464, 533405624, 'school', 'josh.derringer@activeservices.br');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Olympia-Watley', 465, 503054304, 'school', 'olympia.watley@nestle.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Rebeka-McCready', 466, 586671532, 'private', 'rebeka.mccready@spotfireholdings.de');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Jeroen-Gunton', 467, 570269764, 'private', 'jeroen.gunton@pscinfogroup.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Raymond-Winans', 468, 525903237, 'school', 'raymond.winans@hospitalsolutions.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Joseph-Boorem', 469, 575980718, 'school', 'jboorem@ssi.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Terence-Crouch', 470, 523892929, 'school', 'tcrouch@providenceservice.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Victor-Caldwell', 471, 530830016, 'private', 'victor.caldwell@envisiontelephony.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Gordon-Linney', 472, 523372157, 'office', 'gordon.linney@wendysinternational.uk');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Gladys-McGinley', 473, 582829499, 'office', 'gladys.mcginley@sandyspringbancorp.mx');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Pam-Mould', 474, 594772015, 'office', 'pam.m@blueoceansoftware.nl');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Nanci-Garber', 475, 520402382, 'private', 'nanci.garber@enterprise.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Gwyneth-Bello', 476, 589164921, 'private', 'gwyneth.bello@staffone.br');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Denise-Matarazzo', 477, 597649129, 'school', 'denise@fpf.de');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Armand-Quinones', 478, 523110384, 'private', 'armandq@evergreenresources.pt');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Ruth-Rock', 479, 572463394, 'school', 'ruthr@epiqsystems.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Ronny-Dutton', 480, 572348292, 'school', 'rdutton@jollyenterprises.de');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Lucinda-Holly', 481, 511351649, 'private', 'lucinda.holly@fsffinancial.it');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Maria-Tillis', 482, 585031728, 'private', 'maria.tillis@vms.pl');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Crystal-Gallagher', 483, 566619769, 'school', 'crystal.gallagher@horizon.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Albertina-Wells', 484, 583366233, 'school', 'albertina.wells@qestrel.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Edwin-Roberts', 485, 507289501, 'private', 'edwin@isd.br');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Rutger-Morton', 486, 519992052, 'office', 'rutgerm@dancor.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Glen-Kelly', 487, 577653873, 'school', 'glen.kelly@telepoint.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Hugh-Paxton', 488, 528881572, 'office', 'hugh.paxton@ivci.ca');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Mary-Sandler', 489, 595313808, 'office', 'mary.s@accessus.ca');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Angelina-Randal', 490, 567544829, 'office', 'angelina@businessplus.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Bernie-Garr', 491, 581946710, 'office', 'bernie.g@baesch.yu');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Parker-Martinez', 492, 587840014, 'private', 'parker.martinez@cimalabs.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Shirley-Webb', 493, 530935907, 'private', 'shirleyw@diamondgroup.ch');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Mira-Bedelia', 494, 525323638, 'office', 'mira.bedelia@cardinalcartridge.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Anthony-Cassidy', 495, 509185607, 'school', 'anthony.cassidy@denaliventures.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Udo-Himmelman', 496, 564194942, 'office', 'uhimmelman@ahl.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Blair-May', 497, 595528239, 'office', 'blair.may@dancor.uk');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Phoebe-Sanders', 498, 595333117, 'office', 'phoebe.sanders@generalmotors.br');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Jann-Torn', 499, 599557419, 'private', 'jann@ccfholding.de');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Bruce-Reed', 500, 597671136, 'office', 'bruce@mathis.de');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Wally-Kershaw', 501, 521145525, 'office', 'wally.k@oriservices.jp');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Helen-Carlisle', 502, 510698709, 'school', 'helen.carlisle@actechnologies.ec');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Curt-McGowan', 503, 579683004, 'private', 'c.mcgowan@boldtechsystems.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Lizzy-Broza', 504, 540812195, 'school', 'lizzy.broza@ris.ar');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('William-McGoohan', 505, 576321911, 'private', 'william.mcgoohan@telesynthesis.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Pete-Biggs', 506, 510705896, 'school', 'pete.biggs@ghrsystems.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Lindsey-Bailey', 507, 596878425, 'private', 'lindsey.bailey@stmaryland.au');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Martin-Morales', 508, 502000720, 'school', 'martin.morales@shot.it');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Maureen-Fariq', 509, 571599280, 'private', 'maureen.fariq@y2marketing.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Katrin-Gambon', 731, 532836773, 'school', 'k.gambon@telepoint.at');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Marie-Streep', 732, 576900152, 'office', 'marie.streep@millersystems.jp');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Clarence-Clinton', 733, 507516523, 'office', 'clarence.clinton@vms.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Greg-Def', 734, 527133190, 'school', 'greg.def@noodles.it');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Radney-Cube', 735, 560708080, 'school', 'radney.cube@sprint.au');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Woody-Mortensen', 736, 562964858, 'private', 'w.mortensen@mindiq.it');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Isaac-Weiss', 737, 580776861, 'private', 'iweiss@ivci.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Tim-Rickles', 738, 519894535, 'school', 'trickles@mls.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Embeth-Curtis', 739, 544029829, 'private', 'embeth.curtis@printtech.ca');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Isaac-Horizon', 740, 552746367, 'office', 'ihorizon@printcafesoftware.de');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Christian-Butler', 741, 532584832, 'office', 'c.butler@colgatepalmolive.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Willem-Hauer', 742, 591225616, 'office', 'willem.hauer@ahl.uk');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Daryl-Rubinek', 743, 594337339, 'office', 'd.rubinek@otbd.de');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Malcolm-Jeffreys', 744, 581437161, 'private', 'malcolm@tps.uk');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Lynn-Navarro', 745, 595624651, 'school', 'lynn.navarro@genghisgrill.au');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Ellen-Nicholas', 746, 522694731, 'school', 'ellen.nicholas@monitronicsinternational.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Aimee-Mandrell', 747, 512463993, 'office', 'aimee.mandrell@elmco.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Lucy-Mattea', 748, 540832669, 'office', 'lucy.m@mercantilebank.yu');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Ronny-Berkoff', 749, 599926261, 'office', 'ronny.berkoff@venoco.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Johnnie-Kristofferson', 750, 592100287, 'office', 'jkristofferson@mosaic.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Alan-Ryder', 751, 516991327, 'private', 'alan.ryder@softworld.ca');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Roddy-Pierce', 752, 513508776, 'school', 'r.pierce@anheuserbusch.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Moe-Tah', 753, 577207896, 'office', 'mtah@reckittbenckiser.nz');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Dustin-Crowe', 754, 506570380, 'office', 'dcrowe@evergreenresources.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Donald-Knight', 755, 598477256, 'private', 'donald@mag.at');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Madeline-Garber', 756, 561300603, 'school', 'madelineg@caliber.jp');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Ronny-Kier', 757, 559207996, 'office', 'ronny.kier@sci.de');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Albertina-Carrington', 758, 521810784, 'private', 'acarrington@aco.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Radney-Walker', 759, 547502136, 'school', 'radney.walker@fns.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Phil-Gibson', 760, 565722474, 'private', 'phil@printcafesoftware.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Larry-Tsettos', 761, 508427207, 'private', 'larry@maverick.uk');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Christopher-Ranger', 762, 534618318, 'office', 'christopher@johnkeeler.au');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Rachael-Peniston', 763, 502348502, 'office', 'rachael.peniston@onstaff.it');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Claire-Sorvino', 764, 518629646, 'school', 'claires@wellsfinancial.fr');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Faye-Cazale', 765, 551816252, 'school', 'faye.cazale@dearbornbancorp.de');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Miko-Dupree', 766, 530974500, 'private', 'miko.dupree@gna.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Jimmy-Bright', 767, 574713067, 'private', 'jbright@generalmotors.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Steven-Buffalo', 768, 584259907, 'office', 'steven.buffalo@vivendiuniversal.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Joaquin-Koyana', 769, 560279979, 'private', 'joaquin@sht.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Isabella-Sobieski', 770, 564106619, 'school', 'isabella.s@dillards.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Janice-DeLuise', 771, 539558611, 'school', 'janice.deluise@mms.uk');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Dave-Burmester', 772, 522963242, 'private', 'dave@mindiq.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Nancy-Bradford', 773, 501816835, 'office', 'nancy.bradford@canterburypark.fr');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Bret-Sutherland', 774, 572066879, 'private', 'bret.sutherland@escalade.de');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Belinda-Hall', 775, 569399105, 'private', 'belindah@harrison.pl');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Alex-DiCaprio', 776, 533941643, 'office', 'adicaprio@mqsoftware.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Geoff-Kirkwood', 777, 535466252, 'school', 'gkirkwood@americanland.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Rufus-Wilder', 778, 551923739, 'office', 'rufus.wilder@scjohnson.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Noah-Gilliam', 779, 556485339, 'school', 'noah@appriss.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Breckin-Irving', 780, 572795249, 'school', 'breckin.i@componentgraphics.se');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Hilary-Woodward', 781, 532095159, 'school', 'hilary.woodward@allstar.cn');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Harriet-Elwes', 782, 552097272, 'private', 'h.elwes@abs.es');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Rachid-Meniketti', 783, 596472470, 'school', 'rachid.meniketti@marlabs.dk');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Dean-Eat World', 784, 543532373, 'school', 'dean.eatworld@ceo.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Ani-Minogue', 785, 597518292, 'private', 'ani.minogue@usenergyservices.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Nathan-Biehn', 786, 536691676, 'office', 'nathan.biehn@marketfirst.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Mia-Polley', 787, 552313126, 'private', 'mpolley@enterprise.be');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Udo-Garfunkel', 788, 592759045, 'office', 'udo@advertisingventures.de');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Nick-Savage', 789, 554999935, 'private', 'nick.savage@saksinc.de');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Avenged-Jeter', 790, 565963097, 'office', 'avenged.jeter@teamstudio.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Keith-Ponce', 791, 573441697, 'school', 'k.ponce@prometheuslaboratories.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Marty-Khan', 792, 562684109, 'school', 'm.khan@capstone.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Lara-Kahn', 793, 524515466, 'office', 'lara.kahn@gha.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Lisa-Mellencamp', 794, 511755677, 'office', 'lisa.mellencamp@topicsentertainment.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Dianne-Dalton', 795, 519932973, 'school', 'dianne.dalton@axis.de');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Elias-Weiss', 796, 544764667, 'school', 'elias.weiss@sfb.jp');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Pamela-Yankovic', 797, 517674975, 'school', 'pamela.yankovic@homedepot.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Mike-O''Connor', 798, 556021994, 'private', 'mikeo@yashtechnologies.de');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Clint-Dayne', 799, 594477610, 'private', 'clintd@logisticare.ca');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Henry-Bogguss', 800, 543157925, 'office', 'henry.bogguss@mathis.com');
prompt 400 records loaded
prompt Loading TRANSPORTATION...
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (38, 'Cary', 1, to_date('08-04-2011', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (26, 'Clay', 2, to_date('25-09-2855', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (22, 'Harris', 3, to_date('18-05-2856', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (32, 'Clarence', 4, to_date('29-09-2317', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (24, 'Bernie', 5, to_date('03-10-2729', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (37, 'Rosanna', 6, to_date('10-11-2423', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (44, 'Ming-Na', 7, to_date('28-09-2793', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (33, 'Christina', 8, to_date('22-03-2173', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (34, 'Clarence', 9, to_date('27-02-2465', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (34, 'Anne', 10, to_date('28-08-2527', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (35, 'Tara', 11, to_date('03-08-2710', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (21, 'Lynette', 12, to_date('18-12-2864', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (46, 'Franco', 13, to_date('25-03-2115', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (38, 'Juliet', 14, to_date('10-08-1989', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (29, 'Jean-Claude', 15, to_date('10-09-2717', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (43, 'Judy', 16, to_date('10-06-2130', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (21, 'Vonda', 17, to_date('07-04-2044', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (22, 'Jesus', 18, to_date('22-03-2124', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (39, 'Mickey', 19, to_date('09-06-2843', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (48, 'Sonny', 20, to_date('07-11-2010', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (32, 'Rhett', 21, to_date('29-05-2303', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (22, 'Matt', 22, to_date('04-06-2448', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (35, 'Jim', 23, to_date('28-10-2094', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (31, 'Ali', 24, to_date('20-03-2527', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (24, 'Mykelti', 25, to_date('13-06-1988', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (47, 'Morris', 26, to_date('06-12-2653', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (35, 'Patti', 27, to_date('16-10-2985', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (45, 'Rachael', 28, to_date('17-10-2619', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (30, 'Juliet', 29, to_date('21-11-2236', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (36, 'Yolanda', 30, to_date('03-08-2040', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (50, 'Antonio', 31, to_date('15-02-2075', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (49, 'Kate', 32, to_date('06-09-2048', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (25, 'Xander', 33, to_date('19-08-2372', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (26, 'Tal', 34, to_date('24-09-2014', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (27, 'Elias', 35, to_date('02-04-2618', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (36, 'Forest', 36, to_date('25-01-2951', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (35, 'Mary-Louise', 37, to_date('18-06-2519', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (23, 'Freddie', 38, to_date('19-06-2263', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (41, 'Tim', 39, to_date('22-02-2241', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (33, 'Vienna', 40, to_date('16-01-2989', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (45, 'Jimmie', 41, to_date('27-09-2779', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (47, 'Jeffery', 42, to_date('17-07-2676', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (42, 'Mykelti', 43, to_date('11-11-2911', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (24, 'Caroline', 44, to_date('21-10-2889', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (33, 'Beth', 45, to_date('09-01-2304', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (31, 'Bette', 46, to_date('19-09-2214', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (36, 'Steven', 47, to_date('16-06-2585', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (41, 'Rene', 48, to_date('24-05-2085', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (47, 'Lizzy', 49, to_date('15-02-3047', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (33, 'Merillee', 50, to_date('08-06-2680', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (32, 'Helen', 51, to_date('17-10-2274', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (50, 'Pablo', 52, to_date('13-01-2314', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (33, 'Nicolas', 53, to_date('17-08-2133', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (30, 'Vertical', 54, to_date('06-05-2122', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (38, 'Susan', 55, to_date('12-11-2621', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (36, 'Rhea', 56, to_date('05-07-2885', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (49, 'Rosario', 57, to_date('04-08-2910', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (34, 'Glen', 58, to_date('27-02-2880', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (46, 'Ned', 59, to_date('24-10-1967', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (38, 'Suzy', 60, to_date('05-01-2181', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (28, 'Jesus', 61, to_date('09-05-2152', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (47, 'Rawlins', 62, to_date('07-08-1950', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (24, 'Jake', 63, to_date('24-11-2333', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (48, 'Irene', 64, to_date('14-12-2612', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (36, 'Fiona', 65, to_date('18-10-2897', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (37, 'Ryan', 66, to_date('13-01-2204', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (47, 'Cathy', 67, to_date('06-11-2973', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (35, 'Campbell', 68, to_date('27-04-2453', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (28, 'Dave', 69, to_date('28-06-2741', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (35, 'Alan', 70, to_date('12-03-2137', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (45, 'Catherine', 71, to_date('04-12-2608', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (38, 'Terri', 72, to_date('26-12-2917', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (43, 'Grant', 73, to_date('12-05-2943', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (27, 'Isabella', 74, to_date('01-09-2103', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (29, 'Woody', 75, to_date('16-02-2353', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (33, 'Busta', 76, to_date('19-03-2744', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (20, 'Marianne', 77, to_date('14-05-2877', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (25, 'Taye', 78, to_date('09-03-2934', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (42, 'Steven', 79, to_date('05-12-2805', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (20, 'Pablo', 80, to_date('13-04-2181', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (41, 'Wayne', 81, to_date('28-04-2253', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (39, 'Karen', 82, to_date('21-10-2550', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (48, 'Davy', 83, to_date('21-11-2018', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (49, 'Jackson', 84, to_date('24-07-2154', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (44, 'Julianna', 85, to_date('28-06-2090', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (49, 'Busta', 86, to_date('22-05-2352', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (42, 'Adina', 87, to_date('22-06-2512', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (37, 'Parker', 88, to_date('18-02-2296', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (24, 'Tilda', 89, to_date('30-11-2770', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (49, 'Greg', 90, to_date('01-05-2517', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (40, 'Mary-Louise', 91, to_date('03-09-2887', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (32, 'Wade', 92, to_date('08-01-3005', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (32, 'Eddie', 93, to_date('04-02-2498', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (28, 'Suzy', 94, to_date('04-10-2116', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (47, 'Stevie', 95, to_date('03-04-2787', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (48, 'Olympia', 96, to_date('30-12-2882', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (22, 'Raul', 97, to_date('09-07-2132', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (42, 'Gabrielle', 98, to_date('18-08-2586', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (38, 'Jared', 99, to_date('20-11-2042', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (48, 'Stellan', 100, to_date('25-07-2000', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (36, 'Bob', 101, to_date('31-10-2678', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (28, 'Teena', 102, to_date('14-01-2818', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (40, 'Ving', 103, to_date('17-06-2184', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (29, 'Sheryl', 104, to_date('06-02-2927', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (35, 'Nina', 105, to_date('03-02-1984', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (21, 'Laurie', 106, to_date('19-10-2640', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (22, 'Andrae', 107, to_date('22-12-2318', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (21, 'Caroline', 108, to_date('04-01-2929', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (46, 'Ronny', 109, to_date('06-03-2204', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (42, 'Leonardo', 110, to_date('29-08-2371', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (35, 'Temuera', 111, to_date('22-12-2846', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (24, 'Edgar', 112, to_date('04-06-2783', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (25, 'Crystal', 113, to_date('08-01-2260', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (30, 'Joseph', 114, to_date('15-02-2855', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (22, 'Debbie', 115, to_date('15-06-2556', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (37, 'Hugh', 116, to_date('07-12-2680', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (33, 'Rodney', 117, to_date('06-08-2715', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (45, 'Shannyn', 118, to_date('31-07-2487', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (29, 'Corey', 119, to_date('28-01-1974', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (49, 'King', 120, to_date('26-06-3021', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (34, 'Gilberto', 121, to_date('11-01-2591', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (28, 'Natacha', 122, to_date('01-04-2120', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (32, 'Loren', 123, to_date('17-06-2629', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (38, 'Aaron', 124, to_date('24-04-2331', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (22, 'Katie', 125, to_date('05-09-2019', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (21, 'Treat', 126, to_date('22-07-1984', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (48, 'Thora', 127, to_date('10-04-2765', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (44, 'Jody', 128, to_date('18-08-2461', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (27, 'Debbie', 129, to_date('22-08-2609', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (22, 'Jeroen', 130, to_date('29-05-2123', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (21, 'Fats', 131, to_date('26-02-2079', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (50, 'Randall', 132, to_date('11-10-2125', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (42, 'Roscoe', 133, to_date('24-10-2367', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (28, 'Anna', 134, to_date('05-01-2819', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (50, 'Benicio', 135, to_date('07-04-2507', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (41, 'Richard', 136, to_date('07-06-2458', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (45, 'Suzy', 137, to_date('14-02-2329', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (26, 'Nikka', 138, to_date('22-10-2977', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (39, 'Colm', 139, to_date('05-06-2936', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (24, 'Bryan', 140, to_date('27-12-2713', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (50, 'Jaime', 141, to_date('20-06-2346', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (32, 'Carla', 142, to_date('06-05-2958', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (30, 'Taye', 143, to_date('01-11-2488', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (42, 'Vickie', 144, to_date('28-02-2144', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (50, 'Frederic', 145, to_date('14-12-2595', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (25, 'Robbie', 146, to_date('30-03-2159', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (48, 'Charles', 147, to_date('21-09-2622', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (21, 'Anne', 148, to_date('26-09-2046', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (41, 'Mindy', 149, to_date('06-01-2952', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (23, 'Wayman', 150, to_date('25-10-1968', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (20, 'Rosario', 151, to_date('27-05-2114', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (20, 'Vertical', 152, to_date('15-03-2271', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (25, 'Zooey', 153, to_date('03-01-2088', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (46, 'Leon', 154, to_date('22-07-2629', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (26, 'Roger', 155, to_date('15-04-2799', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (40, 'Halle', 156, to_date('01-12-2047', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (34, 'Liam', 157, to_date('11-11-1979', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (23, 'Alannah', 158, to_date('24-03-2855', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (49, 'Jennifer', 159, to_date('21-05-1910', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (37, 'Edgar', 160, to_date('10-06-2366', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (34, 'Kirk', 161, to_date('04-09-2617', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (20, 'Ben', 162, to_date('20-12-1924', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (23, 'Maria', 163, to_date('12-01-2415', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (36, 'Rueben', 164, to_date('11-11-2718', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (35, 'Gilbert', 165, to_date('21-01-2598', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (33, 'Jerry', 166, to_date('07-12-1920', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (49, 'Andrae', 167, to_date('28-05-2489', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (43, 'Rodney', 168, to_date('03-10-2956', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (50, 'Simon', 169, to_date('14-04-2749', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (24, 'Alan', 170, to_date('31-05-2190', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (25, 'Belinda', 171, to_date('28-01-1999', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (50, 'Illeana', 172, to_date('23-09-2489', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (25, 'Veruca', 173, to_date('10-11-2003', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (28, 'Courtney', 174, to_date('14-09-1925', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (36, 'Drew', 175, to_date('05-01-3000', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (44, 'Angie', 176, to_date('11-06-2282', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (47, 'Kevin', 177, to_date('17-04-2073', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (42, 'Judge', 178, to_date('23-08-2354', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (37, 'Joe', 179, to_date('02-03-2735', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (26, 'Madeline', 180, to_date('21-02-2466', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (21, 'Harry', 181, to_date('27-02-2496', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (25, 'Edwin', 182, to_date('09-09-2680', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (20, 'Davey', 183, to_date('30-08-2589', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (50, 'Wade', 184, to_date('30-05-2785', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (22, 'Hugh', 185, to_date('24-03-2026', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (38, 'Josh', 186, to_date('01-12-3019', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (45, 'Radney', 187, to_date('24-10-2669', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (21, 'Shirley', 188, to_date('07-11-2811', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (34, 'Miguel', 189, to_date('08-11-2630', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (27, 'Nina', 190, to_date('27-02-2006', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (35, 'Ritchie', 191, to_date('16-03-2529', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (42, 'Jared', 192, to_date('13-12-2677', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (28, 'Michelle', 193, to_date('26-05-2080', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (44, 'Russell', 194, to_date('20-10-2899', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (44, 'Tori', 195, to_date('20-03-2989', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (47, 'Alex', 196, to_date('21-08-3026', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (43, 'Sissy', 197, to_date('14-09-2560', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (49, 'Christian', 198, to_date('20-04-2348', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (26, 'Hilton', 199, to_date('14-04-1943', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (30, 'Connie', 200, to_date('01-01-1990', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (42, 'Collective', 201, to_date('13-09-3062', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (42, 'Roy', 202, to_date('04-01-2092', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (37, 'Joseph', 203, to_date('12-07-2022', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (46, 'Pete', 204, to_date('13-09-2591', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (20, 'Roy', 205, to_date('10-03-2393', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (25, 'Talvin', 206, to_date('06-08-3064', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (32, 'Robbie', 207, to_date('11-08-2433', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (41, 'Gordie', 208, to_date('05-05-1928', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (36, 'Anthony', 209, to_date('23-05-2315', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (36, 'Elle', 210, to_date('13-11-2778', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (31, 'Geena', 211, to_date('04-09-2841', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (33, 'Dean', 212, to_date('01-07-1982', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (31, 'Lucinda', 213, to_date('30-08-2973', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (35, 'Kristin', 214, to_date('03-12-3071', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (45, 'Maury', 215, to_date('19-06-2780', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (45, 'Miguel', 216, to_date('18-06-2251', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (32, 'Mary Beth', 217, to_date('11-06-3041', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (44, 'Danny', 218, to_date('01-11-2651', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (39, 'Brenda', 219, to_date('31-12-2707', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (34, 'Morris', 220, to_date('25-02-2873', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (44, 'Rowan', 221, to_date('23-05-2038', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (44, 'Clint', 222, to_date('26-03-2098', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (21, 'Rueben', 223, to_date('15-01-2537', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (20, 'Simon', 224, to_date('20-08-2539', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (22, 'Mel', 225, to_date('09-11-2556', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (41, 'Carrie-Anne', 226, to_date('19-07-2226', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (25, 'Kyra', 227, to_date('03-12-1994', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (50, 'Christina', 228, to_date('06-10-2828', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (42, 'Wesley', 229, to_date('14-03-2200', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (27, 'Elisabeth', 230, to_date('29-09-2889', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (41, 'Merillee', 231, to_date('03-07-2757', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (22, 'Gary', 232, to_date('28-07-2656', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (33, 'Victor', 233, to_date('21-11-2958', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (27, 'Rosanne', 234, to_date('05-01-2530', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (26, 'Jack', 235, to_date('11-01-2013', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (25, 'Dylan', 236, to_date('28-04-2124', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (44, 'Devon', 237, to_date('22-10-2544', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (39, 'Sonny', 238, to_date('23-04-2614', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (20, 'Sara', 239, to_date('02-11-2682', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (23, 'James', 240, to_date('09-08-2402', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (42, 'Devon', 241, to_date('02-02-3053', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (21, 'Nigel', 242, to_date('07-05-2567', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (43, 'Martha', 243, to_date('28-07-2320', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (44, 'Thomas', 244, to_date('25-09-2699', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (40, 'Etta', 245, to_date('30-10-2059', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (46, 'Mac', 246, to_date('01-01-2859', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (32, 'France', 247, to_date('22-09-2967', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (30, 'Debra', 248, to_date('12-04-2711', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (50, 'Gilbert', 249, to_date('18-01-2113', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (27, 'Regina', 250, to_date('03-08-2447', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (43, 'Miko', 251, to_date('28-03-2223', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (36, 'Greg', 252, to_date('05-08-2778', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (47, 'Vanessa', 253, to_date('30-04-1961', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (46, 'Anthony', 254, to_date('02-06-2944', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (46, 'Rip', 255, to_date('18-05-2513', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (36, 'Clay', 256, to_date('26-09-2509', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (33, 'Mae', 257, to_date('04-09-2537', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (47, 'Busta', 258, to_date('21-04-2761', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (37, 'Henry', 259, to_date('07-05-2935', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (31, 'Aaron', 260, to_date('27-09-2437', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (44, 'Linda', 261, to_date('24-04-2214', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (46, 'Scott', 262, to_date('08-10-2425', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (43, 'Dick', 263, to_date('01-05-3017', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (34, 'Rachid', 264, to_date('11-02-3002', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (46, 'Swoosie', 265, to_date('29-09-1998', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (32, 'Sydney', 266, to_date('05-10-2561', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (29, 'Bonnie', 267, to_date('10-02-2171', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (33, 'Jimmy', 268, to_date('27-09-2488', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (38, 'Delbert', 269, to_date('11-05-2830', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (43, 'Eliza', 270, to_date('09-08-2197', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (33, 'Chalee', 271, to_date('04-07-2425', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (21, 'Gordon', 272, to_date('04-01-2913', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (26, 'Junior', 273, to_date('04-10-2124', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (41, 'Benicio', 274, to_date('27-03-3005', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (30, 'Tea', 275, to_date('27-05-2332', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (42, 'Mekhi', 276, to_date('14-12-2550', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (29, 'Renee', 277, to_date('09-12-2886', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (24, 'Frederic', 278, to_date('24-03-3026', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (20, 'Ice', 279, to_date('01-11-1980', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (25, 'Anne', 280, to_date('05-12-2329', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (25, 'Rhea', 281, to_date('29-05-1971', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (25, 'Karon', 282, to_date('20-05-2539', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (45, 'Kieran', 283, to_date('23-02-2895', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (21, 'Stephen', 284, to_date('23-10-3019', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (49, 'Patricia', 285, to_date('17-01-1972', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (28, 'Juan', 286, to_date('01-09-2685', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (25, 'Jeffery', 287, to_date('21-02-2174', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (40, 'Larnelle', 288, to_date('11-06-2209', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (46, 'Penelope', 289, to_date('28-09-2148', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (37, 'Norm', 290, to_date('26-05-2454', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (30, 'Chazz', 291, to_date('11-07-2864', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (25, 'Chad', 292, to_date('25-11-2698', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (42, 'Sarah', 293, to_date('18-03-2878', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (38, 'Albert', 294, to_date('25-07-2280', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (25, 'Luis', 295, to_date('31-03-2884', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (45, 'Collective', 296, to_date('29-12-3074', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (30, 'Eliza', 297, to_date('21-05-1966', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (35, 'Diamond', 298, to_date('14-05-2806', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (36, 'Terrence', 299, to_date('07-09-2715', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (24, 'Denny', 300, to_date('19-02-2679', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (28, 'Micky', 301, to_date('02-12-2610', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (37, 'Pierce', 302, to_date('03-03-2941', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (37, 'Steven', 303, to_date('14-08-3003', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (44, 'Victor', 304, to_date('13-03-2906', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (43, 'Frank', 305, to_date('10-10-2531', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (47, 'Jay', 306, to_date('30-09-2823', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (45, 'Jonatha', 307, to_date('24-03-2292', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (34, 'Clive', 308, to_date('06-12-2353', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (47, 'Night', 309, to_date('07-02-2285', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (38, 'Lara', 310, to_date('26-11-2297', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (31, 'Ashton', 311, to_date('04-05-1901', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (44, 'Mark', 312, to_date('17-02-2451', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (43, 'Rebecca', 313, to_date('04-06-2866', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (29, 'Thin', 314, to_date('08-05-2269', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (25, 'Tramaine', 315, to_date('22-12-2893', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (46, 'Lucinda', 316, to_date('25-05-2857', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (50, 'Nicolas', 317, to_date('13-03-2984', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (37, 'Chazz', 318, to_date('04-08-2494', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (24, 'Thelma', 319, to_date('13-07-2723', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (26, 'Rowan', 320, to_date('17-09-2674', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (45, 'George', 321, to_date('16-04-1975', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (45, 'Maura', 322, to_date('22-10-2581', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (22, 'Davis', 323, to_date('01-08-2970', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (20, 'Bridget', 324, to_date('31-07-2638', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (35, 'Hazel', 325, to_date('25-07-2868', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (35, 'Shannon', 326, to_date('13-04-2694', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (23, 'Anna', 327, to_date('22-02-2244', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (29, 'Jaime', 328, to_date('29-06-2574', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (42, 'Trick', 329, to_date('22-06-2165', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (24, 'Fairuza', 330, to_date('13-12-1916', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (30, 'Kenneth', 331, to_date('06-02-2708', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (50, 'Susan', 332, to_date('25-06-2810', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (33, 'Debby', 333, to_date('07-11-2588', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (38, 'Katie', 334, to_date('04-11-1947', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (26, 'Patrick', 335, to_date('06-10-2543', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (22, 'Merrill', 336, to_date('27-08-2067', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (23, 'Dermot', 337, to_date('05-03-3031', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (49, 'Mae', 338, to_date('23-10-2903', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (22, 'Emerson', 339, to_date('07-06-2221', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (41, 'Donald', 340, to_date('11-05-2283', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (28, 'Allison', 341, to_date('30-05-2541', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (34, 'Cesar', 342, to_date('25-12-3017', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (37, 'Gloria', 343, to_date('01-05-2183', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (37, 'Lucinda', 344, to_date('05-08-2893', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (24, 'Night', 345, to_date('27-07-2567', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (42, 'Spencer', 346, to_date('24-05-2541', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (44, 'Hilary', 347, to_date('28-02-2760', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (47, 'Dean', 348, to_date('05-10-2672', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (42, 'Davy', 349, to_date('24-01-2549', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (47, 'Don', 350, to_date('21-09-3047', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (43, 'Stephanie', 351, to_date('03-05-2150', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (25, 'Kimberly', 352, to_date('13-07-2828', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (47, 'Ozzy', 353, to_date('20-11-3061', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (43, 'Franz', 354, to_date('18-06-3041', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (34, 'Miki', 355, to_date('17-02-2696', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (24, 'Embeth', 356, to_date('13-11-2991', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (31, 'Amanda', 357, to_date('12-04-2791', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (43, 'Kristin', 358, to_date('10-01-2823', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (21, 'Taylor', 359, to_date('14-02-3059', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (45, 'Jamie', 360, to_date('13-09-2026', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (32, 'Giovanni', 361, to_date('23-12-2946', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (35, 'Raul', 362, to_date('23-03-2460', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (43, 'Neneh', 363, to_date('06-01-2404', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (40, 'Campbell', 364, to_date('23-08-2942', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (34, 'Jet', 365, to_date('21-12-2455', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (25, 'Debi', 366, to_date('14-11-2879', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (22, 'Robby', 367, to_date('27-08-3012', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (45, 'Joy', 368, to_date('27-07-2673', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (24, 'Thelma', 369, to_date('10-05-2839', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (26, 'Colm', 370, to_date('30-04-2748', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (23, 'Alice', 371, to_date('28-09-2747', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (41, 'Jim', 372, to_date('07-10-3046', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (38, 'Amy', 373, to_date('13-08-1992', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (31, 'Al', 374, to_date('06-08-2918', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (23, 'Gaby', 375, to_date('23-04-2005', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (36, 'Penelope', 376, to_date('02-01-1951', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (25, 'Lennie', 377, to_date('07-06-2243', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (22, 'Johnette', 378, to_date('05-06-2293', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (28, 'Kristin', 379, to_date('08-07-3052', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (23, 'Tanya', 380, to_date('06-03-2792', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (41, 'John', 381, to_date('14-01-1911', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (27, 'Judd', 382, to_date('27-08-2173', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (47, 'Jackson', 383, to_date('19-06-2283', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (20, 'Rachael', 384, to_date('30-08-3008', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (40, 'Gord', 385, to_date('15-10-2208', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (31, 'Wayne', 386, to_date('12-04-2353', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (30, 'Edie', 387, to_date('12-02-2090', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (33, 'Vienna', 388, to_date('12-11-2674', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (46, 'Aidan', 389, to_date('26-08-2829', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (42, 'Chubby', 390, to_date('07-10-1914', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (50, 'Jessica', 391, to_date('10-01-2312', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (27, 'Fionnula', 392, to_date('09-07-2784', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (26, 'Juliet', 393, to_date('31-05-2181', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (22, 'Mia', 394, to_date('06-02-2685', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (33, 'Julia', 395, to_date('16-06-2077', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (48, 'Wendy', 396, to_date('09-06-1904', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (36, 'Nancy', 397, to_date('13-06-2069', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (31, 'Carl', 398, to_date('04-11-3023', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (42, 'Michael', 399, to_date('05-09-1985', 'dd-mm-yyyy'));
insert into TRANSPORTATION (number_of_passengers, driver, id_transportation, duration_time)
values (32, 'Chloe', 400, to_date('27-04-2535', 'dd-mm-yyyy'));
prompt 400 records loaded
prompt Loading TRIP...
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Jeremy', 1, 2192, 1, to_date('12-11-2117', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Grant', 2, 2917, 2, to_date('19-08-2011', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Sigourney', 3, 3912, 3, to_date('24-06-2415', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Holly', 4, 1607, 4, to_date('25-09-2525', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Dwight', 5, 3745, 5, to_date('26-02-2723', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Ivan', 6, 2267, 6, to_date('26-01-2531', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Roy', 7, 1459, 7, to_date('26-11-2398', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Jean', 8, 3058, 8, to_date('13-09-1964', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Regina', 9, 3995, 9, to_date('27-12-1941', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Miki', 10, 2146, 10, to_date('06-08-2210', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Ronny', 11, 2109, 11, to_date('10-08-2471', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Merle', 12, 2059, 12, to_date('01-01-2688', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Sally', 13, 1476, 13, to_date('15-02-2850', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Orlando', 14, 2655, 14, to_date('06-10-2404', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Praga', 15, 1904, 15, to_date('04-12-2620', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Charlize', 16, 3541, 16, to_date('26-08-2194', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Gerald', 17, 3404, 17, to_date('21-07-2896', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Belinda', 18, 1106, 18, to_date('10-09-2807', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Nicky', 19, 1728, 19, to_date('11-09-2657', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Delroy', 20, 1950, 20, to_date('11-01-2301', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Dionne', 21, 2026, 21, to_date('27-03-2040', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Chris', 22, 2857, 22, to_date('24-02-2775', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Ray', 23, 2000, 23, to_date('19-01-2191', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Faye', 24, 2516, 24, to_date('16-08-2096', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Judy', 25, 2732, 25, to_date('17-03-2909', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Nicolas', 26, 3337, 26, to_date('19-04-2620', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Wally', 27, 1696, 27, to_date('23-05-2005', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Rueben', 28, 2951, 28, to_date('12-04-2715', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Alfie', 29, 1724, 29, to_date('29-06-2706', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Robby', 30, 1676, 30, to_date('10-01-2182', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Jay', 31, 3408, 31, to_date('09-03-2007', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Mint', 32, 2372, 32, to_date('15-03-1965', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Rory', 33, 3905, 33, to_date('06-04-2751', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Billy', 34, 2122, 34, to_date('06-06-2490', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Queen', 35, 2947, 35, to_date('30-06-2962', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Julie', 36, 2993, 36, to_date('21-02-3016', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Melanie', 37, 1311, 37, to_date('16-01-3042', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Carlos', 38, 2150, 38, to_date('05-11-2536', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Miriam', 39, 2708, 39, to_date('08-05-1901', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Geggy', 40, 3892, 40, to_date('30-09-2839', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Mika', 41, 1224, 41, to_date('11-10-2438', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Ronnie', 42, 2953, 42, to_date('15-07-2264', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Aaron', 43, 1793, 43, to_date('15-10-1932', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Grant', 44, 1890, 44, to_date('31-03-2828', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Jesus', 45, 1796, 45, to_date('25-04-3012', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Jake', 46, 3726, 46, to_date('27-07-2023', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Mint', 47, 3617, 47, to_date('24-06-2240', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Jena', 48, 3350, 48, to_date('15-12-1995', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Sophie', 49, 2822, 49, to_date('16-10-2116', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Hilary', 50, 1917, 50, to_date('19-07-1962', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Jimmie', 51, 1485, 51, to_date('07-10-2525', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Angie', 52, 3418, 52, to_date('25-05-2841', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Shawn', 53, 1998, 53, to_date('24-02-3071', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Hilton', 54, 1374, 54, to_date('21-12-2771', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Jane', 55, 2388, 55, to_date('19-12-2366', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Madeline', 56, 1048, 56, to_date('28-11-2621', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Azucar', 57, 2794, 57, to_date('26-01-2723', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Vern', 58, 1042, 58, to_date('04-06-2432', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Jesus', 59, 2964, 59, to_date('12-10-2127', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Jonathan', 60, 1809, 60, to_date('01-03-3058', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Victoria', 61, 3780, 61, to_date('09-06-2656', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Oro', 62, 3651, 62, to_date('05-08-2729', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Darius', 63, 3410, 63, to_date('28-05-2934', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Rosie', 64, 3297, 64, to_date('11-02-2401', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Uma', 65, 3032, 65, to_date('09-08-2903', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Donna', 66, 3559, 66, to_date('11-07-1962', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Karon', 67, 1788, 67, to_date('09-12-2358', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Jason', 68, 3704, 68, to_date('03-12-2290', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Franco', 69, 3970, 69, to_date('26-01-1993', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Red', 70, 3672, 70, to_date('16-02-2306', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Sander', 71, 1980, 71, to_date('01-04-2731', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('William', 72, 2818, 72, to_date('19-08-2159', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Daniel', 73, 3734, 73, to_date('04-03-2763', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Kid', 74, 1113, 74, to_date('18-09-2962', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Nikka', 75, 3268, 75, to_date('17-10-2258', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Keith', 76, 1527, 76, to_date('14-01-2436', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Charlie', 77, 2966, 77, to_date('06-06-2499', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Emm', 78, 2057, 78, to_date('29-11-2271', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Petula', 79, 3275, 79, to_date('02-06-2927', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Teena', 80, 3601, 80, to_date('06-07-2827', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Juliana', 81, 1604, 81, to_date('10-09-2691', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Kirk', 82, 3917, 82, to_date('23-02-2844', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Whoopi', 83, 1764, 83, to_date('12-09-2422', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Queen', 84, 3311, 84, to_date('10-04-2238', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Steven', 85, 3036, 85, to_date('06-10-2269', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Cheech', 86, 3785, 86, to_date('28-11-2317', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Rik', 87, 2501, 87, to_date('28-01-2281', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Vondie', 88, 3186, 88, to_date('01-10-2473', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Sinead', 89, 1745, 89, to_date('20-02-1970', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Melanie', 90, 2822, 90, to_date('16-04-2023', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Betty', 91, 2195, 91, to_date('28-02-2450', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Rebeka', 92, 1944, 92, to_date('24-11-2887', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Swoosie', 93, 2292, 93, to_date('01-05-1919', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Gene', 94, 3997, 94, to_date('10-12-2628', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Angelina', 95, 1238, 95, to_date('14-03-2120', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Ernest', 96, 1394, 96, to_date('24-01-2822', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Kiefer', 97, 1233, 97, to_date('10-07-3035', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Veruca', 98, 1353, 98, to_date('06-03-2004', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Janeane', 99, 2721, 99, to_date('09-06-2288', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Joseph', 100, 3872, 100, to_date('01-02-1932', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Maria', 101, 2368, 101, to_date('08-08-1977', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Norm', 102, 1741, 102, to_date('26-08-2590', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Cledus', 103, 2973, 103, to_date('07-04-2284', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Jody', 104, 2483, 104, to_date('22-01-2905', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Oded', 105, 1380, 105, to_date('26-04-2590', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Keith', 106, 3660, 106, to_date('13-03-2946', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Ricky', 107, 1609, 107, to_date('25-08-2767', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Gabriel', 108, 3222, 108, to_date('02-10-2546', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Vondie', 109, 2774, 109, to_date('20-11-2412', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Cary', 110, 2650, 110, to_date('25-09-2509', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Taryn', 111, 2808, 111, to_date('14-02-2137', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Sona', 112, 1749, 112, to_date('05-04-2199', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Dar', 113, 3684, 113, to_date('02-01-2482', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Kelli', 114, 3412, 114, to_date('22-03-3069', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Ritchie', 115, 1307, 115, to_date('19-08-2975', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Clint', 116, 3377, 116, to_date('16-04-2891', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Chalee', 117, 2938, 117, to_date('21-05-1936', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Gord', 118, 1549, 118, to_date('15-11-2467', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Alfred', 119, 1370, 119, to_date('25-04-1947', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Louise', 120, 1567, 120, to_date('08-09-2657', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Rodney', 121, 1470, 121, to_date('07-05-2723', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Nathan', 122, 3639, 122, to_date('26-12-2247', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Cate', 123, 3680, 123, to_date('23-12-2703', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Patricia', 124, 1977, 124, to_date('23-08-1999', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Liquid', 125, 2946, 125, to_date('30-05-2965', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Donna', 126, 2018, 126, to_date('25-01-3013', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Gordie', 127, 3907, 127, to_date('10-01-2284', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Paul', 128, 2860, 128, to_date('16-07-2584', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Jackson', 129, 3218, 129, to_date('08-08-2523', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Mitchell', 130, 1497, 130, to_date('19-02-2740', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Morris', 131, 2449, 131, to_date('12-08-2909', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Jena', 132, 2364, 132, to_date('06-02-2217', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Grace', 133, 2955, 133, to_date('01-02-2255', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Teri', 134, 3877, 134, to_date('14-08-2984', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Lenny', 135, 1553, 135, to_date('17-08-2604', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Lennie', 136, 2016, 136, to_date('06-07-2342', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Danni', 137, 3571, 137, to_date('19-03-2275', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Jarvis', 138, 3983, 138, to_date('24-04-2344', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Jeff', 139, 2819, 139, to_date('22-03-3016', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Alice', 140, 3463, 140, to_date('17-04-2303', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Tamala', 141, 1301, 141, to_date('27-01-2476', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Taylor', 142, 3611, 142, to_date('21-04-2703', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Marina', 143, 3813, 143, to_date('29-06-2561', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Tal', 144, 2234, 144, to_date('15-03-1902', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Elijah', 145, 1041, 145, to_date('12-02-2968', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Ramsey', 146, 2571, 146, to_date('23-09-2330', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Davy', 147, 2283, 147, to_date('14-10-2110', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Maggie', 148, 1101, 148, to_date('20-10-2367', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Temuera', 149, 3301, 149, to_date('30-04-2405', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Laura', 150, 1742, 150, to_date('27-04-1943', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Elisabeth', 151, 2202, 151, to_date('22-05-2500', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Ike', 152, 3314, 152, to_date('09-10-1992', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Juliana', 153, 2397, 153, to_date('11-10-3031', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Trick', 154, 2811, 154, to_date('15-02-1922', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Curtis', 155, 1624, 155, to_date('02-07-2859', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Gina', 156, 3763, 156, to_date('25-09-2999', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Night', 157, 1725, 157, to_date('03-04-2183', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Doug', 158, 2128, 158, to_date('19-07-2093', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Connie', 159, 3097, 159, to_date('02-07-1974', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Celia', 160, 2877, 160, to_date('09-04-2974', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Ossie', 161, 1737, 161, to_date('20-03-2012', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Edie', 162, 3837, 162, to_date('08-08-2843', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Dustin', 163, 1100, 163, to_date('23-01-2856', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Maureen', 164, 2781, 164, to_date('27-11-2118', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Robby', 165, 3974, 165, to_date('27-10-2470', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('William', 166, 3204, 166, to_date('10-09-1924', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Vince', 167, 3761, 167, to_date('04-09-2153', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Shannon', 168, 3033, 168, to_date('01-07-2607', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Gwyneth', 169, 3259, 169, to_date('29-08-2852', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Rhys', 170, 2832, 170, to_date('01-09-2774', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Carrie', 171, 2815, 171, to_date('03-04-2800', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Stanley', 172, 1972, 172, to_date('21-10-2483', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Sigourney', 173, 3932, 173, to_date('11-04-2210', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Nigel', 174, 2157, 174, to_date('17-04-2249', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Tracy', 175, 1560, 175, to_date('03-08-2721', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Rosanna', 176, 1479, 176, to_date('29-10-2128', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Carole', 177, 3705, 177, to_date('05-07-2194', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Brian', 178, 3424, 178, to_date('06-11-2397', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Heath', 179, 1279, 179, to_date('06-12-2108', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Shelby', 180, 1701, 180, to_date('16-03-2810', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Tommy', 181, 3517, 181, to_date('02-12-2044', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Tcheky', 182, 3045, 182, to_date('23-10-3011', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Rosanne', 183, 3371, 183, to_date('28-01-2668', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Cate', 184, 3032, 184, to_date('08-03-2991', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Dar', 185, 3502, 185, to_date('05-04-2800', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Candice', 186, 1021, 186, to_date('05-07-2525', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Courtney', 187, 1163, 187, to_date('19-12-1949', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Marisa', 188, 3391, 188, to_date('08-04-3074', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Uma', 189, 2907, 189, to_date('23-10-2814', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Donal', 190, 1849, 190, to_date('19-01-2216', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Cathy', 191, 2168, 191, to_date('30-11-2624', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Nick', 192, 3608, 192, to_date('22-07-2502', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Phoebe', 193, 1593, 193, to_date('11-08-2237', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Wes', 194, 2080, 194, to_date('14-01-3064', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Vin', 195, 2226, 195, to_date('14-02-2764', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Stephen', 196, 1458, 196, to_date('28-08-2833', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Mili', 197, 1464, 197, to_date('19-12-2655', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Crispin', 198, 2461, 198, to_date('24-07-2569', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Joey', 199, 1808, 199, to_date('21-05-2865', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Omar', 200, 3633, 200, to_date('20-02-2473', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Maria', 201, 3944, 201, to_date('23-07-2509', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Alex', 202, 2318, 202, to_date('21-06-2639', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Nicolas', 203, 2441, 203, to_date('06-05-2154', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Christopher', 204, 1705, 204, to_date('18-12-1973', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Rachel', 205, 3342, 205, to_date('27-07-2110', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Pierce', 206, 3615, 206, to_date('24-08-2326', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Kevin', 207, 2993, 207, to_date('20-03-2847', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Patty', 208, 2891, 208, to_date('16-01-2649', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Jaime', 209, 3747, 209, to_date('22-03-3001', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Nile', 210, 1856, 210, to_date('02-05-2412', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Eddie', 211, 1308, 211, to_date('01-12-2549', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Fairuza', 212, 3130, 212, to_date('16-07-2704', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Hilary', 213, 3775, 213, to_date('05-03-1961', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Elle', 214, 1749, 214, to_date('17-09-2079', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Alec', 215, 1424, 215, to_date('03-12-2298', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Dorry', 216, 3815, 216, to_date('13-11-2450', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Walter', 217, 2309, 217, to_date('17-06-2613', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Rosanna', 218, 3307, 218, to_date('18-07-2322', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Grant', 219, 3350, 219, to_date('18-03-2775', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Lonnie', 220, 3184, 220, to_date('09-07-2220', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Thelma', 221, 1069, 221, to_date('04-05-2020', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Ernest', 222, 3811, 222, to_date('22-10-2804', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Hal', 223, 1147, 223, to_date('26-08-2673', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Temuera', 224, 2204, 224, to_date('06-11-2785', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Willie', 225, 1632, 225, to_date('19-12-2851', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Juan', 226, 1794, 226, to_date('10-05-2699', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Jesse', 227, 3797, 227, to_date('06-01-2921', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Laura', 228, 2466, 228, to_date('25-02-1901', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Breckin', 229, 1266, 229, to_date('03-08-2051', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Jean-Claude', 230, 1993, 230, to_date('20-09-2216', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Cliff', 231, 1078, 231, to_date('13-12-1914', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Dylan', 232, 1397, 232, to_date('07-11-2053', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Armin', 233, 1672, 233, to_date('12-06-2464', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Jaime', 234, 2910, 234, to_date('08-02-3005', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Gates', 235, 1461, 235, to_date('09-11-2527', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Christopher', 236, 2855, 236, to_date('07-08-2470', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Jamie', 237, 3505, 237, to_date('06-12-2469', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Jann', 238, 3421, 238, to_date('13-10-2368', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('LeVar', 239, 2724, 239, to_date('11-02-2525', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Amanda', 240, 1862, 240, to_date('22-02-2810', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Woody', 241, 2288, 241, to_date('22-07-2440', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Crispin', 242, 2614, 242, to_date('31-03-2416', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Miriam', 243, 2801, 243, to_date('27-06-2664', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Penelope', 244, 2074, 244, to_date('22-01-2760', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Thelma', 245, 2061, 245, to_date('11-01-2470', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Buffy', 246, 3756, 246, to_date('08-04-2627', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Elle', 247, 3082, 247, to_date('19-04-2362', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Alessandro', 248, 2235, 248, to_date('23-10-2038', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Kelli', 249, 3889, 249, to_date('07-12-2559', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Lenny', 250, 1068, 250, to_date('25-10-2241', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Embeth', 251, 2158, 251, to_date('04-05-2494', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Ernest', 252, 2701, 252, to_date('08-01-2071', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Coley', 253, 2083, 253, to_date('28-07-2637', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Lesley', 254, 3754, 254, to_date('29-06-2714', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Mena', 255, 2734, 255, to_date('04-11-2267', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Kirk', 256, 2800, 256, to_date('07-03-2666', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Cevin', 257, 3751, 257, to_date('08-06-2423', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Rhona', 258, 2404, 258, to_date('20-10-1947', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Christian', 259, 1205, 259, to_date('19-12-2088', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Jose', 260, 2607, 260, to_date('20-02-2612', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Oded', 261, 1014, 261, to_date('17-06-2636', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Derrick', 262, 2757, 262, to_date('08-09-2885', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Garth', 263, 2128, 263, to_date('04-01-2302', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Gino', 264, 2396, 264, to_date('25-04-2805', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Katie', 265, 3038, 265, to_date('17-11-2263', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Cloris', 266, 3436, 266, to_date('27-06-2898', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Judd', 267, 1563, 267, to_date('07-04-2081', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Collective', 268, 2844, 268, to_date('26-02-2602', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Maxine', 269, 1694, 269, to_date('25-04-2203', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Delbert', 270, 2120, 270, to_date('22-06-2415', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Sigourney', 271, 1040, 271, to_date('12-10-3050', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Freda', 272, 3769, 272, to_date('05-10-2712', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Tea', 273, 3499, 273, to_date('15-05-2360', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Kris', 274, 1304, 274, to_date('14-01-2176', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Diane', 275, 3612, 275, to_date('17-03-2510', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Lucinda', 276, 2954, 276, to_date('24-06-2381', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Martin', 277, 3159, 277, to_date('12-06-1921', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('King', 278, 3574, 278, to_date('29-06-2273', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Brian', 279, 1235, 279, to_date('05-07-2596', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Jean-Claude', 280, 3356, 280, to_date('11-06-2411', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Demi', 281, 2857, 281, to_date('29-02-2232', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Nora', 282, 2063, 282, to_date('09-05-2348', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Sam', 283, 2486, 283, to_date('28-01-2033', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Richard', 284, 1733, 284, to_date('24-10-2365', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Dustin', 285, 2120, 285, to_date('16-06-2598', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Howie', 286, 2528, 286, to_date('29-12-2581', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Fairuza', 287, 3301, 287, to_date('16-06-2087', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Lenny', 288, 1514, 288, to_date('23-10-2914', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Bruce', 289, 3888, 289, to_date('10-11-1963', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Gerald', 290, 3197, 290, to_date('29-11-1907', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Jaime', 291, 2269, 291, to_date('04-11-2208', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Anthony', 292, 3422, 292, to_date('07-03-2249', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Mae', 293, 2138, 293, to_date('07-07-2071', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Ricardo', 294, 3317, 294, to_date('16-09-1910', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Courtney', 295, 3684, 295, to_date('06-06-2267', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Matthew', 296, 3181, 296, to_date('28-10-2820', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Judi', 297, 1181, 297, to_date('20-03-2134', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Humberto', 298, 1084, 298, to_date('21-10-2834', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Wendy', 299, 3355, 299, to_date('31-08-2741', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Lari', 300, 2333, 300, to_date('24-04-2632', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Cherry', 301, 3477, 301, to_date('20-05-2375', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Roddy', 302, 2367, 302, to_date('20-11-1936', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Roger', 303, 3901, 303, to_date('12-10-2724', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Karon', 304, 2971, 304, to_date('02-12-2034', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Janice', 305, 2591, 305, to_date('17-07-2348', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Boyd', 306, 2391, 306, to_date('20-06-2358', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Jay', 307, 2017, 307, to_date('14-06-2971', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Nile', 308, 2927, 308, to_date('29-10-2020', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Anna', 309, 3648, 309, to_date('21-12-2578', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Edwin', 310, 2323, 310, to_date('20-07-2183', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Benjamin', 311, 1948, 311, to_date('06-10-2684', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Embeth', 312, 2719, 312, to_date('19-09-2038', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Dionne', 313, 1378, 313, to_date('14-06-1902', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Loren', 314, 3408, 314, to_date('14-07-3019', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Eric', 315, 2154, 315, to_date('30-12-2555', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Clea', 316, 3309, 316, to_date('10-05-2128', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Marina', 317, 2646, 317, to_date('06-09-1984', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Eliza', 318, 3095, 318, to_date('24-08-2474', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Derek', 319, 1892, 319, to_date('21-05-2169', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Emm', 320, 1448, 320, to_date('30-06-2704', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Zooey', 321, 1033, 321, to_date('12-12-2576', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Trey', 322, 3316, 322, to_date('17-09-2226', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Gavin', 323, 3223, 323, to_date('27-07-2520', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Christina', 324, 2181, 324, to_date('20-11-2669', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Embeth', 325, 3868, 325, to_date('21-04-1931', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Temuera', 326, 2846, 326, to_date('19-12-2523', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Cheech', 327, 2644, 327, to_date('14-10-2348', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Kid', 328, 2787, 328, to_date('18-11-2710', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Dave', 329, 2790, 329, to_date('27-08-2981', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Arnold', 330, 3402, 330, to_date('31-08-2465', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Wally', 331, 3365, 331, to_date('28-04-1971', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Lila', 332, 2216, 332, to_date('10-03-2108', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Morgan', 333, 1717, 333, to_date('11-10-2672', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Wade', 334, 2926, 334, to_date('15-06-2185', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Gil', 335, 1933, 335, to_date('14-05-2732', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Peter', 336, 3816, 336, to_date('21-11-2383', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('William', 337, 3829, 337, to_date('28-10-2084', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Mel', 338, 1200, 338, to_date('11-10-2178', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Kim', 339, 2716, 339, to_date('31-08-2231', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Kenneth', 340, 3882, 340, to_date('05-07-2001', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Cole', 341, 3905, 341, to_date('05-05-2388', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Ozzy', 342, 1734, 342, to_date('15-01-2365', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Sandra', 343, 3457, 343, to_date('19-02-2255', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Brian', 344, 1354, 344, to_date('19-10-1907', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Hex', 345, 3164, 345, to_date('04-12-2522', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Geoff', 346, 3581, 346, to_date('01-04-2593', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Christmas', 347, 3902, 347, to_date('14-10-1938', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Kirk', 348, 1688, 348, to_date('21-05-2017', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Naomi', 349, 1424, 349, to_date('22-08-3027', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Rip', 350, 1520, 350, to_date('08-02-3066', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Udo', 351, 3223, 351, to_date('13-06-1907', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Dustin', 352, 3691, 352, to_date('22-04-1961', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Carole', 353, 3221, 353, to_date('18-07-1930', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Ronnie', 354, 1766, 354, to_date('16-08-2275', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Sara', 355, 3727, 355, to_date('25-12-1914', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Delbert', 356, 3894, 356, to_date('02-07-2075', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Nina', 357, 3228, 357, to_date('13-04-3000', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Barbara', 358, 1128, 358, to_date('11-06-2096', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Merrill', 359, 3082, 359, to_date('14-07-3028', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Courtney', 360, 2736, 360, to_date('01-06-2075', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Marie', 361, 1097, 361, to_date('21-06-2864', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Al', 362, 1295, 362, to_date('19-12-2930', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Todd', 363, 3047, 363, to_date('16-01-2175', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Marie', 364, 3622, 364, to_date('02-03-2212', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Seann', 365, 3580, 365, to_date('13-01-2580', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Merrilee', 366, 1669, 366, to_date('07-02-2668', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Wayne', 367, 3440, 367, to_date('15-10-2439', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Julie', 368, 2630, 368, to_date('04-07-2592', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Eliza', 369, 2519, 369, to_date('04-10-2516', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Geggy', 370, 1915, 370, to_date('11-06-2928', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Mel', 371, 1827, 371, to_date('08-11-2828', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Teena', 372, 3443, 372, to_date('24-04-2518', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Julianne', 373, 2104, 373, to_date('22-12-2032', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Tramaine', 374, 1143, 374, to_date('13-12-2843', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Christina', 375, 2166, 375, to_date('27-06-2056', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Danny', 376, 2775, 376, to_date('12-04-1995', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Clay', 377, 1471, 377, to_date('19-10-2197', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Amy', 378, 2418, 378, to_date('05-08-2071', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Hal', 379, 3392, 379, to_date('24-08-2999', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Vendetta', 380, 3367, 380, to_date('18-01-1975', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Samantha', 381, 1515, 381, to_date('13-12-3052', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Pablo', 382, 1984, 382, to_date('07-08-2108', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Kelli', 383, 2681, 383, to_date('11-03-2404', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Ernie', 384, 1312, 384, to_date('23-07-2540', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Adam', 385, 3533, 385, to_date('01-01-2488', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Lenny', 386, 3412, 386, to_date('18-05-2326', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Radney', 387, 3863, 387, to_date('22-07-2461', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Chrissie', 388, 3300, 388, to_date('27-05-2066', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Gin', 389, 1039, 389, to_date('11-01-2921', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Gladys', 390, 1557, 390, to_date('05-03-2721', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Danni', 391, 1238, 391, to_date('02-03-2382', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Luis', 392, 1033, 392, to_date('30-07-3031', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Freddy', 393, 2886, 393, to_date('07-08-2872', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Allan', 394, 2031, 394, to_date('09-03-2155', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Mia', 395, 2774, 395, to_date('25-09-2468', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Antonio', 396, 1912, 396, to_date('16-02-2234', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Faye', 397, 3521, 397, to_date('28-06-2555', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Tanya', 398, 1582, 398, to_date('02-03-2322', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Sam', 399, 1394, 399, to_date('19-01-2922', 'dd-mm-yyyy'));
insert into TRIP (name, id_trip, price, id_transportation, trip_date)
values ('Jason', 400, 2730, 400, to_date('10-12-2246', 'dd-mm-yyyy'));
prompt 400 records loaded
prompt Loading DESTINATIONS...
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Kirsten', 1, 'The jurney begins: odio expedita nostrud est quidem commodo.  qui aut et sunt. ', 1);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Dean', 2, 'The jurney begins: maxime debitis accusamus mollitia tempor et. ', 2);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Bebe', 3, 'The jurney begins: dolores non in et qui incididunt.  id. ', 3);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Danni', 4, 'The jurney begins: elit distinctio in nulla in eos.  in placeat est consequat est a.  facilis eiusmo', 4);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Allan', 5, 'The jurney begins: delectus sed. ', 5);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Terrence', 6, 'The jurney begins: ex ad aut debitis perferendis optio.  assumenda aut nam deserunt est alias. ', 6);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Bruce', 7, 'The jurney begins: cumque occaecati veniam dolore deleniti mollitia.  est rerum ut reiciendis eiusmo', 7);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Freda', 8, 'The jurney begins: quo fuga excepturi eveniet et adipisicing.  rerum amet laborum aute. ', 8);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Hector', 9, 'The jurney begins: cumque omnis itaque harum assumenda qui.  quo quibusdam tempor impedit voluptates', 9);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Bonnie', 10, 'The jurney begins: sint. ', 10);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Halle', 11, 'The jurney begins: qui excepturi nobis velit aliqua. ', 11);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Ronnie', 12, 'The jurney begins: ', 12);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Bette', 13, 'The jurney begins: iusto nam rerum omnis voluptatibus adipisicing.  et in quidem omnis. ', 13);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Billy', 14, 'The jurney begins: in dolorum assumenda dolor excepteur anim. ', 14);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Hookah', 15, 'The jurney begins: delectus aute et et est harum.  quod non voluptatibus quos doloribus. ', 15);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Chazz', 16, 'The jurney begins: in irure. ', 16);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Tom', 17, 'The jurney begins: omnis. ', 17);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Renee', 18, 'The jurney begins: amet in tenetur sint voluptates soluta.  mollit. ', 18);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Candice', 19, 'The jurney begins: amet velit earum delectus et aut.  ad in. ', 19);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Patricia', 20, 'The jurney begins: dolore veniam rerum est. ', 20);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Katrin', 21, 'The jurney begins: ducimus voluptates reprehenderit distinctio esse excepturi.  perferendis. ', 21);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Christopher', 22, 'The jurney begins: nisi dolore. ', 22);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Danny', 23, 'The jurney begins: aut cupiditate eos dolor nostrud est.  consequat optio est at praesentium. ', 23);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Mandy', 24, 'The jurney begins: libero et consectetur cillum eligendi. ', 24);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Amy', 25, 'The jurney begins: est impedit cumque officia non omnis.  aute sint. ', 25);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Charlton', 26, 'The jurney begins: est aliquip hic et dolore et.  in quos officia dolor rerum. ', 26);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Terry', 27, 'The jurney begins: vero et qui odio. ', 27);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Cornell', 28, 'The jurney begins: eos ullamco velit sunt ut et.  et sint molestiae proident molestias. ', 28);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Ashton', 29, 'The jurney begins: officiis voluptatibus soluta rerum et aliquip. ', 29);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Lucy', 30, 'The jurney begins: amet ut eveniet. ', 30);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Rolando', 31, 'The jurney begins: ipsum dignissimos quis et minus rerum.  et ducimus facilis ut earum. ', 31);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Joe', 32, 'The jurney begins: ad est lorem et a magna.  qui qui eveniet dolor. ', 32);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Ned', 33, 'The jurney begins: maxime ut velit sit voluptate at.  ut accusamus et quis quas molestias. ', 33);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Michael', 34, 'The jurney begins: laboris id et ducimus. ', 34);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Selma', 35, 'The jurney begins: asperiores ex. ', 35);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Blair', 36, 'The jurney begins: at est irure. ', 36);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Gord', 37, 'The jurney begins: elit dolor culpa deleniti laborum laborum.  impedit. ', 37);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Joan', 38, 'The jurney begins: animi magna aliqua cillum deserunt nihil.  et odio facilis non in est.  at. ', 38);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Jena', 39, 'The jurney begins: possimus praesentium fuga exercitation culpa id.  hic earum quo. ', 39);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Kathleen', 40, 'The jurney begins: impedit placeat ut dolor voluptatum laborum. ', 40);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Amy', 41, 'The jurney begins: ad enim in. ', 41);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Ellen', 42, 'The jurney begins: ', 42);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Lupe', 43, 'The jurney begins: earum. ', 43);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Chuck', 44, 'The jurney begins: ea culpa nulla tempor temporibus. ', 44);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Shirley', 45, 'The jurney begins: ', 45);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Lee', 46, 'The jurney begins: sint cumque sunt est sit eligendi. ', 46);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Clay', 47, 'The jurney begins: id expedita aute eos quidem. ', 47);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Jann', 48, 'The jurney begins: aliqua aut incididunt laboris aut. ', 48);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Jackson', 49, 'The jurney begins: et lorem dolor maxime. ', 49);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Hector', 50, 'The jurney begins: dolore est est adipisicing quidem cillum. ', 50);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Ani', 51, 'The jurney begins: occaecat dolorum qui tempor ex doloribus.  et in aut. ', 51);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Andy', 52, 'The jurney begins: a dolorum temporibus quod delectus id.  rerum et facilis distinctio eveniet debit', 52);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Tommy', 53, 'The jurney begins: in ut dolore nulla dolore praesentium. ', 53);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Anjelica', 54, 'The jurney begins: facilis autem id sint rerum irure.  itaque qui velit velit. ', 54);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Melanie', 55, 'The jurney begins: sapiente in amet do necessitatibus recusandae.  dolore facilis enim aliquip asper', 55);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Remy', 56, 'The jurney begins: cupiditate maiores excepturi. ', 56);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Darius', 57, 'The jurney begins: non rerum id fugiat nisi. ', 57);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Olga', 58, 'The jurney begins: dolorum. ', 58);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Vince', 59, 'The jurney begins: expedita aut consequatur molestiae at deserunt.  in. ', 59);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Hector', 60, 'The jurney begins: reprehenderit esse dolor quo quos cum. ', 60);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Liam', 61, 'The jurney begins: aliquip in libero fugiat in debitis.  est est facere iusto et qui.  aute deserunt', 61);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Beverley', 62, 'The jurney begins: laboris et possimus recusandae aut atque. ', 62);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Judd', 63, 'The jurney begins: proident ut minim cupidatat consequatur omnis.  a distinctio. ', 63);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Udo', 64, 'The jurney begins: sit sunt id rerum sed molestias.  enim ut nobis dolorum reprehenderit in. ', 64);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Harriet', 65, 'The jurney begins: ducimus atque sapiente iusto sint saepe.  ut rerum in atque. ', 65);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Cesar', 66, 'The jurney begins: ut aliqua ut voluptas tempore ut. ', 66);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Irene', 67, 'The jurney begins: ', 67);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Janice', 68, 'The jurney begins: ', 68);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Maury', 69, 'The jurney begins: dignissimos ut animi sint eos voluptates. ', 69);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Quentin', 70, 'The jurney begins: eu hic consequat maiores possimus ut.  amet minus nobis doloribus occaecati vero.', 70);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Holly', 71, 'The jurney begins: incididunt ut aliquip magna voluptate in. ', 71);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Jimmy', 72, 'The jurney begins: earum dolore. ', 72);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Sal', 73, 'The jurney begins: assumenda dolor reprehenderit nulla. ', 73);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Breckin', 74, 'The jurney begins: quidem commodo libero voluptate. ', 74);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Rob', 75, 'The jurney begins: et asperiores praesentium possimus nostrud. ', 75);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Lou', 76, 'The jurney begins: ducimus ut ut animi facilis officiis.  rerum et non dolores optio officia. ', 76);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Belinda', 77, 'The jurney begins: laborum minus nisi fuga voluptates. ', 77);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Laurence', 78, 'The jurney begins: et. ', 78);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Vince', 79, 'The jurney begins: deserunt in dignissimos irure iusto do.  possimus aut. ', 79);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Lari', 80, 'The jurney begins: eiusmod odio. ', 80);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Marley', 81, 'The jurney begins: ', 81);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Herbie', 82, 'The jurney begins: temporibus accusamus nulla in dolorum incididunt.  pariatur deserunt libero. ', 82);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Gailard', 83, 'The jurney begins: non elit minus dolores culpa tempor.  distinctio laborum ut. ', 83);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Lily', 84, 'The jurney begins: ', 84);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Teri', 85, 'The jurney begins: nobis nisi in aut soluta dolor.  veniam. ', 85);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Gene', 86, 'The jurney begins: fugiat laborum. ', 86);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Lea', 87, 'The jurney begins: id maxime minus. ', 87);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Ronny', 88, 'The jurney begins: dolor quis. ', 88);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Tilda', 89, 'The jurney begins: ut in eiusmod voluptate et qui.  rerum eos minus. ', 89);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Maury', 90, 'The jurney begins: irure et quod aut ipsum quod.  est. ', 90);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Jonathan', 91, 'The jurney begins: repellat aut nisi sunt tempor quis. ', 91);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Jared', 92, 'The jurney begins: earum ut sapiente amet. ', 92);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Gordon', 93, 'The jurney begins: expedita ut nobis aute assumenda sint.  sint adipisicing. ', 93);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Sylvester', 94, 'The jurney begins: saepe quidem dolor sint culpa in.  et. ', 94);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Breckin', 95, 'The jurney begins: nulla nam id. ', 95);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Chloe', 96, 'The jurney begins: asperiores voluptatum. ', 96);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Lily', 97, 'The jurney begins: ullamco quidem alias. ', 97);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Alessandro', 98, 'The jurney begins: dolor adipisicing dolor expedita id sapiente.  et sed quos eveniet. ', 98);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Elvis', 99, 'The jurney begins: irure minus aut possimus eligendi ex.  tenetur laborum. ', 99);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Chi', 100, 'The jurney begins: ', 100);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Ozzy', 101, 'The jurney begins: accusamus atque quos officia nulla ad.  excepteur qui reprehenderit. ', 101);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Stellan', 102, 'The jurney begins: vero delectus minim dolorum. ', 102);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Ricky', 103, 'The jurney begins: earum non officia et rerum pariatur.  consequat molestiae in voluptas. ', 103);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Eileen', 104, 'The jurney begins: aut adipisicing maxime. ', 104);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Wayman', 105, 'The jurney begins: quibusdam sunt pariatur dolor. ', 105);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Stephen', 106, 'The jurney begins: temporibus rerum in adipisicing. ', 106);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Mary', 107, 'The jurney begins: odio atque officia autem rerum ut.  repellendus in asperiores assumenda. ', 107);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Melanie', 108, 'The jurney begins: placeat nisi et non et est. ', 108);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Sylvester', 109, 'The jurney begins: praesentium saepe voluptas in quidem id. ', 109);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Carlos', 110, 'The jurney begins: officia elit eligendi. ', 110);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Claude', 111, 'The jurney begins: placeat commodo est fugiat proident corrupti.  aliquip at et. ', 111);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Christopher', 112, 'The jurney begins: impedit non. ', 112);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Patrick', 113, 'The jurney begins: nulla voluptates ducimus dolor cillum consectetur.  occaecati delectus delectus t', 113);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Etta', 114, 'The jurney begins: ad laborum cillum ut animi accusamus. ', 114);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Mira', 115, 'The jurney begins: vero sint repellat. ', 115);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Trey', 116, 'The jurney begins: et odio ut veniam quos minim.  id proident. ', 116);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Kris', 117, 'The jurney begins: labore id anim ullamco. ', 117);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Rene', 118, 'The jurney begins: animi nulla praesentium saepe. ', 118);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Gabriel', 119, 'The jurney begins: ', 119);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Rueben', 120, 'The jurney begins: ullamco molestiae est dolor dolore est.  nisi in anim voluptate. ', 120);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Adam', 121, 'The jurney begins: qui sunt dolore cupiditate culpa autem.  lorem reiciendis et. ', 121);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Amy', 122, 'The jurney begins: irure quibusdam soluta minim expedita in. ', 122);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Thelma', 123, 'The jurney begins: aute atque fuga exercitation et. ', 123);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Cole', 124, 'The jurney begins: praesentium et eveniet. ', 124);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Jena', 125, 'The jurney begins: omnis et molestiae mollit alias officia.  enim. ', 125);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Jack', 126, 'The jurney begins: amet nihil assumenda necessitatibus tempor excepturi.  nobis. ', 126);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Machine', 127, 'The jurney begins: at autem earum ut. ', 127);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Penelope', 128, 'The jurney begins: occaecat dolores optio et consequat maiores.  omnis tenetur mollitia. ', 128);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Betty', 129, 'The jurney begins: harum laborum debitis amet est impedit.  fugiat. ', 129);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Etta', 130, 'The jurney begins: officia. ', 130);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Lionel', 131, 'The jurney begins: optio officia nobis magna tempore cillum.  itaque. ', 131);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Darius', 132, 'The jurney begins: maxime esse ut ut rerum sint.  duis sapiente omnis ex sunt delectus.  duis esse. ', 132);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Charlie', 133, 'The jurney begins: dignissimos proident expedita hic. ', 133);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Julianne', 134, 'The jurney begins: aut magna ducimus labore quo debitis.  aut itaque sit. ', 134);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Ronny', 135, 'The jurney begins: commodo debitis aut delectus iusto in.  in ut ut anim. ', 135);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Judy', 136, 'The jurney begins: sed aut officiis odio consequat fuga. ', 136);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Selma', 137, 'The jurney begins: hic laboris mollitia maiores vero sed.  aut omnis at ut et distinctio.  in. ', 137);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Mae', 138, 'The jurney begins: assumenda et rerum harum cupidatat voluptatum.  cillum ut dolores dolore tempor o', 138);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Brooke', 139, 'The jurney begins: dolor excepturi culpa dolorum ducimus commodo.  reprehenderit harum deserunt veni', 139);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Grace', 140, 'The jurney begins: consequatur et aliqua aliqua dolores qui.  voluptas velit dolor. ', 140);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Jason', 141, 'The jurney begins: expedita nam quod officia cum. ', 141);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Linda', 142, 'The jurney begins: tenetur qui cupidatat doloribus pariatur fugiat. ', 142);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Mark', 143, 'The jurney begins: proident at a non et nisi.  ducimus magna aut et nostrud. ', 143);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Kenneth', 144, 'The jurney begins: labore et atque incididunt amet non.  est et culpa quos voluptas sint.  minim. ', 144);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Allison', 145, 'The jurney begins: est et mollit aut. ', 145);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Hex', 146, 'The jurney begins: nam harum. ', 146);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Nina', 147, 'The jurney begins: et aliquip voluptates nam. ', 147);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Oro', 148, 'The jurney begins: et voluptate. ', 148);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Ty', 149, 'The jurney begins: ', 149);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Ricky', 150, 'The jurney begins: ', 150);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Suzanne', 151, 'The jurney begins: et et occaecat anim dolore non.  veniam sit vero doloribus in quas. ', 151);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Remy', 152, 'The jurney begins: impedit voluptate expedita. ', 152);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Charlton', 153, 'The jurney begins: et maiores eligendi id in qui.  magna. ', 153);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Domingo', 154, 'The jurney begins: ex. ', 154);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Harriet', 155, 'The jurney begins: et libero. ', 155);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Marianne', 156, 'The jurney begins: sunt irure maxime dolor qui tempor.  id facilis sint. ', 156);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Gilbert', 157, 'The jurney begins: iusto. ', 157);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Gloria', 158, 'The jurney begins: enim quibusdam omnis delectus mollitia labore.  a laborum. ', 158);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Wayne', 159, 'The jurney begins: quis sapiente et nulla et non.  recusandae. ', 159);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Betty', 160, 'The jurney begins: eos aute maiores est et impedit.  et et est nihil anim labore. ', 160);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Jonatha', 161, 'The jurney begins: officiis delectus mollitia mollit. ', 161);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Shirley', 162, 'The jurney begins: a cillum est eligendi. ', 162);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Gates', 163, 'The jurney begins: libero impedit. ', 163);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Ernest', 164, 'The jurney begins: lorem et mollitia harum non occaecat.  culpa odio id est deserunt corrupti. ', 164);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Darren', 165, 'The jurney begins: est in impedit et eos ut. ', 165);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Jeremy', 166, 'The jurney begins: anim in ut dignissimos laborum id.  tempore fuga aute. ', 166);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Glen', 167, 'The jurney begins: itaque. ', 167);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Chazz', 168, 'The jurney begins: ut et. ', 168);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Kurtwood', 169, 'The jurney begins: sapiente repudiandae nulla sunt et maxime.  id ut qui. ', 169);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Toshiro', 170, 'The jurney begins: dolores. ', 170);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Radney', 171, 'The jurney begins: nam nobis laborum reprehenderit minus eligendi.  deserunt nam cillum qui anim par', 171);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Faye', 172, 'The jurney begins: placeat dignissimos saepe laborum. ', 172);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Nicky', 173, 'The jurney begins: ', 173);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Joaquim', 174, 'The jurney begins: voluptatum cumque sapiente corrupti. ', 174);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Marie', 175, 'The jurney begins: ', 175);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Shannyn', 176, 'The jurney begins: delectus at amet necessitatibus incididunt iusto.  assumenda quis pariatur ad. ', 176);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Nikki', 177, 'The jurney begins: at est do dignissimos. ', 177);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Dave', 178, 'The jurney begins: ut quod eveniet adipisicing molestias ad.  et voluptas reprehenderit. ', 178);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Bob', 179, 'The jurney begins: ducimus. ', 179);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Val', 180, 'The jurney begins: incididunt. ', 180);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Val', 181, 'The jurney begins: non aut non itaque iusto temporibus. ', 181);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Terri', 182, 'The jurney begins: ', 182);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Collective', 183, 'The jurney begins: debitis. ', 183);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Vin', 184, 'The jurney begins: duis molestiae sapiente. ', 184);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Trini', 185, 'The jurney begins: sunt harum ut. ', 185);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Buddy', 186, 'The jurney begins: ', 186);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Forest', 187, 'The jurney begins: eu et. ', 187);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Jeff', 188, 'The jurney begins: amet earum consectetur amet. ', 188);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Natascha', 189, 'The jurney begins: enim est aut ducimus voluptates ex.  minus ut similique delectus molestias. ', 189);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Denis', 190, 'The jurney begins: quidem in mollitia minim eiusmod sint.  asperiores minus cupiditate sed est offic', 190);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Scarlett', 191, 'The jurney begins: in eu velit ut veniam. ', 191);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Hector', 192, 'The jurney begins: ut velit consequat et. ', 192);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Hikaru', 193, 'The jurney begins: in deserunt ut consectetur placeat nulla.  aut dolor. ', 193);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Mindy', 194, 'The jurney begins: tempor repellat qui laboris deserunt harum.  exercitation corrupti occaecat. ', 194);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('CeCe', 195, 'The jurney begins: est delectus aut voluptate in voluptatibus.  nam aut saepe animi do mollitia. ', 195);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Amanda', 196, 'The jurney begins: aut repudiandae non rerum pariatur in.  nisi et tempor sint ut voluptate. ', 196);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Judy', 197, 'The jurney begins: amet non occaecat quos necessitatibus ducimus.  et assumenda enim quas. ', 197);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Balthazar', 198, 'The jurney begins: est laborum nobis in nobis esse.  omnis voluptate. ', 198);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Nancy', 199, 'The jurney begins: officia in esse et tempore lorem. ', 199);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Ivan', 200, 'The jurney begins: est animi omnis voluptas voluptas sint.  id cum ut. ', 200);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Ani', 201, 'The jurney begins: sunt hic nulla optio quidem alias.  deleniti ut doloribus eos. ', 201);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Candice', 202, 'The jurney begins: quo proident non a ad eveniet.  blanditiis eiusmod sunt. ', 202);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Dennis', 203, 'The jurney begins: quas voluptas omnis elit omnis aut.  qui maxime ut accusamus animi. ', 203);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Alex', 204, 'The jurney begins: placeat. ', 204);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Garth', 205, 'The jurney begins: voluptatum magna alias deserunt non autem.  tenetur aut. ', 205);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Phil', 206, 'The jurney begins: et culpa et laborum praesentium aliqua. ', 206);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Kate', 207, 'The jurney begins: occaecat incididunt occaecati mollitia ad eu. ', 207);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Courtney', 208, 'The jurney begins: praesentium exercitation cillum harum labore. ', 208);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Sona', 209, 'The jurney begins: labore facilis corrupti ipsum nulla eveniet.  elit et voluptates est sunt nihil. ', 209);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Rick', 210, 'The jurney begins: dolores harum laborum velit aliqua non.  optio rerum deserunt. ', 210);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Gena', 211, 'The jurney begins: aut sunt eveniet sed voluptas anim.  eos ut facere saepe dolor. ', 211);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Bill', 212, 'The jurney begins: vero omnis quibusdam in nobis mollitia.  assumenda nobis consequat voluptates. ', 212);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Benjamin', 213, 'The jurney begins: et deleniti aliqua cupidatat amet irure.  saepe eiusmod lorem sunt voluptate volu', 213);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Nastassja', 214, 'The jurney begins: sint accusamus blanditiis occaecati temporibus. ', 214);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Taylor', 215, 'The jurney begins: officiis mollit labore impedit eveniet officiis.  quis aut rerum aut non et. ', 215);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Jared', 216, 'The jurney begins: elit esse rerum. ', 216);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Jerry', 217, 'The jurney begins: dolor nulla eu tenetur nostrud maxime.  enim molestias ex aut. ', 217);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Latin', 218, 'The jurney begins: mollit irure voluptatum ducimus sint et.  lorem aut. ', 218);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Ozzy', 219, 'The jurney begins: impedit labore facilis non quis est.  repellendus. ', 219);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Steve', 220, 'The jurney begins: id enim saepe harum maxime rerum.  nostrud dolorum aut. ', 220);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Beverley', 221, 'The jurney begins: omnis esse voluptatibus recusandae occaecat. ', 221);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Edward', 222, 'The jurney begins: est aliqua tempor culpa quidem est.  voluptate voluptate ad lorem ipsum. ', 222);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Jose', 223, 'The jurney begins: elit consequat sapiente magna quo provident.  a sunt cum cupiditate ipsum sapient', 223);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Talvin', 224, 'The jurney begins: est id id officia earum ut.  quidem laborum rerum. ', 224);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Maceo', 225, 'The jurney begins: in adipisicing pariatur hic ut. ', 225);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Charlton', 226, 'The jurney begins: blanditiis culpa ea ut aute et.  qui quo est dolor voluptates minim.  veniam. ', 226);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Gordon', 227, 'The jurney begins: officiis nostrud itaque et. ', 227);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Geena', 228, 'The jurney begins: et eligendi accusamus quo velit dolore.  optio cum excepteur et nihil voluptatum.', 228);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Hope', 229, 'The jurney begins: maiores nobis facilis et voluptates ea.  amet elit est nostrud id qui. ', 229);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Elijah', 230, 'The jurney begins: molestias iusto ut non voluptatum pariatur.  molestias. ', 230);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Pete', 231, 'The jurney begins: quas vero voluptas accusamus nihil. ', 231);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Edie', 232, 'The jurney begins: temporibus hic quidem omnis. ', 232);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Nathan', 233, 'The jurney begins: aliquip dignissimos autem iusto eligendi. ', 233);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Toshiro', 234, 'The jurney begins: deserunt provident est non alias provident.  aliqua animi est mollit. ', 234);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Neneh', 235, 'The jurney begins: at quas provident eligendi adipisicing. ', 235);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Julianna', 236, 'The jurney begins: est cum officia sint. ', 236);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Alana', 237, 'The jurney begins: praesentium autem. ', 237);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Shannyn', 238, 'The jurney begins: et officia sint mollitia sit iusto.  consequat recusandae id impedit asperiores e', 238);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Giancarlo', 239, 'The jurney begins: aut corrupti et do quidem temporibus.  et. ', 239);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Taye', 240, 'The jurney begins: distinctio repudiandae cumque non incididunt dolores.  soluta officia a est. ', 240);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Kitty', 241, 'The jurney begins: iusto quidem. ', 241);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Sarah', 242, 'The jurney begins: deserunt repudiandae molestias laborum non. ', 242);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Luke', 243, 'The jurney begins: magna officia dolore. ', 243);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Alec', 244, 'The jurney begins: aut repellendus assumenda et occaecat laborum.  cum. ', 244);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Vertical', 245, 'The jurney begins: occaecat accusamus non est quos. ', 245);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Neneh', 246, 'The jurney begins: maxime eveniet doloribus voluptatum sapiente qui.  ullamco. ', 246);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Maceo', 247, 'The jurney begins: rerum debitis quos labore dolor repellendus.  consequat. ', 247);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Ernie', 248, 'The jurney begins: proident omnis non aut autem dolor. ', 248);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Colm', 249, 'The jurney begins: fuga et fugiat exercitation distinctio fuga.  fugiat adipisicing. ', 249);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Allison', 250, 'The jurney begins: ', 250);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Dylan', 251, 'The jurney begins: duis repellat ipsum blanditiis nisi et.  id vero qui delectus. ', 251);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Ricky', 252, 'The jurney begins: recusandae nihil ad. ', 252);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Chalee', 253, 'The jurney begins: rerum in non distinctio soluta fuga. ', 253);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Mia', 254, 'The jurney begins: dignissimos esse nisi molestiae itaque. ', 254);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Nils', 255, 'The jurney begins: libero optio dolor molestias aut rerum.  odio. ', 255);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Lynn', 256, 'The jurney begins: aut qui ex tempor. ', 256);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Norm', 257, 'The jurney begins: repellendus et. ', 257);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Graham', 258, 'The jurney begins: atque sapiente facere do iusto at.  rerum incididunt aliqua et corrupti duis. ', 258);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Crispin', 259, 'The jurney begins: et. ', 259);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Lindsay', 260, 'The jurney begins: sed occaecat repellat provident pariatur corrupti.  minim quos dolor provident ut', 260);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Robert', 261, 'The jurney begins: occaecati dolor eu aut minus quod. ', 261);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Maury', 262, 'The jurney begins: reprehenderit. ', 262);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Cesar', 263, 'The jurney begins: eligendi eos elit sint cillum laborum.  ad maiores necessitatibus. ', 263);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Carole', 264, 'The jurney begins: ', 264);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Eugene', 265, 'The jurney begins: et eiusmod sunt asperiores occaecati aute.  rerum adipisicing id officia. ', 265);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Harrison', 266, 'The jurney begins: do necessitatibus minus lorem lorem nobis.  elit adipisicing at soluta omnis ea. ', 266);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Humberto', 267, 'The jurney begins: laborum soluta quibusdam in quidem non.  sunt. ', 267);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Minnie', 268, 'The jurney begins: expedita est impedit voluptate praesentium voluptatibus. ', 268);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Kate', 269, 'The jurney begins: quidem dolores voluptatum et blanditiis dignissimos.  ea consequatur dignissimos ', 269);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Kiefer', 270, 'The jurney begins: repellendus in. ', 270);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Paula', 271, 'The jurney begins: ', 271);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Marisa', 272, 'The jurney begins: aliquip nobis. ', 272);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Nile', 273, 'The jurney begins: hic. ', 273);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Lloyd', 274, 'The jurney begins: et et omnis sint et. ', 274);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Derrick', 275, 'The jurney begins: excepturi hic. ', 275);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Terry', 276, 'The jurney begins: mollit quidem. ', 276);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Louise', 277, 'The jurney begins: omnis id sunt autem culpa sunt.  eveniet. ', 277);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Mandy', 278, 'The jurney begins: dolorum reiciendis sed quos omnis dolore.  sint cillum. ', 278);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Rob', 279, 'The jurney begins: vero sed eligendi id et et.  dolore ducimus culpa. ', 279);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Juliana', 280, 'The jurney begins: accusamus elit cillum id libero distinctio.  ducimus in temporibus laboris elit m', 280);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Temuera', 281, 'The jurney begins: eos repellendus deserunt voluptatum nihil sunt.  dolorum. ', 281);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Bobbi', 282, 'The jurney begins: magna nisi et laborum a soluta.  voluptatum dolorum culpa dolor. ', 282);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Seth', 283, 'The jurney begins: nam id maxime in et in.  exercitation. ', 283);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Patti', 284, 'The jurney begins: voluptatibus et debitis debitis. ', 284);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Rachid', 285, 'The jurney begins: nobis facilis occaecati. ', 285);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Lois', 286, 'The jurney begins: nostrud et corrupti atque at. ', 286);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Bobby', 287, 'The jurney begins: aut expedita rerum perferendis magna reiciendis.  dolor eligendi commodo ut. ', 287);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Joy', 288, 'The jurney begins: deleniti in molestiae dolor fugiat eos.  quos non laboris excepturi. ', 288);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Mandy', 289, 'The jurney begins: quod. ', 289);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Freddy', 290, 'The jurney begins: dolor omnis sapiente occaecati quos commodo.  quibusdam. ', 290);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Edward', 291, 'The jurney begins: eos id incididunt minus molestiae aut.  et dolor occaecati sint deserunt esse. ', 291);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Maureen', 292, 'The jurney begins: possimus rerum id dolore delectus laborum.  dolorum esse elit ut minim aliquip. ', 292);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Ani', 293, 'The jurney begins: aut animi est est occaecat expedita.  rerum excepturi dolore est exercitation. ', 293);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Joshua', 294, 'The jurney begins: ', 294);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Susan', 295, 'The jurney begins: dolor necessitatibus quod et elit optio.  enim ut animi. ', 295);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Chad', 296, 'The jurney begins: expedita dolore officiis accusamus qui in.  adipisicing tempore et. ', 296);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Vonda', 297, 'The jurney begins: et distinctio qui dolorum ut eveniet.  ducimus sint impedit deleniti. ', 297);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Regina', 298, 'The jurney begins: soluta molestias non fuga tenetur perferendis.  praesentium saepe. ', 298);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Praga', 299, 'The jurney begins: voluptas occaecat non facere id. ', 299);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Salma', 300, 'The jurney begins: optio ducimus corrupti cillum autem dolores.  duis deserunt voluptatibus elit. ', 300);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Jena', 301, 'The jurney begins: itaque amet exercitation quibusdam officiis. ', 301);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Mykelti', 302, 'The jurney begins: voluptas sint nulla excepteur ullamco maiores.  corrupti ut aliqua est mollit do.', 302);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Goldie', 303, 'The jurney begins: rerum et omnis ut est nihil.  occaecati eligendi ullamco ex ut vero.  in. ', 303);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Loreena', 304, 'The jurney begins: ex dignissimos. ', 304);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Carolyn', 305, 'The jurney begins: et labore adipisicing. ', 305);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Rueben', 306, 'The jurney begins: a. ', 306);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Freda', 307, 'The jurney begins: repellendus in. ', 307);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Burt', 308, 'The jurney begins: in tenetur et laboris et excepturi.  maiores. ', 308);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Franco', 309, 'The jurney begins: repellat accusamus. ', 309);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Pamela', 310, 'The jurney begins: provident voluptates facere repellat sed nisi.  blanditiis et. ', 310);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Vertical', 311, 'The jurney begins: ', 311);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Woody', 312, 'The jurney begins: ut rerum animi aliquip eligendi. ', 312);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Roscoe', 313, 'The jurney begins: consectetur incididunt sint molestiae. ', 313);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Kurt', 314, 'The jurney begins: proident est exercitation animi dolore tenetur. ', 314);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Harriet', 315, 'The jurney begins: sapiente non dolor soluta vero voluptates.  deleniti magna sapiente alias eu. ', 315);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Ice', 316, 'The jurney begins: sit qui irure assumenda qui ut.  fugiat blanditiis et qui repudiandae at.  repell', 316);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Avenged', 317, 'The jurney begins: cillum eu fuga harum voluptatibus voluptatibus.  blanditiis tempore repudiandae. ', 317);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Johnny', 318, 'The jurney begins: qui eu. ', 318);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Kris', 319, 'The jurney begins: dolores est deleniti quos. ', 319);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Liquid', 320, 'The jurney begins: libero nihil libero corrupti nostrud eu.  in delectus irure. ', 320);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Shelby', 321, 'The jurney begins: tenetur non eos id necessitatibus. ', 321);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Isaiah', 322, 'The jurney begins: iusto optio cumque. ', 322);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Roddy', 323, 'The jurney begins: et. ', 323);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Frankie', 324, 'The jurney begins: harum et in officiis incididunt perferendis.  eveniet. ', 324);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Candice', 325, 'The jurney begins: quis placeat qui non in hic.  deserunt et facere est odio. ', 325);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Campbell', 326, 'The jurney begins: at. ', 326);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Millie', 327, 'The jurney begins: ', 327);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Isaiah', 328, 'The jurney begins: non ut laboris ex eiusmod et.  dolore et perferendis magna elit reprehenderit. ', 328);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Buddy', 329, 'The jurney begins: atque repudiandae est eveniet et deserunt.  quibusdam reiciendis ut. ', 329);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Debi', 330, 'The jurney begins: officia minus accusamus est est ducimus. ', 330);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Cornell', 331, 'The jurney begins: omnis sunt et blanditiis ad ut.  facere sit irure lorem. ', 331);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Mira', 332, 'The jurney begins: quos possimus dolore quo distinctio ullamco.  deserunt voluptatibus reiciendis et', 332);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Scott', 333, 'The jurney begins: dolor aute dolor sint repudiandae anim. ', 333);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Annie', 334, 'The jurney begins: odio excepturi adipisicing eos sapiente laborum.  minus atque ut harum est dolore', 334);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Natalie', 335, 'The jurney begins: est tenetur optio velit dolores in.  expedita provident laboris irure maxime dolo', 335);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Jennifer', 336, 'The jurney begins: quod est irure cumque iusto sint.  culpa soluta nostrud. ', 336);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Kay', 337, 'The jurney begins: voluptates nam ad dignissimos incididunt lorem.  nam. ', 337);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Ellen', 338, 'The jurney begins: dolor culpa eu minus iusto eveniet. ', 338);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Rade', 339, 'The jurney begins: deserunt dolorum blanditiis omnis saepe animi.  sint alias et. ', 339);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Rory', 340, 'The jurney begins: distinctio dolor aliquip. ', 340);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Victor', 341, 'The jurney begins: corrupti laborum amet necessitatibus magna labore.  fuga. ', 341);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Emm', 342, 'The jurney begins: maiores. ', 342);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Woody', 343, 'The jurney begins: minim mollit. ', 343);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Chubby', 344, 'The jurney begins: provident at necessitatibus doloribus. ', 344);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Nik', 345, 'The jurney begins: voluptate lorem. ', 345);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Rhys', 346, 'The jurney begins: dignissimos sunt. ', 346);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Chubby', 347, 'The jurney begins: rerum ut amet debitis deserunt magna.  et cillum ex et deserunt aute. ', 347);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Julia', 348, 'The jurney begins: non ullamco eos alias occaecat quod.  minim eu. ', 348);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Kelly', 349, 'The jurney begins: quod laborum culpa reprehenderit qui velit.  consequat aliquip excepteur. ', 349);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Janice', 350, 'The jurney begins: id eos tempore est sint molestiae.  lorem. ', 350);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Jonathan', 351, 'The jurney begins: id. ', 351);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Rita', 352, 'The jurney begins: nihil et corrupti in animi recusandae.  omnis sint. ', 352);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Earl', 353, 'The jurney begins: distinctio et. ', 353);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Wade', 354, 'The jurney begins: ex placeat fuga sed est nostrud. ', 354);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Maureen', 355, 'The jurney begins: ', 355);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Cliff', 356, 'The jurney begins: ', 356);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Micky', 357, 'The jurney begins: excepteur deserunt aliquip occaecati amet at.  distinctio officia deserunt repudi', 357);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Garth', 358, 'The jurney begins: assumenda ut maiores est occaecat officiis.  voluptas. ', 358);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Breckin', 359, 'The jurney begins: incididunt in in et perferendis est.  sint labore duis. ', 359);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Ellen', 360, 'The jurney begins: amet autem facilis officiis et eos.  et omnis. ', 360);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Daniel', 361, 'The jurney begins: cupidatat excepteur proident mollitia lorem irure.  deleniti hic facere. ', 361);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Stewart', 362, 'The jurney begins: culpa est corrupti magna deserunt officia.  est voluptatibus voluptas et ut. ', 362);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Freda', 363, 'The jurney begins: distinctio assumenda itaque. ', 363);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Kenny', 364, 'The jurney begins: ', 364);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Christian', 365, 'The jurney begins: necessitatibus asperiores eu officia possimus commodo.  nostrud quos. ', 365);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Mac', 366, 'The jurney begins: molestiae et non excepturi ducimus placeat. ', 366);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Sara', 367, 'The jurney begins: proident duis eos minim. ', 367);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Danni', 368, 'The jurney begins: do necessitatibus est ut qui ut. ', 368);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Cloris', 369, 'The jurney begins: et aut. ', 369);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Debbie', 370, 'The jurney begins: quidem nostrud sint hic elit. ', 370);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Fisher', 371, 'The jurney begins: eos duis reiciendis velit et quibusdam.  ullamco omnis dolore cum deserunt. ', 371);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Joan', 372, 'The jurney begins: aut sint incididunt dolor enim eu.  soluta omnis repellat. ', 372);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Lou', 373, 'The jurney begins: odio minim sint nulla tenetur dolorum.  nulla ut molestias harum ut. ', 373);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Kylie', 374, 'The jurney begins: sint dignissimos ipsum. ', 374);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Fionnula', 375, 'The jurney begins: libero id excepturi non possimus qui.  eveniet non minim repudiandae. ', 375);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Trini', 376, 'The jurney begins: ', 376);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Halle', 377, 'The jurney begins: laboris. ', 377);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Robbie', 378, 'The jurney begins: dolore reprehenderit et et distinctio quo.  eu in nihil aute facere atque.  animi', 378);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Dan', 379, 'The jurney begins: mollitia tempore saepe atque animi maiores.  omnis aut enim officia laborum sapie', 379);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Nick', 380, 'The jurney begins: praesentium. ', 380);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Crispin', 381, 'The jurney begins: sunt velit. ', 381);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Brad', 382, 'The jurney begins: quod saepe. ', 382);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Davy', 383, 'The jurney begins: qui. ', 383);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Madeleine', 384, 'The jurney begins: similique laborum mollit excepteur sunt. ', 384);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Cathy', 385, 'The jurney begins: adipisicing ea commodo earum elit dolor. ', 385);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Marina', 386, 'The jurney begins: eu sapiente est consequat qui nisi. ', 386);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Gary', 387, 'The jurney begins: officia doloribus blanditiis magna ea aut.  repellat laborum optio in id. ', 387);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Rachel', 388, 'The jurney begins: exercitation et voluptates eveniet cupidatat possimus. ', 388);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Clea', 389, 'The jurney begins: in eos commodo occaecati. ', 389);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Rhys', 390, 'The jurney begins: animi facilis et dolore et sunt.  ipsum consectetur. ', 390);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Spencer', 391, 'The jurney begins: qui blanditiis eos pariatur sint dolor.  hic a nostrud officia dolorum. ', 391);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Lara', 392, 'The jurney begins: non ut rerum et in et.  tempore in nulla placeat tenetur ut.  aut commodo. ', 392);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Radney', 393, 'The jurney begins: necessitatibus et occaecati. ', 393);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Harvey', 394, 'The jurney begins: sunt labore est mollitia ducimus impedit. ', 394);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Millie', 395, 'The jurney begins: ', 395);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Tobey', 396, 'The jurney begins: ', 396);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Stephanie', 397, 'The jurney begins: necessitatibus molestiae rerum sint elit nihil. ', 397);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Leelee', 398, 'The jurney begins: itaque earum. ', 398);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Stanley', 399, 'The jurney begins: repellat eiusmod. ', 399);
insert into DESTINATIONS (name, id_destinations, description, id_trip)
values ('Lloyd', 400, 'The jurney begins: nisi reiciendis aute in. ', 400);
prompt 400 records loaded
prompt Loading GUARD...
insert into GUARD (name, id_guard, number_phone)
values ('Tobey', 1, '0578081');
insert into GUARD (name, id_guard, number_phone)
values ('Fionnula', 2, '0597897');
insert into GUARD (name, id_guard, number_phone)
values ('Maceo', 3, '0598009');
insert into GUARD (name, id_guard, number_phone)
values ('Moe', 4, '0538061');
insert into GUARD (name, id_guard, number_phone)
values ('Roger', 5, '0541920');
insert into GUARD (name, id_guard, number_phone)
values ('Daniel', 6, '0527082');
insert into GUARD (name, id_guard, number_phone)
values ('Christmas', 7, '0538773');
insert into GUARD (name, id_guard, number_phone)
values ('Tia', 8, '0513562');
insert into GUARD (name, id_guard, number_phone)
values ('Cliff', 9, '0524761');
insert into GUARD (name, id_guard, number_phone)
values ('Laura', 10, '0539840');
insert into GUARD (name, id_guard, number_phone)
values ('Ernest', 11, '0558462');
insert into GUARD (name, id_guard, number_phone)
values ('Kathleen', 12, '0582316');
insert into GUARD (name, id_guard, number_phone)
values ('Jann', 13, '0587873');
insert into GUARD (name, id_guard, number_phone)
values ('Bobbi', 14, '0549511');
insert into GUARD (name, id_guard, number_phone)
values ('Cornell', 15, '0572329');
insert into GUARD (name, id_guard, number_phone)
values ('Hope', 16, '0589137');
insert into GUARD (name, id_guard, number_phone)
values ('Juice', 17, '0531056');
insert into GUARD (name, id_guard, number_phone)
values ('Gailard', 18, '0593485');
insert into GUARD (name, id_guard, number_phone)
values ('Edie', 19, '0528747');
insert into GUARD (name, id_guard, number_phone)
values ('Ronny', 20, '0546417');
insert into GUARD (name, id_guard, number_phone)
values ('Nick', 21, '0567704');
insert into GUARD (name, id_guard, number_phone)
values ('Rhea', 22, '0524932');
insert into GUARD (name, id_guard, number_phone)
values ('Elle', 23, '0559243');
insert into GUARD (name, id_guard, number_phone)
values ('Rickie', 24, '0558704');
insert into GUARD (name, id_guard, number_phone)
values ('Rebecca', 25, '0576221');
insert into GUARD (name, id_guard, number_phone)
values ('Spike', 26, '0557733');
insert into GUARD (name, id_guard, number_phone)
values ('Christian', 27, '0526911');
insert into GUARD (name, id_guard, number_phone)
values ('Kevin', 28, '0528245');
insert into GUARD (name, id_guard, number_phone)
values ('Shirley', 29, '0554221');
insert into GUARD (name, id_guard, number_phone)
values ('Carla', 30, '0599422');
insert into GUARD (name, id_guard, number_phone)
values ('Aaron', 31, '0563344');
insert into GUARD (name, id_guard, number_phone)
values ('Lonnie', 32, '0532499');
insert into GUARD (name, id_guard, number_phone)
values ('Vanessa', 33, '0560969');
insert into GUARD (name, id_guard, number_phone)
values ('Woody', 34, '0528247');
insert into GUARD (name, id_guard, number_phone)
values ('Wayman', 35, '0552744');
insert into GUARD (name, id_guard, number_phone)
values ('Isabella', 36, '0590033');
insert into GUARD (name, id_guard, number_phone)
values ('Andie', 37, '0574830');
insert into GUARD (name, id_guard, number_phone)
values ('Shannyn', 38, '0578792');
insert into GUARD (name, id_guard, number_phone)
values ('Lesley', 39, '0545952');
insert into GUARD (name, id_guard, number_phone)
values ('Gates', 40, '0588211');
insert into GUARD (name, id_guard, number_phone)
values ('Russell', 41, '0516513');
insert into GUARD (name, id_guard, number_phone)
values ('Lance', 42, '0561227');
insert into GUARD (name, id_guard, number_phone)
values ('Bobbi', 43, '0539578');
insert into GUARD (name, id_guard, number_phone)
values ('Danny', 44, '0579934');
insert into GUARD (name, id_guard, number_phone)
values ('Busta', 45, '0577445');
insert into GUARD (name, id_guard, number_phone)
values ('Kathy', 46, '0587264');
insert into GUARD (name, id_guard, number_phone)
values ('Latin', 47, '0529361');
insert into GUARD (name, id_guard, number_phone)
values ('Marie', 48, '0536147');
insert into GUARD (name, id_guard, number_phone)
values ('Mary-Louise', 49, '0599573');
insert into GUARD (name, id_guard, number_phone)
values ('Teri', 50, '0511009');
insert into GUARD (name, id_guard, number_phone)
values ('Elvis', 51, '0526068');
insert into GUARD (name, id_guard, number_phone)
values ('Rueben', 52, '0545389');
insert into GUARD (name, id_guard, number_phone)
values ('Ice', 53, '0566709');
insert into GUARD (name, id_guard, number_phone)
values ('Rosanne', 54, '0581122');
insert into GUARD (name, id_guard, number_phone)
values ('Raul', 55, '0536166');
insert into GUARD (name, id_guard, number_phone)
values ('Dylan', 56, '0554302');
insert into GUARD (name, id_guard, number_phone)
values ('Wang', 57, '0555630');
insert into GUARD (name, id_guard, number_phone)
values ('Ellen', 58, '0524920');
insert into GUARD (name, id_guard, number_phone)
values ('Talvin', 59, '0556307');
insert into GUARD (name, id_guard, number_phone)
values ('Allan', 60, '0586141');
insert into GUARD (name, id_guard, number_phone)
values ('Lucy', 61, '0526505');
insert into GUARD (name, id_guard, number_phone)
values ('Drew', 62, '0592117');
insert into GUARD (name, id_guard, number_phone)
values ('Curt', 63, '0536061');
insert into GUARD (name, id_guard, number_phone)
values ('Ronny', 64, '0575731');
insert into GUARD (name, id_guard, number_phone)
values ('Liv', 65, '0558087');
insert into GUARD (name, id_guard, number_phone)
values ('Lenny', 66, '0511207');
insert into GUARD (name, id_guard, number_phone)
values ('Annette', 67, '0572350');
insert into GUARD (name, id_guard, number_phone)
values ('Ellen', 68, '0562704');
insert into GUARD (name, id_guard, number_phone)
values ('Jena', 69, '0528304');
insert into GUARD (name, id_guard, number_phone)
values ('Bridgette', 70, '0518281');
insert into GUARD (name, id_guard, number_phone)
values ('Stellan', 71, '0577348');
insert into GUARD (name, id_guard, number_phone)
values ('Jean-Luc', 72, '0537569');
insert into GUARD (name, id_guard, number_phone)
values ('Gene', 73, '0554712');
insert into GUARD (name, id_guard, number_phone)
values ('Garland', 74, '0558325');
insert into GUARD (name, id_guard, number_phone)
values ('Regina', 75, '0526351');
insert into GUARD (name, id_guard, number_phone)
values ('Bebe', 76, '0545150');
insert into GUARD (name, id_guard, number_phone)
values ('Victor', 77, '0512197');
insert into GUARD (name, id_guard, number_phone)
values ('King', 78, '0578605');
insert into GUARD (name, id_guard, number_phone)
values ('Alex', 79, '0584852');
insert into GUARD (name, id_guard, number_phone)
values ('Vincent', 80, '0575795');
insert into GUARD (name, id_guard, number_phone)
values ('Brad', 81, '0558743');
insert into GUARD (name, id_guard, number_phone)
values ('Jerry', 82, '0542979');
insert into GUARD (name, id_guard, number_phone)
values ('Joseph', 83, '0563634');
insert into GUARD (name, id_guard, number_phone)
values ('Janeane', 84, '0520930');
insert into GUARD (name, id_guard, number_phone)
values ('Curt', 85, '0580545');
insert into GUARD (name, id_guard, number_phone)
values ('Halle', 86, '0589510');
insert into GUARD (name, id_guard, number_phone)
values ('Alfred', 87, '0576802');
insert into GUARD (name, id_guard, number_phone)
values ('Joseph', 88, '0516600');
insert into GUARD (name, id_guard, number_phone)
values ('Udo', 89, '0543168');
insert into GUARD (name, id_guard, number_phone)
values ('Lena', 90, '0599052');
insert into GUARD (name, id_guard, number_phone)
values ('Christmas', 91, '0576175');
insert into GUARD (name, id_guard, number_phone)
values ('Ralph', 92, '0591335');
insert into GUARD (name, id_guard, number_phone)
values ('Larry', 93, '0570910');
insert into GUARD (name, id_guard, number_phone)
values ('Ricardo', 94, '0572014');
insert into GUARD (name, id_guard, number_phone)
values ('Nancy', 95, '0563942');
insert into GUARD (name, id_guard, number_phone)
values ('Viggo', 96, '0564600');
insert into GUARD (name, id_guard, number_phone)
values ('Brian', 97, '0562434');
insert into GUARD (name, id_guard, number_phone)
values ('Glenn', 98, '0511929');
insert into GUARD (name, id_guard, number_phone)
values ('Willie', 99, '0542638');
insert into GUARD (name, id_guard, number_phone)
values ('Carlene', 100, '0595749');
insert into GUARD (name, id_guard, number_phone)
values ('Mary Beth', 101, '0595546');
insert into GUARD (name, id_guard, number_phone)
values ('Nicole', 102, '0596710');
insert into GUARD (name, id_guard, number_phone)
values ('Irene', 103, '0563716');
insert into GUARD (name, id_guard, number_phone)
values ('Judy', 104, '0554286');
insert into GUARD (name, id_guard, number_phone)
values ('Doug', 105, '0559335');
insert into GUARD (name, id_guard, number_phone)
values ('Natalie', 106, '0542419');
insert into GUARD (name, id_guard, number_phone)
values ('Nelly', 107, '0580540');
insert into GUARD (name, id_guard, number_phone)
values ('Lindsey', 108, '0568906');
insert into GUARD (name, id_guard, number_phone)
values ('Ramsey', 109, '0559728');
insert into GUARD (name, id_guard, number_phone)
values ('Anjelica', 110, '0521018');
insert into GUARD (name, id_guard, number_phone)
values ('Jim', 111, '0530098');
insert into GUARD (name, id_guard, number_phone)
values ('Kirsten', 112, '0514374');
insert into GUARD (name, id_guard, number_phone)
values ('Mary', 113, '0557900');
insert into GUARD (name, id_guard, number_phone)
values ('Julianne', 114, '0519941');
insert into GUARD (name, id_guard, number_phone)
values ('Collin', 115, '0597072');
insert into GUARD (name, id_guard, number_phone)
values ('Bradley', 116, '0597051');
insert into GUARD (name, id_guard, number_phone)
values ('William', 117, '0581628');
insert into GUARD (name, id_guard, number_phone)
values ('Robby', 118, '0512864');
insert into GUARD (name, id_guard, number_phone)
values ('Faye', 119, '0582331');
insert into GUARD (name, id_guard, number_phone)
values ('Orlando', 120, '0591255');
insert into GUARD (name, id_guard, number_phone)
values ('Jonny', 121, '0510259');
insert into GUARD (name, id_guard, number_phone)
values ('Josh', 122, '0548526');
insert into GUARD (name, id_guard, number_phone)
values ('Chloe', 123, '0554039');
insert into GUARD (name, id_guard, number_phone)
values ('Merillee', 124, '0589215');
insert into GUARD (name, id_guard, number_phone)
values ('Lynette', 125, '0580295');
insert into GUARD (name, id_guard, number_phone)
values ('Ving', 126, '0541291');
insert into GUARD (name, id_guard, number_phone)
values ('Ashley', 127, '0592169');
insert into GUARD (name, id_guard, number_phone)
values ('Stellan', 128, '0517147');
insert into GUARD (name, id_guard, number_phone)
values ('Darren', 129, '0560255');
insert into GUARD (name, id_guard, number_phone)
values ('Neil', 130, '0558989');
insert into GUARD (name, id_guard, number_phone)
values ('Ray', 131, '0540900');
insert into GUARD (name, id_guard, number_phone)
values ('Manu', 132, '0597743');
insert into GUARD (name, id_guard, number_phone)
values ('Freda', 133, '0575316');
insert into GUARD (name, id_guard, number_phone)
values ('Cherry', 134, '0548569');
insert into GUARD (name, id_guard, number_phone)
values ('Thelma', 135, '0530081');
insert into GUARD (name, id_guard, number_phone)
values ('Forest', 136, '0518079');
insert into GUARD (name, id_guard, number_phone)
values ('Bernard', 137, '0575399');
insert into GUARD (name, id_guard, number_phone)
values ('Spike', 138, '0544174');
insert into GUARD (name, id_guard, number_phone)
values ('James', 139, '0579837');
insert into GUARD (name, id_guard, number_phone)
values ('Kyra', 140, '0540274');
insert into GUARD (name, id_guard, number_phone)
values ('Wang', 141, '0510529');
insert into GUARD (name, id_guard, number_phone)
values ('Charlton', 142, '0596900');
insert into GUARD (name, id_guard, number_phone)
values ('Neneh', 143, '0520974');
insert into GUARD (name, id_guard, number_phone)
values ('Jessica', 144, '0591068');
insert into GUARD (name, id_guard, number_phone)
values ('Graham', 145, '0518993');
insert into GUARD (name, id_guard, number_phone)
values ('Mae', 146, '0573248');
insert into GUARD (name, id_guard, number_phone)
values ('Kathy', 147, '0588386');
insert into GUARD (name, id_guard, number_phone)
values ('Cole', 148, '0552539');
insert into GUARD (name, id_guard, number_phone)
values ('Ronnie', 149, '0574878');
insert into GUARD (name, id_guard, number_phone)
values ('Dean', 150, '0546273');
insert into GUARD (name, id_guard, number_phone)
values ('Illeana', 151, '0555856');
insert into GUARD (name, id_guard, number_phone)
values ('Sheryl', 152, '0562694');
insert into GUARD (name, id_guard, number_phone)
values ('Daryle', 153, '0550456');
insert into GUARD (name, id_guard, number_phone)
values ('Edward', 154, '0586678');
insert into GUARD (name, id_guard, number_phone)
values ('Goldie', 155, '0584965');
insert into GUARD (name, id_guard, number_phone)
values ('Stephen', 156, '0575842');
insert into GUARD (name, id_guard, number_phone)
values ('Edwin', 157, '0538001');
insert into GUARD (name, id_guard, number_phone)
values ('Desmond', 158, '0555886');
insert into GUARD (name, id_guard, number_phone)
values ('Timothy', 159, '0561433');
insert into GUARD (name, id_guard, number_phone)
values ('Kelly', 160, '0519590');
insert into GUARD (name, id_guard, number_phone)
values ('Wes', 161, '0591409');
insert into GUARD (name, id_guard, number_phone)
values ('Seth', 162, '0521440');
insert into GUARD (name, id_guard, number_phone)
values ('Carla', 163, '0566650');
insert into GUARD (name, id_guard, number_phone)
values ('Dick', 164, '0535044');
insert into GUARD (name, id_guard, number_phone)
values ('Graham', 165, '0559587');
insert into GUARD (name, id_guard, number_phone)
values ('Maxine', 166, '0550180');
insert into GUARD (name, id_guard, number_phone)
values ('Ozzy', 167, '0522453');
insert into GUARD (name, id_guard, number_phone)
values ('Eric', 168, '0533299');
insert into GUARD (name, id_guard, number_phone)
values ('Cheryl', 169, '0554116');
insert into GUARD (name, id_guard, number_phone)
values ('Lucy', 170, '0576910');
insert into GUARD (name, id_guard, number_phone)
values ('Rip', 171, '0537325');
insert into GUARD (name, id_guard, number_phone)
values ('Bret', 172, '0582158');
insert into GUARD (name, id_guard, number_phone)
values ('Molly', 173, '0599764');
insert into GUARD (name, id_guard, number_phone)
values ('Charlize', 174, '0593305');
insert into GUARD (name, id_guard, number_phone)
values ('Maura', 175, '0582324');
insert into GUARD (name, id_guard, number_phone)
values ('Uma', 176, '0519253');
insert into GUARD (name, id_guard, number_phone)
values ('Rosanne', 177, '0521775');
insert into GUARD (name, id_guard, number_phone)
values ('Emily', 178, '0542426');
insert into GUARD (name, id_guard, number_phone)
values ('Emm', 179, '0541754');
insert into GUARD (name, id_guard, number_phone)
values ('Samuel', 180, '0555174');
insert into GUARD (name, id_guard, number_phone)
values ('Sheena', 181, '0577564');
insert into GUARD (name, id_guard, number_phone)
values ('Horace', 182, '0548026');
insert into GUARD (name, id_guard, number_phone)
values ('Mickey', 183, '0569842');
insert into GUARD (name, id_guard, number_phone)
values ('Gil', 184, '0510711');
insert into GUARD (name, id_guard, number_phone)
values ('Ozzy', 185, '0545668');
insert into GUARD (name, id_guard, number_phone)
values ('Luis', 186, '0525865');
insert into GUARD (name, id_guard, number_phone)
values ('Judge', 187, '0573585');
insert into GUARD (name, id_guard, number_phone)
values ('Anne', 188, '0513317');
insert into GUARD (name, id_guard, number_phone)
values ('Nik', 189, '0594455');
insert into GUARD (name, id_guard, number_phone)
values ('Don', 190, '0581515');
insert into GUARD (name, id_guard, number_phone)
values ('Tim', 191, '0527670');
insert into GUARD (name, id_guard, number_phone)
values ('Sophie', 192, '0566808');
insert into GUARD (name, id_guard, number_phone)
values ('Susan', 193, '0555615');
insert into GUARD (name, id_guard, number_phone)
values ('Barbara', 194, '0546488');
insert into GUARD (name, id_guard, number_phone)
values ('Kid', 195, '0565319');
insert into GUARD (name, id_guard, number_phone)
values ('Gina', 196, '0560117');
insert into GUARD (name, id_guard, number_phone)
values ('Randy', 197, '0547081');
insert into GUARD (name, id_guard, number_phone)
values ('Angela', 198, '0533427');
insert into GUARD (name, id_guard, number_phone)
values ('Micky', 199, '0524368');
insert into GUARD (name, id_guard, number_phone)
values ('Isaiah', 200, '0563110');
insert into GUARD (name, id_guard, number_phone)
values ('Phoebe', 201, '0550158');
insert into GUARD (name, id_guard, number_phone)
values ('Vonda', 202, '0525712');
insert into GUARD (name, id_guard, number_phone)
values ('Victor', 203, '0534698');
insert into GUARD (name, id_guard, number_phone)
values ('Pamela', 204, '0574643');
insert into GUARD (name, id_guard, number_phone)
values ('Lucy', 205, '0539579');
insert into GUARD (name, id_guard, number_phone)
values ('Lari', 206, '0538181');
insert into GUARD (name, id_guard, number_phone)
values ('Ceili', 207, '0571948');
insert into GUARD (name, id_guard, number_phone)
values ('Goldie', 208, '0562231');
insert into GUARD (name, id_guard, number_phone)
values ('Thora', 209, '0529105');
insert into GUARD (name, id_guard, number_phone)
values ('Ving', 210, '0526719');
insert into GUARD (name, id_guard, number_phone)
values ('Charlie', 211, '0531016');
insert into GUARD (name, id_guard, number_phone)
values ('Beverley', 212, '0515566');
insert into GUARD (name, id_guard, number_phone)
values ('Joaquim', 213, '0593913');
insert into GUARD (name, id_guard, number_phone)
values ('Roscoe', 214, '0531276');
insert into GUARD (name, id_guard, number_phone)
values ('Sigourney', 215, '0520302');
insert into GUARD (name, id_guard, number_phone)
values ('Chi', 216, '0537077');
insert into GUARD (name, id_guard, number_phone)
values ('Joseph', 217, '0537306');
insert into GUARD (name, id_guard, number_phone)
values ('Lonnie', 218, '0540236');
insert into GUARD (name, id_guard, number_phone)
values ('Lena', 219, '0538362');
insert into GUARD (name, id_guard, number_phone)
values ('Al', 220, '0554043');
insert into GUARD (name, id_guard, number_phone)
values ('Norm', 221, '0531696');
insert into GUARD (name, id_guard, number_phone)
values ('Scott', 222, '0540123');
insert into GUARD (name, id_guard, number_phone)
values ('Neve', 223, '0590108');
insert into GUARD (name, id_guard, number_phone)
values ('Ben', 224, '0599732');
insert into GUARD (name, id_guard, number_phone)
values ('Rickie', 225, '0523398');
insert into GUARD (name, id_guard, number_phone)
values ('Julianne', 226, '0592645');
insert into GUARD (name, id_guard, number_phone)
values ('Delroy', 227, '0542276');
insert into GUARD (name, id_guard, number_phone)
values ('Belinda', 228, '0546846');
insert into GUARD (name, id_guard, number_phone)
values ('Natacha', 229, '0526733');
insert into GUARD (name, id_guard, number_phone)
values ('Tzi', 230, '0596693');
insert into GUARD (name, id_guard, number_phone)
values ('Andre', 231, '0572364');
insert into GUARD (name, id_guard, number_phone)
values ('Delbert', 232, '0561933');
insert into GUARD (name, id_guard, number_phone)
values ('Albert', 233, '0558139');
insert into GUARD (name, id_guard, number_phone)
values ('Martin', 234, '0566452');
insert into GUARD (name, id_guard, number_phone)
values ('Eric', 235, '0529817');
insert into GUARD (name, id_guard, number_phone)
values ('Derek', 236, '0517144');
insert into GUARD (name, id_guard, number_phone)
values ('Bob', 237, '0576208');
insert into GUARD (name, id_guard, number_phone)
values ('Andrea', 238, '0541791');
insert into GUARD (name, id_guard, number_phone)
values ('Carl', 239, '0562942');
insert into GUARD (name, id_guard, number_phone)
values ('Angie', 240, '0564773');
insert into GUARD (name, id_guard, number_phone)
values ('Wade', 241, '0542585');
insert into GUARD (name, id_guard, number_phone)
values ('Ben', 242, '0594602');
insert into GUARD (name, id_guard, number_phone)
values ('Judy', 243, '0518883');
insert into GUARD (name, id_guard, number_phone)
values ('Nelly', 244, '0588369');
insert into GUARD (name, id_guard, number_phone)
values ('Armin', 245, '0512792');
insert into GUARD (name, id_guard, number_phone)
values ('Nickel', 246, '0537972');
insert into GUARD (name, id_guard, number_phone)
values ('Hugo', 247, '0593886');
insert into GUARD (name, id_guard, number_phone)
values ('Teena', 248, '0582921');
insert into GUARD (name, id_guard, number_phone)
values ('Rhys', 249, '0576725');
insert into GUARD (name, id_guard, number_phone)
values ('Rolando', 250, '0593681');
insert into GUARD (name, id_guard, number_phone)
values ('Rowan', 251, '0514161');
insert into GUARD (name, id_guard, number_phone)
values ('Whoopi', 252, '0568777');
insert into GUARD (name, id_guard, number_phone)
values ('Pablo', 253, '0563551');
insert into GUARD (name, id_guard, number_phone)
values ('Busta', 254, '0514477');
insert into GUARD (name, id_guard, number_phone)
values ('Talvin', 255, '0562842');
insert into GUARD (name, id_guard, number_phone)
values ('Eileen', 256, '0563557');
insert into GUARD (name, id_guard, number_phone)
values ('Trini', 257, '0518357');
insert into GUARD (name, id_guard, number_phone)
values ('Edgar', 258, '0566975');
insert into GUARD (name, id_guard, number_phone)
values ('Edgar', 259, '0521489');
insert into GUARD (name, id_guard, number_phone)
values ('Howie', 260, '0556313');
insert into GUARD (name, id_guard, number_phone)
values ('Howie', 261, '0534875');
insert into GUARD (name, id_guard, number_phone)
values ('Mira', 262, '0544313');
insert into GUARD (name, id_guard, number_phone)
values ('Nik', 263, '0524164');
insert into GUARD (name, id_guard, number_phone)
values ('Sheryl', 264, '0577244');
insert into GUARD (name, id_guard, number_phone)
values ('Vivica', 265, '0583172');
insert into GUARD (name, id_guard, number_phone)
values ('Mac', 266, '0550833');
insert into GUARD (name, id_guard, number_phone)
values ('Jason', 267, '0522711');
insert into GUARD (name, id_guard, number_phone)
values ('Pablo', 268, '0570121');
insert into GUARD (name, id_guard, number_phone)
values ('Christopher', 269, '0563067');
insert into GUARD (name, id_guard, number_phone)
values ('Kristin', 270, '0573244');
insert into GUARD (name, id_guard, number_phone)
values ('Julie', 271, '0591851');
insert into GUARD (name, id_guard, number_phone)
values ('Jon', 272, '0569891');
insert into GUARD (name, id_guard, number_phone)
values ('Millie', 273, '0534839');
insert into GUARD (name, id_guard, number_phone)
values ('Tramaine', 274, '0547246');
insert into GUARD (name, id_guard, number_phone)
values ('Jimmie', 275, '0542413');
insert into GUARD (name, id_guard, number_phone)
values ('Gin', 276, '0534488');
insert into GUARD (name, id_guard, number_phone)
values ('Earl', 277, '0568096');
insert into GUARD (name, id_guard, number_phone)
values ('Thora', 278, '0583995');
insert into GUARD (name, id_guard, number_phone)
values ('Brian', 279, '0582654');
insert into GUARD (name, id_guard, number_phone)
values ('Raymond', 280, '0590124');
insert into GUARD (name, id_guard, number_phone)
values ('Tanya', 281, '0586326');
insert into GUARD (name, id_guard, number_phone)
values ('Gaby', 282, '0546438');
insert into GUARD (name, id_guard, number_phone)
values ('Sam', 283, '0515623');
insert into GUARD (name, id_guard, number_phone)
values ('Kiefer', 284, '0580285');
insert into GUARD (name, id_guard, number_phone)
values ('Rosco', 285, '0511171');
insert into GUARD (name, id_guard, number_phone)
values ('Eric', 286, '0535207');
insert into GUARD (name, id_guard, number_phone)
values ('Daryle', 287, '0525491');
insert into GUARD (name, id_guard, number_phone)
values ('Olympia', 288, '0566497');
insert into GUARD (name, id_guard, number_phone)
values ('Wendy', 289, '0533428');
insert into GUARD (name, id_guard, number_phone)
values ('Johnny', 290, '0541306');
insert into GUARD (name, id_guard, number_phone)
values ('Jamie', 291, '0563458');
insert into GUARD (name, id_guard, number_phone)
values ('Cesar', 292, '0511083');
insert into GUARD (name, id_guard, number_phone)
values ('Gailard', 293, '0576104');
insert into GUARD (name, id_guard, number_phone)
values ('Curtis', 294, '0577107');
insert into GUARD (name, id_guard, number_phone)
values ('Arturo', 295, '0542018');
insert into GUARD (name, id_guard, number_phone)
values ('Annette', 296, '0525758');
insert into GUARD (name, id_guard, number_phone)
values ('Leelee', 297, '0545436');
insert into GUARD (name, id_guard, number_phone)
values ('Ivan', 298, '0531594');
insert into GUARD (name, id_guard, number_phone)
values ('Fats', 299, '0558491');
insert into GUARD (name, id_guard, number_phone)
values ('Moe', 300, '0565859');
insert into GUARD (name, id_guard, number_phone)
values ('Judge', 301, '0511217');
insert into GUARD (name, id_guard, number_phone)
values ('Charlize', 302, '0585737');
insert into GUARD (name, id_guard, number_phone)
values ('Courtney', 303, '0552813');
insert into GUARD (name, id_guard, number_phone)
values ('Colleen', 304, '0511564');
insert into GUARD (name, id_guard, number_phone)
values ('Bobby', 305, '0540927');
insert into GUARD (name, id_guard, number_phone)
values ('Stockard', 306, '0546575');
insert into GUARD (name, id_guard, number_phone)
values ('Vienna', 307, '0593265');
insert into GUARD (name, id_guard, number_phone)
values ('Junior', 308, '0531647');
insert into GUARD (name, id_guard, number_phone)
values ('Rosco', 309, '0588473');
insert into GUARD (name, id_guard, number_phone)
values ('Boyd', 310, '0545497');
insert into GUARD (name, id_guard, number_phone)
values ('Giovanni', 311, '0553681');
insert into GUARD (name, id_guard, number_phone)
values ('Karen', 312, '0594684');
insert into GUARD (name, id_guard, number_phone)
values ('Trace', 313, '0513413');
insert into GUARD (name, id_guard, number_phone)
values ('Loreena', 314, '0527112');
insert into GUARD (name, id_guard, number_phone)
values ('Howard', 315, '0536599');
insert into GUARD (name, id_guard, number_phone)
values ('Joshua', 316, '0536047');
insert into GUARD (name, id_guard, number_phone)
values ('Noah', 317, '0569521');
insert into GUARD (name, id_guard, number_phone)
values ('Russell', 318, '0539656');
insert into GUARD (name, id_guard, number_phone)
values ('Gailard', 319, '0543742');
insert into GUARD (name, id_guard, number_phone)
values ('Ramsey', 320, '0516601');
insert into GUARD (name, id_guard, number_phone)
values ('Tracy', 321, '0582140');
insert into GUARD (name, id_guard, number_phone)
values ('CeCe', 322, '0576169');
insert into GUARD (name, id_guard, number_phone)
values ('Dianne', 323, '0571205');
insert into GUARD (name, id_guard, number_phone)
values ('Tommy', 324, '0539171');
insert into GUARD (name, id_guard, number_phone)
values ('Amanda', 325, '0550352');
insert into GUARD (name, id_guard, number_phone)
values ('Derek', 326, '0533869');
insert into GUARD (name, id_guard, number_phone)
values ('Vertical', 327, '0585650');
insert into GUARD (name, id_guard, number_phone)
values ('Antonio', 328, '0570275');
insert into GUARD (name, id_guard, number_phone)
values ('Liquid', 329, '0568841');
insert into GUARD (name, id_guard, number_phone)
values ('Alex', 330, '0590904');
insert into GUARD (name, id_guard, number_phone)
values ('Betty', 331, '0590347');
insert into GUARD (name, id_guard, number_phone)
values ('Saul', 332, '0569313');
insert into GUARD (name, id_guard, number_phone)
values ('Garland', 333, '0569733');
insert into GUARD (name, id_guard, number_phone)
values ('Curtis', 334, '0535468');
insert into GUARD (name, id_guard, number_phone)
values ('Chuck', 335, '0591688');
insert into GUARD (name, id_guard, number_phone)
values ('Rolando', 336, '0527254');
insert into GUARD (name, id_guard, number_phone)
values ('Noah', 337, '0583013');
insert into GUARD (name, id_guard, number_phone)
values ('Cole', 338, '0598889');
insert into GUARD (name, id_guard, number_phone)
values ('Nikka', 339, '0511933');
insert into GUARD (name, id_guard, number_phone)
values ('Joaquim', 340, '0589645');
insert into GUARD (name, id_guard, number_phone)
values ('Matthew', 341, '0570704');
insert into GUARD (name, id_guard, number_phone)
values ('Kathleen', 342, '0569173');
insert into GUARD (name, id_guard, number_phone)
values ('Andre', 343, '0561182');
insert into GUARD (name, id_guard, number_phone)
values ('Irene', 344, '0536842');
insert into GUARD (name, id_guard, number_phone)
values ('Taylor', 345, '0558419');
insert into GUARD (name, id_guard, number_phone)
values ('Larry', 346, '0590057');
insert into GUARD (name, id_guard, number_phone)
values ('Lea', 347, '0537130');
insert into GUARD (name, id_guard, number_phone)
values ('Ashley', 348, '0545625');
insert into GUARD (name, id_guard, number_phone)
values ('Rade', 349, '0516763');
insert into GUARD (name, id_guard, number_phone)
values ('Jared', 350, '0575760');
insert into GUARD (name, id_guard, number_phone)
values ('Tony', 351, '0532359');
insert into GUARD (name, id_guard, number_phone)
values ('Rod', 352, '0527577');
insert into GUARD (name, id_guard, number_phone)
values ('Devon', 353, '0597764');
insert into GUARD (name, id_guard, number_phone)
values ('Dylan', 354, '0529697');
insert into GUARD (name, id_guard, number_phone)
values ('Art', 355, '0595031');
insert into GUARD (name, id_guard, number_phone)
values ('Dom', 356, '0551569');
insert into GUARD (name, id_guard, number_phone)
values ('Dean', 357, '0519607');
insert into GUARD (name, id_guard, number_phone)
values ('Coley', 358, '0538464');
insert into GUARD (name, id_guard, number_phone)
values ('Roberta', 359, '0571840');
insert into GUARD (name, id_guard, number_phone)
values ('Pelvic', 360, '0599768');
insert into GUARD (name, id_guard, number_phone)
values ('Peter', 361, '0537479');
insert into GUARD (name, id_guard, number_phone)
values ('Russell', 362, '0583613');
insert into GUARD (name, id_guard, number_phone)
values ('Debbie', 363, '0590961');
insert into GUARD (name, id_guard, number_phone)
values ('Harriet', 364, '0558206');
insert into GUARD (name, id_guard, number_phone)
values ('Marc', 365, '0570965');
insert into GUARD (name, id_guard, number_phone)
values ('Dan', 366, '0545370');
insert into GUARD (name, id_guard, number_phone)
values ('Herbie', 367, '0521939');
insert into GUARD (name, id_guard, number_phone)
values ('Armand', 368, '0586427');
insert into GUARD (name, id_guard, number_phone)
values ('Jane', 369, '0526002');
insert into GUARD (name, id_guard, number_phone)
values ('Andrae', 370, '0538533');
insert into GUARD (name, id_guard, number_phone)
values ('Cevin', 371, '0525692');
insert into GUARD (name, id_guard, number_phone)
values ('Glenn', 372, '0540226');
insert into GUARD (name, id_guard, number_phone)
values ('Nickel', 373, '0598829');
insert into GUARD (name, id_guard, number_phone)
values ('Claire', 374, '0594924');
insert into GUARD (name, id_guard, number_phone)
values ('Leon', 375, '0543443');
insert into GUARD (name, id_guard, number_phone)
values ('Irene', 376, '0540560');
insert into GUARD (name, id_guard, number_phone)
values ('Noah', 377, '0566227');
insert into GUARD (name, id_guard, number_phone)
values ('Lucinda', 378, '0598336');
insert into GUARD (name, id_guard, number_phone)
values ('Meg', 379, '0574797');
insert into GUARD (name, id_guard, number_phone)
values ('Remy', 380, '0557116');
insert into GUARD (name, id_guard, number_phone)
values ('Ving', 381, '0599629');
insert into GUARD (name, id_guard, number_phone)
values ('Tilda', 382, '0518009');
insert into GUARD (name, id_guard, number_phone)
values ('Red', 383, '0587853');
insert into GUARD (name, id_guard, number_phone)
values ('Gil', 384, '0566605');
insert into GUARD (name, id_guard, number_phone)
values ('Ned', 385, '0520601');
insert into GUARD (name, id_guard, number_phone)
values ('Rebeka', 386, '0585379');
insert into GUARD (name, id_guard, number_phone)
values ('Toshiro', 387, '0520883');
insert into GUARD (name, id_guard, number_phone)
values ('Harold', 388, '0579340');
insert into GUARD (name, id_guard, number_phone)
values ('Pelvic', 389, '0563932');
insert into GUARD (name, id_guard, number_phone)
values ('Cheech', 390, '0563529');
insert into GUARD (name, id_guard, number_phone)
values ('Kimberly', 391, '0527023');
insert into GUARD (name, id_guard, number_phone)
values ('Lisa', 392, '0520493');
insert into GUARD (name, id_guard, number_phone)
values ('Mint', 393, '0582503');
insert into GUARD (name, id_guard, number_phone)
values ('Ossie', 394, '0592894');
insert into GUARD (name, id_guard, number_phone)
values ('Jean-Claude', 395, '0547852');
insert into GUARD (name, id_guard, number_phone)
values ('Miranda', 396, '0541670');
insert into GUARD (name, id_guard, number_phone)
values ('Thin', 397, '0514544');
insert into GUARD (name, id_guard, number_phone)
values ('Sophie', 398, '0573121');
insert into GUARD (name, id_guard, number_phone)
values ('Rosanne', 399, '0523269');
insert into GUARD (name, id_guard, number_phone)
values ('Miranda', 400, '0574421');
prompt 400 records loaded
prompt Loading GUIDED_BY...
insert into GUIDED_BY (price, id_trip, id_guard)
values (5542, 1, 1);
insert into GUIDED_BY (price, id_trip, id_guard)
values (5710, 2, 2);
insert into GUIDED_BY (price, id_trip, id_guard)
values (7528, 3, 3);
insert into GUIDED_BY (price, id_trip, id_guard)
values (6038, 4, 4);
insert into GUIDED_BY (price, id_trip, id_guard)
values (5338, 5, 5);
insert into GUIDED_BY (price, id_trip, id_guard)
values (6792, 6, 6);
insert into GUIDED_BY (price, id_trip, id_guard)
values (7866, 7, 7);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8470, 8, 8);
insert into GUIDED_BY (price, id_trip, id_guard)
values (7664, 9, 9);
insert into GUIDED_BY (price, id_trip, id_guard)
values (5517, 10, 10);
insert into GUIDED_BY (price, id_trip, id_guard)
values (6211, 11, 11);
insert into GUIDED_BY (price, id_trip, id_guard)
values (5939, 12, 12);
insert into GUIDED_BY (price, id_trip, id_guard)
values (6486, 13, 13);
insert into GUIDED_BY (price, id_trip, id_guard)
values (6809, 14, 14);
insert into GUIDED_BY (price, id_trip, id_guard)
values (5617, 15, 15);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8931, 16, 16);
insert into GUIDED_BY (price, id_trip, id_guard)
values (5330, 17, 17);
insert into GUIDED_BY (price, id_trip, id_guard)
values (6838, 18, 18);
insert into GUIDED_BY (price, id_trip, id_guard)
values (6655, 19, 19);
insert into GUIDED_BY (price, id_trip, id_guard)
values (5852, 20, 20);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8989, 21, 21);
insert into GUIDED_BY (price, id_trip, id_guard)
values (6307, 22, 22);
insert into GUIDED_BY (price, id_trip, id_guard)
values (7561, 23, 23);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8515, 24, 24);
insert into GUIDED_BY (price, id_trip, id_guard)
values (6649, 25, 25);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8858, 26, 26);
insert into GUIDED_BY (price, id_trip, id_guard)
values (6027, 27, 27);
insert into GUIDED_BY (price, id_trip, id_guard)
values (5826, 28, 28);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8143, 29, 29);
insert into GUIDED_BY (price, id_trip, id_guard)
values (5039, 30, 30);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8819, 31, 31);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8659, 32, 32);
insert into GUIDED_BY (price, id_trip, id_guard)
values (7985, 33, 33);
insert into GUIDED_BY (price, id_trip, id_guard)
values (7296, 34, 34);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8422, 35, 35);
insert into GUIDED_BY (price, id_trip, id_guard)
values (5795, 36, 36);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8917, 37, 37);
insert into GUIDED_BY (price, id_trip, id_guard)
values (6380, 38, 38);
insert into GUIDED_BY (price, id_trip, id_guard)
values (6886, 39, 39);
insert into GUIDED_BY (price, id_trip, id_guard)
values (7931, 40, 40);
insert into GUIDED_BY (price, id_trip, id_guard)
values (5607, 41, 41);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8653, 42, 42);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8072, 43, 43);
insert into GUIDED_BY (price, id_trip, id_guard)
values (5630, 44, 44);
insert into GUIDED_BY (price, id_trip, id_guard)
values (6231, 45, 45);
insert into GUIDED_BY (price, id_trip, id_guard)
values (6698, 46, 46);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8472, 47, 47);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8209, 48, 48);
insert into GUIDED_BY (price, id_trip, id_guard)
values (6591, 49, 49);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8695, 50, 50);
insert into GUIDED_BY (price, id_trip, id_guard)
values (5808, 51, 51);
insert into GUIDED_BY (price, id_trip, id_guard)
values (7450, 52, 52);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8477, 53, 53);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8971, 54, 54);
insert into GUIDED_BY (price, id_trip, id_guard)
values (5582, 55, 55);
insert into GUIDED_BY (price, id_trip, id_guard)
values (7114, 56, 56);
insert into GUIDED_BY (price, id_trip, id_guard)
values (6961, 57, 57);
insert into GUIDED_BY (price, id_trip, id_guard)
values (7201, 58, 58);
insert into GUIDED_BY (price, id_trip, id_guard)
values (6772, 59, 59);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8170, 60, 60);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8290, 61, 61);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8654, 62, 62);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8859, 63, 63);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8685, 64, 64);
insert into GUIDED_BY (price, id_trip, id_guard)
values (5094, 65, 65);
insert into GUIDED_BY (price, id_trip, id_guard)
values (6956, 66, 66);
insert into GUIDED_BY (price, id_trip, id_guard)
values (7375, 67, 67);
insert into GUIDED_BY (price, id_trip, id_guard)
values (6310, 68, 68);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8575, 69, 69);
insert into GUIDED_BY (price, id_trip, id_guard)
values (7794, 70, 70);
insert into GUIDED_BY (price, id_trip, id_guard)
values (6161, 71, 71);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8310, 72, 72);
insert into GUIDED_BY (price, id_trip, id_guard)
values (6369, 73, 73);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8991, 74, 74);
insert into GUIDED_BY (price, id_trip, id_guard)
values (7511, 75, 75);
insert into GUIDED_BY (price, id_trip, id_guard)
values (7050, 76, 76);
insert into GUIDED_BY (price, id_trip, id_guard)
values (7780, 77, 77);
insert into GUIDED_BY (price, id_trip, id_guard)
values (5403, 78, 78);
insert into GUIDED_BY (price, id_trip, id_guard)
values (6407, 79, 79);
insert into GUIDED_BY (price, id_trip, id_guard)
values (7910, 80, 80);
insert into GUIDED_BY (price, id_trip, id_guard)
values (7058, 81, 81);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8073, 82, 82);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8017, 83, 83);
insert into GUIDED_BY (price, id_trip, id_guard)
values (5530, 84, 84);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8417, 85, 85);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8069, 86, 86);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8654, 87, 87);
insert into GUIDED_BY (price, id_trip, id_guard)
values (5360, 88, 88);
insert into GUIDED_BY (price, id_trip, id_guard)
values (5481, 89, 89);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8453, 90, 90);
insert into GUIDED_BY (price, id_trip, id_guard)
values (5380, 91, 91);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8412, 92, 92);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8839, 93, 93);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8825, 94, 94);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8439, 95, 95);
insert into GUIDED_BY (price, id_trip, id_guard)
values (6181, 96, 96);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8404, 97, 97);
insert into GUIDED_BY (price, id_trip, id_guard)
values (7853, 98, 98);
insert into GUIDED_BY (price, id_trip, id_guard)
values (7707, 99, 99);
insert into GUIDED_BY (price, id_trip, id_guard)
values (5674, 100, 100);
insert into GUIDED_BY (price, id_trip, id_guard)
values (6260, 101, 101);
insert into GUIDED_BY (price, id_trip, id_guard)
values (6267, 102, 102);
insert into GUIDED_BY (price, id_trip, id_guard)
values (5360, 103, 103);
insert into GUIDED_BY (price, id_trip, id_guard)
values (5456, 104, 104);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8684, 105, 105);
insert into GUIDED_BY (price, id_trip, id_guard)
values (5710, 106, 106);
insert into GUIDED_BY (price, id_trip, id_guard)
values (7927, 107, 107);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8679, 108, 108);
insert into GUIDED_BY (price, id_trip, id_guard)
values (7031, 109, 109);
insert into GUIDED_BY (price, id_trip, id_guard)
values (7923, 110, 110);
insert into GUIDED_BY (price, id_trip, id_guard)
values (7920, 111, 111);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8020, 112, 112);
insert into GUIDED_BY (price, id_trip, id_guard)
values (6170, 113, 113);
insert into GUIDED_BY (price, id_trip, id_guard)
values (7670, 114, 114);
insert into GUIDED_BY (price, id_trip, id_guard)
values (6254, 115, 115);
insert into GUIDED_BY (price, id_trip, id_guard)
values (6465, 116, 116);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8162, 117, 117);
insert into GUIDED_BY (price, id_trip, id_guard)
values (5865, 118, 118);
insert into GUIDED_BY (price, id_trip, id_guard)
values (7602, 119, 119);
insert into GUIDED_BY (price, id_trip, id_guard)
values (6883, 120, 120);
insert into GUIDED_BY (price, id_trip, id_guard)
values (7853, 121, 121);
insert into GUIDED_BY (price, id_trip, id_guard)
values (6325, 122, 122);
insert into GUIDED_BY (price, id_trip, id_guard)
values (5904, 123, 123);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8313, 124, 124);
insert into GUIDED_BY (price, id_trip, id_guard)
values (6095, 125, 125);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8583, 126, 126);
insert into GUIDED_BY (price, id_trip, id_guard)
values (6212, 127, 127);
insert into GUIDED_BY (price, id_trip, id_guard)
values (7917, 128, 128);
insert into GUIDED_BY (price, id_trip, id_guard)
values (7258, 129, 129);
insert into GUIDED_BY (price, id_trip, id_guard)
values (6213, 130, 130);
insert into GUIDED_BY (price, id_trip, id_guard)
values (6047, 131, 131);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8539, 132, 132);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8731, 133, 133);
insert into GUIDED_BY (price, id_trip, id_guard)
values (5094, 134, 134);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8467, 135, 135);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8778, 136, 136);
insert into GUIDED_BY (price, id_trip, id_guard)
values (7101, 137, 137);
insert into GUIDED_BY (price, id_trip, id_guard)
values (5053, 138, 138);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8025, 139, 139);
insert into GUIDED_BY (price, id_trip, id_guard)
values (5558, 140, 140);
insert into GUIDED_BY (price, id_trip, id_guard)
values (6697, 141, 141);
insert into GUIDED_BY (price, id_trip, id_guard)
values (5319, 142, 142);
insert into GUIDED_BY (price, id_trip, id_guard)
values (7822, 143, 143);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8090, 144, 144);
insert into GUIDED_BY (price, id_trip, id_guard)
values (5180, 145, 145);
insert into GUIDED_BY (price, id_trip, id_guard)
values (7241, 146, 146);
insert into GUIDED_BY (price, id_trip, id_guard)
values (6808, 147, 147);
insert into GUIDED_BY (price, id_trip, id_guard)
values (7187, 148, 148);
insert into GUIDED_BY (price, id_trip, id_guard)
values (7877, 149, 149);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8690, 150, 150);
insert into GUIDED_BY (price, id_trip, id_guard)
values (5564, 151, 151);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8873, 152, 152);
insert into GUIDED_BY (price, id_trip, id_guard)
values (7530, 153, 153);
insert into GUIDED_BY (price, id_trip, id_guard)
values (5590, 154, 154);
insert into GUIDED_BY (price, id_trip, id_guard)
values (7708, 155, 155);
insert into GUIDED_BY (price, id_trip, id_guard)
values (6196, 156, 156);
insert into GUIDED_BY (price, id_trip, id_guard)
values (7178, 157, 157);
insert into GUIDED_BY (price, id_trip, id_guard)
values (5023, 158, 158);
insert into GUIDED_BY (price, id_trip, id_guard)
values (7147, 159, 159);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8225, 160, 160);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8816, 161, 161);
insert into GUIDED_BY (price, id_trip, id_guard)
values (7326, 162, 162);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8340, 163, 163);
insert into GUIDED_BY (price, id_trip, id_guard)
values (6116, 164, 164);
insert into GUIDED_BY (price, id_trip, id_guard)
values (7559, 165, 165);
insert into GUIDED_BY (price, id_trip, id_guard)
values (7638, 166, 166);
insert into GUIDED_BY (price, id_trip, id_guard)
values (7773, 167, 167);
insert into GUIDED_BY (price, id_trip, id_guard)
values (5247, 168, 168);
insert into GUIDED_BY (price, id_trip, id_guard)
values (7981, 169, 169);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8324, 170, 170);
insert into GUIDED_BY (price, id_trip, id_guard)
values (5829, 171, 171);
insert into GUIDED_BY (price, id_trip, id_guard)
values (5293, 172, 172);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8304, 173, 173);
insert into GUIDED_BY (price, id_trip, id_guard)
values (6717, 174, 174);
insert into GUIDED_BY (price, id_trip, id_guard)
values (7233, 175, 175);
insert into GUIDED_BY (price, id_trip, id_guard)
values (7232, 176, 176);
insert into GUIDED_BY (price, id_trip, id_guard)
values (7152, 177, 177);
insert into GUIDED_BY (price, id_trip, id_guard)
values (7607, 178, 178);
insert into GUIDED_BY (price, id_trip, id_guard)
values (5277, 179, 179);
insert into GUIDED_BY (price, id_trip, id_guard)
values (7192, 180, 180);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8540, 181, 181);
insert into GUIDED_BY (price, id_trip, id_guard)
values (6931, 182, 182);
insert into GUIDED_BY (price, id_trip, id_guard)
values (5991, 183, 183);
insert into GUIDED_BY (price, id_trip, id_guard)
values (6082, 184, 184);
insert into GUIDED_BY (price, id_trip, id_guard)
values (5781, 185, 185);
insert into GUIDED_BY (price, id_trip, id_guard)
values (6083, 186, 186);
insert into GUIDED_BY (price, id_trip, id_guard)
values (5469, 187, 187);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8950, 188, 188);
insert into GUIDED_BY (price, id_trip, id_guard)
values (6017, 189, 189);
insert into GUIDED_BY (price, id_trip, id_guard)
values (5300, 190, 190);
insert into GUIDED_BY (price, id_trip, id_guard)
values (6520, 191, 191);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8997, 192, 192);
insert into GUIDED_BY (price, id_trip, id_guard)
values (6045, 193, 193);
insert into GUIDED_BY (price, id_trip, id_guard)
values (5541, 194, 194);
insert into GUIDED_BY (price, id_trip, id_guard)
values (5838, 195, 195);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8187, 196, 196);
insert into GUIDED_BY (price, id_trip, id_guard)
values (7130, 197, 197);
insert into GUIDED_BY (price, id_trip, id_guard)
values (5315, 198, 198);
insert into GUIDED_BY (price, id_trip, id_guard)
values (7887, 199, 199);
insert into GUIDED_BY (price, id_trip, id_guard)
values (7400, 200, 200);
insert into GUIDED_BY (price, id_trip, id_guard)
values (5497, 201, 201);
insert into GUIDED_BY (price, id_trip, id_guard)
values (7889, 202, 202);
insert into GUIDED_BY (price, id_trip, id_guard)
values (6671, 203, 203);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8053, 204, 204);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8188, 205, 205);
insert into GUIDED_BY (price, id_trip, id_guard)
values (7303, 206, 206);
insert into GUIDED_BY (price, id_trip, id_guard)
values (5591, 207, 207);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8123, 208, 208);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8962, 209, 209);
insert into GUIDED_BY (price, id_trip, id_guard)
values (6650, 210, 210);
insert into GUIDED_BY (price, id_trip, id_guard)
values (6573, 211, 211);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8537, 212, 212);
insert into GUIDED_BY (price, id_trip, id_guard)
values (7942, 213, 213);
insert into GUIDED_BY (price, id_trip, id_guard)
values (7042, 214, 214);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8648, 215, 215);
insert into GUIDED_BY (price, id_trip, id_guard)
values (6827, 216, 216);
insert into GUIDED_BY (price, id_trip, id_guard)
values (7684, 217, 217);
insert into GUIDED_BY (price, id_trip, id_guard)
values (6703, 218, 218);
insert into GUIDED_BY (price, id_trip, id_guard)
values (5178, 219, 219);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8022, 220, 220);
insert into GUIDED_BY (price, id_trip, id_guard)
values (7358, 221, 221);
insert into GUIDED_BY (price, id_trip, id_guard)
values (6633, 222, 222);
insert into GUIDED_BY (price, id_trip, id_guard)
values (5924, 223, 223);
insert into GUIDED_BY (price, id_trip, id_guard)
values (7690, 224, 224);
insert into GUIDED_BY (price, id_trip, id_guard)
values (5730, 225, 225);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8274, 226, 226);
insert into GUIDED_BY (price, id_trip, id_guard)
values (7112, 227, 227);
insert into GUIDED_BY (price, id_trip, id_guard)
values (7087, 228, 228);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8639, 229, 229);
insert into GUIDED_BY (price, id_trip, id_guard)
values (5613, 230, 230);
insert into GUIDED_BY (price, id_trip, id_guard)
values (5728, 231, 231);
insert into GUIDED_BY (price, id_trip, id_guard)
values (5332, 232, 232);
insert into GUIDED_BY (price, id_trip, id_guard)
values (5635, 233, 233);
insert into GUIDED_BY (price, id_trip, id_guard)
values (7178, 234, 234);
insert into GUIDED_BY (price, id_trip, id_guard)
values (7197, 235, 235);
insert into GUIDED_BY (price, id_trip, id_guard)
values (6565, 236, 236);
insert into GUIDED_BY (price, id_trip, id_guard)
values (5498, 237, 237);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8327, 238, 238);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8642, 239, 239);
insert into GUIDED_BY (price, id_trip, id_guard)
values (9000, 240, 240);
insert into GUIDED_BY (price, id_trip, id_guard)
values (5297, 241, 241);
insert into GUIDED_BY (price, id_trip, id_guard)
values (7316, 242, 242);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8920, 243, 243);
insert into GUIDED_BY (price, id_trip, id_guard)
values (7843, 244, 244);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8686, 245, 245);
insert into GUIDED_BY (price, id_trip, id_guard)
values (7538, 246, 246);
insert into GUIDED_BY (price, id_trip, id_guard)
values (5607, 247, 247);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8987, 248, 248);
insert into GUIDED_BY (price, id_trip, id_guard)
values (6132, 249, 249);
insert into GUIDED_BY (price, id_trip, id_guard)
values (5409, 250, 250);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8137, 251, 251);
insert into GUIDED_BY (price, id_trip, id_guard)
values (7423, 252, 252);
insert into GUIDED_BY (price, id_trip, id_guard)
values (6756, 253, 253);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8302, 254, 254);
insert into GUIDED_BY (price, id_trip, id_guard)
values (5262, 255, 255);
insert into GUIDED_BY (price, id_trip, id_guard)
values (5324, 256, 256);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8468, 257, 257);
insert into GUIDED_BY (price, id_trip, id_guard)
values (7999, 258, 258);
insert into GUIDED_BY (price, id_trip, id_guard)
values (6040, 259, 259);
insert into GUIDED_BY (price, id_trip, id_guard)
values (5720, 260, 260);
insert into GUIDED_BY (price, id_trip, id_guard)
values (6096, 261, 261);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8078, 262, 262);
insert into GUIDED_BY (price, id_trip, id_guard)
values (6529, 263, 263);
insert into GUIDED_BY (price, id_trip, id_guard)
values (6705, 264, 264);
insert into GUIDED_BY (price, id_trip, id_guard)
values (6194, 265, 265);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8682, 266, 266);
insert into GUIDED_BY (price, id_trip, id_guard)
values (7366, 267, 267);
insert into GUIDED_BY (price, id_trip, id_guard)
values (6123, 268, 268);
insert into GUIDED_BY (price, id_trip, id_guard)
values (6200, 269, 269);
insert into GUIDED_BY (price, id_trip, id_guard)
values (5101, 270, 270);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8447, 271, 271);
insert into GUIDED_BY (price, id_trip, id_guard)
values (7662, 272, 272);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8662, 273, 273);
insert into GUIDED_BY (price, id_trip, id_guard)
values (5609, 274, 274);
insert into GUIDED_BY (price, id_trip, id_guard)
values (7854, 275, 275);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8294, 276, 276);
insert into GUIDED_BY (price, id_trip, id_guard)
values (6187, 277, 277);
insert into GUIDED_BY (price, id_trip, id_guard)
values (6997, 278, 278);
insert into GUIDED_BY (price, id_trip, id_guard)
values (5258, 279, 279);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8002, 280, 280);
insert into GUIDED_BY (price, id_trip, id_guard)
values (5829, 281, 281);
insert into GUIDED_BY (price, id_trip, id_guard)
values (7225, 282, 282);
insert into GUIDED_BY (price, id_trip, id_guard)
values (6959, 283, 283);
insert into GUIDED_BY (price, id_trip, id_guard)
values (7727, 284, 284);
insert into GUIDED_BY (price, id_trip, id_guard)
values (6579, 285, 285);
insert into GUIDED_BY (price, id_trip, id_guard)
values (7650, 286, 286);
insert into GUIDED_BY (price, id_trip, id_guard)
values (6751, 287, 287);
insert into GUIDED_BY (price, id_trip, id_guard)
values (6481, 288, 288);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8663, 289, 289);
insert into GUIDED_BY (price, id_trip, id_guard)
values (6254, 290, 290);
insert into GUIDED_BY (price, id_trip, id_guard)
values (5817, 291, 291);
insert into GUIDED_BY (price, id_trip, id_guard)
values (5550, 292, 292);
insert into GUIDED_BY (price, id_trip, id_guard)
values (6323, 293, 293);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8317, 294, 294);
insert into GUIDED_BY (price, id_trip, id_guard)
values (7832, 295, 295);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8739, 296, 296);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8784, 297, 297);
insert into GUIDED_BY (price, id_trip, id_guard)
values (5955, 298, 298);
insert into GUIDED_BY (price, id_trip, id_guard)
values (6449, 299, 299);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8582, 300, 300);
insert into GUIDED_BY (price, id_trip, id_guard)
values (7066, 301, 301);
insert into GUIDED_BY (price, id_trip, id_guard)
values (6999, 302, 302);
insert into GUIDED_BY (price, id_trip, id_guard)
values (7376, 303, 303);
insert into GUIDED_BY (price, id_trip, id_guard)
values (5473, 304, 304);
insert into GUIDED_BY (price, id_trip, id_guard)
values (5367, 305, 305);
insert into GUIDED_BY (price, id_trip, id_guard)
values (6603, 306, 306);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8224, 307, 307);
insert into GUIDED_BY (price, id_trip, id_guard)
values (7635, 308, 308);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8674, 309, 309);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8059, 310, 310);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8304, 311, 311);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8876, 312, 312);
insert into GUIDED_BY (price, id_trip, id_guard)
values (7292, 313, 313);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8235, 314, 314);
insert into GUIDED_BY (price, id_trip, id_guard)
values (5573, 315, 315);
insert into GUIDED_BY (price, id_trip, id_guard)
values (6070, 316, 316);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8009, 317, 317);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8083, 318, 318);
insert into GUIDED_BY (price, id_trip, id_guard)
values (6919, 319, 319);
insert into GUIDED_BY (price, id_trip, id_guard)
values (7304, 320, 320);
insert into GUIDED_BY (price, id_trip, id_guard)
values (6536, 321, 321);
insert into GUIDED_BY (price, id_trip, id_guard)
values (5643, 322, 322);
insert into GUIDED_BY (price, id_trip, id_guard)
values (6947, 323, 323);
insert into GUIDED_BY (price, id_trip, id_guard)
values (6604, 324, 324);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8955, 325, 325);
insert into GUIDED_BY (price, id_trip, id_guard)
values (6001, 326, 326);
insert into GUIDED_BY (price, id_trip, id_guard)
values (7496, 327, 327);
insert into GUIDED_BY (price, id_trip, id_guard)
values (6219, 328, 328);
insert into GUIDED_BY (price, id_trip, id_guard)
values (6828, 329, 329);
insert into GUIDED_BY (price, id_trip, id_guard)
values (7615, 330, 330);
insert into GUIDED_BY (price, id_trip, id_guard)
values (7029, 331, 331);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8360, 332, 332);
insert into GUIDED_BY (price, id_trip, id_guard)
values (7684, 333, 333);
insert into GUIDED_BY (price, id_trip, id_guard)
values (5459, 334, 334);
insert into GUIDED_BY (price, id_trip, id_guard)
values (6117, 335, 335);
insert into GUIDED_BY (price, id_trip, id_guard)
values (7359, 336, 336);
insert into GUIDED_BY (price, id_trip, id_guard)
values (7543, 337, 337);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8428, 338, 338);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8193, 339, 339);
insert into GUIDED_BY (price, id_trip, id_guard)
values (6174, 340, 340);
insert into GUIDED_BY (price, id_trip, id_guard)
values (5186, 341, 341);
insert into GUIDED_BY (price, id_trip, id_guard)
values (5426, 342, 342);
insert into GUIDED_BY (price, id_trip, id_guard)
values (7754, 343, 343);
insert into GUIDED_BY (price, id_trip, id_guard)
values (6173, 344, 344);
insert into GUIDED_BY (price, id_trip, id_guard)
values (6852, 345, 345);
insert into GUIDED_BY (price, id_trip, id_guard)
values (7589, 346, 346);
insert into GUIDED_BY (price, id_trip, id_guard)
values (7219, 347, 347);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8152, 348, 348);
insert into GUIDED_BY (price, id_trip, id_guard)
values (7040, 349, 349);
insert into GUIDED_BY (price, id_trip, id_guard)
values (7069, 350, 350);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8608, 351, 351);
insert into GUIDED_BY (price, id_trip, id_guard)
values (7500, 352, 352);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8122, 353, 353);
insert into GUIDED_BY (price, id_trip, id_guard)
values (5827, 354, 354);
insert into GUIDED_BY (price, id_trip, id_guard)
values (7249, 355, 355);
insert into GUIDED_BY (price, id_trip, id_guard)
values (7471, 356, 356);
insert into GUIDED_BY (price, id_trip, id_guard)
values (6437, 357, 357);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8867, 358, 358);
insert into GUIDED_BY (price, id_trip, id_guard)
values (7690, 359, 359);
insert into GUIDED_BY (price, id_trip, id_guard)
values (7493, 360, 360);
insert into GUIDED_BY (price, id_trip, id_guard)
values (5562, 361, 361);
insert into GUIDED_BY (price, id_trip, id_guard)
values (5340, 362, 362);
insert into GUIDED_BY (price, id_trip, id_guard)
values (7002, 363, 363);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8436, 364, 364);
insert into GUIDED_BY (price, id_trip, id_guard)
values (6454, 365, 365);
insert into GUIDED_BY (price, id_trip, id_guard)
values (5980, 366, 366);
insert into GUIDED_BY (price, id_trip, id_guard)
values (7667, 367, 367);
insert into GUIDED_BY (price, id_trip, id_guard)
values (5807, 368, 368);
insert into GUIDED_BY (price, id_trip, id_guard)
values (5124, 369, 369);
insert into GUIDED_BY (price, id_trip, id_guard)
values (6279, 370, 370);
insert into GUIDED_BY (price, id_trip, id_guard)
values (7234, 371, 371);
insert into GUIDED_BY (price, id_trip, id_guard)
values (6782, 372, 372);
insert into GUIDED_BY (price, id_trip, id_guard)
values (5577, 373, 373);
insert into GUIDED_BY (price, id_trip, id_guard)
values (5863, 374, 374);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8937, 375, 375);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8025, 376, 376);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8650, 377, 377);
insert into GUIDED_BY (price, id_trip, id_guard)
values (7496, 378, 378);
insert into GUIDED_BY (price, id_trip, id_guard)
values (6447, 379, 379);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8233, 380, 380);
insert into GUIDED_BY (price, id_trip, id_guard)
values (6477, 381, 381);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8140, 382, 382);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8971, 383, 383);
insert into GUIDED_BY (price, id_trip, id_guard)
values (6337, 384, 384);
insert into GUIDED_BY (price, id_trip, id_guard)
values (5264, 385, 385);
insert into GUIDED_BY (price, id_trip, id_guard)
values (7534, 386, 386);
insert into GUIDED_BY (price, id_trip, id_guard)
values (5851, 387, 387);
insert into GUIDED_BY (price, id_trip, id_guard)
values (5303, 388, 388);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8029, 389, 389);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8709, 390, 390);
insert into GUIDED_BY (price, id_trip, id_guard)
values (6896, 391, 391);
insert into GUIDED_BY (price, id_trip, id_guard)
values (6469, 392, 392);
insert into GUIDED_BY (price, id_trip, id_guard)
values (6036, 393, 393);
insert into GUIDED_BY (price, id_trip, id_guard)
values (5872, 394, 394);
insert into GUIDED_BY (price, id_trip, id_guard)
values (7577, 395, 395);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8353, 396, 396);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8589, 397, 397);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8124, 398, 398);
insert into GUIDED_BY (price, id_trip, id_guard)
values (5335, 399, 399);
insert into GUIDED_BY (price, id_trip, id_guard)
values (8867, 400, 400);
prompt 400 records loaded
prompt Loading NEWCATALOG...
insert into NEWCATALOG (newcatalognumber, newcatalogname, priceperunit)
values (801, ' Business Cards', 20);
insert into NEWCATALOG (newcatalognumber, newcatalogname, priceperunit)
values (802, ' Brochures', 30);
insert into NEWCATALOG (newcatalognumber, newcatalogname, priceperunit)
values (803, ' Flyers', 16);
insert into NEWCATALOG (newcatalognumber, newcatalogname, priceperunit)
values (804, ' Posters', 25);
insert into NEWCATALOG (newcatalognumber, newcatalogname, priceperunit)
values (805, ' Banners', 35);
insert into NEWCATALOG (newcatalognumber, newcatalogname, priceperunit)
values (806, ' Booklets', 40);
insert into NEWCATALOG (newcatalognumber, newcatalogname, priceperunit)
values (807, ' Catalogs', 50);
insert into NEWCATALOG (newcatalognumber, newcatalogname, priceperunit)
values (808, ' Envelopes', 10);
insert into NEWCATALOG (newcatalognumber, newcatalogname, priceperunit)
values (809, ' Letterheads', 15);
insert into NEWCATALOG (newcatalognumber, newcatalogname, priceperunit)
values (810, ' Invitations', 20);
insert into NEWCATALOG (newcatalognumber, newcatalogname, priceperunit)
values (811, ' Greeting Cards', 13);
insert into NEWCATALOG (newcatalognumber, newcatalogname, priceperunit)
values (812, ' Postcards', 17);
insert into NEWCATALOG (newcatalognumber, newcatalogname, priceperunit)
values (813, ' Stickers', 10);
insert into NEWCATALOG (newcatalognumber, newcatalogname, priceperunit)
values (814, ' Labels', 12);
insert into NEWCATALOG (newcatalognumber, newcatalogname, priceperunit)
values (815, ' Menus', 20);
insert into NEWCATALOG (newcatalognumber, newcatalogname, priceperunit)
values (816, ' Calendars', 25);
insert into NEWCATALOG (newcatalognumber, newcatalogname, priceperunit)
values (817, ' Notepads', 15);
insert into NEWCATALOG (newcatalognumber, newcatalogname, priceperunit)
values (818, ' Magazines', 50);
insert into NEWCATALOG (newcatalognumber, newcatalogname, priceperunit)
values (819, ' Newsletters', 35);
insert into NEWCATALOG (newcatalognumber, newcatalogname, priceperunit)
values (820, ' Folders', 30);
insert into NEWCATALOG (newcatalognumber, newcatalogname, priceperunit)
values (821, ' Certificates', 13);
insert into NEWCATALOG (newcatalognumber, newcatalogname, priceperunit)
values (822, ' Reports', 40);
insert into NEWCATALOG (newcatalognumber, newcatalogname, priceperunit)
values (823, ' Manuals', 50);
insert into NEWCATALOG (newcatalognumber, newcatalogname, priceperunit)
values (824, ' Photo Books', 45);
insert into NEWCATALOG (newcatalognumber, newcatalogname, priceperunit)
values (825, ' Wedding Invitations', 30);
insert into NEWCATALOG (newcatalognumber, newcatalogname, priceperunit)
values (826, ' Save the Date Cards', 20);
insert into NEWCATALOG (newcatalognumber, newcatalogname, priceperunit)
values (827, ' Event Programs', 25);
insert into NEWCATALOG (newcatalognumber, newcatalogname, priceperunit)
values (828, ' Thank You Cards', 13);
insert into NEWCATALOG (newcatalognumber, newcatalogname, priceperunit)
values (829, ' Announcement Cards', 17);
insert into NEWCATALOG (newcatalognumber, newcatalogname, priceperunit)
values (830, ' Business Forms', 15);
insert into NEWCATALOG (newcatalognumber, newcatalogname, priceperunit)
values (831, ' Door Hangers', 16);
insert into NEWCATALOG (newcatalognumber, newcatalogname, priceperunit)
values (832, ' Rack Cards', 18);
insert into NEWCATALOG (newcatalognumber, newcatalogname, priceperunit)
values (833, ' Table Tents', 20);
insert into NEWCATALOG (newcatalognumber, newcatalogname, priceperunit)
values (834, ' Tent Cards', 15);
insert into NEWCATALOG (newcatalognumber, newcatalogname, priceperunit)
values (835, ' Presentation Folders', 30);
insert into NEWCATALOG (newcatalognumber, newcatalogname, priceperunit)
values (836, ' NCR Forms', 25);
insert into NEWCATALOG (newcatalognumber, newcatalogname, priceperunit)
values (837, ' Vinyl Banners', 40);
insert into NEWCATALOG (newcatalognumber, newcatalogname, priceperunit)
values (838, ' Roll-Up Banners', 45);
insert into NEWCATALOG (newcatalognumber, newcatalogname, priceperunit)
values (839, ' Custom Packaging', 60);
insert into NEWCATALOG (newcatalognumber, newcatalogname, priceperunit)
values (840, ' Gift Certificates', 20);
insert into NEWCATALOG (newcatalognumber, newcatalogname, priceperunit)
values (841, ' Loyalty Cards', 15);
insert into NEWCATALOG (newcatalognumber, newcatalogname, priceperunit)
values (842, ' Membership Cards', 15);
insert into NEWCATALOG (newcatalognumber, newcatalogname, priceperunit)
values (843, ' ID Cards', 13);
insert into NEWCATALOG (newcatalognumber, newcatalogname, priceperunit)
values (844, ' Luggage Tags', 10);
insert into NEWCATALOG (newcatalognumber, newcatalogname, priceperunit)
values (845, ' Tickets', 20);
insert into NEWCATALOG (newcatalognumber, newcatalogname, priceperunit)
values (846, ' Car Magnets', 25);
insert into NEWCATALOG (newcatalognumber, newcatalogname, priceperunit)
values (847, ' Yard Signs', 30);
insert into NEWCATALOG (newcatalognumber, newcatalogname, priceperunit)
values (848, ' Window Clings', 35);
insert into NEWCATALOG (newcatalognumber, newcatalogname, priceperunit)
values (849, ' Wall Decals', 40);
insert into NEWCATALOG (newcatalognumber, newcatalogname, priceperunit)
values (850, ' Canvas Prints', 50);
prompt 50 records loaded
prompt Loading INVENTORY...
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 31, 2000, 809);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 13, 2001, 834);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 10, 2002, 817);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 49, 2003, 822);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 29, 2004, 845);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 42, 2005, 821);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 22, 2006, 808);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 15, 2007, 810);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 7, 2008, 834);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 12, 2009, 844);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 28, 2010, 837);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 26, 2011, 840);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 46, 2012, 847);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 21, 2013, 849);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 10, 2014, 804);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 3, 2015, 812);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 3, 2016, 844);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 22, 2017, 830);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 3, 2018, 802);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 29, 2019, 850);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 23, 2020, 814);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 14, 2021, 819);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 11, 2022, 822);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 34, 2023, 812);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 26, 2024, 817);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 18, 2025, 835);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 39, 2026, 807);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 49, 2027, 828);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 5, 2028, 822);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 45, 2029, 804);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 15, 2030, 835);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 41, 2031, 824);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 50, 2032, 825);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 26, 2033, 828);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 26, 2034, 810);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 42, 2035, 838);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 27, 2036, 826);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 45, 2037, 817);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 43, 2038, 837);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 10, 2039, 805);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 23, 2040, 816);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 25, 2041, 812);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 3, 2042, 813);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 29, 2043, 804);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 40, 2044, 826);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 31, 2045, 845);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 9, 2046, 815);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 43, 2047, 809);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 25, 2048, 827);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 48, 2049, 802);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 3, 2050, 850);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 11, 2051, 817);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 15, 2052, 848);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 12, 2053, 841);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 32, 2054, 825);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 8, 2055, 824);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 34, 2056, 823);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 44, 2057, 817);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 36, 2058, 822);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 24, 2059, 833);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 7, 2060, 819);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 21, 2061, 839);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 23, 2062, 816);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 19, 2063, 805);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 8, 2064, 820);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 38, 2065, 834);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 22, 2066, 840);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 11, 2067, 810);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 27, 2068, 808);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 35, 2069, 827);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 27, 2070, 813);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 32, 2071, 848);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 38, 2072, 826);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 47, 2073, 816);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 10, 2074, 817);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 35, 2075, 844);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 45, 2076, 849);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 6, 2077, 847);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 46, 2078, 848);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 38, 2079, 849);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 7, 2080, 819);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 45, 2081, 843);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 34, 2082, 818);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 4, 2083, 830);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 43, 2084, 843);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 43, 2085, 847);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 7, 2086, 848);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 13, 2087, 808);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 29, 2088, 848);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 38, 2089, 825);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 17, 2090, 808);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 45, 2091, 834);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 45, 2092, 839);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 43, 2093, 810);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 24, 2094, 823);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 18, 2095, 825);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 36, 2096, 815);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 32, 2097, 813);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 7, 2098, 809);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 31, 2099, 836);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 9, 2100, 838);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 35, 2101, 841);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 40, 2102, 811);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 4, 2103, 833);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 47, 2104, 836);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 16, 2105, 839);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 16, 2106, 803);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 11, 2107, 825);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 33, 2108, 830);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 16, 2109, 823);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 20, 2110, 820);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 19, 2111, 823);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 41, 2112, 823);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 40, 2113, 818);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 33, 2114, 843);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 1, 2115, 833);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 25, 2116, 812);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 0, 2117, 839);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 33, 2118, 833);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 20, 2119, 809);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 3, 2120, 806);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 44, 2121, 811);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 41, 2122, 818);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 9, 2123, 808);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 47, 2124, 822);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 11, 2125, 811);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 14, 2126, 802);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 33, 2127, 838);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 32, 2128, 819);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 2, 2129, 808);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 21, 2130, 816);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 37, 2131, 828);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 12, 2132, 815);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 34, 2133, 846);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 36, 2134, 811);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 25, 2135, 830);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 13, 2136, 829);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 8, 2137, 827);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 47, 2138, 846);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 14, 2139, 805);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 11, 2140, 811);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 22, 2141, 812);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 2, 2142, 830);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 21, 2143, 825);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 10, 2144, 830);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 15, 2145, 828);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 13, 2146, 809);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 7, 2147, 832);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 46, 2148, 816);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 50, 2149, 815);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 47, 2150, 826);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 28, 2151, 802);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 20, 2152, 825);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 39, 2153, 838);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 20, 2154, 822);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 3, 2155, 818);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 23, 2156, 833);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 23, 2157, 803);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 8, 2158, 830);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 9, 2159, 803);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 45, 2160, 829);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 50, 2161, 801);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 30, 2162, 801);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 28, 2163, 815);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 33, 2164, 841);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 45, 2165, 828);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 11, 2166, 803);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 18, 2167, 842);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 26, 2168, 803);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 26, 2169, 834);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 28, 2170, 839);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 37, 2171, 833);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 22, 2172, 805);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 30, 2173, 828);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 27, 2174, 808);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 26, 2175, 805);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 1, 2176, 819);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 14, 2177, 806);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 21, 2178, 840);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 42, 2179, 804);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 44, 2180, 818);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 22, 2181, 823);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 29, 2182, 832);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 11, 2183, 839);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 18, 2184, 849);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 31, 2185, 827);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 22, 2186, 811);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 4, 2187, 823);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 22, 2188, 813);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 19, 2189, 825);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 37, 2190, 816);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 44, 2191, 834);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 21, 2192, 831);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 29, 2193, 806);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 29, 2194, 801);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 17, 2195, 843);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 32, 2196, 815);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 48, 2197, 820);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 4, 2198, 831);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 34, 2199, 849);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 48, 2200, 819);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 6, 2201, 825);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 42, 2202, 843);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 11, 2203, 801);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 41, 2204, 805);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 41, 2205, 807);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 46, 2206, 817);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 18, 2207, 816);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 47, 2208, 808);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 33, 2209, 825);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 29, 2210, 807);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 36, 2211, 841);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 21, 2212, 831);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 21, 2213, 806);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 1, 2214, 813);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 19, 2215, 802);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 6, 2216, 831);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 10, 2217, 812);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 18, 2218, 844);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 24, 2219, 822);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 26, 2220, 830);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 35, 2221, 836);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 48, 2222, 802);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 33, 2223, 849);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 3, 2224, 849);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 4, 2225, 825);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 43, 2226, 845);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 32, 2227, 825);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 28, 2228, 838);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 41, 2229, 803);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 45, 2230, 849);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 47, 2231, 808);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 9, 2232, 802);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 19, 2233, 824);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 24, 2234, 843);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 6, 2235, 840);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 32, 2236, 828);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 50, 2237, 806);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 25, 2238, 802);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 34, 2239, 814);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 25, 2240, 801);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 26, 2241, 839);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 38, 2242, 827);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 35, 2243, 849);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 41, 2244, 820);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 19, 2245, 806);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 25, 2246, 837);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 29, 2247, 803);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 17, 2248, 841);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 49, 2249, 833);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 31, 2250, 802);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 14, 2251, 805);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 0, 2252, 825);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 1, 2253, 817);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 3, 2254, 810);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 25, 2255, 819);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 33, 2256, 846);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 49, 2257, 843);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 27, 2258, 809);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 10, 2259, 840);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 50, 2260, 814);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 46, 2261, 805);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 2, 2262, 816);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 8, 2263, 808);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 19, 2264, 839);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 14, 2265, 817);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 12, 2266, 839);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 32, 2267, 823);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 41, 2268, 818);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 47, 2269, 806);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 0, 2270, 841);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 8, 2271, 809);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 14, 2272, 844);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 7, 2273, 838);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 28, 2274, 808);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 48, 2275, 804);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 23, 2276, 801);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 6, 2277, 814);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 5, 2278, 830);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 42, 2279, 830);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 6, 2280, 810);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 1, 2281, 845);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 42, 2282, 834);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 16, 2283, 803);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 50, 2284, 818);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 43, 2285, 824);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 34, 2286, 848);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 20, 2287, 817);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 50, 2288, 822);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 38, 2289, 830);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 12, 2290, 813);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 5, 2291, 831);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 37, 2292, 845);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 50, 2293, 801);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 39, 2294, 847);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 46, 2295, 816);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 5, 2296, 831);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 25, 2297, 849);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 0, 2298, 803);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 35, 2299, 815);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 0, 2300, 842);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 16, 2301, 812);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 22, 2302, 841);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 28, 2303, 817);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 41, 2304, 818);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 44, 2305, 850);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 10, 2306, 805);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 47, 2307, 846);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 1, 2308, 838);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 47, 2309, 816);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 36, 2310, 824);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 34, 2311, 803);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 0, 2312, 833);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 3, 2313, 809);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 31, 2314, 808);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 7, 2315, 839);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 11, 2316, 802);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 28, 2317, 833);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 36, 2318, 801);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 16, 2319, 825);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 40, 2320, 816);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 7, 2321, 842);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 12, 2322, 821);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 34, 2323, 812);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 39, 2324, 836);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 12, 2325, 816);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 9, 2326, 818);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 11, 2327, 826);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 19, 2328, 841);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 15, 2329, 825);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 36, 2330, 825);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 49, 2331, 822);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 29, 2332, 846);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 38, 2333, 848);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 5, 2334, 845);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 30, 2335, 805);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 26, 2336, 843);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 11, 2337, 835);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 23, 2338, 818);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 16, 2339, 833);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 16, 2340, 850);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 18, 2341, 848);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 4, 2342, 809);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 11, 2343, 818);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 1, 2344, 818);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 23, 2345, 849);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 36, 2346, 811);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 4, 2347, 828);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 6, 2348, 848);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 21, 2349, 845);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 21, 2350, 840);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 14, 2351, 823);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 37, 2352, 805);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 50, 2353, 822);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 15, 2354, 841);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 24, 2355, 809);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 16, 2356, 840);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 10, 2357, 821);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 6, 2358, 809);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 36, 2359, 814);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 35, 2360, 848);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 33, 2361, 811);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 18, 2362, 817);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 48, 2363, 842);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 29, 2364, 801);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 35, 2365, 815);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 36, 2366, 824);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 3, 2367, 847);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 41, 2368, 830);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 45, 2369, 839);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 33, 2370, 838);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 5, 2371, 838);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 20, 2372, 802);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 23, 2373, 841);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 39, 2374, 832);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 0, 2375, 803);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 31, 2376, 836);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 12, 2377, 849);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 46, 2378, 803);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 13, 2379, 826);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 44, 2380, 802);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 31, 2381, 832);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 20, 2382, 816);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 14, 2383, 850);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 23, 2384, 805);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 13, 2385, 844);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 43, 2386, 827);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 20, 2387, 818);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 37, 2388, 813);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 44, 2389, 835);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 19, 2390, 807);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 21, 2391, 833);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 0, 2392, 842);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 6, 2393, 833);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 3, 2394, 808);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 44, 2395, 815);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 39, 2396, 801);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 25, 2397, 832);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 12, 2398, 835);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 37, 2399, 818);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 3, 3000, 825);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 3, 3001, 836);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 3, 3002, 840);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 2, 3003, 846);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 4, 3004, 804);
prompt 405 records loaded
prompt Loading PERSON...
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (2, 'Chaka', 2004, '546597191', '6nH7yatv@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (7, 'Jackie', 2013, '535796510', 'eZslowdS@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (12, 'Lila', 2019, '509286034', 'UHRBwxhc@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (17, 'Alfie', 2015, '514103974', 'BwlXs3S0@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (22, 'Isaiah', 2001, '503386039', 'PQrlU0DH@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (26, 'Hazel', 2020, '565811105', 'AiX7Iylg@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (31, 'Charlie', 2008, '582066880', 'V463Osef@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (36, 'Murray', 2012, '576716252', 'yrybonQD@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (41, 'Javon', 2007, '522955072', 'rEvppcLv@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (47, 'Curtis', 2011, '518269520', 'dgz3BOmZ@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (52, 'Mindy', 2012, '515633392', '1sqQ1w5V@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (57, 'Albert', 2015, '517804862', 'cIRI8C7I@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (62, 'Ty', 2003, '551519517', 'ZL0p4XNn@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (67, 'Pelvic', 2003, '581288119', 'wMZR4ZpO@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (72, 'Rosanna', 2002, '506487681', 'g9qHbSom@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (77, 'Jeroen', 2002, '559027760', 'AzIy1pPl@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (82, 'Anita', 2021, '534674181', 'R3XSwBgh@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (89, 'Annie', 2021, '555702962', 'yMVMCZ7h@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (94, 'Rik', 2018, '536391125', 'VDNcyBOx@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (99, 'Candice', 2005, '592974002', 'vN40wQJS@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (104, 'Angelina', 2013, '524097816', 'OeJNOmXf@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (109, 'Colin', 2013, '555318955', 'aGUQeB5c@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (113, 'Colin', 2022, '582531445', 'aYZ6sirl@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (118, 'Bob', 2011, '543442604', 'xomIejjz@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (122, 'Debra', 2022, '590831902', 'Q9v3OY7v@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (126, 'Chad', 2019, '566625064', 'tgyP87nU@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (131, 'Mika', 2011, '595616828', 'VlsjjorT@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (135, 'Juliette', 2013, '542738027', 'agKPJ3wb@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (139, 'Marlon', 2020, '558600621', 'vZHo0yRM@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (143, 'Queen', 2003, '548756040', 'EFUAeDcN@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (148, 'Andy', 2008, '559362076', 'lWCpHFXn@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (152, 'Kyle', 2000, '544766314', 'If2sIZSO@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (156, 'Lin', 2011, '574160322', 'j9jLB4Hv@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (161, 'Mykelti', 2009, '509334722', 'aoleN6Vt@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (166, 'Terry', 2010, '513149746', '6LlVevcq@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (172, 'Luis', 2020, '563189422', 'EV2GPBGD@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (176, 'Delroy', 2020, '512850072', 'Nh6euYyz@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (181, 'Rascal', 2001, '506840153', 'Sse3B30V@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (186, 'Rebecca', 2004, '566764860', '3VyXMrJI@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (192, 'Judi', 2006, '542487569', 'Gb0pNOAc@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (196, 'Wayne', 2007, '534931109', '2V7QmuiF@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (201, 'Rebecca', 2012, '574218628', 'AwOXCzWZ@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (206, 'Kitty', 2016, '588095528', 'SyE1GHP9@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (211, 'Art', 2001, '571386119', 'XUd2wzmZ@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (215, 'Azucar', 2008, '529988373', '7ipiuIGo@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (219, 'Michelle', 2007, '594141307', 'qPK7uXjo@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (225, 'Heather', 2004, '536192517', 'OlpBc5Xe@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (229, 'Christine', 2022, '550179038', 'XwwLVDue@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (233, 'Betty', 2014, '580066010', 'nNr3DldY@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (237, 'Tia', 2016, '579261307', 'UQ5TiUQL@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (242, 'Danni', 2017, '567889508', 's7gdMvhE@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (247, 'Robbie', 2010, '520022597', 'S2tejpIh@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (251, 'Natascha', 2020, '547593159', 'F3ivUYE2@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (252, 'Bill', 2013, '540415830', '7wLDHASG@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (253, 'Rick', 2017, '559828330', 'Bj1WDAV9@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (254, 'Maureen', 2004, '563886939', '78qrfTPG@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (255, 'Suzy', 2007, '577713103', 'X1bCvrA0@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (256, 'King', 2013, '572292450', '1MZi0zES@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (257, 'Udo', 2014, '542436459', 'wjayEG9a@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (258, 'Ivan', 2015, '566109080', '5YM23Phy@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (259, 'Wang', 2005, '569388320', '7fysTn9q@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (260, 'Wayne', 2019, '515336181', 'YtRNzE95@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (261, 'Vanessa', 2009, '557732368', 'ZgOCD7mK@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (262, 'Natalie', 2000, '590957961', 'fQoSKNlq@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (263, 'Miranda', 2020, '591147522', 'n0GNo1C5@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (264, 'Rowan', 2021, '557662005', '7oshZjvY@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (265, 'Natasha', 2014, '586488440', 'i4p5S5ph@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (266, 'Emilio', 2008, '546026199', 'VWQ7pIvC@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (267, 'Roscoe', 2017, '533068166', 'FMtVD4mL@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (268, 'Jon', 2019, '575733860', 'pJkHXxo7@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (269, 'Rory', 2014, '532540716', 'Pwbtidb5@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (270, 'Frank', 2016, '511838668', 'zNgTfUJB@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (271, 'Chris', 2014, '598230508', 'zugoH8YT@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (272, 'Delbert', 2008, '536387642', '3v7yUitg@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (273, 'Claude', 2007, '548006453', 'y3fARtvX@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (274, 'Katrin', 2008, '587853962', '3SPWqyxT@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (275, 'Ruth', 2005, '520756674', '7BPE475D@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (276, 'Lenny', 2011, '584091607', '4oVEzN7D@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (277, 'Willem', 2011, '573579439', '73CNXgLe@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (278, 'Saffron', 2003, '554122833', 'e088K4ub@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (279, 'Rutger', 2004, '590104781', 'e2HoJDXL@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (282, 'Jann', 2022, '577958343', 'ouDk88o5@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (287, 'Roddy', 2011, '594965585', 'qKTjenvZ@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (291, 'Miko', 2016, '528560931', 'XSwBn6TI@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (296, 'Tamala', 2001, '514139407', 'EAqRLWEb@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (300, 'Mitchell', 2005, '579702487', 'axg609LC@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (305, 'Buddy', 2014, '556321193', 'XXrYMfLK@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (310, 'Madeline', 2017, '539648744', 'QbFrgMIl@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (314, 'Robin', 2005, '513199101', 'mOwFDV6g@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (318, 'Bret', 2016, '542440874', 'L01hqvkR@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (323, 'Coley', 2015, '559079275', 'aUkJHEDA@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (328, 'Mel', 2009, '542438189', '5nBtbJz0@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (333, 'Ossie', 2006, '588967892', 'm5wWgZNn@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (336, 'Emily', 2005, '538066996', 'h1nSenl1@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (340, 'Samuel', 2019, '528431079', 'vtyUFiSo@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (345, 'Marisa', 2009, '508672051', 'FTXhOk4V@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (349, 'Tramaine', 2000, '505104160', 'USbZscUt@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (353, 'Dave', 2007, '599565362', 'APY82YDE@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (358, 'Cheryl', 2010, '506916652', 'aTFmk2Vr@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (363, 'Natacha', 2005, '595570776', 'lpMrHB7V@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (367, 'Ethan', 2002, '504254558', 'u89Cfmd8@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (371, 'Emerson', 2006, '502776679', 'QOSvrh1r@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (375, 'Bridget', 2007, '596598587', 'g5Hx7qCv@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (380, 'Nastassja', 2018, '564311166', '4gWpq6Aq@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (382, 'Roy', 2008, '593240846', 'oUGgwero@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (383, 'Leonardo', 2012, null, null);
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (384, 'King', 2011, null, null);
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (385, 'Mos', 2016, null, null);
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (386, 'Brad', 2013, null, null);
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (387, 'Tzi', 2002, null, null);
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (388, 'Dionne', 2011, null, null);
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (389, 'Jackie', 2012, null, null);
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (390, 'Mary-Louise', 2005, null, null);
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (391, 'Cary', 2009, '591195411', 'gzcqytz9@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (392, 'Nickel', 2017, '520820659', '4gAOCGvY@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (393, 'Jennifer', 2018, '583742734', 'j9jGVpkE@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (394, 'Gabrielle', 2018, '508996068', '43H2rpoa@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (395, 'Powers', 2001, '504583403', '0wjVxlQp@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (396, 'Johnnie', 2000, '583027794', 'HxKvLbhu@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (397, 'Lila', 2012, '553864574', 'VZ66xbGU@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (398, 'Antonio', 2000, '588097735', '4BVRYEYO@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (399, 'Larry', 2018, '545871829', 'Q8WCuvvG@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (400, 'Nils', 2011, '568170451', 'KDRiP8Oh@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (280, 'Lili', 2013, '595217872', 'gSCJQDC9@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (281, 'Tyrone', 2022, '567653563', 'BUl9qC0N@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (283, 'Cheryl', 2003, '571561354', 'ZDacUbuX@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (284, 'Sean', 2020, '528898041', 'wTA5V7Fv@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (285, 'Ali', 2019, '506839883', 'EWbd0j05@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (286, 'Raymond', 2000, '578454668', 'LoXInppJ@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (288, 'Michael', 2022, '555498620', '4AdEhwEm@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (289, 'Cate', 2016, '569402622', 'HDgBIXGB@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (290, 'Gordon', 2012, '554160845', 'WLI8MrrN@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (292, 'Elisabeth', 2008, '575459032', 'J8ygK8VI@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (293, 'Maury', 2006, '548998380', 'Ntqah4QO@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (294, 'Jet', 2002, '515055408', 'YneYvek9@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (295, 'Amanda', 2010, '534419887', 'UAUagf14@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (297, 'Lou', 2010, '592308752', '2vcE6gcn@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (298, 'Freda', 2016, '538598018', 'ZYwRHByt@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (299, 'Charlie', 2016, '598403828', 'olmJ4R3f@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (301, 'Sophie', 2002, '582897136', 'fcjcrRPC@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (302, 'Nicole', 2020, '542834118', 'tB4JTkwK@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (303, 'Jean', 2003, '542289097', 'kPD4NLhO@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (304, 'Azucar', 2000, '594398213', 'bYkes5g2@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (306, 'Mika', 2000, '556859495', 't3vI17jv@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (307, 'Kid', 2010, '592962119', 'oWl4bGkg@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (308, 'Lynn', 2003, '593438995', 'glyekcR9@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (309, 'Giancarlo', 2008, '526872014', 'axmujlTH@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (311, 'Clea', 2015, '568019358', 'Hb09H3KW@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (312, 'Stellan', 2000, '590862113', 'ltHjHuun@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (313, 'Marina', 2009, '591467756', 'dLlGdODf@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (315, 'Vonda', 2016, '516364296', 'A4nGnp1S@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (316, 'Timothy', 2008, '567924958', 'SEerS3Rr@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (317, 'Gabrielle', 2011, '596620804', '5EFoqgKz@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (319, 'Rik', 2021, '587109577', 'fZLUoxHh@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (320, 'Rita', 2014, '569587843', 'jEHxNwk0@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (321, 'Geoff', 2012, '590894657', '3faVsfLj@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (322, 'Tia', 2019, '501040878', '0zf6SmIz@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (324, 'Lonnie', 2011, '528031003', 'O6fYRwF1@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (325, 'Alex', 2014, '507155069', 'gkqMbxdr@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (326, 'Omar', 2012, '525547330', 'IPPTfI7v@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (327, 'Jake', 2020, '557583004', 'kNMBdakM@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (329, 'Willem', 2002, '523023839', '5JesFpQ2@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (330, 'Luke', 2008, '581097012', 'E06imdQO@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (331, 'Kasey', 2020, '526650083', 'oVuOgj1n@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (332, 'Daniel', 2013, '569256757', 'ONLZCxI9@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (169, 'Balthazar', 2017, '532528104', 'VWflwFhY@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (170, 'Katrin', 2009, '553610071', 'yptSwt2n@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (171, 'Robin', 2022, '505214713', 'jeEdXLde@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (173, 'Hank', 2005, '591574501', 'fRfEc48B@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (174, 'Karen', 2016, '510343881', 'fB3pXp5X@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (175, 'Elias', 2004, '517188523', 'C1eJDe9d@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (177, 'Tim', 2021, '506139868', 'IAKsJUuX@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (178, 'Wesley', 2022, '517827818', 'xd1DVx7G@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (179, 'Wendy', 2007, '527082662', '1YvanWcs@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (180, 'Gene', 2004, '575352411', 'qLuHEmxt@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (182, 'Rade', 2014, '578405706', '15Kj3rKL@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (183, 'Sam', 2000, '560462040', 'Du7es9Vi@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (184, 'Rhea', 2012, '528570438', 'E3jatcrq@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (185, 'Parker', 2017, '596291725', 'zvNKJpct@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (187, 'Hal', 2001, '533303640', 'epsYzeoF@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (188, 'Cole', 2014, '590571518', 'cq9RuSZY@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (189, 'Rik', 2013, '516385582', 'JOILxHhW@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (190, 'Sally', 2020, '558461953', 'fPmwCbFX@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (191, 'Curtis', 2009, '528718737', 'oyCZpce5@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (193, 'Earl', 2014, '524998883', 'bLCXDjJj@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (194, 'Nikka', 2020, '575134006', 'eQxsMA9I@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (195, 'Jeff', 2008, '561817795', 'SIItpMkl@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (197, 'Nick', 2003, '500409706', 'El96HfMS@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (198, 'Jeffery', 2005, '531691969', 'oxYWZ70x@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (199, 'Percy', 2016, '553931039', 'ncYwERq3@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (200, 'LeVar', 2017, '562634725', 'rpKkYKgY@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (202, 'Anne', 2001, '508026335', 'svWZ7714@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (203, 'Gena', 2017, '526015865', 'jPqXIQLE@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (204, 'Faye', 2022, '592889041', 'eZwpJHgi@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (205, 'Ronny', 2010, '579243132', 'kPAEStkz@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (207, 'Miko', 2001, '577369574', 'hiULWto3@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (208, 'Gene', 2021, '512228547', 'QyTXC6lB@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (209, 'Diamond', 2017, '519766797', '9vBXK02L@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (210, 'Charlton', 2005, '589811074', 'SVOw5bN2@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (212, 'Brooke', 2010, '525483933', 'aLVYLpGc@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (213, 'Randy', 2015, '528757463', 'dAraXMZi@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (214, 'Arnold', 2005, '591132607', 'pl7oRCHj@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (216, 'Seann', 2012, '532130221', 'ulG9z5kA@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (217, 'Joy', 2022, '541159511', 'WH8peg4h@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (218, 'Curtis', 2020, '574913325', '6mmev0SD@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (220, 'Joy', 2022, '503691848', 'NP2YKEOh@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (221, 'Mel', 2006, '580303312', 'cnF0Q8r4@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (222, 'Luke', 2019, '528715481', 'B0wc6qpu@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (223, 'Davy', 2006, '525309009', 'z14fOBcW@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (224, 'Merillee', 2013, '510126263', 'NU7sEQIj@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (226, 'Scott', 2001, '548228870', 'lXG8nerh@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (227, 'Hugh', 2014, '547207818', '1ifGUc4B@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (228, 'Emerson', 2018, '571952438', 'gT4Z3UwM@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (230, 'Balthazar', 2006, '567050759', 'BAVz1ro4@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (231, 'Nikka', 2022, '555868937', 'ErJowWVj@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (232, 'Geena', 2013, '511668852', '4ic3eaE7@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (234, 'Vendetta', 2014, '569188160', 'MvkGvUk1@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (235, 'Will', 2006, '554897172', 'kZZ5j66z@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (236, 'Sally', 2012, '577858680', 'BanWriSM@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (238, 'Hugo', 2008, '570276583', '2Rs1uQoO@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (239, 'Mel', 2006, '592218810', 'PNV4RoPf@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (240, 'Gwyneth', 2006, '581838870', 'ZsKVuZcW@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (241, 'Chalee', 2015, '598376687', 'dIsU4JYG@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (243, 'Oded', 2014, '534110452', 'hS8ZfmOF@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (244, 'Miko', 2014, '506705567', 'OWzpY2V1@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (245, 'Kitty', 2013, '528977163', 'yoPGV1cr@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (246, 'Diane', 2013, '544910231', 'yt1UpmBy@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (248, 'Nils', 2020, '531383560', 'gI76Rufv@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (249, 'Ramsey', 2018, '559346498', '5mXEvkUZ@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (250, 'Selma', 2008, '589537870', 'sNsdC7sc@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (85, 'Naomi', 2015, '513678912', 'huBX75Wh@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (86, 'Tia', 2002, '589669940', 'EMGWCTS5@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (87, 'Harrison', 2001, '557015726', 'oz8Nb2bz@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (88, 'Stephen', 2010, '531052830', '4kl334Bn@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (90, 'Alannah', 2000, '511894314', '5f1WD2Xo@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (91, 'Alicia', 2002, '578702453', '4Wu71MDW@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (92, 'Chuck', 2014, '594196850', 'XMCOe0fe@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (93, 'Hope', 2013, '591233538', 'oFS0IBpL@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (95, 'Andy', 2021, '573536531', 'rDjEC4YH@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (96, 'Roddy', 2009, '515834600', 'Ddz5l3nJ@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (97, 'Radney', 2022, '518387970', 'TSDFFn7m@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (98, 'Nicolas', 2010, '520689705', 'IliqJvrF@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (100, 'Jessica', 2016, '586450881', 'vYFi1BNC@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (101, 'Glenn', 2019, '574137010', 'UT4TU1O0@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (102, 'Tim', 2004, '555217403', 'UiUYf8Kr@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (103, 'Minnie', 2001, '509569472', 'wR9vUehQ@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (105, 'Raul', 2022, '534741037', 'clAJN0Nh@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (106, 'Matt', 2009, '545070072', 'G0uVF44A@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (107, 'Davey', 2018, '501126493', 'RGAB4ucq@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (108, 'Vincent', 2008, '548989383', 'TYgdOxLE@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (110, 'James', 2000, '565578192', 'XWUIykwf@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (111, 'Miranda', 2015, '518829946', 'qfwMbMps@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (112, 'Jeff', 2019, '527584920', 'aws8ige6@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (114, 'Chris', 2011, '595609972', 'jNnxEo0t@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (115, 'Jack', 2000, '512946955', 'JMRhxR4E@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (116, 'Cheryl', 2014, '528942704', 'WpbRE2Bg@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (117, 'Latin', 2003, '573069644', 'SydIGlDu@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (119, 'Chaka', 2013, '531311411', 'srcIaymu@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (120, 'Hilary', 2010, '546038928', 'bhMGH8Ps@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (121, 'Patty', 2007, '517544772', 'eAajFqMr@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (123, 'Machine', 2004, '574811782', 'xlUR5WMd@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (124, 'Eliza', 2016, '566142031', 'aZ1FtSUv@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (125, 'Forest', 2020, '586384716', 'AZFIAUPh@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (127, 'Azucar', 2001, '541758860', 'cZbJD4ZV@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (128, 'Jonatha', 2016, '505065140', '8DI1thph@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (129, 'Will', 2004, '596851087', 'IEK1LKdt@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (130, 'William', 2007, '589054493', 'ivjD1J4C@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (132, 'Carlos', 2012, '592759653', 'rPPxv09W@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (133, 'Parker', 2006, '511439653', 'k4MydnyK@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (134, 'Sophie', 2017, '544503063', 'ucGpH8gv@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (136, 'Casey', 2008, '584238863', 'nHwPrbmO@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (137, 'Jonathan', 2021, '560033171', 'xs4zal62@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (138, 'Laurence', 2018, '504085308', 'zxx8ybq2@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (140, 'Pablo', 2005, '570833546', 'vsU037yi@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (141, 'Nicholas', 2015, '537566076', 'JMqdDBMT@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (142, 'Gran', 2015, '537021434', 'pJPqEnHH@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (144, 'Hope', 2019, '586233230', 'sDXsGKz7@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (145, 'Terry', 2016, '560352029', 'I7HPYKIv@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (146, 'Maggie', 2010, '565054766', 'pML4bvqf@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (147, 'Stewart', 2005, '596145348', '54iAcoEo@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (149, 'Sam', 2006, '575258169', 'LaPkhLQz@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (150, 'Burt', 2008, '527595994', 'WxnydswT@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (151, 'Mary Beth', 2020, '525772289', 'lgolGf2Y@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (153, 'Jeffery', 2013, '534884493', 'vTyQEpqy@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (154, 'Clay', 2003, '597121496', 'Wk1Ilwzs@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (155, 'Isabella', 2022, '594766367', 'F5GvjfaO@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (157, 'Rascal', 2005, '527686916', 'vxEoIODK@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (158, 'Ricky', 2009, '562694889', '09bBLCcP@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (159, 'Kazem', 2003, '577044786', '0V5RCVD8@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (160, 'Ramsey', 2009, '523297388', 'CQyYvjmI@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (162, 'Don', 2010, '513601393', 'HV1XooNy@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (163, 'Sara', 2006, '507855207', '0ZxDdRwA@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (164, 'Chi', 2016, '533322083', 'G58rumS1@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (165, 'Dionne', 2008, '527399786', 'GooEaANg@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (167, 'Melanie', 2009, '546426321', 'QVsHI8BY@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (168, 'Trey', 2013, '525700652', 'a1biOq9X@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (1, 'Maceo', 2010, '526956196', 'GAAD4Gvz@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (3, 'Rip', 2019, '531149208', 'gi7BAUJU@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (4, 'Wayman', 2003, '539048194', 'Y5kCLDmE@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (5, 'Lili', 2005, '536732435', '1hYiTP6g@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (6, 'Katrin', 2022, '571796738', 'oiTZv76k@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (8, 'Thin', 2011, '569391226', 'Jm4gMp5R@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (9, 'Louise', 2017, '572740432', 'x4XJknNp@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (10, 'Jean-Claude', 2013, '576945371', 'EsdgtOYs@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (11, 'Uma', 2012, '536342312', 'WCduuOBr@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (13, 'Alfred', 2016, '595522957', 'A9qO1tjN@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (14, 'Kiefer', 2010, '591200672', '78OofnqK@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (15, 'Chazz', 2010, '583586434', '1gDaAeE9@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (16, 'Kurt', 2011, '552337692', 'TgXQrIAR@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (18, 'Marina', 2010, '529814090', 'IeI0C6pp@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (19, 'Robbie', 2007, '508291301', 'YE1J0PXg@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (20, 'Cornell', 2020, '504357854', 'pqMgEsc5@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (21, 'Rawlins', 2005, '572260269', 'PUFX199h@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (23, 'Chris', 2002, '533375134', '8BCFLbEI@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (24, 'Curtis', 2006, '597321717', 'An40xdkZ@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (25, 'Lara', 2001, '557836241', 'm20jWqa7@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (27, 'Brent', 2018, '591157312', 'xIo5Rzc4@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (28, 'Frederic', 2013, '548441159', 'aR6JSBjz@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (29, 'Judge', 2005, '562938459', 'vyTAEOkY@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (30, 'Albert', 2001, '528746755', 'LXPribsA@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (32, 'Liam', 2012, '538201036', '96k9xQ2o@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (33, 'Gordie', 2012, '570649166', 'L1E3kf4V@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (34, 'Hex', 2020, '559682130', 'W2XH0zYT@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (35, 'First', 2022, '542467998', 'TwnwCmkt@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (37, 'Veruca', 2017, '562485543', 'jP8RHiOr@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (38, 'Adrien', 2002, '531392041', 'y33H0Fak@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (39, 'Merle', 2003, '519970445', 'c6hSZvJG@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (40, 'Suzy', 2022, '550479868', 'tamyBCgo@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (42, 'Will', 2020, '577536719', '8Vp9sFwY@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (43, 'Robby', 2016, '563747501', 'j5c9aE2Y@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (44, 'Aidan', 2006, '525879367', 'LpC6obrr@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (45, 'Gino', 2014, '538306078', 'fr07YdqE@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (46, 'Linda', 2006, '526704387', 'R7tQK1Sr@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (48, 'Reese', 2000, '558056698', 'j4CbgqnF@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (49, 'Meredith', 2011, '599394146', 'moQMLCBt@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (50, 'Suzi', 2002, '554253415', '2hBAWI0n@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (51, 'Bruce', 2006, '509320960', 'BX18EyNn@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (53, 'Gary', 2004, '506938505', 'LY7TfiiT@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (54, 'Carlene', 2017, '589856059', 'LBEDM70b@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (55, 'Leelee', 2010, '560529370', 'yo7rv2m3@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (56, 'Rod', 2000, '584697110', 'OMBpYwxP@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (58, 'Sheryl', 2000, '514869393', 'ZQzzg1z8@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (59, 'Yolanda', 2008, '530469739', '1aEjz3kV@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (60, 'Holly', 2022, '514138556', 'Y3KC4Cwy@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (61, 'Ernest', 2012, '533642917', 'ZeJhzX67@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (63, 'Saffron', 2021, '556545258', 'z2VMinVL@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (64, 'Elias', 2018, '559270669', '2OnnjRrd@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (65, 'Selma', 2021, '571219730', 'jE3hUxyX@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (66, 'Jack', 2019, '576451537', 'QaxWvBKD@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (68, 'Treat', 2006, '578763693', 'mbvL0VI6@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (69, 'Kristin', 2004, '518611303', 'zsGxd509@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (70, 'Todd', 2003, '593795124', 'PdtASed0@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (71, 'Ralph', 2018, '505817467', 'gMhuzYc0@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (73, 'Aaron', 2022, '535336993', 'b28ERxnM@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (74, 'Joaquim', 2019, '579430329', 'UVWpEaTp@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (75, 'Ewan', 2003, '541135262', 's2af13fR@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (76, 'Roberta', 2018, '516256511', 'FqYIP34w@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (78, 'Debby', 2012, '558713988', '3lBcPXTY@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (79, 'Robbie', 2016, '565641120', 'tEXa18Z0@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (80, 'Curt', 2001, '514677999', 'YnbzsL8k@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (81, 'Tori', 2018, '592891900', '6vuL1i45@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (83, 'Jena', 2003, '527521685', '1S7eqI8N@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (84, 'Stephen', 2021, '590019845', 'iiA9miYG@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (334, 'Eric', 2011, '529437123', 'L5a1AmxO@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (335, 'Tara', 2003, '524796363', '24OsitCY@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (337, 'Willem', 2017, '502971717', 'PG7Wm3M5@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (338, 'Kelli', 2001, '569442839', 'u43EI0Kt@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (339, 'Carrie-Anne', 2002, '560797933', 'Q8Xgd3IP@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (341, 'Alicia', 2007, '541835259', 'YvSqAf1h@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (342, 'Lee', 2011, '512881514', 'hYjJRn1E@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (343, 'Boyd', 2003, '535597591', 'aTTT9QVf@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (344, 'Harrison', 2016, '581356571', 'keCdwFJE@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (346, 'Cole', 2001, '592310757', 'B8ojr5PU@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (347, 'Freda', 2010, '559661771', 'oKnBTdVY@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (348, 'Millie', 2000, '536065702', 'cwJigb05@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (350, 'Tilda', 2020, '552979798', 'bjkuMA2b@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (351, 'Toshiro', 2001, '539768121', 'Zsw9tfSi@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (352, 'Adam', 2015, '511197573', 'iabiRyfK@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (354, 'Luke', 2022, '543251627', 'TqyI6rLz@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (355, 'Kyle', 2001, '514190728', '3dXy9XcC@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (356, 'Lydia', 2014, '567216812', 'CdXNbZ6e@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (357, 'Clarence', 2020, '552195398', 'TGAsCZsb@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (359, 'Patricia', 2014, '532665232', 'YUXxDp8p@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (360, 'Harry', 2015, '588426256', 'JlaFoxfF@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (361, 'Guy', 2000, '507362202', 'It9TwzTP@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (362, 'Terence', 2007, '583161545', 'ky9KCP5H@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (364, 'Armin', 2017, '515884498', 'XROc5Zko@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (365, 'Domingo', 2012, '524668969', 'RyCRF4fn@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (366, 'Adrien', 2004, '540463916', '7xZUUbNR@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (368, 'Kristin', 2005, '501019696', 'L81Gkmp1@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (369, 'Brenda', 2003, '515042721', '70cbwBca@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (370, 'Cledus', 2022, '500046415', 'WGSqXsO2@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (372, 'Mandy', 2003, '527984176', 'A7kfOh7V@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (373, 'Owen', 2021, '591335142', 'bP8ZZNbn@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (374, 'Toshiro', 2015, '511729022', 'lDx57p3s@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (376, 'Aida', 2010, '531347364', '6UZpSdeG@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (377, 'Antonio', 2009, '594695462', 'n4J8tgWh@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (378, 'Victor', 2010, '536280685', 'Ac40NdiY@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (379, 'Maggie', 2011, '532415772', 'CMqwVbmj@gmail.com');
insert into PERSON (id_person, name, year_of_birth, phone, email)
values (381, 'Holly', 2021, '583541376', 'PE1IcXUk@gmail.com');
prompt 400 records loaded
prompt Loading WORKERS...
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values (' Graphic Designer', 11007, '7wLDHASG@gmail.com', 540415830, 'Morning', 252, 'Alexander Wright', 252);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values (' Graphic Designer', 13065, 'Bj1WDAV9@gmail.com', 559828330, 'Evening', 253, 'Claire Lewis', 253);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values (' Graphic Designer', 14684, '78qrfTPG@gmail.com', 563886939, 'Evening', 254, 'Elijah Wright', 254);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Press Operator', 13805, 'X1bCvrA0@gmail.com', 577713103, 'Morning', 255, 'Evelyn Moore', 255);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Prepress Technician', 14501, '1MZi0zES@gmail.com', 572292450, 'Morning', 256, 'Mason Nelson', 256);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values (' Graphic Designer', 13122, 'wjayEG9a@gmail.com', 542436459, 'Morning', 257, 'Ava Garcia', 257);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Prepress Technician', 8285, '5YM23Phy@gmail.com', 566109080, 'Afternoon', 258, 'Ava Smith', 258);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Press Operator', 9540, '7fysTn9q@gmail.com', 569388320, 'Morning', 259, 'Noah Robinson', 259);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Customer Service Representative', 13564, 'YtRNzE95@gmail.com', 515336181, 'Afternoon', 260, 'Amelia Scott', 260);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Customer Service Representative', 10905, 'ZgOCD7mK@gmail.com', 557732368, 'Afternoon', 261, 'Claire Nelson', 261);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values (' Graphic Designer', 12531, 'fQoSKNlq@gmail.com', 590957961, 'Afternoon', 262, 'Henry Walker', 262);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Press Operator', 15741, 'n0GNo1C5@gmail.com', 591147522, 'Morning', 263, 'Mateo Scott', 263);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Customer Service Representative', 12651, '7oshZjvY@gmail.com', 557662005, 'Afternoon', 264, 'Noah Adams', 264);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values (' Graphic Designer', 11531, 'i4p5S5ph@gmail.com', 586488440, 'Morning', 265, 'Ethan Young', 265);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Press Operator', 12167, 'VWQ7pIvC@gmail.com', 546026199, 'Afternoon', 266, 'Logan Wood', 266);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Press Operator', 14427, 'FMtVD4mL@gmail.com', 533068166, 'Morning', 267, 'Oliver Anderson', 267);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Customer Service Representative', 15686, 'pJkHXxo7@gmail.com', 575733860, 'Morning', 268, 'Mason Lewis', 268);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values (' Graphic Designer', 12673, 'Pwbtidb5@gmail.com', 532540716, 'Morning', 269, 'Aaliyah Scott', 269);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values (' Graphic Designer', 15464, 'zNgTfUJB@gmail.com', 511838668, 'Morning', 270, 'Scarlett Williams', 270);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values (' Graphic Designer', 11816, 'zugoH8YT@gmail.com', 598230508, 'Afternoon', 271, 'Elijah Walker', 271);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Prepress Technician', 9247, '3v7yUitg@gmail.com', 536387642, 'Morning', 272, 'Isabella Davis', 272);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Press Operator', 12117, 'y3fARtvX@gmail.com', 548006453, 'Morning', 273, 'Elijah Diaz', 273);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values (' Graphic Designer', 10981, '3SPWqyxT@gmail.com', 587853962, 'Evening', 274, 'Abigail Nelson', 274);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values (' Graphic Designer', 10827, '7BPE475D@gmail.com', 520756674, 'Evening', 275, 'Noah Scott', 275);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Prepress Technician', 10121, '4oVEzN7D@gmail.com', 584091607, 'Morning', 276, 'Harper Robinson', 276);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Press Operator', 10534, '73CNXgLe@gmail.com', 573579439, 'Afternoon', 277, 'Elijah Turner', 277);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Customer Service Representative', 10241, 'e088K4ub@gmail.com', 554122833, 'Morning', 278, 'Aurora Jones', 278);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values (' Graphic Designer', 8819, 'e2HoJDXL@gmail.com', 590104781, 'Afternoon', 279, 'Mason Carter', 279);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Prepress Technician', 11168, 'gSCJQDC9@gmail.com', 595217872, 'Morning', 280, 'Abigail Nelson', 280);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values (' Graphic Designer', 13969, 'BUl9qC0N@gmail.com', 567653563, 'Morning', 281, 'Evelyn Rodriguez', 281);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Customer Service Representative', 14983, 'ouDk88o5@gmail.com', 577958343, 'Evening', 282, 'Abigail Robinson', 282);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Prepress Technician', 10818, 'ZDacUbuX@gmail.com', 571561354, 'Evening', 283, 'Amelia Pierce', 283);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Press Operator', 14277, 'wTA5V7Fv@gmail.com', 528898041, 'Evening', 284, 'Avah Brown', 284);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Prepress Technician', 10623, 'EWbd0j05@gmail.com', 506839883, 'Evening', 285, 'Logan Hernandez', 285);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Press Operator', 14078, 'LoXInppJ@gmail.com', 578454668, 'Evening', 286, 'Levi Lewis', 286);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Customer Service Representative', 12779, 'qKTjenvZ@gmail.com', 594965585, 'Morning', 287, 'Mason Murphy', 287);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Customer Service Representative', 10332, '4AdEhwEm@gmail.com', 555498620, 'Afternoon', 288, 'Alexander Davis', 288);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Customer Service Representative', 8704, 'HDgBIXGB@gmail.com', 569402622, 'Afternoon', 289, 'Aurora Harris', 289);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Customer Service Representative', 10956, 'WLI8MrrN@gmail.com', 554160845, 'Evening', 290, 'Michael Garcia', 290);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Prepress Technician', 14451, 'XSwBn6TI@gmail.com', 528560931, 'Evening', 291, 'William Garcia', 291);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Press Operator', 13715, 'J8ygK8VI@gmail.com', 575459032, 'Morning', 292, 'Jackson Miller', 292);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Prepress Technician', 11608, 'Ntqah4QO@gmail.com', 548998380, 'Afternoon', 293, 'Mason Wright', 293);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Customer Service Representative', 8956, 'YneYvek9@gmail.com', 515055408, 'Evening', 294, 'Harper Lewis', 294);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values (' Graphic Designer', 8903, 'UAUagf14@gmail.com', 534419887, 'Morning', 295, 'Liam Thomas', 295);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Customer Service Representative', 9253, 'EAqRLWEb@gmail.com', 514139407, 'Afternoon', 296, 'Amelia Carter', 296);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Customer Service Representative', 10652, '2vcE6gcn@gmail.com', 592308752, 'Evening', 297, 'Logan Young', 297);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Press Operator', 13937, 'ZYwRHByt@gmail.com', 538598018, 'Morning', 298, 'Amelia Miller', 298);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values (' Graphic Designer', 8124, 'olmJ4R3f@gmail.com', 598403828, 'Afternoon', 299, 'William Scott', 299);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Customer Service Representative', 12845, 'axg609LC@gmail.com', 579702487, 'Afternoon', 300, 'Matthew Robinson', 300);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Customer Service Representative', 14016, 'fcjcrRPC@gmail.com', 582897136, 'Evening', 301, 'James Allen', 301);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Customer Service Representative', 8438, 'tB4JTkwK@gmail.com', 542834118, 'Evening', 302, 'Liam Young', 302);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Press Operator', 9500, 'kPD4NLhO@gmail.com', 542289097, 'Afternoon', 303, 'Michael Walker', 303);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Prepress Technician', 8961, 'bYkes5g2@gmail.com', 594398213, 'Evening', 304, 'Charlotte Wright', 304);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Press Operator', 14122, 'XXrYMfLK@gmail.com', 556321193, 'Morning', 305, 'Charlotte Diaz', 305);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Customer Service Representative', 10403, 't3vI17jv@gmail.com', 556859495, 'Evening', 306, 'James Scott', 306);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values (' Graphic Designer', 14451, 'oWl4bGkg@gmail.com', 592962119, 'Afternoon', 307, 'Olivia Lee', 307);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Prepress Technician', 13358, 'glyekcR9@gmail.com', 593438995, 'Morning', 308, 'Zoe Young', 308);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Prepress Technician', 9602, 'axmujlTH@gmail.com', 526872014, 'Afternoon', 309, 'Elijah Scott', 309);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Prepress Technician', 13431, 'QbFrgMIl@gmail.com', 539648744, 'Afternoon', 310, 'Sophia Lewis', 310);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values (' Graphic Designer', 14136, 'Hb09H3KW@gmail.com', 568019358, 'Afternoon', 311, 'Mason Walker', 311);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Customer Service Representative', 11777, 'ltHjHuun@gmail.com', 590862113, 'Morning', 312, 'Mia Lee', 312);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Customer Service Representative', 12712, 'dLlGdODf@gmail.com', 591467756, 'Morning', 313, 'Mason Mitchell', 313);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Prepress Technician', 8363, 'mOwFDV6g@gmail.com', 513199101, 'Evening', 314, 'Noah Hall', 314);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Prepress Technician', 8934, 'A4nGnp1S@gmail.com', 516364296, 'Morning', 315, 'Harper Carter', 315);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Press Operator', 14594, 'SEerS3Rr@gmail.com', 567924958, 'Morning', 316, 'Amelia Moore', 316);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values (' Graphic Designer', 10580, '5EFoqgKz@gmail.com', 596620804, 'Morning', 317, 'Amelia Moore', 317);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Prepress Technician', 12514, 'L01hqvkR@gmail.com', 542440874, 'Evening', 318, 'Charlotte Lopez', 318);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Prepress Technician', 14084, 'fZLUoxHh@gmail.com', 587109577, 'Evening', 319, 'James Moore', 319);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Press Operator', 12077, 'jEHxNwk0@gmail.com', 569587843, 'Morning', 320, 'Evelyn Rodriguez', 320);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values (' Graphic Designer', 7755, '3faVsfLj@gmail.com', 590894657, 'Afternoon', 321, 'Charlotte Hall', 321);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Customer Service Representative', 8069, '0zf6SmIz@gmail.com', 501040878, 'Evening', 322, 'Scarlett Sanchez', 322);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Customer Service Representative', 14373, 'aUkJHEDA@gmail.com', 559079275, 'Evening', 323, 'Jackson Adams', 323);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Press Operator', 16336, 'O6fYRwF1@gmail.com', 528031003, 'Morning', 324, 'Elijah Harris', 324);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Customer Service Representative', 10739, 'gkqMbxdr@gmail.com', 507155069, 'Afternoon', 325, 'Noah Diaz', 325);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Prepress Technician', 12639, 'IPPTfI7v@gmail.com', 525547330, 'Morning', 326, 'Violet Walker', 326);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values (' Graphic Designer', 9024, 'kNMBdakM@gmail.com', 557583004, 'Evening', 327, 'Ava Scott', 327);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values (' Graphic Designer', 10337, '5nBtbJz0@gmail.com', 542438189, 'Afternoon', 328, 'Sofia Scott', 328);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Customer Service Representative', 15579, '5JesFpQ2@gmail.com', 523023839, 'Morning', 329, 'Avery Jones', 329);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values (' Graphic Designer', 10693, 'E06imdQO@gmail.com', 581097012, 'Afternoon', 330, 'Amelia Young', 330);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Prepress Technician', 12808, 'oVuOgj1n@gmail.com', 526650083, 'Afternoon', 331, 'Evelyn Moore', 331);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Customer Service Representative', 9125, 'ONLZCxI9@gmail.com', 569256757, 'Morning', 332, 'Luna Phillips', 332);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Prepress Technician', 7578, 'm5wWgZNn@gmail.com', 588967892, 'Afternoon', 333, 'James Wright', 333);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Prepress Technician', 8914, 'VWflwFhY@gmail.com', 532528104, 'Evening', 169, 'Lucas Walker', 169);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Customer Service Representative', 14797, 'yptSwt2n@gmail.com', 553610071, 'Evening', 170, 'William Clark', 170);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Press Operator', 10163, 'jeEdXLde@gmail.com', 505214713, 'Evening', 171, 'Mason Scott', 171);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Prepress Technician', 8415, 'EV2GPBGD@gmail.com', 563189422, 'Morning', 172, 'Jackson Diaz', 172);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Prepress Technician', 12444, 'fRfEc48B@gmail.com', 591574501, 'Evening', 173, 'Henry Davis', 173);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Customer Service Representative', 12667, 'fB3pXp5X@gmail.com', 510343881, 'Morning', 174, 'Emma Clark', 174);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Press Operator', 11745, 'C1eJDe9d@gmail.com', 517188523, 'Evening', 175, 'Isabella Allen', 175);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Customer Service Representative', 10706, 'Nh6euYyz@gmail.com', 512850072, 'Afternoon', 176, 'Ava Wright', 176);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values (' Graphic Designer', 9466, 'IAKsJUuX@gmail.com', 506139868, 'Afternoon', 177, 'Emily Phillips', 177);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Press Operator', 11132, 'xd1DVx7G@gmail.com', 517827818, 'Afternoon', 178, 'Elijah Allen', 178);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Press Operator', 11216, '1YvanWcs@gmail.com', 527082662, 'Afternoon', 179, 'Ava Lopez', 179);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values (' Graphic Designer', 13257, 'qLuHEmxt@gmail.com', 575352411, 'Morning', 180, 'David Allen', 180);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Customer Service Representative', 9791, 'Sse3B30V@gmail.com', 506840153, 'Afternoon', 181, 'James Roberts', 181);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Press Operator', 12863, '15Kj3rKL@gmail.com', 578405706, 'Evening', 182, 'Noah Anderson', 182);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Customer Service Representative', 14319, 'Du7es9Vi@gmail.com', 560462040, 'Morning', 183, 'Liam Roberts', 183);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Customer Service Representative', 7634, 'E3jatcrq@gmail.com', 528570438, 'Evening', 184, 'Alexander Wright', 184);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Customer Service Representative', 13286, 'zvNKJpct@gmail.com', 596291725, 'Afternoon', 185, 'Lucas Campbell', 185);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values (' Graphic Designer', 7800, '3VyXMrJI@gmail.com', 566764860, 'Afternoon', 186, 'Logan Hall', 186);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Customer Service Representative', 15634, 'epsYzeoF@gmail.com', 533303640, 'Morning', 187, 'Noah Garcia', 187);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values (' Graphic Designer', 14958, 'cq9RuSZY@gmail.com', 590571518, 'Morning', 188, 'Mason Williams', 188);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values (' Graphic Designer', 12204, 'JOILxHhW@gmail.com', 516385582, 'Afternoon', 189, 'Lucas Robinson', 189);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values (' Graphic Designer', 15219, 'fPmwCbFX@gmail.com', 558461953, 'Morning', 190, 'Mia Garcia', 190);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Press Operator', 9566, 'oyCZpce5@gmail.com', 528718737, 'Morning', 191, 'Emma Clark', 191);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values (' Graphic Designer', 13411, 'Gb0pNOAc@gmail.com', 542487569, 'Evening', 192, 'Sophia Phillips', 192);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Prepress Technician', 8385, 'bLCXDjJj@gmail.com', 524998883, 'Afternoon', 193, 'Aaliyah Lee', 193);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values (' Graphic Designer', 12813, 'eQxsMA9I@gmail.com', 575134006, 'Afternoon', 194, 'Alexander Nelson', 194);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Press Operator', 10989, 'SIItpMkl@gmail.com', 561817795, 'Morning', 195, 'Logan Harris', 195);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Press Operator', 8887, '2V7QmuiF@gmail.com', 534931109, 'Morning', 196, 'Ava Miller', 196);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values (' Graphic Designer', 12395, 'El96HfMS@gmail.com', 500409706, 'Morning', 197, 'Sofia Lewis', 197);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values (' Graphic Designer', 7736, 'oxYWZ70x@gmail.com', 531691969, 'Evening', 198, 'Violet Miller', 198);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values (' Graphic Designer', 12344, 'ncYwERq3@gmail.com', 553931039, 'Morning', 199, 'Lucas Williams', 199);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values (' Graphic Designer', 9494, 'rpKkYKgY@gmail.com', 562634725, 'Morning', 200, 'Logan Gonzalez', 200);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Customer Service Representative', 13939, 'AwOXCzWZ@gmail.com', 574218628, 'Afternoon', 201, 'Amelia Hall', 201);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values (' Graphic Designer', 13874, 'svWZ7714@gmail.com', 508026335, 'Evening', 202, 'Oliver Garcia', 202);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Press Operator', 14054, 'jPqXIQLE@gmail.com', 526015865, 'Morning', 203, 'Camila Thomas', 203);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Customer Service Representative', 8489, 'eZwpJHgi@gmail.com', 592889041, 'Afternoon', 204, 'Liam Miller', 204);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Press Operator', 10809, 'kPAEStkz@gmail.com', 579243132, 'Afternoon', 205, 'Luna Robinson', 205);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Prepress Technician', 8839, 'SyE1GHP9@gmail.com', 588095528, 'Evening', 206, 'Elijah Robinson', 206);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Customer Service Representative', 9726, 'hiULWto3@gmail.com', 577369574, 'Afternoon', 207, 'Alexander Clark', 207);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Customer Service Representative', 9735, 'QyTXC6lB@gmail.com', 512228547, 'Afternoon', 208, 'Harper Lewis', 208);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Press Operator', 9998, '9vBXK02L@gmail.com', 519766797, 'Afternoon', 209, 'Violet Lewis', 209);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Press Operator', 8916, 'SVOw5bN2@gmail.com', 589811074, 'Afternoon', 210, 'Ella Robinson', 210);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Customer Service Representative', 13459, 'XUd2wzmZ@gmail.com', 571386119, 'Afternoon', 211, 'Sophia Allen', 211);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Customer Service Representative', 10832, 'aLVYLpGc@gmail.com', 525483933, 'Morning', 212, 'Emily Lee', 212);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Press Operator', 10212, 'dAraXMZi@gmail.com', 528757463, 'Morning', 213, 'Emily Baker', 213);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Press Operator', 11263, 'pl7oRCHj@gmail.com', 591132607, 'Evening', 214, 'Charlotte Hernandez', 214);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Prepress Technician', 12382, '7ipiuIGo@gmail.com', 529988373, 'Morning', 215, 'Ava Roberts', 215);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values (' Graphic Designer', 10188, 'ulG9z5kA@gmail.com', 532130221, 'Evening', 216, 'Ava Harris', 216);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values (' Graphic Designer', 8777, 'WH8peg4h@gmail.com', 541159511, 'Morning', 217, 'Ella Hall', 217);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Press Operator', 7552, '6mmev0SD@gmail.com', 574913325, 'Evening', 218, 'Amelia King', 218);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Customer Service Representative', 15324, 'qPK7uXjo@gmail.com', 594141307, 'Morning', 219, 'Elias Clark', 219);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Press Operator', 12364, 'NP2YKEOh@gmail.com', 503691848, 'Evening', 220, 'Lucas Robinson', 220);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values (' Graphic Designer', 11223, 'cnF0Q8r4@gmail.com', 580303312, 'Evening', 221, 'Mason Robinson', 221);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Press Operator', 12523, 'B0wc6qpu@gmail.com', 528715481, 'Afternoon', 222, 'Emily Bell', 222);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Prepress Technician', 14787, 'z14fOBcW@gmail.com', 525309009, 'Morning', 223, 'Noah Scott', 223);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Press Operator', 13648, 'NU7sEQIj@gmail.com', 510126263, 'Afternoon', 224, 'Henry Lopez', 224);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values (' Graphic Designer', 10351, 'OlpBc5Xe@gmail.com', 536192517, 'Morning', 225, 'Harper Young', 225);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Prepress Technician', 14381, 'lXG8nerh@gmail.com', 548228870, 'Morning', 226, 'Ethan Lewis', 226);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Customer Service Representative', 12826, '1ifGUc4B@gmail.com', 547207818, 'Afternoon', 227, 'Avery Rodriguez', 227);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values (' Graphic Designer', 14517, 'gT4Z3UwM@gmail.com', 571952438, 'Afternoon', 228, 'Charlotte Nelson', 228);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Prepress Technician', 13919, 'XwwLVDue@gmail.com', 550179038, 'Afternoon', 229, 'Ava Robinson', 229);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Press Operator', 12731, 'BAVz1ro4@gmail.com', 567050759, 'Evening', 230, 'James Clark', 230);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Customer Service Representative', 9478, 'ErJowWVj@gmail.com', 555868937, 'Morning', 231, 'Evelyn Hernandez', 231);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values (' Graphic Designer', 11543, '4ic3eaE7@gmail.com', 511668852, 'Morning', 232, 'Liam Hall', 232);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values (' Graphic Designer', 13829, 'nNr3DldY@gmail.com', 580066010, 'Afternoon', 233, 'Avery Carter', 233);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Press Operator', 14582, 'MvkGvUk1@gmail.com', 569188160, 'Evening', 234, 'Levi Walker', 234);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Customer Service Representative', 13465, 'kZZ5j66z@gmail.com', 554897172, 'Morning', 235, 'Zoe Young', 235);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values (' Graphic Designer', 10535, 'BanWriSM@gmail.com', 577858680, 'Evening', 236, 'Abigail Harris', 236);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values (' Graphic Designer', 9739, 'UQ5TiUQL@gmail.com', 579261307, 'Evening', 237, 'Abigail Williams', 237);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Customer Service Representative', 9220, '2Rs1uQoO@gmail.com', 570276583, 'Afternoon', 238, 'Henry Hall', 238);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Prepress Technician', 10004, 'PNV4RoPf@gmail.com', 592218810, 'Afternoon', 239, 'James Moore', 239);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Prepress Technician', 9475, 'ZsKVuZcW@gmail.com', 581838870, 'Afternoon', 240, 'Isabella Clark', 240);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Prepress Technician', 11289, 'dIsU4JYG@gmail.com', 598376687, 'Evening', 241, 'William Brown', 241);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Prepress Technician', 12949, 's7gdMvhE@gmail.com', 567889508, 'Afternoon', 242, 'Ella Hernandez', 242);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values (' Graphic Designer', 8433, 'hS8ZfmOF@gmail.com', 534110452, 'Evening', 243, 'Evelyn Garcia', 243);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values (' Graphic Designer', 8908, 'OWzpY2V1@gmail.com', 506705567, 'Morning', 244, 'Ethan Garcia', 244);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values (' Graphic Designer', 13847, 'yoPGV1cr@gmail.com', 528977163, 'Evening', 245, 'Violet Nelson', 245);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Press Operator', 13986, 'yt1UpmBy@gmail.com', 544910231, 'Evening', 246, 'Alexander Moore', 246);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Customer Service Representative', 13571, 'S2tejpIh@gmail.com', 520022597, 'Evening', 247, 'Elijah Young', 247);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Prepress Technician', 8478, 'gI76Rufv@gmail.com', 531383560, 'Afternoon', 248, 'Isabella Campbell', 248);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Customer Service Representative', 14112, '5mXEvkUZ@gmail.com', 559346498, 'Afternoon', 249, 'Liam Pierce', 249);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Customer Service Representative', 12893, 'sNsdC7sc@gmail.com', 589537870, 'Morning', 250, 'Logan Allen', 250);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Press Operator', 7576, 'F3ivUYE2@gmail.com', 547593159, 'Evening', 251, 'Evelyn Wilson', 251);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Prepress Technician', 9869, 'huBX75Wh@gmail.com', 513678912, 'Morning', 85, 'Evelyn Diaz', 85);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values (' Graphic Designer', 9461, 'EMGWCTS5@gmail.com', 589669940, 'Afternoon', 86, 'Liam Garcia', 86);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Customer Service Representative', 14540, 'oz8Nb2bz@gmail.com', 557015726, 'Evening', 87, 'Charlotte Phillips', 87);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Customer Service Representative', 9141, '4kl334Bn@gmail.com', 531052830, 'Afternoon', 88, 'Mason Phillips', 88);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values (' Graphic Designer', 13732, 'yMVMCZ7h@gmail.com', 555702962, 'Evening', 89, 'William Murphy', 89);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values (' Graphic Designer', 12031, '5f1WD2Xo@gmail.com', 511894314, 'Afternoon', 90, 'Avery Lewis', 90);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Prepress Technician', 12448, '4Wu71MDW@gmail.com', 578702453, 'Afternoon', 91, 'Amelia Rodriguez', 91);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values (' Graphic Designer', 10246, 'XMCOe0fe@gmail.com', 594196850, 'Afternoon', 92, 'James Thomas', 92);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Press Operator', 10278, 'oFS0IBpL@gmail.com', 591233538, 'Evening', 93, 'Emily Lopez', 93);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values (' Graphic Designer', 7806, 'VDNcyBOx@gmail.com', 536391125, 'Evening', 94, 'Charlotte Young', 94);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Prepress Technician', 9260, 'rDjEC4YH@gmail.com', 573536531, 'Afternoon', 95, 'Aaliyah Lewis', 95);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values (' Graphic Designer', 14311, 'Ddz5l3nJ@gmail.com', 515834600, 'Evening', 96, 'Mia Nelson', 96);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Customer Service Representative', 13960, 'TSDFFn7m@gmail.com', 518387970, 'Afternoon', 97, 'Evelyn Smith', 97);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values (' Graphic Designer', 15210, 'IliqJvrF@gmail.com', 520689705, 'Morning', 98, 'Sophia Scott', 98);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Prepress Technician', 9584, 'vN40wQJS@gmail.com', 592974002, 'Morning', 99, 'Zoe King', 99);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values (' Graphic Designer', 15711, 'vYFi1BNC@gmail.com', 586450881, 'Morning', 100, 'Mason Thomas', 100);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values (' Graphic Designer', 8072, 'UT4TU1O0@gmail.com', 574137010, 'Evening', 101, 'Elizabeth Cruz', 101);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Prepress Technician', 8325, 'UiUYf8Kr@gmail.com', 555217403, 'Afternoon', 102, 'Evelyn Baker', 102);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Press Operator', 14993, 'wR9vUehQ@gmail.com', 509569472, 'Evening', 103, 'Alexander Clark', 103);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Press Operator', 13863, 'OeJNOmXf@gmail.com', 524097816, 'Morning', 104, 'Sophia Harris', 104);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values (' Graphic Designer', 14802, 'clAJN0Nh@gmail.com', 534741037, 'Evening', 105, 'Evelyn Turner', 105);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Customer Service Representative', 14625, 'G0uVF44A@gmail.com', 545070072, 'Afternoon', 106, 'Mia Hall', 106);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Customer Service Representative', 8656, 'RGAB4ucq@gmail.com', 501126493, 'Afternoon', 107, 'Mason Scott', 107);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Prepress Technician', 15499, 'TYgdOxLE@gmail.com', 548989383, 'Morning', 108, 'Ethan Harris', 108);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Press Operator', 14746, 'aGUQeB5c@gmail.com', 555318955, 'Afternoon', 109, 'Jackson Clark', 109);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Customer Service Representative', 12923, 'XWUIykwf@gmail.com', 565578192, 'Afternoon', 110, 'Ethan Adams', 110);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Press Operator', 12082, 'qfwMbMps@gmail.com', 518829946, 'Morning', 111, 'Evelyn Roberts', 111);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Prepress Technician', 13586, 'aws8ige6@gmail.com', 527584920, 'Afternoon', 112, 'Lucas Bell', 112);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values (' Graphic Designer', 14429, 'aYZ6sirl@gmail.com', 582531445, 'Evening', 113, 'Logan Young', 113);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Prepress Technician', 13857, 'jNnxEo0t@gmail.com', 595609972, 'Afternoon', 114, 'Zoe Harris', 114);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Press Operator', 9403, 'JMRhxR4E@gmail.com', 512946955, 'Afternoon', 115, 'Sophia Moore', 115);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Press Operator', 9912, 'WpbRE2Bg@gmail.com', 528942704, 'Afternoon', 116, 'Aurora Wilson', 116);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Press Operator', 8570, 'SydIGlDu@gmail.com', 573069644, 'Afternoon', 117, 'Luna Moore', 117);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Prepress Technician', 10361, 'xomIejjz@gmail.com', 543442604, 'Afternoon', 118, 'Oliver Wilson', 118);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Customer Service Representative', 14597, 'srcIaymu@gmail.com', 531311411, 'Morning', 119, 'Claire Moore', 119);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Prepress Technician', 10709, 'bhMGH8Ps@gmail.com', 546038928, 'Morning', 120, 'Ethan Jackson', 120);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Press Operator', 8371, 'eAajFqMr@gmail.com', 517544772, 'Afternoon', 121, 'Jackson Lee', 121);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Prepress Technician', 10085, 'Q9v3OY7v@gmail.com', 590831902, 'Afternoon', 122, 'Maverick Thomas', 122);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Prepress Technician', 11553, 'xlUR5WMd@gmail.com', 574811782, 'Evening', 123, 'Charlotte Brown', 123);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Prepress Technician', 7815, 'aZ1FtSUv@gmail.com', 566142031, 'Evening', 124, 'Scarlett Lewis', 124);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values (' Graphic Designer', 10436, 'AZFIAUPh@gmail.com', 586384716, 'Morning', 125, 'Ethan Moore', 125);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Prepress Technician', 14831, 'tgyP87nU@gmail.com', 566625064, 'Morning', 126, 'Mason Johnson', 126);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values (' Graphic Designer', 14651, 'cZbJD4ZV@gmail.com', 541758860, 'Morning', 127, 'Harper Allen', 127);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Prepress Technician', 13791, '8DI1thph@gmail.com', 505065140, 'Morning', 128, 'Scarlett Allen', 128);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values (' Graphic Designer', 13783, 'IEK1LKdt@gmail.com', 596851087, 'Evening', 129, 'Lucas Campbell', 129);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Press Operator', 14575, 'ivjD1J4C@gmail.com', 589054493, 'Morning', 130, 'Ella Thomas', 130);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Customer Service Representative', 12889, 'VlsjjorT@gmail.com', 595616828, 'Morning', 131, 'Emma Hernandez', 131);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Press Operator', 8807, 'rPPxv09W@gmail.com', 592759653, 'Afternoon', 132, 'Mason Young', 132);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Press Operator', 8994, 'k4MydnyK@gmail.com', 511439653, 'Afternoon', 133, 'Avery Johnson', 133);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Customer Service Representative', 12452, 'ucGpH8gv@gmail.com', 544503063, 'Morning', 134, 'Matthew Davis', 134);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Press Operator', 7850, 'agKPJ3wb@gmail.com', 542738027, 'Afternoon', 135, 'Ethan Robinson', 135);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Customer Service Representative', 12330, 'nHwPrbmO@gmail.com', 584238863, 'Morning', 136, 'Logan Allen', 136);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values (' Graphic Designer', 12511, 'xs4zal62@gmail.com', 560033171, 'Evening', 137, 'Mason Scott', 137);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Customer Service Representative', 11966, 'zxx8ybq2@gmail.com', 504085308, 'Afternoon', 138, 'Ella Turner', 138);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Prepress Technician', 12619, 'vZHo0yRM@gmail.com', 558600621, 'Evening', 139, 'Mason Lopez', 139);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values (' Graphic Designer', 13858, 'vsU037yi@gmail.com', 570833546, 'Afternoon', 140, 'Aaliyah Walker', 140);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Prepress Technician', 11922, 'JMqdDBMT@gmail.com', 537566076, 'Evening', 141, 'Olivia Mitchell', 141);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Customer Service Representative', 13432, 'pJPqEnHH@gmail.com', 537021434, 'Afternoon', 142, 'Ethan Nelson', 142);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Prepress Technician', 13651, 'EFUAeDcN@gmail.com', 548756040, 'Morning', 143, 'Alexander Miller', 143);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Prepress Technician', 14632, 'sDXsGKz7@gmail.com', 586233230, 'Morning', 144, 'Mason King', 144);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Press Operator', 8613, 'I7HPYKIv@gmail.com', 560352029, 'Afternoon', 145, 'Ethan Hall', 145);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Prepress Technician', 15107, 'pML4bvqf@gmail.com', 565054766, 'Morning', 146, 'Elias Carter', 146);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Prepress Technician', 10805, '54iAcoEo@gmail.com', 596145348, 'Afternoon', 147, 'Emily Turner', 147);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values (' Graphic Designer', 11703, 'lWCpHFXn@gmail.com', 559362076, 'Evening', 148, 'Charlotte Rodriguez', 148);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values (' Graphic Designer', 15859, 'LaPkhLQz@gmail.com', 575258169, 'Morning', 149, 'Mason Clark', 149);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Press Operator', 12917, 'WxnydswT@gmail.com', 527595994, 'Afternoon', 150, 'Elias Miller', 150);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values (' Graphic Designer', 12555, 'lgolGf2Y@gmail.com', 525772289, 'Afternoon', 151, 'James Carter', 151);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Prepress Technician', 11227, 'If2sIZSO@gmail.com', 544766314, 'Afternoon', 152, 'Charlotte Hall', 152);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Press Operator', 12294, 'vTyQEpqy@gmail.com', 534884493, 'Evening', 153, 'Oliver Davis', 153);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Press Operator', 14952, 'Wk1Ilwzs@gmail.com', 597121496, 'Morning', 154, 'Emma Turner', 154);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Press Operator', 13822, 'F5GvjfaO@gmail.com', 594766367, 'Morning', 155, 'Liam Moore', 155);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Press Operator', 7814, 'j9jLB4Hv@gmail.com', 574160322, 'Afternoon', 156, 'James Garcia', 156);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values (' Graphic Designer', 11328, 'vxEoIODK@gmail.com', 527686916, 'Afternoon', 157, 'Mason Jackson', 157);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Prepress Technician', 15233, '09bBLCcP@gmail.com', 562694889, 'Morning', 158, 'Mason Lee', 158);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Customer Service Representative', 10780, '0V5RCVD8@gmail.com', 577044786, 'Afternoon', 159, 'Avah Robinson', 159);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values (' Graphic Designer', 8817, 'CQyYvjmI@gmail.com', 523297388, 'Morning', 160, 'Abigail Young', 160);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Press Operator', 16192, 'aoleN6Vt@gmail.com', 509334722, 'Morning', 161, 'William Moore', 161);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Press Operator', 12022, 'HV1XooNy@gmail.com', 513601393, 'Afternoon', 162, 'William Walker', 162);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Prepress Technician', 10223, '0ZxDdRwA@gmail.com', 507855207, 'Evening', 163, 'Ethan Hernandez', 163);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Press Operator', 13575, 'G58rumS1@gmail.com', 533322083, 'Afternoon', 164, 'Olivia Green', 164);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Prepress Technician', 9174, 'GooEaANg@gmail.com', 527399786, 'Afternoon', 165, 'Evelyn Diaz', 165);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Press Operator', 14644, '6LlVevcq@gmail.com', 513149746, 'Evening', 166, 'Stella Rodriguez', 166);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values (' Graphic Designer', 9336, 'QVsHI8BY@gmail.com', 546426321, 'Afternoon', 167, 'Avery Walker', 167);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Customer Service Representative', 9253, 'a1biOq9X@gmail.com', 525700652, 'Afternoon', 168, 'Avah Davis', 168);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Prepress Technician', 8933, 'GAAD4Gvz@gmail.com', 526956196, 'Afternoon', 1, 'Elias Martin', 1);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Prepress Technician', 8919, '6nH7yatv@gmail.com', 546597191, 'Evening', 2, 'Oliver Young', 2);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Prepress Technician', 8466, 'gi7BAUJU@gmail.com', 531149208, 'Morning', 3, 'Jackson Murphy', 3);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values (' Graphic Designer', 11895, 'Y5kCLDmE@gmail.com', 539048194, 'Afternoon', 4, 'Elijah Robinson', 4);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Customer Service Representative', 8712, '1hYiTP6g@gmail.com', 536732435, 'Evening', 5, 'David Carter', 5);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Prepress Technician', 15785, 'oiTZv76k@gmail.com', 571796738, 'Morning', 6, 'Claire Miller', 6);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Prepress Technician', 14530, 'eZslowdS@gmail.com', 535796510, 'Evening', 7, 'Aurora Turner', 7);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Customer Service Representative', 10118, 'Jm4gMp5R@gmail.com', 569391226, 'Evening', 8, 'Emma Wright', 8);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values (' Graphic Designer', 11307, 'x4XJknNp@gmail.com', 572740432, 'Morning', 9, 'Amelia Campbell', 9);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Prepress Technician', 14112, 'EsdgtOYs@gmail.com', 576945371, 'Morning', 10, 'Sophia King', 10);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Press Operator', 9180, 'WCduuOBr@gmail.com', 536342312, 'Evening', 11, 'Olivia Scott', 11);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Press Operator', 9575, 'UHRBwxhc@gmail.com', 509286034, 'Evening', 12, 'Harper Young', 12);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Press Operator', 11800, 'A9qO1tjN@gmail.com', 595522957, 'Morning', 13, 'Henry Lopez', 13);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Press Operator', 14402, '78OofnqK@gmail.com', 591200672, 'Afternoon', 14, 'Benjamin Hall', 14);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Prepress Technician', 8113, '1gDaAeE9@gmail.com', 583586434, 'Afternoon', 15, 'William Jones', 15);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Prepress Technician', 9470, 'TgXQrIAR@gmail.com', 552337692, 'Morning', 16, 'Sophia Anderson', 16);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values (' Graphic Designer', 12521, 'BwlXs3S0@gmail.com', 514103974, 'Afternoon', 17, 'Claire Miller', 17);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Press Operator', 8627, 'IeI0C6pp@gmail.com', 529814090, 'Evening', 18, 'Elizabeth Lee', 18);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values (' Graphic Designer', 10277, 'YE1J0PXg@gmail.com', 508291301, 'Afternoon', 19, 'Avah Lewis', 19);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Prepress Technician', 8961, 'pqMgEsc5@gmail.com', 504357854, 'Afternoon', 20, 'Luna Phillips', 20);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Customer Service Representative', 10323, 'PUFX199h@gmail.com', 572260269, 'Afternoon', 21, 'Violet Young', 21);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values (' Graphic Designer', 14003, 'PQrlU0DH@gmail.com', 503386039, 'Morning', 22, 'Avery Davis', 22);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values (' Graphic Designer', 9758, '8BCFLbEI@gmail.com', 533375134, 'Afternoon', 23, 'Oliver Turner', 23);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values (' Graphic Designer', 9366, 'An40xdkZ@gmail.com', 597321717, 'Afternoon', 24, 'Aaliyah Carter', 24);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values (' Graphic Designer', 10977, 'm20jWqa7@gmail.com', 557836241, 'Evening', 25, 'Harper Baker', 25);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Press Operator', 7695, 'AiX7Iylg@gmail.com', 565811105, 'Evening', 26, 'Amelia Diaz', 26);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values (' Graphic Designer', 12888, 'xIo5Rzc4@gmail.com', 591157312, 'Afternoon', 27, 'Isabella Wright', 27);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Press Operator', 8811, 'aR6JSBjz@gmail.com', 548441159, 'Afternoon', 28, 'Liam Nelson', 28);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Press Operator', 12976, 'vyTAEOkY@gmail.com', 562938459, 'Afternoon', 29, 'Liam Smith', 29);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Customer Service Representative', 11248, 'LXPribsA@gmail.com', 528746755, 'Afternoon', 30, 'Aaliyah Hernandez', 30);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Customer Service Representative', 12296, 'V463Osef@gmail.com', 582066880, 'Morning', 31, 'Liam Young', 31);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Press Operator', 8575, '96k9xQ2o@gmail.com', 538201036, 'Evening', 32, 'Abigail Moore', 32);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Press Operator', 7938, 'L1E3kf4V@gmail.com', 570649166, 'Evening', 33, 'Liam Phillips', 33);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Press Operator', 12484, 'W2XH0zYT@gmail.com', 559682130, 'Evening', 34, 'Evelyn Campbell', 34);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Press Operator', 15082, 'TwnwCmkt@gmail.com', 542467998, 'Morning', 35, 'Mason Miller', 35);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Prepress Technician', 10240, 'yrybonQD@gmail.com', 576716252, 'Morning', 36, 'Abigail Walker', 36);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Prepress Technician', 14276, 'jP8RHiOr@gmail.com', 562485543, 'Morning', 37, 'Elizabeth Scott', 37);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Prepress Technician', 9586, 'y33H0Fak@gmail.com', 531392041, 'Evening', 38, 'William Jones', 38);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Press Operator', 9464, 'c6hSZvJG@gmail.com', 519970445, 'Evening', 39, 'William Rodriguez', 39);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Prepress Technician', 10961, 'tamyBCgo@gmail.com', 550479868, 'Afternoon', 40, 'Ava Wright', 40);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values (' Graphic Designer', 13431, 'rEvppcLv@gmail.com', 522955072, 'Afternoon', 41, 'Evelyn Rodriguez', 41);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Prepress Technician', 13288, '8Vp9sFwY@gmail.com', 577536719, 'Afternoon', 42, 'Elijah Wood', 42);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Prepress Technician', 12635, 'j5c9aE2Y@gmail.com', 563747501, 'Evening', 43, 'Jackson Bell', 43);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Prepress Technician', 12807, 'LpC6obrr@gmail.com', 525879367, 'Evening', 44, 'James Campbell', 44);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Prepress Technician', 15270, 'fr07YdqE@gmail.com', 538306078, 'Morning', 45, 'Camila Young', 45);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Customer Service Representative', 15577, 'R7tQK1Sr@gmail.com', 526704387, 'Morning', 46, 'Mateo Robinson', 46);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Customer Service Representative', 13351, 'dgz3BOmZ@gmail.com', 518269520, 'Afternoon', 47, 'Alexander Mitchell', 47);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Press Operator', 11868, 'j4CbgqnF@gmail.com', 558056698, 'Morning', 48, 'Henry Scott', 48);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values (' Graphic Designer', 14772, 'moQMLCBt@gmail.com', 599394146, 'Afternoon', 49, 'Lucas Wright', 49);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Prepress Technician', 10828, '2hBAWI0n@gmail.com', 554253415, 'Morning', 50, 'Mason Diaz', 50);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Prepress Technician', 10063, 'BX18EyNn@gmail.com', 509320960, 'Morning', 51, 'Harper Clark', 51);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Press Operator', 11269, '1sqQ1w5V@gmail.com', 515633392, 'Afternoon', 52, 'Lucas Miller', 52);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Prepress Technician', 9533, 'LY7TfiiT@gmail.com', 506938505, 'Evening', 53, 'Benjamin Walker', 53);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Prepress Technician', 10259, 'LBEDM70b@gmail.com', 589856059, 'Morning', 54, 'Charlotte Allen', 54);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Press Operator', 12793, 'yo7rv2m3@gmail.com', 560529370, 'Morning', 55, 'Mia Martin', 55);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values (' Graphic Designer', 11774, 'OMBpYwxP@gmail.com', 584697110, 'Afternoon', 56, 'William Williams', 56);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Customer Service Representative', 10975, 'cIRI8C7I@gmail.com', 517804862, 'Evening', 57, 'Liam Moore', 57);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Prepress Technician', 9532, 'ZQzzg1z8@gmail.com', 514869393, 'Morning', 58, 'Charlotte Robinson', 58);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Customer Service Representative', 7683, '1aEjz3kV@gmail.com', 530469739, 'Evening', 59, 'Benjamin Campbell', 59);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Customer Service Representative', 8374, 'Y3KC4Cwy@gmail.com', 514138556, 'Evening', 60, 'Avery Diaz', 60);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Prepress Technician', 11220, 'ZeJhzX67@gmail.com', 533642917, 'Afternoon', 61, 'Avery Allen', 61);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values (' Graphic Designer', 13886, 'ZL0p4XNn@gmail.com', 551519517, 'Afternoon', 62, 'Benjamin Wright', 62);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Customer Service Representative', 11913, 'z2VMinVL@gmail.com', 556545258, 'Morning', 63, 'Michael Robinson', 63);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Prepress Technician', 8913, '2OnnjRrd@gmail.com', 559270669, 'Evening', 64, 'Emma Johnson', 64);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values (' Graphic Designer', 7527, 'jE3hUxyX@gmail.com', 571219730, 'Afternoon', 65, 'Julian Hall', 65);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Press Operator', 9932, 'QaxWvBKD@gmail.com', 576451537, 'Evening', 66, 'Julian Harris', 66);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values (' Graphic Designer', 12215, 'wMZR4ZpO@gmail.com', 581288119, 'Afternoon', 67, 'Michael Rodriguez', 67);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Prepress Technician', 12170, 'mbvL0VI6@gmail.com', 578763693, 'Evening', 68, 'Sofia Thomas', 68);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Prepress Technician', 11594, 'zsGxd509@gmail.com', 518611303, 'Morning', 69, 'Charlotte Hall', 69);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Press Operator', 11562, 'PdtASed0@gmail.com', 593795124, 'Morning', 70, 'Sofia Wright', 70);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Press Operator', 14664, 'gMhuzYc0@gmail.com', 505817467, 'Morning', 71, 'Noah Rodriguez', 71);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Prepress Technician', 14284, 'g9qHbSom@gmail.com', 506487681, 'Afternoon', 72, 'Charlotte Lewis', 72);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Customer Service Representative', 9945, 'b28ERxnM@gmail.com', 535336993, 'Evening', 73, 'Noah Young', 73);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Press Operator', 15976, 'UVWpEaTp@gmail.com', 579430329, 'Morning', 74, 'Evelyn Wright', 74);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values (' Graphic Designer', 8497, 's2af13fR@gmail.com', 541135262, 'Afternoon', 75, 'Sophia Williams', 75);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Customer Service Representative', 11077, 'FqYIP34w@gmail.com', 516256511, 'Afternoon', 76, 'Mason Murphy', 76);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Press Operator', 14174, 'AzIy1pPl@gmail.com', 559027760, 'Morning', 77, 'Elias Gonzalez', 77);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Prepress Technician', 8059, '3lBcPXTY@gmail.com', 558713988, 'Evening', 78, 'James Wood', 78);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Customer Service Representative', 13421, 'tEXa18Z0@gmail.com', 565641120, 'Morning', 79, 'Mason Walker', 79);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values (' Graphic Designer', 8856, 'YnbzsL8k@gmail.com', 514677999, 'Morning', 80, 'Lucas Green', 80);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values (' Graphic Designer', 11018, '6vuL1i45@gmail.com', 592891900, 'Morning', 81, 'Camila Robinson', 81);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values (' Graphic Designer', 11313, 'R3XSwBgh@gmail.com', 534674181, 'Evening', 82, 'James Moore', 82);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Customer Service Representative', 13596, '1S7eqI8N@gmail.com', 527521685, 'Afternoon', 83, 'Aaliyah Gonzalez', 83);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Customer Service Representative', 15040, 'iiA9miYG@gmail.com', 590019845, 'Morning', 84, 'Liam Davis', 84);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Prepress Technician', 14386, 'L5a1AmxO@gmail.com', 529437123, 'Morning', 334, 'Mateo Harris', 334);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Press Operator', 9275, '24OsitCY@gmail.com', 524796363, 'Morning', 335, 'Avah Robinson', 335);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values (' Graphic Designer', 13412, 'h1nSenl1@gmail.com', 538066996, 'Afternoon', 336, 'Evelyn Wright', 336);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Customer Service Representative', 12321, 'PG7Wm3M5@gmail.com', 502971717, 'Afternoon', 337, 'Harper Phillips', 337);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values (' Graphic Designer', 8360, 'u43EI0Kt@gmail.com', 569442839, 'Morning', 338, 'Charlotte Garcia', 338);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Prepress Technician', 14970, 'Q8Xgd3IP@gmail.com', 560797933, 'Afternoon', 339, 'Elizabeth King', 339);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Press Operator', 8276, 'vtyUFiSo@gmail.com', 528431079, 'Evening', 340, 'Amelia Pierce', 340);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Press Operator', 10932, 'YvSqAf1h@gmail.com', 541835259, 'Afternoon', 341, 'Amelia Green', 341);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Prepress Technician', 14828, 'hYjJRn1E@gmail.com', 512881514, 'Morning', 342, 'Charlotte Lewis', 342);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Press Operator', 13951, 'aTTT9QVf@gmail.com', 535597591, 'Morning', 343, 'Elijah Allen', 343);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values (' Graphic Designer', 9790, 'keCdwFJE@gmail.com', 581356571, 'Evening', 344, 'Noah Murphy', 344);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Press Operator', 13457, 'FTXhOk4V@gmail.com', 508672051, 'Afternoon', 345, 'Emma Turner', 345);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Prepress Technician', 12210, 'B8ojr5PU@gmail.com', 592310757, 'Morning', 346, 'Harper Bell', 346);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Prepress Technician', 14518, 'oKnBTdVY@gmail.com', 559661771, 'Evening', 347, 'Elijah Phillips', 347);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Prepress Technician', 14094, 'cwJigb05@gmail.com', 536065702, 'Evening', 348, 'Emily Wilson', 348);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Press Operator', 9563, 'USbZscUt@gmail.com', 505104160, 'Afternoon', 349, 'Lucas Scott', 349);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Press Operator', 13109, 'bjkuMA2b@gmail.com', 552979798, 'Afternoon', 350, 'Sophia Miller', 350);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Customer Service Representative', 9602, 'Zsw9tfSi@gmail.com', 539768121, 'Evening', 351, 'Amelia Hernandez', 351);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values (' Graphic Designer', 14967, 'iabiRyfK@gmail.com', 511197573, 'Evening', 352, 'James Robinson', 352);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values (' Graphic Designer', 8130, 'APY82YDE@gmail.com', 599565362, 'Afternoon', 353, 'Lucas Scott', 353);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values (' Graphic Designer', 10538, 'TqyI6rLz@gmail.com', 543251627, 'Afternoon', 354, 'Julian Nelson', 354);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Press Operator', 12874, '3dXy9XcC@gmail.com', 514190728, 'Afternoon', 355, 'Penelope Nelson', 355);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Customer Service Representative', 10226, 'CdXNbZ6e@gmail.com', 567216812, 'Afternoon', 356, 'Lucas Bell', 356);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Press Operator', 10144, 'TGAsCZsb@gmail.com', 552195398, 'Afternoon', 357, 'Mateo Campbell', 357);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Prepress Technician', 9693, 'aTFmk2Vr@gmail.com', 506916652, 'Morning', 358, 'Sofia Moore', 358);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Prepress Technician', 8256, 'YUXxDp8p@gmail.com', 532665232, 'Morning', 359, 'Abigail Rodriguez', 359);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Prepress Technician', 9842, 'JlaFoxfF@gmail.com', 588426256, 'Morning', 360, 'Elijah Clark', 360);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Press Operator', 11345, 'It9TwzTP@gmail.com', 507362202, 'Evening', 361, 'Evelyn Diaz', 361);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values (' Graphic Designer', 14478, 'ky9KCP5H@gmail.com', 583161545, 'Evening', 362, 'Violet Wright', 362);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Press Operator', 10593, 'lpMrHB7V@gmail.com', 595570776, 'Evening', 363, 'Oliver Gonzalez', 363);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values (' Graphic Designer', 9848, 'XROc5Zko@gmail.com', 515884498, 'Evening', 364, 'Stella Lopez', 364);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values (' Graphic Designer', 9071, 'RyCRF4fn@gmail.com', 524668969, 'Evening', 365, 'Alexander Diaz', 365);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Prepress Technician', 8424, '7xZUUbNR@gmail.com', 540463916, 'Morning', 366, 'Camila Walker', 366);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Customer Service Representative', 12425, 'u89Cfmd8@gmail.com', 504254558, 'Morning', 367, 'Sofia Thomas', 367);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Customer Service Representative', 13309, 'L81Gkmp1@gmail.com', 501019696, 'Afternoon', 368, 'Emily Johnson', 368);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Customer Service Representative', 15453, '70cbwBca@gmail.com', 515042721, 'Morning', 369, 'Benjamin Moore', 369);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values (' Graphic Designer', 15065, 'WGSqXsO2@gmail.com', 500046415, 'Morning', 370, 'Ava Davis', 370);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Customer Service Representative', 16070, 'QOSvrh1r@gmail.com', 502776679, 'Morning', 371, 'Sophia Nelson', 371);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Prepress Technician', 12950, 'A7kfOh7V@gmail.com', 527984176, 'Evening', 372, 'Layla Miller', 372);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values (' Graphic Designer', 11208, 'bP8ZZNbn@gmail.com', 591335142, 'Afternoon', 373, 'Mateo Allen', 373);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values (' Graphic Designer', 10001, 'lDx57p3s@gmail.com', 511729022, 'Morning', 374, 'Julian Pierce', 374);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values (' Graphic Designer', 12095, 'g5Hx7qCv@gmail.com', 596598587, 'Morning', 375, 'Evelyn Robinson', 375);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Prepress Technician', 9579, '6UZpSdeG@gmail.com', 531347364, 'Evening', 376, 'Aaliyah Lewis', 376);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Prepress Technician', 13829, 'n4J8tgWh@gmail.com', 594695462, 'Evening', 377, 'Ethan Clark', 377);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values (' Graphic Designer', 8866, 'Ac40NdiY@gmail.com', 536280685, 'Morning', 378, 'Harper Wright', 378);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Prepress Technician', 11108, 'CMqwVbmj@gmail.com', 532415772, 'Evening', 379, 'Claire Rodriguez', 379);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values (' Graphic Designer', 12764, '4gWpq6Aq@gmail.com', 564311166, 'Afternoon', 380, 'Evelyn Lewis', 380);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Prepress Technician', 11786, 'PE1IcXUk@gmail.com', 583541376, 'Afternoon', 381, 'Evelyn Clark', 381);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Customer Service Representative', 14709, 'oUGgwero@gmail.com', 593240846, 'Evening', 382, 'Logan Davis', 382);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Prepress Technician', 9678, 'gzcqytz9@gmail.com', 591195411, 'Afternoon', 391, 'Evelyn Cruz', 391);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values (' Graphic Designer', 9261, '4gAOCGvY@gmail.com', 520820659, 'Morning', 392, 'Harper Moore', 392);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values (' Graphic Designer', 7788, 'j9jGVpkE@gmail.com', 583742734, 'Evening', 393, 'Isabella Garcia', 393);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values (' Graphic Designer', 7853, '43H2rpoa@gmail.com', 508996068, 'Afternoon', 394, 'Sophia Moore', 394);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Customer Service Representative', 12118, '0wjVxlQp@gmail.com', 504583403, 'Morning', 395, 'Luna Robinson', 395);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values (' Graphic Designer', 9458, 'HxKvLbhu@gmail.com', 583027794, 'Afternoon', 396, 'Noah Moore', 396);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Press Operator', 9357, 'VZ66xbGU@gmail.com', 553864574, 'Morning', 397, 'Olivia Clark', 397);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Press Operator', 12788, '4BVRYEYO@gmail.com', 588097735, 'Morning', 398, 'Stella Thomas', 398);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Prepress Technician', 10117, 'Q8WCuvvG@gmail.com', 545871829, 'Evening', 399, 'Levi Carter', 399);
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname, id_person)
values ('Press Operator', 14744, 'KDRiP8Oh@gmail.com', 568170451, 'Evening', 400, 'Benjamin Clark', 400);
prompt 392 records loaded
prompt Loading ORDERS...
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1379, to_date('24-09-2021', 'dd-mm-yyyy'), to_date('27-03-2020', 'dd-mm-yyyy'), 2225, 179, 818, 2242, 569, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1817, to_date('28-04-2021', 'dd-mm-yyyy'), to_date('09-05-2021', 'dd-mm-yyyy'), 2226, 308, 818, 2257, 644, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1886, to_date('10-10-2022', 'dd-mm-yyyy'), to_date('27-04-2020', 'dd-mm-yyyy'), 2227, 31, 811, 2385, 599, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1169, to_date('10-06-2021', 'dd-mm-yyyy'), to_date('24-05-2021', 'dd-mm-yyyy'), 2228, 88, 817, 2115, 728, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1111, to_date('11-10-2021', 'dd-mm-yyyy'), to_date('02-12-2020', 'dd-mm-yyyy'), 2229, 236, 813, 2237, 633, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1211, to_date('26-08-2022', 'dd-mm-yyyy'), to_date('07-12-2022', 'dd-mm-yyyy'), 2230, 45, 812, 2206, 780, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1201, to_date('13-05-2020', 'dd-mm-yyyy'), to_date('15-08-2022', 'dd-mm-yyyy'), 2231, 114, 850, 2246, 600, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1394, to_date('24-01-2020', 'dd-mm-yyyy'), to_date('28-02-2021', 'dd-mm-yyyy'), 2233, 24, 850, 2367, 751, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1678, to_date('05-01-2020', 'dd-mm-yyyy'), to_date('11-10-2023', 'dd-mm-yyyy'), 2234, 395, 803, 2265, 644, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1204, to_date('03-11-2023', 'dd-mm-yyyy'), to_date('18-10-2023', 'dd-mm-yyyy'), 2235, 363, 806, 2206, 527, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1393, to_date('05-05-2020', 'dd-mm-yyyy'), to_date('25-11-2023', 'dd-mm-yyyy'), 2236, 77, 834, 2265, 783, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1524, to_date('15-08-2021', 'dd-mm-yyyy'), to_date('17-10-2022', 'dd-mm-yyyy'), 2237, 71, 844, 2022, 465, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1076, to_date('27-09-2023', 'dd-mm-yyyy'), to_date('10-01-2022', 'dd-mm-yyyy'), 2238, 168, 845, 2178, 761, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1219, to_date('28-06-2020', 'dd-mm-yyyy'), to_date('02-07-2020', 'dd-mm-yyyy'), 2240, 5, 811, 2217, 766, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1761, to_date('17-05-2020', 'dd-mm-yyyy'), to_date('24-12-2023', 'dd-mm-yyyy'), 2241, 233, 847, 2351, 469, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1254, to_date('10-11-2022', 'dd-mm-yyyy'), to_date('21-05-2020', 'dd-mm-yyyy'), 2242, 1, 838, 2088, 432, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1090, to_date('05-07-2022', 'dd-mm-yyyy'), to_date('05-11-2021', 'dd-mm-yyyy'), 2243, 106, 811, 2094, 599, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1031, to_date('05-01-2021', 'dd-mm-yyyy'), to_date('29-11-2020', 'dd-mm-yyyy'), 2244, 77, 834, 2132, 675, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1451, to_date('13-10-2022', 'dd-mm-yyyy'), to_date('03-09-2023', 'dd-mm-yyyy'), 2245, 233, 844, 2193, 499, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1432, to_date('28-02-2021', 'dd-mm-yyyy'), to_date('05-09-2023', 'dd-mm-yyyy'), 2246, 133, 804, 2220, 671, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1366, to_date('15-12-2020', 'dd-mm-yyyy'), to_date('04-12-2021', 'dd-mm-yyyy'), 2247, 56, 814, 2128, 408, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1247, to_date('20-02-2023', 'dd-mm-yyyy'), to_date('04-07-2020', 'dd-mm-yyyy'), 2248, 312, 833, 2120, 787, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1775, to_date('22-01-2020', 'dd-mm-yyyy'), to_date('16-01-2021', 'dd-mm-yyyy'), 2249, 92, 834, 2163, 787, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1189, to_date('27-02-2021', 'dd-mm-yyyy'), to_date('25-11-2023', 'dd-mm-yyyy'), 2250, 2, 838, 2369, 582, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1697, to_date('30-11-2021', 'dd-mm-yyyy'), to_date('11-05-2022', 'dd-mm-yyyy'), 2251, 86, 814, 2380, 669, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1704, to_date('04-08-2020', 'dd-mm-yyyy'), to_date('21-09-2023', 'dd-mm-yyyy'), 2253, 170, 807, 2347, 760, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1064, to_date('26-03-2020', 'dd-mm-yyyy'), to_date('14-04-2022', 'dd-mm-yyyy'), 2254, 256, 845, 2334, 441, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1140, to_date('23-08-2023', 'dd-mm-yyyy'), to_date('13-09-2021', 'dd-mm-yyyy'), 2259, 308, 807, 2340, 552, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1405, to_date('08-01-2022', 'dd-mm-yyyy'), to_date('25-08-2020', 'dd-mm-yyyy'), 2260, 6, 818, 2383, 420, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1300, to_date('05-10-2023', 'dd-mm-yyyy'), to_date('28-03-2020', 'dd-mm-yyyy'), 2261, 205, 837, 2257, 772, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1510, to_date('13-08-2022', 'dd-mm-yyyy'), to_date('20-04-2023', 'dd-mm-yyyy'), 2266, 197, 803, 2100, 603, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1849, to_date('17-10-2022', 'dd-mm-yyyy'), to_date('25-01-2020', 'dd-mm-yyyy'), 2267, 32, 836, 2092, 696, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1551, to_date('07-11-2020', 'dd-mm-yyyy'), to_date('08-03-2023', 'dd-mm-yyyy'), 2268, 297, 824, 2031, 593, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1682, to_date('18-03-2021', 'dd-mm-yyyy'), to_date('27-06-2021', 'dd-mm-yyyy'), 2270, 188, 839, 2041, 582, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1709, to_date('18-01-2021', 'dd-mm-yyyy'), to_date('23-10-2021', 'dd-mm-yyyy'), 2273, 138, 848, 2292, 423, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1036, to_date('26-09-2022', 'dd-mm-yyyy'), to_date('11-09-2022', 'dd-mm-yyyy'), 2274, 299, 804, 2376, 755, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1729, to_date('22-04-2023', 'dd-mm-yyyy'), to_date('30-01-2022', 'dd-mm-yyyy'), 2275, 29, 837, 2116, 582, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1154, to_date('10-06-2022', 'dd-mm-yyyy'), to_date('22-04-2022', 'dd-mm-yyyy'), 2277, 319, 807, 2085, 737, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1507, to_date('28-04-2020', 'dd-mm-yyyy'), to_date('27-01-2022', 'dd-mm-yyyy'), 2278, 164, 808, 2296, 735, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1607, to_date('15-12-2021', 'dd-mm-yyyy'), to_date('17-03-2020', 'dd-mm-yyyy'), 2280, 334, 807, 2038, 613, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1369, to_date('21-02-2023', 'dd-mm-yyyy'), to_date('14-04-2023', 'dd-mm-yyyy'), 2281, 82, 829, 2369, 677, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1051, to_date('09-03-2021', 'dd-mm-yyyy'), to_date('11-10-2020', 'dd-mm-yyyy'), 2282, 196, 830, 2336, 484, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1471, to_date('05-11-2021', 'dd-mm-yyyy'), to_date('27-08-2021', 'dd-mm-yyyy'), 2284, 146, 820, 2000, 544, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1865, to_date('13-12-2021', 'dd-mm-yyyy'), to_date('11-08-2022', 'dd-mm-yyyy'), 2285, 360, 836, 2179, 419, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1701, to_date('13-09-2023', 'dd-mm-yyyy'), to_date('06-08-2020', 'dd-mm-yyyy'), 2286, 343, 809, 2244, 590, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1632, to_date('21-02-2020', 'dd-mm-yyyy'), to_date('26-08-2020', 'dd-mm-yyyy'), 2287, 334, 819, 2283, 515, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1380, to_date('29-08-2020', 'dd-mm-yyyy'), to_date('20-06-2021', 'dd-mm-yyyy'), 2288, 187, 823, 2085, 421, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1714, to_date('01-01-2022', 'dd-mm-yyyy'), to_date('31-01-2022', 'dd-mm-yyyy'), 2291, 277, 821, 2398, 724, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1123, to_date('31-10-2020', 'dd-mm-yyyy'), to_date('23-12-2022', 'dd-mm-yyyy'), 2293, 266, 812, 2355, 791, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1882, to_date('23-10-2022', 'dd-mm-yyyy'), to_date('10-11-2020', 'dd-mm-yyyy'), 2298, 65, 842, 2290, 468, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1927, to_date('02-12-2022', 'dd-mm-yyyy'), to_date('16-05-2020', 'dd-mm-yyyy'), 2300, 136, 831, 2103, 413, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1268, to_date('02-06-2020', 'dd-mm-yyyy'), to_date('05-02-2023', 'dd-mm-yyyy'), 2301, 378, 819, 2147, 507, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1562, to_date('21-08-2021', 'dd-mm-yyyy'), to_date('23-11-2021', 'dd-mm-yyyy'), 2303, 303, 831, 2045, 519, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1564, to_date('17-03-2022', 'dd-mm-yyyy'), to_date('24-09-2021', 'dd-mm-yyyy'), 2305, 113, 838, 2347, 507, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1933, to_date('31-10-2022', 'dd-mm-yyyy'), to_date('17-10-2023', 'dd-mm-yyyy'), 2306, 55, 807, 2310, 795, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1438, to_date('12-11-2021', 'dd-mm-yyyy'), to_date('13-12-2020', 'dd-mm-yyyy'), 2307, 171, 821, 2369, 445, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1167, to_date('16-10-2023', 'dd-mm-yyyy'), to_date('30-01-2021', 'dd-mm-yyyy'), 2308, 336, 806, 2276, 594, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1745, to_date('23-06-2021', 'dd-mm-yyyy'), to_date('13-01-2022', 'dd-mm-yyyy'), 2309, 265, 850, 2392, 567, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1889, to_date('10-12-2021', 'dd-mm-yyyy'), to_date('26-10-2020', 'dd-mm-yyyy'), 2311, 336, 827, 2041, 536, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1266, to_date('03-09-2023', 'dd-mm-yyyy'), to_date('10-12-2022', 'dd-mm-yyyy'), 2312, 150, 822, 2059, 581, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1560, to_date('27-05-2021', 'dd-mm-yyyy'), to_date('22-04-2021', 'dd-mm-yyyy'), 2315, 265, 844, 2314, 552, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1851, to_date('25-01-2023', 'dd-mm-yyyy'), to_date('19-08-2020', 'dd-mm-yyyy'), 2317, 296, 811, 2209, 799, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1966, to_date('12-11-2023', 'dd-mm-yyyy'), to_date('16-01-2023', 'dd-mm-yyyy'), 2318, 27, 817, 2361, 456, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1473, to_date('02-10-2020', 'dd-mm-yyyy'), to_date('25-04-2022', 'dd-mm-yyyy'), 2319, 292, 838, 2194, 719, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1504, to_date('21-06-2023', 'dd-mm-yyyy'), to_date('14-09-2021', 'dd-mm-yyyy'), 2320, 68, 813, 2181, 531, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1888, to_date('09-08-2022', 'dd-mm-yyyy'), to_date('24-10-2021', 'dd-mm-yyyy'), 2321, 225, 846, 2215, 650, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1782, to_date('09-01-2021', 'dd-mm-yyyy'), to_date('28-03-2021', 'dd-mm-yyyy'), 2322, 212, 827, 2007, 572, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1034, to_date('29-11-2020', 'dd-mm-yyyy'), to_date('23-04-2021', 'dd-mm-yyyy'), 2323, 101, 813, 2041, 571, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1793, to_date('14-09-2023', 'dd-mm-yyyy'), to_date('10-03-2023', 'dd-mm-yyyy'), 2325, 105, 843, 2195, 660, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1173, to_date('09-03-2023', 'dd-mm-yyyy'), to_date('16-12-2020', 'dd-mm-yyyy'), 2326, 351, 834, 2279, 674, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1650, to_date('02-02-2021', 'dd-mm-yyyy'), to_date('11-02-2022', 'dd-mm-yyyy'), 2328, 202, 817, 2384, 477, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1358, to_date('24-11-2021', 'dd-mm-yyyy'), to_date('30-10-2021', 'dd-mm-yyyy'), 2329, 257, 839, 2304, 700, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1348, to_date('18-03-2020', 'dd-mm-yyyy'), to_date('14-01-2021', 'dd-mm-yyyy'), 2330, 325, 811, 2220, 602, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1024, to_date('27-02-2020', 'dd-mm-yyyy'), to_date('11-06-2022', 'dd-mm-yyyy'), 2331, 161, 829, 2008, 439, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1048, to_date('21-08-2021', 'dd-mm-yyyy'), to_date('01-06-2021', 'dd-mm-yyyy'), 2332, 203, 825, 2104, 612, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1059, to_date('16-09-2020', 'dd-mm-yyyy'), to_date('10-05-2022', 'dd-mm-yyyy'), 2333, 213, 806, 2256, 767, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1372, to_date('18-11-2023', 'dd-mm-yyyy'), to_date('20-09-2021', 'dd-mm-yyyy'), 2334, 225, 815, 2386, 635, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1956, to_date('24-08-2023', 'dd-mm-yyyy'), to_date('22-03-2020', 'dd-mm-yyyy'), 2335, 43, 839, 2025, 660, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1677, to_date('02-05-2021', 'dd-mm-yyyy'), to_date('29-08-2023', 'dd-mm-yyyy'), 2337, 368, 806, 2321, 589, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1941, to_date('02-08-2023', 'dd-mm-yyyy'), to_date('24-05-2020', 'dd-mm-yyyy'), 2338, 63, 835, 2230, 503, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1096, to_date('17-11-2023', 'dd-mm-yyyy'), to_date('27-04-2023', 'dd-mm-yyyy'), 2341, 152, 831, 2057, 751, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1355, to_date('12-02-2022', 'dd-mm-yyyy'), to_date('12-10-2023', 'dd-mm-yyyy'), 2342, 68, 829, 2202, 434, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1255, to_date('21-04-2021', 'dd-mm-yyyy'), to_date('07-06-2020', 'dd-mm-yyyy'), 2343, 77, 848, 2275, 436, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1323, to_date('26-09-2022', 'dd-mm-yyyy'), to_date('25-06-2023', 'dd-mm-yyyy'), 2344, 393, 808, 2257, 507, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1609, to_date('06-09-2022', 'dd-mm-yyyy'), to_date('06-07-2020', 'dd-mm-yyyy'), 2345, 162, 814, 2167, 547, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1470, to_date('05-11-2022', 'dd-mm-yyyy'), to_date('17-01-2021', 'dd-mm-yyyy'), 2346, 292, 808, 2010, 594, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1956, to_date('07-06-2020', 'dd-mm-yyyy'), to_date('15-02-2021', 'dd-mm-yyyy'), 2347, 285, 837, 2114, 565, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1851, to_date('16-02-2020', 'dd-mm-yyyy'), to_date('13-08-2022', 'dd-mm-yyyy'), 2348, 230, 847, 2392, 547, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1304, to_date('29-04-2023', 'dd-mm-yyyy'), to_date('16-03-2023', 'dd-mm-yyyy'), 2349, 132, 837, 2094, 633, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1628, to_date('06-08-2020', 'dd-mm-yyyy'), to_date('27-06-2023', 'dd-mm-yyyy'), 2350, 271, 815, 2180, 569, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1047, to_date('20-03-2022', 'dd-mm-yyyy'), to_date('18-04-2023', 'dd-mm-yyyy'), 2352, 258, 824, 2041, 598, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1362, to_date('29-10-2021', 'dd-mm-yyyy'), to_date('21-06-2022', 'dd-mm-yyyy'), 2353, 381, 810, 2148, 653, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1833, to_date('23-07-2021', 'dd-mm-yyyy'), to_date('15-04-2021', 'dd-mm-yyyy'), 2354, 18, 846, 2119, 658, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1234, to_date('05-07-2021', 'dd-mm-yyyy'), to_date('09-07-2021', 'dd-mm-yyyy'), 2355, 295, 818, 2056, 477, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1346, to_date('25-08-2023', 'dd-mm-yyyy'), to_date('27-09-2021', 'dd-mm-yyyy'), 2357, 400, 813, 2197, 531, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1929, to_date('26-07-2022', 'dd-mm-yyyy'), to_date('28-07-2022', 'dd-mm-yyyy'), 2359, 268, 832, 2114, 451, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1767, to_date('04-04-2020', 'dd-mm-yyyy'), to_date('13-08-2023', 'dd-mm-yyyy'), 2360, 156, 819, 2392, 782, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1091, to_date('16-04-2022', 'dd-mm-yyyy'), to_date('11-03-2020', 'dd-mm-yyyy'), 2363, 149, 805, 2209, 570, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1494, to_date('29-10-2022', 'dd-mm-yyyy'), to_date('23-03-2020', 'dd-mm-yyyy'), 2366, 15, 814, 2059, 526, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1649, to_date('06-03-2022', 'dd-mm-yyyy'), to_date('30-11-2021', 'dd-mm-yyyy'), 2367, 232, 819, 2332, 752, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1235, to_date('17-05-2023', 'dd-mm-yyyy'), to_date('07-12-2021', 'dd-mm-yyyy'), 2368, 84, 830, 2221, 736, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1071, to_date('03-10-2021', 'dd-mm-yyyy'), to_date('14-10-2022', 'dd-mm-yyyy'), 2370, 313, 813, 2008, 688, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1735, to_date('24-07-2022', 'dd-mm-yyyy'), to_date('13-03-2022', 'dd-mm-yyyy'), 2372, 350, 820, 2382, 692, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1912, to_date('14-03-2022', 'dd-mm-yyyy'), to_date('08-06-2021', 'dd-mm-yyyy'), 2373, 261, 837, 2378, 630, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1673, to_date('27-08-2020', 'dd-mm-yyyy'), to_date('12-08-2023', 'dd-mm-yyyy'), 2374, 293, 831, 2387, 755, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1945, to_date('15-12-2021', 'dd-mm-yyyy'), to_date('28-07-2022', 'dd-mm-yyyy'), 2377, 286, 838, 2000, 637, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1671, to_date('02-05-2022', 'dd-mm-yyyy'), to_date('18-09-2022', 'dd-mm-yyyy'), 2378, 234, 832, 2146, 642, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1199, to_date('01-09-2020', 'dd-mm-yyyy'), to_date('21-07-2020', 'dd-mm-yyyy'), 2381, 29, 824, 2046, 632, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1621, to_date('12-09-2021', 'dd-mm-yyyy'), to_date('26-03-2020', 'dd-mm-yyyy'), 2383, 308, 844, 2079, 578, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1035, to_date('13-11-2021', 'dd-mm-yyyy'), to_date('05-08-2021', 'dd-mm-yyyy'), 2384, 97, 816, 2163, 567, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1019, to_date('02-01-2022', 'dd-mm-yyyy'), to_date('08-11-2022', 'dd-mm-yyyy'), 2386, 349, 811, 2150, 646, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1590, to_date('24-02-2021', 'dd-mm-yyyy'), to_date('28-07-2021', 'dd-mm-yyyy'), 2388, 360, 820, 2267, 717, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1650, to_date('03-07-2020', 'dd-mm-yyyy'), to_date('26-04-2022', 'dd-mm-yyyy'), 2389, 41, 837, 2337, 737, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1153, to_date('21-10-2023', 'dd-mm-yyyy'), to_date('25-01-2021', 'dd-mm-yyyy'), 2391, 4, 819, 2048, 567, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1472, to_date('10-05-2021', 'dd-mm-yyyy'), to_date('31-07-2021', 'dd-mm-yyyy'), 2392, 143, 816, 2038, 728, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1768, to_date('26-05-2021', 'dd-mm-yyyy'), to_date('10-03-2021', 'dd-mm-yyyy'), 2397, 332, 850, 2341, 477, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1102, to_date('11-11-2022', 'dd-mm-yyyy'), to_date('01-02-2021', 'dd-mm-yyyy'), 2398, 221, 807, 2312, 426, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1316, to_date('04-04-2021', 'dd-mm-yyyy'), to_date('11-08-2023', 'dd-mm-yyyy'), 2399, 254, 835, 2104, 543, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1949, to_date('18-09-2020', 'dd-mm-yyyy'), to_date('07-08-2023', 'dd-mm-yyyy'), 2002, 43, 807, 2100, 514, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1702, to_date('04-11-2021', 'dd-mm-yyyy'), to_date('03-05-2022', 'dd-mm-yyyy'), 2003, 19, 850, 2326, 451, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1198, to_date('22-09-2023', 'dd-mm-yyyy'), to_date('20-01-2022', 'dd-mm-yyyy'), 2004, 223, 829, 2137, 675, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1778, to_date('01-10-2020', 'dd-mm-yyyy'), to_date('27-02-2023', 'dd-mm-yyyy'), 2005, 218, 827, 2098, 421, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1401, to_date('02-02-2022', 'dd-mm-yyyy'), to_date('25-04-2023', 'dd-mm-yyyy'), 2007, 197, 803, 2210, 779, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1451, to_date('26-06-2020', 'dd-mm-yyyy'), to_date('09-05-2021', 'dd-mm-yyyy'), 2009, 382, 816, 2353, 674, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1527, to_date('01-04-2020', 'dd-mm-yyyy'), to_date('17-09-2023', 'dd-mm-yyyy'), 2010, 199, 824, 2398, 777, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1942, to_date('15-12-2022', 'dd-mm-yyyy'), to_date('18-06-2022', 'dd-mm-yyyy'), 2013, 82, 810, 2171, 514, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1080, to_date('18-11-2020', 'dd-mm-yyyy'), to_date('04-02-2020', 'dd-mm-yyyy'), 2014, 96, 804, 2223, 504, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1142, to_date('25-05-2020', 'dd-mm-yyyy'), to_date('27-07-2020', 'dd-mm-yyyy'), 2015, 223, 834, 2393, 600, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1219, to_date('12-09-2020', 'dd-mm-yyyy'), to_date('05-12-2020', 'dd-mm-yyyy'), 2016, 245, 847, 2259, 615, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1478, to_date('05-02-2022', 'dd-mm-yyyy'), to_date('12-12-2021', 'dd-mm-yyyy'), 2018, 33, 844, 2299, 434, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1722, to_date('09-03-2023', 'dd-mm-yyyy'), to_date('03-05-2020', 'dd-mm-yyyy'), 2019, 356, 808, 2263, 434, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1783, to_date('17-05-2022', 'dd-mm-yyyy'), to_date('17-07-2023', 'dd-mm-yyyy'), 2021, 100, 827, 2239, 738, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1825, to_date('01-07-2023', 'dd-mm-yyyy'), to_date('12-10-2023', 'dd-mm-yyyy'), 2022, 15, 832, 2298, 478, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1923, to_date('02-11-2022', 'dd-mm-yyyy'), to_date('23-02-2021', 'dd-mm-yyyy'), 2024, 153, 805, 2142, 495, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1569, to_date('12-06-2022', 'dd-mm-yyyy'), to_date('16-02-2021', 'dd-mm-yyyy'), 2025, 38, 832, 2236, 570, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1695, to_date('27-02-2021', 'dd-mm-yyyy'), to_date('17-12-2022', 'dd-mm-yyyy'), 2027, 132, 805, 2131, 464, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1065, to_date('02-11-2021', 'dd-mm-yyyy'), to_date('14-12-2021', 'dd-mm-yyyy'), 2028, 335, 838, 2359, 756, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1419, to_date('29-09-2021', 'dd-mm-yyyy'), to_date('29-12-2022', 'dd-mm-yyyy'), 2030, 109, 809, 2060, 603, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1589, to_date('13-06-2021', 'dd-mm-yyyy'), to_date('20-03-2020', 'dd-mm-yyyy'), 2032, 48, 808, 2095, 720, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1600, to_date('22-12-2020', 'dd-mm-yyyy'), to_date('21-02-2023', 'dd-mm-yyyy'), 2033, 53, 826, 2304, 792, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1657, to_date('03-12-2020', 'dd-mm-yyyy'), to_date('18-10-2023', 'dd-mm-yyyy'), 2035, 58, 818, 2094, 571, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1857, to_date('13-10-2021', 'dd-mm-yyyy'), to_date('30-11-2023', 'dd-mm-yyyy'), 2037, 4, 820, 2244, 554, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1458, to_date('04-05-2022', 'dd-mm-yyyy'), to_date('05-06-2021', 'dd-mm-yyyy'), 2038, 80, 850, 2040, 477, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1638, to_date('16-05-2022', 'dd-mm-yyyy'), to_date('11-02-2023', 'dd-mm-yyyy'), 2039, 23, 849, 2120, 502, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1680, to_date('09-12-2020', 'dd-mm-yyyy'), to_date('29-10-2023', 'dd-mm-yyyy'), 2040, 199, 823, 2216, 779, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1143, to_date('18-09-2020', 'dd-mm-yyyy'), to_date('13-09-2023', 'dd-mm-yyyy'), 2043, 212, 826, 2135, 613, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1419, to_date('28-03-2020', 'dd-mm-yyyy'), to_date('14-05-2021', 'dd-mm-yyyy'), 2049, 244, 803, 2361, 589, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1073, to_date('23-08-2022', 'dd-mm-yyyy'), to_date('22-08-2021', 'dd-mm-yyyy'), 2050, 54, 824, 2379, 686, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1646, to_date('19-02-2021', 'dd-mm-yyyy'), to_date('19-08-2023', 'dd-mm-yyyy'), 2051, 54, 843, 2296, 795, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1208, to_date('17-12-2022', 'dd-mm-yyyy'), to_date('01-04-2023', 'dd-mm-yyyy'), 2053, 143, 850, 2082, 719, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1113, to_date('22-11-2021', 'dd-mm-yyyy'), to_date('09-03-2020', 'dd-mm-yyyy'), 2056, 116, 811, 2149, 403, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1607, to_date('12-09-2022', 'dd-mm-yyyy'), to_date('23-09-2022', 'dd-mm-yyyy'), 2057, 59, 817, 2042, 453, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1554, to_date('12-03-2022', 'dd-mm-yyyy'), to_date('29-08-2020', 'dd-mm-yyyy'), 2060, 175, 849, 2064, 438, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1319, to_date('28-09-2020', 'dd-mm-yyyy'), to_date('24-03-2023', 'dd-mm-yyyy'), 2061, 277, 811, 2065, 640, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1867, to_date('16-07-2022', 'dd-mm-yyyy'), to_date('08-06-2021', 'dd-mm-yyyy'), 2062, 205, 843, 2184, 437, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1325, to_date('27-03-2022', 'dd-mm-yyyy'), to_date('09-12-2022', 'dd-mm-yyyy'), 2064, 261, 845, 2311, 539, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1657, to_date('03-02-2021', 'dd-mm-yyyy'), to_date('04-08-2022', 'dd-mm-yyyy'), 2065, 356, 805, 2123, 514, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1076, to_date('31-08-2021', 'dd-mm-yyyy'), to_date('30-11-2023', 'dd-mm-yyyy'), 2066, 161, 822, 2020, 581, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1620, to_date('09-10-2021', 'dd-mm-yyyy'), to_date('02-03-2022', 'dd-mm-yyyy'), 2067, 186, 812, 2175, 403, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1552, to_date('04-10-2020', 'dd-mm-yyyy'), to_date('26-01-2023', 'dd-mm-yyyy'), 2068, 91, 835, 2251, 567, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1285, to_date('03-09-2022', 'dd-mm-yyyy'), to_date('08-06-2020', 'dd-mm-yyyy'), 2069, 299, 835, 2395, 647, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1976, to_date('06-02-2022', 'dd-mm-yyyy'), to_date('11-04-2023', 'dd-mm-yyyy'), 2071, 391, 814, 2269, 575, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1667, to_date('24-05-2021', 'dd-mm-yyyy'), to_date('15-09-2022', 'dd-mm-yyyy'), 2073, 366, 838, 2014, 493, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1167, to_date('18-12-2021', 'dd-mm-yyyy'), to_date('09-07-2020', 'dd-mm-yyyy'), 2076, 364, 833, 2285, 425, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1770, to_date('20-08-2021', 'dd-mm-yyyy'), to_date('23-04-2021', 'dd-mm-yyyy'), 2077, 33, 837, 2344, 598, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1606, to_date('10-03-2022', 'dd-mm-yyyy'), to_date('13-03-2023', 'dd-mm-yyyy'), 2078, 14, 831, 2118, 580, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1880, to_date('07-09-2021', 'dd-mm-yyyy'), to_date('09-08-2023', 'dd-mm-yyyy'), 2081, 218, 816, 2352, 482, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1239, to_date('17-01-2021', 'dd-mm-yyyy'), to_date('02-11-2022', 'dd-mm-yyyy'), 2082, 128, 802, 2195, 562, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1618, to_date('30-11-2022', 'dd-mm-yyyy'), to_date('15-05-2020', 'dd-mm-yyyy'), 2083, 28, 828, 2097, 770, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1818, to_date('18-09-2022', 'dd-mm-yyyy'), to_date('01-02-2020', 'dd-mm-yyyy'), 2084, 220, 839, 2240, 664, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1586, to_date('21-09-2022', 'dd-mm-yyyy'), to_date('21-07-2023', 'dd-mm-yyyy'), 2085, 50, 812, 2120, 438, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1550, to_date('11-10-2022', 'dd-mm-yyyy'), to_date('08-08-2020', 'dd-mm-yyyy'), 2086, 118, 832, 2254, 503, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1863, to_date('25-02-2020', 'dd-mm-yyyy'), to_date('16-11-2022', 'dd-mm-yyyy'), 2087, 368, 814, 2190, 466, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1857, to_date('28-05-2021', 'dd-mm-yyyy'), to_date('22-07-2020', 'dd-mm-yyyy'), 2088, 266, 841, 2025, 727, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1687, to_date('09-02-2023', 'dd-mm-yyyy'), to_date('25-07-2023', 'dd-mm-yyyy'), 2093, 204, 801, 2337, 779, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (2000, to_date('30-08-2021', 'dd-mm-yyyy'), to_date('07-09-2022', 'dd-mm-yyyy'), 2094, 81, 820, 2117, 656, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1348, to_date('25-01-2023', 'dd-mm-yyyy'), to_date('14-04-2020', 'dd-mm-yyyy'), 2095, 94, 821, 2359, 570, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1442, to_date('18-11-2023', 'dd-mm-yyyy'), to_date('19-10-2023', 'dd-mm-yyyy'), 2097, 153, 839, 2076, 542, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1470, to_date('06-07-2021', 'dd-mm-yyyy'), to_date('13-11-2022', 'dd-mm-yyyy'), 2098, 186, 813, 2311, 445, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1096, to_date('07-01-2021', 'dd-mm-yyyy'), to_date('06-02-2021', 'dd-mm-yyyy'), 2099, 81, 836, 2106, 483, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1482, to_date('27-03-2021', 'dd-mm-yyyy'), to_date('13-11-2023', 'dd-mm-yyyy'), 2100, 205, 805, 2190, 476, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1475, to_date('13-03-2022', 'dd-mm-yyyy'), to_date('04-02-2023', 'dd-mm-yyyy'), 2101, 158, 825, 2119, 603, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1284, to_date('06-04-2022', 'dd-mm-yyyy'), to_date('12-08-2022', 'dd-mm-yyyy'), 2102, 136, 827, 2216, 731, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1462, to_date('21-09-2020', 'dd-mm-yyyy'), to_date('18-07-2021', 'dd-mm-yyyy'), 2103, 27, 805, 2063, 481, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1099, to_date('14-10-2022', 'dd-mm-yyyy'), to_date('11-04-2023', 'dd-mm-yyyy'), 2104, 174, 820, 2081, 658, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1844, to_date('22-07-2023', 'dd-mm-yyyy'), to_date('16-06-2023', 'dd-mm-yyyy'), 2105, 174, 842, 2179, 722, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1665, to_date('19-02-2022', 'dd-mm-yyyy'), to_date('08-03-2023', 'dd-mm-yyyy'), 2106, 130, 834, 2222, 764, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1472, to_date('18-04-2020', 'dd-mm-yyyy'), to_date('31-12-2020', 'dd-mm-yyyy'), 2107, 117, 820, 2234, 442, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1261, to_date('26-07-2022', 'dd-mm-yyyy'), to_date('15-03-2023', 'dd-mm-yyyy'), 2108, 159, 818, 2132, 792, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1546, to_date('20-06-2020', 'dd-mm-yyyy'), to_date('23-03-2021', 'dd-mm-yyyy'), 2110, 179, 808, 2065, 775, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1683, to_date('12-11-2020', 'dd-mm-yyyy'), to_date('01-03-2020', 'dd-mm-yyyy'), 2111, 331, 802, 2397, 734, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1294, to_date('09-07-2021', 'dd-mm-yyyy'), to_date('10-06-2022', 'dd-mm-yyyy'), 2113, 26, 831, 2214, 593, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1993, to_date('18-09-2021', 'dd-mm-yyyy'), to_date('27-03-2021', 'dd-mm-yyyy'), 2117, 53, 818, 2001, 589, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1160, to_date('19-02-2021', 'dd-mm-yyyy'), to_date('24-05-2021', 'dd-mm-yyyy'), 2118, 149, 837, 2371, 512, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1036, to_date('31-05-2021', 'dd-mm-yyyy'), to_date('29-10-2020', 'dd-mm-yyyy'), 2119, 102, 845, 2242, 436, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1015, to_date('22-02-2023', 'dd-mm-yyyy'), to_date('08-08-2021', 'dd-mm-yyyy'), 2120, 331, 850, 2074, 438, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1131, to_date('29-04-2021', 'dd-mm-yyyy'), to_date('16-04-2022', 'dd-mm-yyyy'), 2124, 6, 844, 2330, 493, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1904, to_date('30-09-2022', 'dd-mm-yyyy'), to_date('07-08-2023', 'dd-mm-yyyy'), 2125, 250, 839, 2151, 457, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1227, to_date('23-10-2023', 'dd-mm-yyyy'), to_date('02-09-2020', 'dd-mm-yyyy'), 2126, 341, 806, 2138, 495, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1479, to_date('03-03-2022', 'dd-mm-yyyy'), to_date('13-11-2021', 'dd-mm-yyyy'), 2127, 147, 838, 2029, 457, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1580, to_date('13-07-2022', 'dd-mm-yyyy'), to_date('04-07-2021', 'dd-mm-yyyy'), 2128, 223, 827, 2271, 682, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1799, to_date('31-08-2020', 'dd-mm-yyyy'), to_date('27-11-2023', 'dd-mm-yyyy'), 2129, 248, 848, 2002, 518, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1271, to_date('20-09-2022', 'dd-mm-yyyy'), to_date('01-08-2022', 'dd-mm-yyyy'), 2130, 367, 815, 2296, 692, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1297, to_date('11-05-2021', 'dd-mm-yyyy'), to_date('22-07-2022', 'dd-mm-yyyy'), 2131, 167, 814, 2329, 679, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1986, to_date('07-10-2023', 'dd-mm-yyyy'), to_date('26-11-2023', 'dd-mm-yyyy'), 2132, 39, 805, 2078, 699, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1668, to_date('09-09-2023', 'dd-mm-yyyy'), to_date('26-01-2021', 'dd-mm-yyyy'), 2133, 11, 823, 2145, 505, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1097, to_date('03-10-2020', 'dd-mm-yyyy'), to_date('26-12-2022', 'dd-mm-yyyy'), 2135, 111, 817, 2316, 735, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1365, to_date('20-10-2023', 'dd-mm-yyyy'), to_date('05-06-2020', 'dd-mm-yyyy'), 2136, 348, 808, 2324, 597, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1440, to_date('15-04-2020', 'dd-mm-yyyy'), to_date('10-02-2020', 'dd-mm-yyyy'), 2137, 248, 814, 2185, 654, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1093, to_date('31-10-2020', 'dd-mm-yyyy'), to_date('29-05-2023', 'dd-mm-yyyy'), 2139, 360, 815, 2238, 452, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1033, to_date('22-06-2023', 'dd-mm-yyyy'), to_date('07-01-2021', 'dd-mm-yyyy'), 2140, 322, 842, 2086, 522, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1467, to_date('14-10-2021', 'dd-mm-yyyy'), to_date('22-11-2023', 'dd-mm-yyyy'), 2141, 46, 825, 2239, 504, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1072, to_date('07-11-2021', 'dd-mm-yyyy'), to_date('01-09-2023', 'dd-mm-yyyy'), 2142, 201, 823, 2325, 443, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1114, to_date('28-10-2020', 'dd-mm-yyyy'), to_date('24-03-2022', 'dd-mm-yyyy'), 2143, 126, 813, 2398, 513, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1527, to_date('11-06-2022', 'dd-mm-yyyy'), to_date('23-09-2021', 'dd-mm-yyyy'), 2144, 151, 842, 2392, 620, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1852, to_date('07-10-2020', 'dd-mm-yyyy'), to_date('03-06-2022', 'dd-mm-yyyy'), 2146, 187, 819, 2258, 679, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1841, to_date('27-08-2022', 'dd-mm-yyyy'), to_date('21-09-2023', 'dd-mm-yyyy'), 2147, 183, 826, 2268, 499, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1334, to_date('22-07-2020', 'dd-mm-yyyy'), to_date('18-11-2023', 'dd-mm-yyyy'), 2149, 197, 802, 2129, 445, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1910, to_date('07-10-2022', 'dd-mm-yyyy'), to_date('19-01-2021', 'dd-mm-yyyy'), 2150, 74, 812, 2003, 770, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1343, to_date('08-09-2022', 'dd-mm-yyyy'), to_date('21-09-2023', 'dd-mm-yyyy'), 2152, 163, 828, 2280, 514, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1588, to_date('04-07-2021', 'dd-mm-yyyy'), to_date('29-06-2021', 'dd-mm-yyyy'), 2153, 160, 807, 2039, 531, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1003, to_date('04-02-2021', 'dd-mm-yyyy'), to_date('28-01-2020', 'dd-mm-yyyy'), 2155, 110, 824, 2055, 504, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1091, to_date('13-07-2022', 'dd-mm-yyyy'), to_date('06-05-2022', 'dd-mm-yyyy'), 2156, 257, 807, 2164, 530, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1647, to_date('29-08-2023', 'dd-mm-yyyy'), to_date('15-11-2023', 'dd-mm-yyyy'), 2157, 142, 806, 2226, 519, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1724, to_date('21-12-2020', 'dd-mm-yyyy'), to_date('21-11-2021', 'dd-mm-yyyy'), 2158, 293, 841, 2355, 746, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1145, to_date('04-05-2022', 'dd-mm-yyyy'), to_date('12-11-2021', 'dd-mm-yyyy'), 2161, 375, 818, 2395, 565, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1134, to_date('17-07-2023', 'dd-mm-yyyy'), to_date('20-10-2022', 'dd-mm-yyyy'), 2163, 35, 844, 2195, 589, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1664, to_date('30-11-2020', 'dd-mm-yyyy'), to_date('16-07-2020', 'dd-mm-yyyy'), 2164, 310, 823, 2313, 669, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1836, to_date('10-10-2023', 'dd-mm-yyyy'), to_date('20-12-2023', 'dd-mm-yyyy'), 2167, 280, 830, 2046, 483, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1637, to_date('05-08-2023', 'dd-mm-yyyy'), to_date('04-10-2020', 'dd-mm-yyyy'), 2168, 362, 803, 2248, 642, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1581, to_date('17-08-2020', 'dd-mm-yyyy'), to_date('01-05-2022', 'dd-mm-yyyy'), 2169, 76, 834, 2315, 556, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1983, to_date('05-09-2020', 'dd-mm-yyyy'), to_date('06-05-2022', 'dd-mm-yyyy'), 2170, 112, 811, 2387, 670, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1312, to_date('16-09-2021', 'dd-mm-yyyy'), to_date('08-08-2021', 'dd-mm-yyyy'), 2172, 327, 801, 2063, 650, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1302, to_date('15-06-2023', 'dd-mm-yyyy'), to_date('20-05-2023', 'dd-mm-yyyy'), 2175, 335, 836, 2019, 415, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1688, to_date('10-04-2020', 'dd-mm-yyyy'), to_date('24-06-2022', 'dd-mm-yyyy'), 2176, 379, 840, 2059, 667, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1081, to_date('09-05-2020', 'dd-mm-yyyy'), to_date('06-12-2023', 'dd-mm-yyyy'), 2177, 326, 839, 2075, 675, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1486, to_date('05-06-2021', 'dd-mm-yyyy'), to_date('20-05-2020', 'dd-mm-yyyy'), 2184, 139, 844, 2311, 736, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1995, to_date('17-12-2021', 'dd-mm-yyyy'), to_date('30-03-2020', 'dd-mm-yyyy'), 2185, 32, 841, 2350, 526, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1922, to_date('28-05-2023', 'dd-mm-yyyy'), to_date('29-08-2023', 'dd-mm-yyyy'), 2186, 160, 827, 2290, 410, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1636, to_date('30-05-2020', 'dd-mm-yyyy'), to_date('08-02-2023', 'dd-mm-yyyy'), 2187, 230, 842, 2029, 648, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1648, to_date('19-02-2023', 'dd-mm-yyyy'), to_date('02-10-2020', 'dd-mm-yyyy'), 2188, 371, 808, 2147, 523, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1919, to_date('03-06-2020', 'dd-mm-yyyy'), to_date('26-09-2021', 'dd-mm-yyyy'), 2189, 5, 837, 2236, 589, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1431, to_date('17-06-2020', 'dd-mm-yyyy'), to_date('23-05-2021', 'dd-mm-yyyy'), 2190, 310, 842, 2307, 558, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1152, to_date('28-04-2023', 'dd-mm-yyyy'), to_date('04-04-2021', 'dd-mm-yyyy'), 2192, 130, 818, 2006, 643, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1764, to_date('27-01-2022', 'dd-mm-yyyy'), to_date('18-03-2023', 'dd-mm-yyyy'), 2196, 197, 818, 2072, 530, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1250, to_date('01-11-2022', 'dd-mm-yyyy'), to_date('06-08-2020', 'dd-mm-yyyy'), 2198, 307, 839, 2167, 567, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1584, to_date('29-05-2022', 'dd-mm-yyyy'), to_date('07-03-2020', 'dd-mm-yyyy'), 2199, 232, 808, 2079, 702, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1754, to_date('17-06-2023', 'dd-mm-yyyy'), to_date('05-04-2021', 'dd-mm-yyyy'), 2200, 364, 827, 2060, 477, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1471, to_date('03-03-2023', 'dd-mm-yyyy'), to_date('03-08-2023', 'dd-mm-yyyy'), 2201, 233, 825, 2111, 578, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1343, to_date('12-09-2021', 'dd-mm-yyyy'), to_date('11-04-2021', 'dd-mm-yyyy'), 2202, 90, 811, 2334, 483, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1062, to_date('11-02-2021', 'dd-mm-yyyy'), to_date('24-08-2022', 'dd-mm-yyyy'), 2204, 269, 836, 2163, 721, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1437, to_date('21-06-2023', 'dd-mm-yyyy'), to_date('15-07-2022', 'dd-mm-yyyy'), 2205, 281, 828, 2006, 582, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1882, to_date('12-11-2023', 'dd-mm-yyyy'), to_date('14-06-2021', 'dd-mm-yyyy'), 2206, 236, 811, 2110, 431, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1747, to_date('09-05-2021', 'dd-mm-yyyy'), to_date('16-11-2021', 'dd-mm-yyyy'), 2208, 351, 832, 2223, 410, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1949, to_date('07-04-2022', 'dd-mm-yyyy'), to_date('12-02-2022', 'dd-mm-yyyy'), 2209, 296, 812, 2176, 455, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1604, to_date('24-01-2023', 'dd-mm-yyyy'), to_date('15-09-2021', 'dd-mm-yyyy'), 2210, 308, 811, 2235, 729, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1694, to_date('09-06-2020', 'dd-mm-yyyy'), to_date('26-07-2020', 'dd-mm-yyyy'), 2211, 317, 831, 2376, 408, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1582, to_date('13-07-2021', 'dd-mm-yyyy'), to_date('15-12-2023', 'dd-mm-yyyy'), 2212, 307, 829, 2399, 475, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1335, to_date('29-01-2020', 'dd-mm-yyyy'), to_date('08-03-2020', 'dd-mm-yyyy'), 2214, 209, 830, 2274, 531, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1271, to_date('23-07-2023', 'dd-mm-yyyy'), to_date('10-10-2022', 'dd-mm-yyyy'), 2215, 265, 836, 2148, 575, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1979, to_date('28-07-2022', 'dd-mm-yyyy'), to_date('11-02-2022', 'dd-mm-yyyy'), 2216, 370, 801, 2315, 495, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1533, to_date('02-07-2023', 'dd-mm-yyyy'), to_date('12-09-2020', 'dd-mm-yyyy'), 2217, 92, 834, 2217, 520, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1398, to_date('17-10-2023', 'dd-mm-yyyy'), to_date('27-11-2021', 'dd-mm-yyyy'), 2219, 356, 838, 2182, 775, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1588, to_date('20-05-2023', 'dd-mm-yyyy'), to_date('29-03-2021', 'dd-mm-yyyy'), 2220, 259, 822, 2171, 570, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1050, to_date('03-03-2022', 'dd-mm-yyyy'), to_date('12-05-2023', 'dd-mm-yyyy'), 2221, 361, 823, 2014, 673, null);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco, id_person)
values (1251, to_date('10-01-2022', 'dd-mm-yyyy'), to_date('11-12-2022', 'dd-mm-yyyy'), 2224, 120, 844, 2194, 508, null);
prompt 266 records loaded
prompt Loading PAYMENTS...
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('07-08-2008', 'dd-mm-yyyy'), 10, 'paid', 'cash', 1002, 773);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('09-12-2020', 'dd-mm-yyyy'), 2, 'Paid', 'CreditCard', 1003, 425);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('16-03-2017', 'dd-mm-yyyy'), 8, 'Paid', 'bank transfer', 1004, 720);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('06-06-2018', 'dd-mm-yyyy'), 9, 'not paid', 'cash', 1005, 654);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('16-10-2005', 'dd-mm-yyyy'), 7, 'not paid', 'CreditCard', 1007, 671);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('11-02-2012', 'dd-mm-yyyy'), 1, 'not paid', 'bank transfer', 1008, 468);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('06-07-2023', 'dd-mm-yyyy'), 5, 'Paid', 'CreditCard', 1010, 745);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('22-03-2012', 'dd-mm-yyyy'), 9, 'not paid', 'CreditCard', 1011, 653);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('14-07-2012', 'dd-mm-yyyy'), 8, 'paid', 'cash', 1013, 446);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('04-01-2011', 'dd-mm-yyyy'), 9, 'Paid', 'CreditCard', 1014, 629);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('21-11-2014', 'dd-mm-yyyy'), 2, 'paid', 'bank transfer', 1015, 683);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('06-04-2009', 'dd-mm-yyyy'), 10, 'paid', 'CreditCard', 1016, 473);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('06-03-2008', 'dd-mm-yyyy'), 7, 'Paid', 'bank transfer', 1021, 535);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('19-09-2023', 'dd-mm-yyyy'), 2, 'not paid', 'CreditCard', 1022, 624);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('06-05-2016', 'dd-mm-yyyy'), 2, 'not paid', 'bank transfer', 1025, 440);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('30-12-2022', 'dd-mm-yyyy'), 8, 'paid', 'bank transfer', 1026, 566);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('09-06-2012', 'dd-mm-yyyy'), 6, 'paid', 'bank transfer', 1027, 549);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('16-05-2008', 'dd-mm-yyyy'), 7, 'paid', 'bank transfer', 1031, 430);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('23-04-2006', 'dd-mm-yyyy'), 5, 'paid', 'CreditCard', 1032, 687);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('13-03-2015', 'dd-mm-yyyy'), 7, 'Paid', 'cash', 1034, 568);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('02-07-2023', 'dd-mm-yyyy'), 2, 'Paid', 'cash', 1035, 797);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('18-05-2005', 'dd-mm-yyyy'), 1, 'paid', 'CreditCard', 1037, 768);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('02-06-2007', 'dd-mm-yyyy'), 8, 'paid', 'CreditCard', 1038, 494);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('21-11-2005', 'dd-mm-yyyy'), 5, 'Paid', 'bank transfer', 1039, 434);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('14-08-2008', 'dd-mm-yyyy'), 3, 'Paid', 'CreditCard', 1041, 530);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('08-09-2015', 'dd-mm-yyyy'), 3, 'Paid', 'bank transfer', 1042, 648);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('15-06-2016', 'dd-mm-yyyy'), 2, 'paid', 'cash', 1043, 538);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('19-03-2011', 'dd-mm-yyyy'), 10, 'Paid', 'bank transfer', 1044, 686);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('29-03-2018', 'dd-mm-yyyy'), 9, 'Paid', 'bank transfer', 1047, 477);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('27-04-2014', 'dd-mm-yyyy'), 2, 'paid', 'CreditCard', 1050, 703);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('13-10-2007', 'dd-mm-yyyy'), 3, 'not paid', 'CreditCard', 1051, 780);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('24-11-2022', 'dd-mm-yyyy'), 7, 'Paid', 'cash', 1052, 675);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('25-09-2014', 'dd-mm-yyyy'), 6, 'not paid', 'CreditCard', 1053, 545);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('06-12-2016', 'dd-mm-yyyy'), 6, 'paid', 'bank transfer', 1055, 429);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('29-07-2019', 'dd-mm-yyyy'), 4, 'paid', 'cash', 1056, 753);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('12-03-2014', 'dd-mm-yyyy'), 8, 'paid', 'cash', 1057, 424);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('22-07-2012', 'dd-mm-yyyy'), 5, 'paid', 'cash', 1058, 500);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('22-08-2018', 'dd-mm-yyyy'), 5, 'paid', 'bank transfer', 1059, 435);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('11-08-2006', 'dd-mm-yyyy'), 6, 'Paid', 'bank transfer', 1060, 586);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('30-08-2011', 'dd-mm-yyyy'), 3, 'paid', 'cash', 1061, 678);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('31-01-2023', 'dd-mm-yyyy'), 6, 'paid', 'bank transfer', 1062, 498);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('29-01-2015', 'dd-mm-yyyy'), 10, 'paid', 'cash', 1063, 538);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('18-04-2020', 'dd-mm-yyyy'), 1, 'paid', 'cash', 1065, 411);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('27-02-2007', 'dd-mm-yyyy'), 2, 'Paid', 'CreditCard', 1066, 468);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('01-09-2008', 'dd-mm-yyyy'), 5, 'paid', 'cash', 1070, 625);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('25-09-2004', 'dd-mm-yyyy'), 2, 'Paid', 'cash', 1071, 537);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('28-06-2007', 'dd-mm-yyyy'), 3, 'not paid', 'CreditCard', 1072, 709);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('23-03-2005', 'dd-mm-yyyy'), 5, 'not paid', 'bank transfer', 1073, 795);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('26-02-2020', 'dd-mm-yyyy'), 4, 'Paid', 'bank transfer', 1074, 609);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('21-05-2018', 'dd-mm-yyyy'), 7, 'not paid', 'cash', 1075, 797);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('26-09-2020', 'dd-mm-yyyy'), 7, 'paid', 'cash', 1080, 706);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('27-12-2023', 'dd-mm-yyyy'), 10, 'paid', 'CreditCard', 1081, 687);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('24-01-2015', 'dd-mm-yyyy'), 4, 'paid', 'bank transfer', 1082, 732);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('30-05-2019', 'dd-mm-yyyy'), 6, 'Paid', 'cash', 1083, 468);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('18-06-2015', 'dd-mm-yyyy'), 10, 'paid', 'bank transfer', 1084, 718);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('13-01-2019', 'dd-mm-yyyy'), 2, 'not paid', 'cash', 1089, 612);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('07-11-2013', 'dd-mm-yyyy'), 7, 'paid', 'cash', 1091, 800);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('27-02-2009', 'dd-mm-yyyy'), 8, 'not paid', 'CreditCard', 1092, 723);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('22-10-2004', 'dd-mm-yyyy'), 10, 'paid', 'CreditCard', 1093, 790);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('27-03-2006', 'dd-mm-yyyy'), 1, 'paid', 'CreditCard', 1094, 773);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('10-11-2012', 'dd-mm-yyyy'), 2, 'not paid', 'cash', 1097, 617);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('03-02-2013', 'dd-mm-yyyy'), 5, 'not paid', 'CreditCard', 1098, 709);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('06-07-2021', 'dd-mm-yyyy'), 2, 'not paid', 'CreditCard', 1099, 594);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('14-11-2006', 'dd-mm-yyyy'), 9, 'paid', 'CreditCard', 1100, 429);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('12-02-2005', 'dd-mm-yyyy'), 2, 'Paid', 'bank transfer', 1101, 536);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('30-11-2012', 'dd-mm-yyyy'), 5, 'not paid', 'bank transfer', 1102, 700);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('06-12-2015', 'dd-mm-yyyy'), 6, 'paid', 'cash', 1103, 794);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('03-04-2017', 'dd-mm-yyyy'), 2, 'paid', 'bank transfer', 1104, 631);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('17-11-2021', 'dd-mm-yyyy'), 2, 'Paid', 'CreditCard', 1105, 417);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('17-01-2004', 'dd-mm-yyyy'), 4, 'paid', 'bank transfer', 1106, 706);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('19-09-2015', 'dd-mm-yyyy'), 4, 'Paid', 'CreditCard', 1107, 513);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('25-10-2009', 'dd-mm-yyyy'), 3, 'paid', 'cash', 1108, 726);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('15-02-2010', 'dd-mm-yyyy'), 6, 'Paid', 'CreditCard', 1109, 578);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('28-10-2019', 'dd-mm-yyyy'), 8, 'Paid', 'cash', 1112, 567);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('16-07-2011', 'dd-mm-yyyy'), 2, 'Paid', 'bank transfer', 1113, 756);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('27-09-2008', 'dd-mm-yyyy'), 5, 'paid', 'bank transfer', 1114, 726);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('23-06-2007', 'dd-mm-yyyy'), 4, 'not paid', 'cash', 1115, 526);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('03-03-2006', 'dd-mm-yyyy'), 10, 'paid', 'bank transfer', 1117, 626);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('28-08-2008', 'dd-mm-yyyy'), 3, 'Paid', 'bank transfer', 1118, 599);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('05-03-2022', 'dd-mm-yyyy'), 2, 'Paid', 'bank transfer', 1119, 562);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('08-09-2012', 'dd-mm-yyyy'), 10, 'paid', 'CreditCard', 1121, 800);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('04-01-2020', 'dd-mm-yyyy'), 5, 'paid', 'cash', 1122, 748);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('05-12-2020', 'dd-mm-yyyy'), 4, 'paid', 'cash', 1123, 778);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('15-09-2013', 'dd-mm-yyyy'), 2, 'Paid', 'CreditCard', 1124, 487);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('22-02-2011', 'dd-mm-yyyy'), 6, 'not paid', 'bank transfer', 1125, 516);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('13-03-2019', 'dd-mm-yyyy'), 9, 'paid', 'bank transfer', 1129, 747);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('06-09-2020', 'dd-mm-yyyy'), 3, 'paid', 'bank transfer', 1130, 607);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('12-01-2020', 'dd-mm-yyyy'), 7, 'not paid', 'cash', 1131, 689);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('13-01-2004', 'dd-mm-yyyy'), 5, 'paid', 'bank transfer', 1132, 793);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('24-09-2017', 'dd-mm-yyyy'), 7, 'paid', 'bank transfer', 1133, 733);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('22-05-2018', 'dd-mm-yyyy'), 8, 'paid', 'CreditCard', 1135, 626);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('25-10-2006', 'dd-mm-yyyy'), 1, 'paid', 'cash', 1137, 472);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('18-07-2023', 'dd-mm-yyyy'), 1, 'Paid', 'CreditCard', 1138, 704);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('02-09-2022', 'dd-mm-yyyy'), 8, 'paid', 'CreditCard', 1140, 687);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('29-11-2017', 'dd-mm-yyyy'), 2, 'not paid', 'CreditCard', 1141, 569);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('24-01-2011', 'dd-mm-yyyy'), 3, 'not paid', 'CreditCard', 1142, 693);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('09-05-2021', 'dd-mm-yyyy'), 4, 'Paid', 'bank transfer', 1143, 700);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('22-04-2013', 'dd-mm-yyyy'), 9, 'not paid', 'cash', 1145, 589);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('26-10-2008', 'dd-mm-yyyy'), 2, 'paid', 'cash', 1147, 494);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('29-08-2010', 'dd-mm-yyyy'), 9, 'not paid', 'bank transfer', 1148, 453);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('30-01-2008', 'dd-mm-yyyy'), 4, 'paid', 'cash', 1151, 596);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('10-12-2012', 'dd-mm-yyyy'), 4, 'paid', 'CreditCard', 1152, 638);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('17-10-2019', 'dd-mm-yyyy'), 10, 'paid', 'bank transfer', 1153, 741);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('12-04-2020', 'dd-mm-yyyy'), 2, 'paid', 'bank transfer', 1154, 788);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('18-01-2023', 'dd-mm-yyyy'), 6, 'paid', 'CreditCard', 1155, 611);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('01-05-2008', 'dd-mm-yyyy'), 6, 'not paid', 'bank transfer', 1156, 721);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('23-03-2023', 'dd-mm-yyyy'), 4, 'Paid', 'CreditCard', 1158, 707);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('23-10-2007', 'dd-mm-yyyy'), 8, 'Paid', 'cash', 1160, 408);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('28-08-2016', 'dd-mm-yyyy'), 3, 'paid', 'bank transfer', 1162, 561);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('13-02-2004', 'dd-mm-yyyy'), 4, 'not paid', 'bank transfer', 1163, 605);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('28-01-2011', 'dd-mm-yyyy'), 2, 'paid', 'bank transfer', 1169, 790);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('28-11-2023', 'dd-mm-yyyy'), 8, 'paid', 'cash', 1170, 444);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('12-09-2005', 'dd-mm-yyyy'), 4, 'paid', 'cash', 1173, 694);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('05-09-2020', 'dd-mm-yyyy'), 8, 'not paid', 'cash', 1174, 668);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('19-05-2013', 'dd-mm-yyyy'), 7, 'Paid', 'bank transfer', 1175, 708);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('02-07-2012', 'dd-mm-yyyy'), 8, 'paid', 'bank transfer', 1176, 683);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('13-10-2004', 'dd-mm-yyyy'), 2, 'not paid', 'cash', 1177, 479);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('30-03-2005', 'dd-mm-yyyy'), 3, 'paid', 'cash', 1180, 698);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('05-07-2020', 'dd-mm-yyyy'), 8, 'not paid', 'bank transfer', 1181, 745);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('08-12-2023', 'dd-mm-yyyy'), 10, 'not paid', 'cash', 1182, 526);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('14-07-2009', 'dd-mm-yyyy'), 2, 'not paid', 'bank transfer', 1184, 523);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('18-10-2007', 'dd-mm-yyyy'), 2, 'Paid', 'bank transfer', 1185, 545);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('10-09-2023', 'dd-mm-yyyy'), 6, 'paid', 'cash', 1187, 450);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('08-09-2017', 'dd-mm-yyyy'), 1, 'paid', 'bank transfer', 1188, 501);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('18-11-2014', 'dd-mm-yyyy'), 9, 'Paid', 'CreditCard', 1189, 728);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('15-03-2014', 'dd-mm-yyyy'), 1, 'paid', 'CreditCard', 1190, 661);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('25-10-2006', 'dd-mm-yyyy'), 7, 'paid', 'cash', 1194, 450);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('31-01-2021', 'dd-mm-yyyy'), 7, 'paid', 'bank transfer', 1195, 741);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('03-08-2006', 'dd-mm-yyyy'), 9, 'Paid', 'CreditCard', 1197, 728);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('16-05-2016', 'dd-mm-yyyy'), 1, 'not paid', 'bank transfer', 1198, 752);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('25-04-2019', 'dd-mm-yyyy'), 6, 'Paid', 'CreditCard', 1199, 721);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('31-07-2008', 'dd-mm-yyyy'), 7, 'Paid', 'bank transfer', 1200, 709);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('11-06-2019', 'dd-mm-yyyy'), 10, 'paid', 'bank transfer', 1202, 651);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('27-10-2021', 'dd-mm-yyyy'), 3, 'Paid', 'cash', 1203, 629);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('20-08-2013', 'dd-mm-yyyy'), 7, 'not paid', 'bank transfer', 1205, 553);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('24-04-2017', 'dd-mm-yyyy'), 5, 'not paid', 'bank transfer', 1206, 792);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('25-11-2023', 'dd-mm-yyyy'), 9, 'paid', 'bank transfer', 1208, 732);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('15-04-2010', 'dd-mm-yyyy'), 3, 'not paid', 'cash', 1211, 456);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('07-03-2020', 'dd-mm-yyyy'), 5, 'paid', 'bank transfer', 1214, 685);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('15-11-2015', 'dd-mm-yyyy'), 6, 'Paid', 'bank transfer', 1215, 445);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('07-06-2006', 'dd-mm-yyyy'), 8, 'Paid', 'CreditCard', 1216, 445);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('28-10-2007', 'dd-mm-yyyy'), 8, 'paid', 'CreditCard', 1218, 416);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('27-08-2006', 'dd-mm-yyyy'), 8, 'paid', 'CreditCard', 1219, 747);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('22-12-2022', 'dd-mm-yyyy'), 9, 'paid', 'CreditCard', 1220, 732);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('28-07-2022', 'dd-mm-yyyy'), 10, 'paid', 'CreditCard', 1221, 616);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('13-01-2005', 'dd-mm-yyyy'), 6, 'not paid', 'CreditCard', 1222, 770);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('15-06-2021', 'dd-mm-yyyy'), 4, 'paid', 'cash', 1223, 458);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('17-04-2015', 'dd-mm-yyyy'), 2, 'paid', 'cash', 1224, 444);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('16-10-2005', 'dd-mm-yyyy'), 8, 'paid', 'bank transfer', 1225, 631);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('09-01-2016', 'dd-mm-yyyy'), 7, 'Paid', 'CreditCard', 1226, 434);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('23-07-2008', 'dd-mm-yyyy'), 3, 'paid', 'CreditCard', 1227, 405);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('11-07-2009', 'dd-mm-yyyy'), 2, 'Paid', 'bank transfer', 1229, 605);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('31-08-2015', 'dd-mm-yyyy'), 7, 'paid', 'cash', 1230, 472);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('03-03-2022', 'dd-mm-yyyy'), 10, 'paid', 'CreditCard', 1231, 655);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('08-03-2018', 'dd-mm-yyyy'), 7, 'not paid', 'bank transfer', 1232, 524);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('19-10-2015', 'dd-mm-yyyy'), 1, 'paid', 'cash', 1233, 521);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('13-07-2013', 'dd-mm-yyyy'), 2, 'not paid', 'CreditCard', 1234, 532);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('11-01-2004', 'dd-mm-yyyy'), 10, 'not paid', 'cash', 1235, 728);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('02-07-2021', 'dd-mm-yyyy'), 6, 'not paid', 'bank transfer', 1236, 536);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('03-09-2019', 'dd-mm-yyyy'), 10, 'not paid', 'bank transfer', 1237, 403);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('28-08-2012', 'dd-mm-yyyy'), 10, 'Paid', 'CreditCard', 1238, 675);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('29-08-2008', 'dd-mm-yyyy'), 4, 'Paid', 'cash', 1239, 570);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('01-12-2022', 'dd-mm-yyyy'), 9, 'not paid', 'CreditCard', 1241, 795);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('12-10-2022', 'dd-mm-yyyy'), 8, 'Paid', 'bank transfer', 1242, 508);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('29-08-2015', 'dd-mm-yyyy'), 6, 'paid', 'CreditCard', 1243, 462);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('21-06-2017', 'dd-mm-yyyy'), 6, 'paid', 'cash', 1244, 557);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('11-04-2013', 'dd-mm-yyyy'), 8, 'Paid', 'CreditCard', 1245, 593);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('05-10-2012', 'dd-mm-yyyy'), 5, 'paid', 'cash', 1246, 621);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('16-06-2017', 'dd-mm-yyyy'), 4, 'Paid', 'bank transfer', 1247, 537);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('12-07-2006', 'dd-mm-yyyy'), 7, 'not paid', 'cash', 1248, 707);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('06-11-2011', 'dd-mm-yyyy'), 7, 'paid', 'CreditCard', 1250, 618);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('18-01-2016', 'dd-mm-yyyy'), 5, 'paid', 'bank transfer', 1251, 665);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('20-12-2021', 'dd-mm-yyyy'), 2, 'Paid', 'bank transfer', 1252, 553);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('16-06-2014', 'dd-mm-yyyy'), 3, 'Paid', 'cash', 1254, 536);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('10-01-2007', 'dd-mm-yyyy'), 10, 'Paid', 'CreditCard', 1255, 777);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('25-03-2017', 'dd-mm-yyyy'), 10, 'paid', 'bank transfer', 1256, 641);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('23-06-2014', 'dd-mm-yyyy'), 5, 'not paid', 'cash', 1259, 608);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('22-02-2012', 'dd-mm-yyyy'), 5, 'not paid', 'cash', 1260, 671);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('15-04-2022', 'dd-mm-yyyy'), 3, 'Paid', 'bank transfer', 1261, 415);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('16-10-2009', 'dd-mm-yyyy'), 9, 'not paid', 'bank transfer', 1262, 777);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('24-01-2005', 'dd-mm-yyyy'), 9, 'not paid', 'cash', 1263, 704);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('05-07-2010', 'dd-mm-yyyy'), 9, 'Paid', 'bank transfer', 1264, 704);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('11-08-2018', 'dd-mm-yyyy'), 6, 'paid', 'bank transfer', 1266, 573);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('01-11-2014', 'dd-mm-yyyy'), 9, 'paid', 'CreditCard', 1267, 694);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('02-08-2019', 'dd-mm-yyyy'), 6, 'paid', 'bank transfer', 1269, 757);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('22-06-2022', 'dd-mm-yyyy'), 3, 'Paid', 'cash', 1270, 707);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('18-01-2018', 'dd-mm-yyyy'), 1, 'paid', 'cash', 1272, 488);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('16-08-2004', 'dd-mm-yyyy'), 8, 'paid', 'bank transfer', 1273, 592);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('06-06-2015', 'dd-mm-yyyy'), 4, 'Paid', 'CreditCard', 1274, 708);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('21-10-2004', 'dd-mm-yyyy'), 10, 'paid', 'CreditCard', 1275, 404);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('08-06-2006', 'dd-mm-yyyy'), 2, 'not paid', 'cash', 1276, 513);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('09-05-2014', 'dd-mm-yyyy'), 5, 'Paid', 'cash', 1277, 440);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('14-03-2012', 'dd-mm-yyyy'), 6, 'Paid', 'CreditCard', 1278, 495);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('28-02-2006', 'dd-mm-yyyy'), 6, 'Paid', 'CreditCard', 1279, 669);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('08-04-2014', 'dd-mm-yyyy'), 9, 'paid', 'bank transfer', 1280, 742);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('24-12-2008', 'dd-mm-yyyy'), 6, 'not paid', 'CreditCard', 1282, 553);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('15-04-2016', 'dd-mm-yyyy'), 3, 'not paid', 'cash', 1283, 470);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('01-12-2018', 'dd-mm-yyyy'), 1, 'Paid', 'cash', 1285, 578);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('22-01-2014', 'dd-mm-yyyy'), 3, 'Paid', 'bank transfer', 1287, 431);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('08-01-2019', 'dd-mm-yyyy'), 3, 'paid', 'CreditCard', 1289, 418);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('28-04-2006', 'dd-mm-yyyy'), 4, 'Paid', 'cash', 1290, 738);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('31-01-2017', 'dd-mm-yyyy'), 4, 'Paid', 'bank transfer', 1291, 470);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('01-10-2007', 'dd-mm-yyyy'), 5, 'not paid', 'bank transfer', 1293, 738);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('26-06-2013', 'dd-mm-yyyy'), 10, 'not paid', 'bank transfer', 1295, 720);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('01-12-2013', 'dd-mm-yyyy'), 4, 'paid', 'cash', 1300, 404);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('14-12-2006', 'dd-mm-yyyy'), 2, 'not paid', 'cash', 1301, 784);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('01-08-2006', 'dd-mm-yyyy'), 2, 'paid', 'cash', 1302, 461);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('27-08-2021', 'dd-mm-yyyy'), 8, 'paid', 'cash', 1303, 422);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('25-12-2007', 'dd-mm-yyyy'), 8, 'paid', 'CreditCard', 1304, 776);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('25-02-2006', 'dd-mm-yyyy'), 3, 'paid', 'bank transfer', 1305, 790);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('04-03-2020', 'dd-mm-yyyy'), 1, 'paid', 'CreditCard', 1306, 435);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('20-02-2006', 'dd-mm-yyyy'), 1, 'paid', 'cash', 1307, 754);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('10-02-2005', 'dd-mm-yyyy'), 4, 'paid', 'CreditCard', 1311, 595);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('02-09-2015', 'dd-mm-yyyy'), 8, 'paid', 'cash', 1312, 716);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('20-03-2016', 'dd-mm-yyyy'), 6, 'paid', 'CreditCard', 1313, 636);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('04-04-2010', 'dd-mm-yyyy'), 3, 'Paid', 'CreditCard', 1314, 731);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('21-12-2014', 'dd-mm-yyyy'), 6, 'Paid', 'cash', 1316, 667);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('24-09-2004', 'dd-mm-yyyy'), 2, 'Paid', 'cash', 1317, 792);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('09-04-2004', 'dd-mm-yyyy'), 2, 'not paid', 'bank transfer', 1318, 545);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('07-10-2005', 'dd-mm-yyyy'), 4, 'paid', 'cash', 1319, 549);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('17-06-2010', 'dd-mm-yyyy'), 6, 'paid', 'cash', 1320, 753);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('21-04-2012', 'dd-mm-yyyy'), 6, 'paid', 'CreditCard', 1321, 616);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('15-06-2012', 'dd-mm-yyyy'), 2, 'not paid', 'cash', 1322, 784);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('11-12-2004', 'dd-mm-yyyy'), 3, 'not paid', 'bank transfer', 1323, 415);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('27-02-2016', 'dd-mm-yyyy'), 4, 'Paid', 'CreditCard', 1324, 617);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('08-08-2016', 'dd-mm-yyyy'), 7, 'paid', 'CreditCard', 1325, 611);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('30-10-2005', 'dd-mm-yyyy'), 8, 'not paid', 'cash', 1328, 487);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('03-08-2005', 'dd-mm-yyyy'), 10, 'not paid', 'cash', 1329, 553);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('23-10-2016', 'dd-mm-yyyy'), 1, 'paid', 'bank transfer', 1330, 690);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('15-11-2020', 'dd-mm-yyyy'), 8, 'paid', 'cash', 1331, 610);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('05-12-2008', 'dd-mm-yyyy'), 3, 'Paid', 'bank transfer', 1332, 523);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('14-11-2008', 'dd-mm-yyyy'), 5, 'paid', 'bank transfer', 1334, 690);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('02-04-2018', 'dd-mm-yyyy'), 5, 'Paid', 'bank transfer', 1335, 792);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('20-07-2010', 'dd-mm-yyyy'), 2, 'Paid', 'CreditCard', 1336, 612);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('22-01-2007', 'dd-mm-yyyy'), 8, 'Paid', 'bank transfer', 1337, 465);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('05-08-2013', 'dd-mm-yyyy'), 7, 'Paid', 'bank transfer', 1338, 734);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('17-05-2018', 'dd-mm-yyyy'), 9, 'paid', 'cash', 1339, 491);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('07-08-2017', 'dd-mm-yyyy'), 3, 'paid', 'cash', 1340, 763);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('23-10-2004', 'dd-mm-yyyy'), 10, 'not paid', 'cash', 1341, 721);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('25-01-2004', 'dd-mm-yyyy'), 5, 'paid', 'CreditCard', 1342, 409);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('22-04-2018', 'dd-mm-yyyy'), 2, 'Paid', 'bank transfer', 1344, 723);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('08-10-2015', 'dd-mm-yyyy'), 5, 'not paid', 'CreditCard', 1346, 543);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('28-07-2008', 'dd-mm-yyyy'), 3, 'Paid', 'cash', 1347, 745);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('03-05-2007', 'dd-mm-yyyy'), 10, 'Paid', 'CreditCard', 1348, 791);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('09-10-2016', 'dd-mm-yyyy'), 1, 'paid', 'CreditCard', 1349, 614);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('09-06-2022', 'dd-mm-yyyy'), 5, 'not paid', 'bank transfer', 1350, 495);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('03-09-2020', 'dd-mm-yyyy'), 2, 'Paid', 'CreditCard', 1351, 469);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('13-09-2007', 'dd-mm-yyyy'), 6, 'not paid', 'CreditCard', 1354, 779);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('08-12-2016', 'dd-mm-yyyy'), 4, 'paid', 'CreditCard', 1355, 576);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('04-05-2015', 'dd-mm-yyyy'), 4, 'Paid', 'cash', 1359, 484);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('14-03-2016', 'dd-mm-yyyy'), 6, 'Paid', 'CreditCard', 1363, 520);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('08-06-2007', 'dd-mm-yyyy'), 10, 'paid', 'cash', 1365, 618);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('13-04-2017', 'dd-mm-yyyy'), 10, 'not paid', 'bank transfer', 1366, 529);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('31-03-2008', 'dd-mm-yyyy'), 1, 'paid', 'CreditCard', 1368, 616);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('17-09-2019', 'dd-mm-yyyy'), 7, 'paid', 'bank transfer', 1369, 450);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('17-07-2010', 'dd-mm-yyyy'), 1, 'paid', 'cash', 1371, 698);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('30-06-2010', 'dd-mm-yyyy'), 3, 'Paid', 'cash', 1372, 784);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('15-03-2021', 'dd-mm-yyyy'), 3, 'paid', 'cash', 1373, 742);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('27-04-2011', 'dd-mm-yyyy'), 2, 'Paid', 'CreditCard', 1376, 792);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('18-03-2006', 'dd-mm-yyyy'), 9, 'not paid', 'cash', 1377, 679);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('08-01-2011', 'dd-mm-yyyy'), 8, 'not paid', 'bank transfer', 1379, 480);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('10-02-2010', 'dd-mm-yyyy'), 7, 'not paid', 'cash', 1380, 567);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('24-02-2008', 'dd-mm-yyyy'), 5, 'not paid', 'cash', 1381, 553);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('22-09-2014', 'dd-mm-yyyy'), 4, 'not paid', 'CreditCard', 1382, 714);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('11-08-2012', 'dd-mm-yyyy'), 7, 'paid', 'CreditCard', 1383, 533);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('11-01-2007', 'dd-mm-yyyy'), 2, 'paid', 'bank transfer', 1385, 695);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('22-02-2020', 'dd-mm-yyyy'), 1, 'paid', 'CreditCard', 1393, 607);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('20-10-2014', 'dd-mm-yyyy'), 5, 'not paid', 'CreditCard', 1394, 524);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('24-04-2020', 'dd-mm-yyyy'), 2, 'paid', 'bank transfer', 1395, 616);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('03-04-2010', 'dd-mm-yyyy'), 10, 'not paid', 'cash', 1396, 560);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('11-10-2016', 'dd-mm-yyyy'), 9, 'Paid', 'bank transfer', 1397, 443);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('31-10-2023', 'dd-mm-yyyy'), 7, 'paid', 'CreditCard', 1398, 694);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('17-07-2017', 'dd-mm-yyyy'), 4, 'Paid', 'CreditCard', 1399, 721);
prompt 273 records loaded
prompt Loading TRAVELERS...
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Maceo', 2010, 1, 1);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Chaka', 2004, 2, 2);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Rip', 2019, 3, 3);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Wayman', 2003, 4, 4);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Lili', 2005, 5, 5);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Katrin', 2022, 6, 6);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Jackie', 2013, 7, 7);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Thin', 2011, 8, 8);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Louise', 2017, 9, 9);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Jean-Claude', 2013, 10, 10);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Uma', 2012, 11, 11);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Lila', 2019, 12, 12);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Alfred', 2016, 13, 13);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Kiefer', 2010, 14, 14);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Chazz', 2010, 15, 15);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Kurt', 2011, 16, 16);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Alfie', 2015, 17, 17);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Marina', 2010, 18, 18);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Robbie', 2007, 19, 19);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Cornell', 2020, 20, 20);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Rawlins', 2005, 21, 21);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Isaiah', 2001, 22, 22);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Chris', 2002, 23, 23);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Curtis', 2006, 24, 24);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Lara', 2001, 25, 25);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Hazel', 2020, 26, 26);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Brent', 2018, 27, 27);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Frederic', 2013, 28, 28);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Judge', 2005, 29, 29);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Albert', 2001, 30, 30);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Charlie', 2008, 31, 31);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Liam', 2012, 32, 32);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Gordie', 2012, 33, 33);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Hex', 2020, 34, 34);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('First', 2022, 35, 35);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Murray', 2012, 36, 36);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Veruca', 2017, 37, 37);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Adrien', 2002, 38, 38);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Merle', 2003, 39, 39);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Suzy', 2022, 40, 40);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Javon', 2007, 41, 41);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Will', 2020, 42, 42);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Robby', 2016, 43, 43);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Aidan', 2006, 44, 44);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Gino', 2014, 45, 45);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Linda', 2006, 46, 46);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Curtis', 2011, 47, 47);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Reese', 2000, 48, 48);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Meredith', 2011, 49, 49);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Suzi', 2002, 50, 50);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Bruce', 2006, 51, 51);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Mindy', 2012, 52, 52);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Gary', 2004, 53, 53);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Carlene', 2017, 54, 54);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Leelee', 2010, 55, 55);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Rod', 2000, 56, 56);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Albert', 2015, 57, 57);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Sheryl', 2000, 58, 58);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Yolanda', 2008, 59, 59);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Holly', 2022, 60, 60);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Ernest', 2012, 61, 61);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Ty', 2003, 62, 62);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Saffron', 2021, 63, 63);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Elias', 2018, 64, 64);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Selma', 2021, 65, 65);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Jack', 2019, 66, 66);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Pelvic', 2003, 67, 67);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Treat', 2006, 68, 68);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Kristin', 2004, 69, 69);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Todd', 2003, 70, 70);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Ralph', 2018, 71, 71);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Rosanna', 2002, 72, 72);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Aaron', 2022, 73, 73);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Joaquim', 2019, 74, 74);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Ewan', 2003, 75, 75);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Roberta', 2018, 76, 76);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Jeroen', 2002, 77, 77);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Debby', 2012, 78, 78);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Robbie', 2016, 79, 79);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Curt', 2001, 80, 80);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Tori', 2018, 81, 81);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Anita', 2021, 82, 82);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Jena', 2003, 83, 83);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Stephen', 2021, 84, 84);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Naomi', 2015, 85, 85);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Tia', 2002, 86, 86);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Harrison', 2001, 87, 87);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Stephen', 2010, 88, 88);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Annie', 2021, 89, 89);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Alannah', 2000, 90, 90);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Alicia', 2002, 91, 91);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Chuck', 2014, 92, 92);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Hope', 2013, 93, 93);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Rik', 2018, 94, 94);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Andy', 2021, 95, 95);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Roddy', 2009, 96, 96);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Radney', 2022, 97, 97);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Nicolas', 2010, 98, 98);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Candice', 2005, 99, 99);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Jessica', 2016, 100, 100);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Glenn', 2019, 101, 101);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Tim', 2004, 102, 102);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Minnie', 2001, 103, 103);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Angelina', 2013, 104, 104);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Raul', 2022, 105, 105);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Matt', 2009, 106, 106);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Davey', 2018, 107, 107);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Vincent', 2008, 108, 108);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Colin', 2013, 109, 109);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('James', 2000, 110, 110);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Miranda', 2015, 111, 111);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Jeff', 2019, 112, 112);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Colin', 2022, 113, 113);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Chris', 2011, 114, 114);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Jack', 2000, 115, 115);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Cheryl', 2014, 116, 116);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Latin', 2003, 117, 117);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Bob', 2011, 118, 118);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Chaka', 2013, 119, 119);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Hilary', 2010, 120, 120);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Patty', 2007, 121, 121);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Debra', 2022, 122, 122);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Machine', 2004, 123, 123);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Eliza', 2016, 124, 124);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Forest', 2020, 125, 125);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Chad', 2019, 126, 126);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Azucar', 2001, 127, 127);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Jonatha', 2016, 128, 128);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Will', 2004, 129, 129);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('William', 2007, 130, 130);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Mika', 2011, 131, 131);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Carlos', 2012, 132, 132);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Parker', 2006, 133, 133);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Sophie', 2017, 134, 134);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Juliette', 2013, 135, 135);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Casey', 2008, 136, 136);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Jonathan', 2021, 137, 137);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Laurence', 2018, 138, 138);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Marlon', 2020, 139, 139);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Pablo', 2005, 140, 140);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Nicholas', 2015, 141, 141);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Gran', 2015, 142, 142);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Queen', 2003, 143, 143);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Hope', 2019, 144, 144);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Terry', 2016, 145, 145);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Maggie', 2010, 146, 146);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Stewart', 2005, 147, 147);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Andy', 2008, 148, 148);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Sam', 2006, 149, 149);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Burt', 2008, 150, 150);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Mary Beth', 2020, 151, 151);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Kyle', 2000, 152, 152);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Jeffery', 2013, 153, 153);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Clay', 2003, 154, 154);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Isabella', 2022, 155, 155);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Lin', 2011, 156, 156);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Rascal', 2005, 157, 157);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Ricky', 2009, 158, 158);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Kazem', 2003, 159, 159);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Ramsey', 2009, 160, 160);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Mykelti', 2009, 161, 161);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Don', 2010, 162, 162);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Sara', 2006, 163, 163);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Chi', 2016, 164, 164);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Dionne', 2008, 165, 165);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Terry', 2010, 166, 166);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Melanie', 2009, 167, 167);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Trey', 2013, 168, 168);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Balthazar', 2017, 169, 169);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Katrin', 2009, 170, 170);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Robin', 2022, 171, 171);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Luis', 2020, 172, 172);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Hank', 2005, 173, 173);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Karen', 2016, 174, 174);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Elias', 2004, 175, 175);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Delroy', 2020, 176, 176);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Tim', 2021, 177, 177);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Wesley', 2022, 178, 178);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Wendy', 2007, 179, 179);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Gene', 2004, 180, 180);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Rascal', 2001, 181, 181);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Rade', 2014, 182, 182);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Sam', 2000, 183, 183);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Rhea', 2012, 184, 184);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Parker', 2017, 185, 185);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Rebecca', 2004, 186, 186);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Hal', 2001, 187, 187);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Cole', 2014, 188, 188);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Rik', 2013, 189, 189);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Sally', 2020, 190, 190);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Curtis', 2009, 191, 191);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Judi', 2006, 192, 192);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Earl', 2014, 193, 193);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Nikka', 2020, 194, 194);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Jeff', 2008, 195, 195);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Wayne', 2007, 196, 196);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Nick', 2003, 197, 197);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Jeffery', 2005, 198, 198);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Percy', 2016, 199, 199);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('LeVar', 2017, 200, 200);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Rebecca', 2012, 201, 201);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Anne', 2001, 202, 202);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Gena', 2017, 203, 203);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Faye', 2022, 204, 204);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Ronny', 2010, 205, 205);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Kitty', 2016, 206, 206);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Miko', 2001, 207, 207);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Gene', 2021, 208, 208);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Diamond', 2017, 209, 209);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Charlton', 2005, 210, 210);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Art', 2001, 211, 211);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Brooke', 2010, 212, 212);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Randy', 2015, 213, 213);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Arnold', 2005, 214, 214);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Azucar', 2008, 215, 215);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Seann', 2012, 216, 216);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Joy', 2022, 217, 217);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Curtis', 2020, 218, 218);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Michelle', 2007, 219, 219);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Joy', 2022, 220, 220);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Mel', 2006, 221, 221);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Luke', 2019, 222, 222);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Davy', 2006, 223, 223);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Merillee', 2013, 224, 224);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Heather', 2004, 225, 225);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Scott', 2001, 226, 226);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Hugh', 2014, 227, 227);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Emerson', 2018, 228, 228);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Christine', 2022, 229, 229);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Balthazar', 2006, 230, 230);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Nikka', 2022, 231, 231);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Betty', 2014, 233, 233);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Vendetta', 2014, 234, 234);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Sally', 2012, 236, 236);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Tia', 2016, 237, 237);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Mel', 2006, 239, 239);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Gwyneth', 2006, 240, 240);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Danni', 2017, 242, 242);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Oded', 2014, 243, 243);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Kitty', 2013, 245, 245);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Diane', 2013, 246, 246);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Nils', 2020, 248, 248);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Ramsey', 2018, 249, 249);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Natascha', 2020, 251, 251);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Bill', 2013, 252, 252);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Maureen', 2004, 254, 254);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Suzy', 2007, 255, 255);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Udo', 2014, 257, 257);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Ivan', 2015, 258, 258);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Wayne', 2019, 260, 260);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Natalie', 2000, 262, 262);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Miranda', 2020, 263, 263);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Rowan', 2021, 264, 264);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Emilio', 2008, 266, 266);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Roscoe', 2017, 267, 267);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Rory', 2014, 269, 269);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Frank', 2016, 270, 270);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Delbert', 2008, 272, 272);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Claude', 2007, 273, 273);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Ruth', 2005, 275, 275);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Lenny', 2011, 276, 276);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Saffron', 2003, 278, 278);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Rutger', 2004, 279, 279);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Tyrone', 2022, 281, 281);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Jann', 2022, 282, 282);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Sean', 2020, 284, 284);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Ali', 2019, 285, 285);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Roddy', 2011, 287, 287);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Michael', 2022, 288, 288);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Cate', 2016, 289, 289);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Miko', 2016, 291, 291);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Elisabeth', 2008, 292, 292);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Jet', 2002, 294, 294);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Amanda', 2010, 295, 295);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Lou', 2010, 297, 297);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Freda', 2016, 298, 298);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Mitchell', 2005, 300, 300);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Sophie', 2002, 301, 301);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Nicole', 2020, 302, 302);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Azucar', 2000, 304, 304);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Buddy', 2014, 305, 305);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Kid', 2010, 307, 307);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Giancarlo', 2008, 309, 309);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Madeline', 2017, 310, 310);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Stellan', 2000, 312, 312);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Marina', 2009, 313, 313);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Vonda', 2016, 315, 315);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Timothy', 2008, 316, 316);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Bret', 2016, 318, 318);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Rik', 2021, 319, 319);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Rita', 2014, 320, 320);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Tia', 2019, 322, 322);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Coley', 2015, 323, 323);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Alex', 2014, 325, 325);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Omar', 2012, 326, 326);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Mel', 2009, 328, 328);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Willem', 2002, 329, 329);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Kasey', 2020, 331, 331);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Ossie', 2006, 333, 333);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Eric', 2011, 334, 334);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Tara', 2003, 335, 335);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Willem', 2017, 337, 337);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Kelli', 2001, 338, 338);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Samuel', 2019, 340, 340);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Alicia', 2007, 341, 341);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Lee', 2011, 342, 342);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Harrison', 2016, 344, 344);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Marisa', 2009, 345, 345);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Freda', 2010, 347, 347);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Millie', 2000, 348, 348);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Tilda', 2020, 350, 350);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Toshiro', 2001, 351, 351);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Dave', 2007, 353, 353);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Luke', 2022, 354, 354);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Lydia', 2014, 356, 356);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Clarence', 2020, 357, 357);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Patricia', 2014, 359, 359);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Harry', 2015, 360, 360);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Terence', 2007, 362, 362);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Armin', 2017, 364, 364);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Domingo', 2012, 365, 365);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Adrien', 2004, 366, 366);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Kristin', 2005, 368, 368);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Brenda', 2003, 369, 369);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Emerson', 2006, 371, 371);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Mandy', 2003, 372, 372);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Toshiro', 2015, 374, 374);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Bridget', 2007, 375, 375);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Antonio', 2009, 377, 377);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Maggie', 2011, 379, 379);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Nastassja', 2018, 380, 380);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Holly', 2021, 381, 381);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Roy', 2008, 382, 382);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Leonardo', 2012, 383, 383);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('King', 2011, 384, 384);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Mos', 2016, 385, 385);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Brad', 2013, 386, 386);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Tzi', 2002, 387, 387);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Dionne', 2011, 388, 388);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Jackie', 2012, 389, 389);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Mary-Louise', 2005, 390, 390);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Cary', 2009, 391, 391);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Nickel', 2017, 392, 392);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Jennifer', 2018, 393, 393);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Gabrielle', 2018, 394, 394);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Powers', 2001, 395, 395);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Johnnie', 2000, 396, 396);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Lila', 2012, 397, 397);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Antonio', 2000, 398, 398);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Larry', 2018, 399, 399);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Nils', 2011, 400, 400);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Geena', 2013, 232, 232);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Will', 2006, 235, 235);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Hugo', 2008, 238, 238);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Chalee', 2015, 241, 241);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Miko', 2014, 244, 244);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Robbie', 2010, 247, 247);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Selma', 2008, 250, 250);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Rick', 2017, 253, 253);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('King', 2013, 256, 256);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Wang', 2005, 259, 259);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Vanessa', 2009, 261, 261);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Natasha', 2014, 265, 265);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Jon', 2019, 268, 268);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Chris', 2014, 271, 271);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Katrin', 2008, 274, 274);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Willem', 2011, 277, 277);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Lili', 2013, 280, 280);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Cheryl', 2003, 283, 283);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Raymond', 2000, 286, 286);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Gordon', 2012, 290, 290);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Maury', 2006, 293, 293);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Tamala', 2001, 296, 296);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Charlie', 2016, 299, 299);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Jean', 2003, 303, 303);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Mika', 2000, 306, 306);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Lynn', 2003, 308, 308);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Clea', 2015, 311, 311);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Robin', 2005, 314, 314);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Gabrielle', 2011, 317, 317);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Geoff', 2012, 321, 321);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Lonnie', 2011, 324, 324);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Jake', 2020, 327, 327);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Luke', 2008, 330, 330);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Daniel', 2013, 332, 332);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Emily', 2005, 336, 336);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Carrie-Anne', 2002, 339, 339);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Boyd', 2003, 343, 343);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Cole', 2001, 346, 346);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Tramaine', 2000, 349, 349);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Adam', 2015, 352, 352);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Kyle', 2001, 355, 355);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Cheryl', 2010, 358, 358);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Guy', 2000, 361, 361);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Natacha', 2005, 363, 363);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Ethan', 2002, 367, 367);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Cledus', 2022, 370, 370);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Owen', 2021, 373, 373);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Aida', 2010, 376, 376);
insert into TRAVELERS (name, year_of_birth, id_travels, id_person)
values ('Victor', 2010, 378, 378);
prompt 400 records loaded
prompt Loading TRAVELERS_LIST...
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (1, 2800, 1, 1, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (2, 1340, 2, 2, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (3, 3404, 3, 3, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (4, 3741, 4, 4, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (5, 2259, 5, 5, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (6, 3527, 6, 6, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (7, 2502, 7, 7, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (8, 1520, 8, 8, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (9, 3906, 9, 9, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (10, 1056, 10, 10, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (11, 2365, 11, 11, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (12, 3613, 12, 12, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (13, 3749, 13, 13, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (14, 1584, 14, 14, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (15, 1596, 15, 15, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (16, 1902, 16, 16, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (17, 2774, 17, 17, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (18, 1100, 18, 18, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (19, 3709, 19, 19, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (20, 2045, 20, 20, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (21, 1972, 21, 21, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (22, 2385, 22, 22, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (23, 1987, 23, 23, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (24, 1605, 24, 24, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (25, 3092, 25, 25, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (26, 2083, 26, 26, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (27, 2398, 27, 27, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (28, 2401, 28, 28, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (29, 3441, 29, 29, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (30, 2017, 30, 30, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (31, 2740, 31, 31, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (32, 2083, 32, 32, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (33, 3814, 33, 33, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (34, 2148, 34, 34, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (35, 2993, 35, 35, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (36, 3695, 36, 36, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (37, 1378, 37, 37, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (38, 2311, 38, 38, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (39, 2572, 39, 39, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (40, 1746, 40, 40, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (41, 3095, 41, 41, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (42, 1626, 42, 42, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (43, 3934, 43, 43, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (44, 3054, 44, 44, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (45, 2996, 45, 45, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (46, 3217, 46, 46, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (47, 3738, 47, 47, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (48, 3378, 48, 48, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (49, 2409, 49, 49, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (50, 2634, 50, 50, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (51, 1524, 51, 51, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (52, 3606, 52, 52, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (53, 2951, 53, 53, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (54, 2120, 54, 54, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (55, 2602, 55, 55, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (56, 3003, 56, 56, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (57, 1858, 57, 57, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (58, 3609, 58, 58, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (59, 1601, 59, 59, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (60, 3811, 60, 60, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (61, 2004, 61, 61, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (62, 3093, 62, 62, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (63, 2902, 63, 63, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (64, 2180, 64, 64, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (65, 1662, 65, 65, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (66, 3772, 66, 66, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (67, 2880, 67, 67, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (68, 1231, 68, 68, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (69, 1851, 69, 69, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (70, 3083, 70, 70, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (71, 3687, 71, 71, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (72, 1741, 72, 72, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (73, 3844, 73, 73, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (74, 2546, 74, 74, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (75, 3000, 75, 75, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (76, 1732, 76, 76, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (77, 3154, 77, 77, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (78, 3039, 78, 78, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (79, 3962, 79, 79, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (80, 3967, 80, 80, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (81, 2098, 81, 81, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (82, 2895, 82, 82, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (83, 3254, 83, 83, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (84, 1127, 84, 84, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (85, 3748, 85, 85, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (86, 1979, 86, 86, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (87, 3005, 87, 87, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (88, 2191, 88, 88, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (89, 1847, 89, 89, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (90, 3611, 90, 90, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (91, 3001, 91, 91, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (92, 2259, 92, 92, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (93, 3043, 93, 93, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (94, 3992, 94, 94, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (95, 2378, 95, 95, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (96, 2861, 96, 96, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (97, 1482, 97, 97, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (98, 1528, 98, 98, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (99, 1773, 99, 99, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (100, 1512, 100, 100, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (101, 3619, 101, 101, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (102, 2171, 102, 102, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (103, 3624, 103, 103, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (104, 2012, 104, 104, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (105, 3804, 105, 105, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (106, 3691, 106, 106, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (107, 3066, 107, 107, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (108, 1776, 108, 108, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (109, 3991, 109, 109, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (110, 2500, 110, 110, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (111, 1650, 111, 111, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (112, 3200, 112, 112, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (113, 3629, 113, 113, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (114, 1441, 114, 114, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (115, 1812, 115, 115, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (116, 3830, 116, 116, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (117, 3576, 117, 117, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (118, 3659, 118, 118, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (119, 3807, 119, 119, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (120, 1854, 120, 120, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (121, 2607, 121, 121, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (122, 2456, 122, 122, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (123, 3557, 123, 123, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (124, 3177, 124, 124, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (125, 1848, 125, 125, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (126, 1781, 126, 126, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (127, 2636, 127, 127, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (128, 2088, 128, 128, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (129, 3212, 129, 129, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (130, 3718, 130, 130, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (131, 3302, 131, 131, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (132, 1311, 132, 132, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (133, 3669, 133, 133, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (134, 2143, 134, 134, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (135, 1329, 135, 135, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (136, 2923, 136, 136, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (137, 2920, 137, 137, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (138, 1420, 138, 138, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (139, 2052, 139, 139, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (140, 1422, 140, 140, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (141, 3816, 141, 141, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (142, 1787, 142, 142, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (143, 1856, 143, 143, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (144, 1969, 144, 144, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (145, 3583, 145, 145, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (146, 1815, 146, 146, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (147, 1043, 147, 147, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (148, 3539, 148, 148, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (149, 1698, 149, 149, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (150, 3091, 150, 150, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (151, 3791, 151, 151, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (152, 1536, 152, 152, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (153, 2984, 153, 153, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (154, 2999, 154, 154, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (155, 3655, 155, 155, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (156, 2107, 156, 156, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (157, 1253, 157, 157, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (158, 1264, 158, 158, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (159, 1815, 159, 159, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (160, 2182, 160, 160, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (161, 1580, 161, 161, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (162, 1627, 162, 162, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (163, 1018, 163, 163, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (164, 1009, 164, 164, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (165, 2034, 165, 165, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (166, 2795, 166, 166, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (167, 2924, 167, 167, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (168, 1696, 168, 168, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (169, 3437, 169, 169, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (170, 3578, 170, 170, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (171, 1305, 171, 171, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (172, 1018, 172, 172, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (173, 2490, 173, 173, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (174, 2820, 174, 174, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (175, 3306, 175, 175, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (176, 2526, 176, 176, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (177, 2342, 177, 177, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (178, 2545, 178, 178, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (179, 3707, 179, 179, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (180, 1692, 180, 180, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (181, 3423, 181, 181, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (182, 2441, 182, 182, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (183, 2913, 183, 183, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (184, 3641, 184, 184, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (185, 1120, 185, 185, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (186, 1572, 186, 186, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (187, 1098, 187, 187, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (188, 2702, 188, 188, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (189, 2641, 189, 189, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (190, 2979, 190, 190, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (191, 3727, 191, 191, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (192, 3824, 192, 192, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (193, 1118, 193, 193, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (194, 2524, 194, 194, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (195, 2395, 195, 195, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (196, 1598, 196, 196, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (197, 1799, 197, 197, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (198, 1162, 198, 198, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (199, 3701, 199, 199, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (200, 1415, 200, 200, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (201, 3896, 201, 201, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (202, 2492, 202, 202, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (203, 2591, 203, 203, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (204, 3021, 204, 204, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (205, 1418, 205, 205, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (206, 3253, 206, 206, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (207, 1394, 207, 207, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (208, 2482, 208, 208, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (209, 1084, 209, 209, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (210, 3143, 210, 210, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (211, 2489, 211, 211, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (212, 3336, 212, 212, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (213, 2104, 213, 213, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (214, 1110, 214, 214, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (215, 2302, 215, 215, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (216, 1430, 216, 216, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (217, 3454, 217, 217, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (218, 2999, 218, 218, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (219, 3116, 219, 219, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (220, 1721, 220, 220, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (221, 2942, 221, 221, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (222, 3196, 222, 222, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (223, 2855, 223, 223, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (224, 3055, 224, 224, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (225, 1151, 225, 225, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (226, 2664, 226, 226, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (227, 1827, 227, 227, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (228, 1679, 228, 228, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (229, 3091, 229, 229, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (230, 3512, 230, 230, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (231, 3121, 231, 231, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (232, 2024, 232, 232, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (233, 2132, 233, 233, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (234, 1975, 234, 234, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (235, 2096, 235, 235, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (236, 2994, 236, 236, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (237, 3555, 237, 237, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (238, 2474, 238, 238, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (239, 3193, 239, 239, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (240, 3806, 240, 240, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (241, 1782, 241, 241, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (242, 1103, 242, 242, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (243, 3995, 243, 243, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (244, 2125, 244, 244, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (245, 3144, 245, 245, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (246, 1733, 246, 246, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (247, 1256, 247, 247, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (248, 3027, 248, 248, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (249, 3722, 249, 249, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (250, 2583, 250, 250, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (251, 2356, 251, 251, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (252, 1035, 252, 252, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (253, 3632, 253, 253, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (254, 2922, 254, 254, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (255, 2352, 255, 255, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (256, 3273, 256, 256, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (257, 1801, 257, 257, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (258, 2285, 258, 258, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (259, 1632, 259, 259, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (260, 3461, 260, 260, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (261, 3086, 261, 261, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (262, 1344, 262, 262, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (263, 1821, 263, 263, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (264, 3323, 264, 264, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (265, 1283, 265, 265, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (266, 2325, 266, 266, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (267, 2432, 267, 267, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (268, 1613, 268, 268, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (269, 1397, 269, 269, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (270, 1607, 270, 270, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (271, 3441, 271, 271, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (272, 3827, 272, 272, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (273, 1208, 273, 273, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (274, 3909, 274, 274, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (275, 1751, 275, 275, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (276, 1324, 276, 276, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (277, 2992, 277, 277, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (278, 1179, 278, 278, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (279, 3248, 279, 279, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (280, 1412, 280, 280, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (281, 3957, 281, 281, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (282, 1112, 282, 282, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (283, 3889, 283, 283, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (284, 1625, 284, 284, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (285, 1732, 285, 285, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (286, 1896, 286, 286, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (287, 2047, 287, 287, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (288, 3237, 288, 288, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (289, 3989, 289, 289, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (290, 2610, 290, 290, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (291, 3048, 291, 291, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (292, 3765, 292, 292, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (293, 2005, 293, 293, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (294, 1399, 294, 294, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (295, 1608, 295, 295, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (296, 1974, 296, 296, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (297, 3778, 297, 297, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (298, 3323, 298, 298, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (299, 3630, 299, 299, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (300, 1663, 300, 300, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (301, 3993, 301, 301, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (302, 3511, 302, 302, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (303, 2551, 303, 303, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (304, 1233, 304, 304, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (305, 2930, 305, 305, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (306, 2023, 306, 306, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (307, 3211, 307, 307, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (308, 1807, 308, 308, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (309, 1143, 309, 309, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (310, 2553, 310, 310, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (311, 3920, 311, 311, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (312, 1427, 312, 312, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (313, 2488, 313, 313, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (314, 1863, 314, 314, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (315, 1208, 315, 315, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (316, 3578, 316, 316, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (317, 1815, 317, 317, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (318, 1595, 318, 318, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (319, 1438, 319, 319, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (320, 3067, 320, 320, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (321, 3430, 321, 321, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (322, 2845, 322, 322, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (323, 3237, 323, 323, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (324, 3018, 324, 324, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (325, 3118, 325, 325, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (326, 1644, 326, 326, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (327, 2461, 327, 327, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (328, 3498, 328, 328, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (329, 2346, 329, 329, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (330, 1233, 330, 330, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (331, 3143, 331, 331, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (332, 2038, 332, 332, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (333, 3936, 333, 333, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (334, 3776, 334, 334, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (335, 3609, 335, 335, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (336, 2074, 336, 336, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (337, 2312, 337, 337, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (338, 1896, 338, 338, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (339, 2743, 339, 339, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (340, 2059, 340, 340, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (341, 3141, 341, 341, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (342, 3191, 342, 342, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (343, 3086, 343, 343, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (344, 1773, 344, 344, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (345, 2942, 345, 345, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (346, 1590, 346, 346, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (347, 3229, 347, 347, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (348, 3093, 348, 348, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (349, 3997, 349, 349, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (350, 2226, 350, 350, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (351, 2695, 351, 351, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (352, 1239, 352, 352, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (353, 2637, 353, 353, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (354, 3183, 354, 354, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (355, 1279, 355, 355, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (356, 2259, 356, 356, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (357, 3742, 357, 357, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (358, 3287, 358, 358, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (359, 2532, 359, 359, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (360, 1273, 360, 360, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (361, 1011, 361, 361, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (362, 3808, 362, 362, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (363, 1848, 363, 363, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (364, 3740, 364, 364, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (365, 1365, 365, 365, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (366, 2728, 366, 366, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (367, 3370, 367, 367, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (368, 1756, 368, 368, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (369, 1516, 369, 369, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (370, 1962, 370, 370, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (371, 2642, 371, 371, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (372, 1171, 372, 372, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (373, 2574, 373, 373, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (374, 3667, 374, 374, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (375, 1734, 375, 375, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (376, 1008, 376, 376, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (377, 2243, 377, 377, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (378, 2539, 378, 378, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (379, 1286, 379, 379, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (380, 1478, 380, 380, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (381, 3941, 381, 381, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (382, 2734, 382, 382, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (383, 1661, 383, 383, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (384, 3591, 384, 384, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (385, 1921, 385, 385, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (386, 1799, 386, 386, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (387, 1182, 387, 387, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (388, 3136, 388, 388, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (389, 1237, 389, 389, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (390, 1765, 390, 390, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (391, 1142, 391, 391, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (392, 3542, 392, 392, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (393, 3097, 393, 393, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (394, 3280, 394, 394, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (395, 1042, 395, 395, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (396, 3881, 396, 396, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (397, 3969, 397, 397, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (398, 2429, 398, 398, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (399, 1263, 399, 399, null);
insert into TRAVELERS_LIST (id_travelers_list, price, id_trip, id_travels, id_person)
values (400, 3046, 400, 400, null);
prompt 400 records loaded
prompt Loading WORKER_TRAVEL...
prompt Table is empty
prompt Enabling foreign key constraints for TRIP...
alter table TRIP enable constraint SYS_C007855;
prompt Enabling foreign key constraints for DESTINATIONS...
alter table DESTINATIONS enable constraint SYS_C007861;
prompt Enabling foreign key constraints for GUIDED_BY...
alter table GUIDED_BY enable constraint SYS_C007870;
alter table GUIDED_BY enable constraint SYS_C007871;
prompt Enabling foreign key constraints for INVENTORY...
alter table INVENTORY enable constraint SYS_C007828;
prompt Enabling foreign key constraints for WORKERS...
alter table WORKERS enable constraint FK_WORKERS_PERSON;
prompt Enabling foreign key constraints for ORDERS...
alter table ORDERS enable constraint FK_ORDERS_PERSON;
alter table ORDERS enable constraint SYS_C007838;
alter table ORDERS enable constraint SYS_C007839;
alter table ORDERS enable constraint SYS_C007840;
alter table ORDERS enable constraint SYS_C007841;
prompt Enabling foreign key constraints for PAYMENTS...
alter table PAYMENTS enable constraint SYS_C007844;
prompt Enabling foreign key constraints for TRAVELERS...
alter table TRAVELERS enable constraint FK_TRAVELERS_PERSON;
prompt Enabling foreign key constraints for TRAVELERS_LIST...
alter table TRAVELERS_LIST enable constraint FK_TRAVELERS_LIST_PERSON;
alter table TRAVELERS_LIST enable constraint SYS_C007882;
alter table TRAVELERS_LIST enable constraint SYS_C007883;
prompt Enabling foreign key constraints for WORKER_TRAVEL...
alter table WORKER_TRAVEL enable constraint FK_TRAVEL;
alter table WORKER_TRAVEL enable constraint FK_WORKER;
prompt Enabling triggers for CUSTOMERS...
alter table CUSTOMERS enable all triggers;
prompt Enabling triggers for TRANSPORTATION...
alter table TRANSPORTATION enable all triggers;
prompt Enabling triggers for TRIP...
alter table TRIP enable all triggers;
prompt Enabling triggers for DESTINATIONS...
alter table DESTINATIONS enable all triggers;
prompt Enabling triggers for GUARD...
alter table GUARD enable all triggers;
prompt Enabling triggers for GUIDED_BY...
alter table GUIDED_BY enable all triggers;
prompt Enabling triggers for NEWCATALOG...
alter table NEWCATALOG enable all triggers;
prompt Enabling triggers for INVENTORY...
alter table INVENTORY enable all triggers;
prompt Enabling triggers for PERSON...
alter table PERSON enable all triggers;
prompt Enabling triggers for WORKERS...
alter table WORKERS enable all triggers;
prompt Enabling triggers for ORDERS...
alter table ORDERS enable all triggers;
prompt Enabling triggers for PAYMENTS...
alter table PAYMENTS enable all triggers;
prompt Enabling triggers for TRAVELERS...
alter table TRAVELERS enable all triggers;
prompt Enabling triggers for TRAVELERS_LIST...
alter table TRAVELERS_LIST enable all triggers;
prompt Enabling triggers for WORKER_TRAVEL...
alter table WORKER_TRAVEL enable all triggers;
set feedback on
set define on
prompt Done.
