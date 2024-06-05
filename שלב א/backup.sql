prompt PL/SQL Developer import file
prompt Created on יום שלישי 04 יוני 2024 by USER
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
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table CUSTOMERS
  add primary key (IDCO)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating NEWCATALOG...
create table NEWCATALOG
(
  newcatalognumber INTEGER not null,
  newcatalogname   VARCHAR2(50),
  priceperunit     INTEGER
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table NEWCATALOG
  add primary key (NEWCATALOGNUMBER)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating INVENTORY...
create table INVENTORY
(
  shelf         INTEGER,
  unitsinstock  INTEGER,
  inventoryid   INTEGER not null,
  catalognumber INTEGER not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table INVENTORY
  add primary key (INVENTORYID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table INVENTORY
  add foreign key (CATALOGNUMBER)
  references NEWCATALOG (NEWCATALOGNUMBER);

prompt Creating WORKERS...
create table WORKERS
(
  workersrole  VARCHAR2(50),
  wage         INTEGER,
  workersmail  VARCHAR2(50),
  workersphone INTEGER,
  shift        VARCHAR2(50),
  idwo         INTEGER not null,
  workersname  VARCHAR2(50)
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table WORKERS
  add primary key (IDWO)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

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
  idco          INTEGER not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table ORDERS
  add primary key (ORDERID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
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
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table PAYMENTS
  add primary key (PAYMENTID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table PAYMENTS
  add foreign key (IDCO)
  references CUSTOMERS (IDCO);

prompt Disabling triggers for CUSTOMERS...
alter table CUSTOMERS disable all triggers;
prompt Disabling triggers for NEWCATALOG...
alter table NEWCATALOG disable all triggers;
prompt Disabling triggers for INVENTORY...
alter table INVENTORY disable all triggers;
prompt Disabling triggers for WORKERS...
alter table WORKERS disable all triggers;
prompt Disabling triggers for ORDERS...
alter table ORDERS disable all triggers;
prompt Disabling triggers for PAYMENTS...
alter table PAYMENTS disable all triggers;
prompt Disabling foreign key constraints for INVENTORY...
alter table INVENTORY disable constraint SYS_C007339;
prompt Disabling foreign key constraints for ORDERS...
alter table ORDERS disable constraint SYS_C007346;
alter table ORDERS disable constraint SYS_C007347;
alter table ORDERS disable constraint SYS_C007348;
alter table ORDERS disable constraint SYS_C007349;
prompt Disabling foreign key constraints for PAYMENTS...
alter table PAYMENTS disable constraint SYS_C007335;
prompt Deleting PAYMENTS...
delete from PAYMENTS;
prompt Deleting ORDERS...
delete from ORDERS;
prompt Deleting WORKERS...
delete from WORKERS;
prompt Deleting INVENTORY...
delete from INVENTORY;
prompt Deleting NEWCATALOG...
delete from NEWCATALOG;
prompt Deleting CUSTOMERS...
delete from CUSTOMERS;
prompt Loading CUSTOMERS...
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Rebecca-Vassar', 401, 538379886, 'school', 'rebecca.v@accesssystems.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Howard-Saucedo', 402, 549564069, 'school', 'howard.saucedo@spinnakerexploration.ca');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Fisher-Warden', 403, 510385360, 'office', 'fisher.w@trafficmanagement.uk');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Drew-McIntyre', 404, 582897989, 'private', 'd.mcintyre@gillette.de');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Laurie-Gordon', 405, 525114708, 'private', 'laurie.gordon@kroger.ch');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Sylvester-Roberts', 406, 554554578, 'private', 'sylvester.roberts@linacsystems.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Dan-Hubbard', 407, 568179128, 'school', 'dan.hubbard@telwares.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Celia-Makeba', 408, 572463939, 'private', 'cmakeba@ris.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Rich-Alston', 409, 598844634, 'school', 'r.alston@safehomesecurity.at');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Madeleine-Heslov', 410, 507213920, 'school', 'madeleine.h@usenergyservices.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Rade-Alda', 411, 540537529, 'office', 'rade.alda@hudsonriverbancorp.ca');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Ozzy-Giamatti', 412, 523924655, 'private', 'ozzy.giamatti@onesourceprinting.se');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Richie-Day', 413, 513756496, 'office', 'richie.d@prosperitybancshares.de');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Samantha-Michaels', 414, 556207364, 'private', 'samantha.michaels@meritagetechnologies.nl');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Ellen-Roy Parnell', 415, 513932942, 'office', 'ellen@mms.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Melba-Keaton', 416, 576558942, 'school', 'melba.keaton@stmaryland.at');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Leon-Suchet', 417, 553431919, 'private', 'leon.suchet@pscinfogroup.in');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Arnold-Ojeda', 418, 584579506, 'private', 'arnold.ojeda@progressivedesigns.uk');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('George-Gracie', 419, 562212632, 'private', 'george.g@atlanticnet.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Jimmie-Mandrell', 420, 581090668, 'school', 'jimmie.mandrell@bps.sg');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Lois-Benson', 421, 552796045, 'private', 'lois.benson@ghrsystems.de');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Bryan-Roberts', 422, 528461644, 'private', 'bryanr@vspan.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Petula-Rizzo', 423, 535912267, 'office', 'petula.r@infopros.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Bradley-Brandt', 424, 588632282, 'school', 'bbrandt@employerservices.ch');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Juliana-McNarland', 425, 500072019, 'office', 'juliana.mcnarland@keith.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Javon-Forrest', 426, 558206939, 'private', 'javonf@manhattanassociates.ch');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Bobby-Glenn', 427, 578149808, 'school', 'bobby.glenn@intraspheretechnologies.il');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Hilary-Mason', 428, 545071561, 'school', 'hilary.mason@questarcapital.dk');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Tilda-Lennox', 429, 589397707, 'office', 'tilda.lennox@americanland.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Stephanie-Moraz', 430, 539196847, 'private', 'stephaniem@gentrasystems.nl');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Clarence-Harrison', 431, 549014575, 'school', 'clarence.harrison@unilever.de');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Tamala-Torres', 432, 579589466, 'office', 'tamala.t@bioreliance.br');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Rolando-Dawson', 433, 539280186, 'private', 'rolando.dawson@ezecastlesoftware.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Nanci-Joli', 434, 519279788, 'school', 'n.joli@sfmai.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Wes-Rains', 435, 564387766, 'private', 'wesr@cynergydata.ch');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Vonda-Katt', 436, 501367962, 'private', 'vonda.katt@codykramerimports.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Fisher-Winslet', 437, 513983020, 'school', 'fisher.winslet@summitenergy.ch');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Ice-Reinhold', 438, 555414601, 'private', 'ice.reinhold@max.uk');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Lance-Hornsby', 439, 564949927, 'school', 'lance@mwp.uk');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Veruca-Sutherland', 440, 543441502, 'office', 'veruca.sutherland@portosan.it');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Omar-Waite', 441, 516360395, 'office', 'owaite@ubp.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Dom-Duncan', 442, 559710994, 'school', 'dom@accuship.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Humberto-Burke', 443, 584563835, 'school', 'humberto.burke@servicesource.nl');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Cameron-Holden', 444, 583639557, 'office', 'cameron.holden@hotmail.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Cole-Curfman', 445, 539378309, 'private', 'cole.curfman@nobrainerblindscom.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Stewart-Coverdale', 446, 556647666, 'school', 'stewart.coverdale@seiaarons.gr');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Liquid-Flack', 447, 595783326, 'private', 'liquidf@typhoon.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Chuck-Phillippe', 448, 590041174, 'school', 'chuck@dynacqinternational.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Coley-Bello', 449, 504472611, 'office', 'coley.bello@irissoftware.nl');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Nikki-Spall', 450, 581490183, 'office', 'nikki.spall@nhr.uk');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Cliff-Masur', 451, 519989467, 'private', 'cliff.masur@biosite.il');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Udo-Favreau', 452, 511108882, 'school', 'u.favreau@jollyenterprises.uk');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Trick-Beckham', 453, 577305952, 'school', 'trickb@peerlessmanufacturing.il');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Merrill-Madonna', 454, 586732747, 'private', 'merrill.madonna@accuship.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Tobey-Zevon', 455, 531643091, 'school', 'tobey.z@invisioncom.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Maria-Walker', 456, 597489425, 'school', 'maria.walker@nbs.uk');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Gena-McDonald', 457, 520221353, 'office', 'gena.mcdonald@parksite.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Andie-Idol', 458, 576905279, 'office', 'andie.idol@morganresearch.lt');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('First-Rydell', 459, 526290664, 'school', 'first.rydell@swi.it');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Spencer-Sorvino', 460, 543980230, 'office', 'spencers@fpf.jp');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Dennis-Ammons', 461, 549034411, 'private', 'dennis.ammons@capitalautomotive.mx');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Jeffery-Hutton', 462, 535298075, 'private', 'j.hutton@venoco.it');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Humberto-Gilliam', 463, 558353189, 'private', 'h.gilliam@timberlanewoodcrafters.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Emilio-Bello', 464, 565521619, 'school', 'emiliob@glmt.br');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Rawlins-Baranski', 465, 556856130, 'school', 'rawlins.baranski@fam.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Tara-Dempsey', 466, 558490977, 'school', 'tara.dempsey@marriottinternational.nl');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Winona-Kleinenberg', 467, 559819751, 'private', 'winona@nmr.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Celia-Andrews', 468, 521762179, 'school', 'celia.andrews@gbas.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Lloyd-Howard', 469, 556713679, 'private', 'lloyd.howard@onesourceprinting.fr');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Avril-Bonneville', 470, 563358272, 'private', 'abonneville@ach.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Jimmy-Schreiber', 471, 543286488, 'school', 'jimmy.schreiber@amerisourcefunding.uk');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Josh-Cage', 472, 522105328, 'office', 'j.cage@democracydata.it');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Wayman-Seagal', 473, 594456957, 'private', 'wayman@perfectorder.uk');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Busta-Bright', 474, 527793343, 'private', 'bbright@integratelecom.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Meg-MacDonald', 475, 544140108, 'school', 'mmacdonald@mitsubishimotors.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Neve-Davidtz', 476, 593358181, 'private', 'neve@totalentertainment.jp');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Gaby-Allison', 477, 546898188, 'school', 'gabya@unilever.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Burton-Coe', 478, 598090986, 'private', 'burtonc@codykramerimports.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Grace-Henstridge', 479, 557932875, 'office', 'g.henstridge@lifelinesystems.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Seann-Salonga', 480, 535602251, 'private', 'seann.salonga@carteretmortgage.es');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Debi-Hunt', 481, 577138302, 'private', 'd.hunt@venoco.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Diane-Gershon', 482, 597922423, 'private', 'dgershon@mosaic.ar');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Vickie-Lightfoot', 483, 560796049, 'school', 'vickiel@als.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Vern-Durning', 484, 502818384, 'private', 'v.durning@marsinc.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Bridget-MacPherson', 485, 538397152, 'school', 'bridget.macpherson@universalsolutions.ec');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Rosanna-Griggs', 486, 564710747, 'school', 'rosanna.griggs@gra.ca');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Jose-Cherry', 487, 567080236, 'school', 'jose@pharmacia.jp');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Chrissie-Ponce', 488, 581796321, 'private', 'chrissie@comglobalsystems.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Alessandro-O''Neill', 489, 589616339, 'school', 'alessandroo@atlanticcredit.uk');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Oliver-Van Helden', 490, 574733167, 'school', 'oliver.vanhelden@fflcbancorp.uk');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Forest-Yorn', 491, 562793956, 'office', 'forest.yorn@bigyanksports.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Katie-Cube', 492, 520987850, 'office', 'katie.cube@pepsico.ie');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Adrien-Sarsgaard', 493, 557846014, 'office', 'adrien@cns.ch');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Andrew-Donovan', 494, 534545609, 'school', 'andrew.donovan@softworld.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Dennis-Badalucco', 495, 552853996, 'private', 'dennis.badalucco@restaurantpartners.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Burt-Tomei', 496, 530560554, 'private', 'burt.t@grt.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Shawn-Krabbe', 497, 515130826, 'private', 'shawn.krabbe@kingston.uk');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Anne-Himmelman', 498, 517802197, 'office', 'a.himmelman@lms.ch');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Mac-Glover', 499, 506270541, 'office', 'mac.glover@fmt.uk');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Sheena-Rea', 500, 548781187, 'office', 'sheena.rea@mindiq.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Sharon-Sobieski', 501, 541872485, 'school', 'sharons@gci.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Salma-McCoy', 502, 560830456, 'office', 'salma.mccoy@ositissoftware.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Alessandro-Sawa', 503, 553091781, 'private', 'alessandro@americanhealthways.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Brian-Gallant', 504, 543094881, 'private', 'brian@stonetechprofessional.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Kathy-Almond', 505, 544213711, 'office', 'kathy@spinnakerexploration.it');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Sonny-Patillo', 506, 564764073, 'private', 'sonnyp@hersheyfoods.be');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Vanessa-Reynolds', 507, 507730610, 'office', 'vanessa.reynolds@safeway.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Connie-Hedaya', 508, 523162109, 'private', 'c.hedaya@techbooks.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Rebeka-Murdock', 509, 568533459, 'school', 'rebeka.murdock@capitolbancorp.ca');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Crystal-Davison', 510, 503479178, 'private', 'crystal.davison@allegiantbancorp.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Andre-Saxon', 511, 557400305, 'office', 'andre.s@royalgold.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Sheena-Ryan', 512, 507581647, 'school', 'sheena.ryan@dynacqinternational.ch');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Chantי-Farris', 513, 561873464, 'school', 'chant.farris@idlabel.za');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Marina-Reinhold', 514, 550059855, 'office', 'marina.reinhold@smg.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Hazel-Roberts', 515, 598360383, 'private', 'hazel@faef.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Natacha-Supernaw', 516, 505765904, 'school', 'natacha.supernaw@trainersoft.ch');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Gene-Hedaya', 517, 513072171, 'private', 'gene.h@microtek.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Allan-Rhames', 518, 545776842, 'office', 'allan.r@credopetroleum.ch');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Edward-Bosco', 519, 561146804, 'school', 'edward.bosco@slt.jp');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Peabo-Kudrow', 520, 530625851, 'private', 'peabo.kudrow@enterprise.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Tilda-Neville', 521, 545290588, 'private', 'tilda@invisioncom.it');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Debbie-Armstrong', 522, 562770489, 'school', 'debbiea@verizon.de');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Ethan-Dunn', 523, 566747553, 'private', 'ethan.dunn@coldstonecreamery.dk');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Demi-Pollack', 524, 507763191, 'office', 'demi.pollack@fordmotor.ch');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Gran-Gilley', 525, 567114481, 'private', 'ggilley@commworks.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Milla-Stuermer', 526, 554647284, 'school', 'm.stuermer@parker.dk');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Chad-Thornton', 527, 571665262, 'private', 'cthornton@ctg.ch');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Angela-Laws', 528, 542110534, 'private', 'angela@actechnologies.nz');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Alec-Frost', 529, 577764540, 'private', 'alec.frost@solutionbuilders.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Clive-Watson', 530, 501438142, 'office', 'clive.watson@elitemedical.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Kenny-Howard', 531, 504611218, 'school', 'kenny.howard@nbs.uk');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Dermot-Pfeiffer', 532, 517898534, 'office', 'dermot.pfeiffer@swp.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Karen-Robards', 533, 579515076, 'school', 'karen.robards@nsd.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Meryl-Johnson', 534, 513397513, 'office', 'mjohnson@volkswagen.it');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Lionel-Avital', 535, 506333672, 'office', 'lionela@perfectorder.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Ceili-Rapaport', 536, 531993778, 'private', 'ceili.rapaport@pearllawgroup.dk');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Lionel-Getty', 537, 546188584, 'office', 'lionel.g@coadvantageresources.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Nik-Saucedo', 538, 569913895, 'private', 'nik.s@execuscribe.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Mena-Moreno', 539, 551399912, 'office', 'mena.moreno@aci.jp');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Jena-Dalley', 540, 510603574, 'private', 'jena.dalley@tmt.dk');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Mykelti-Tyler', 541, 592761723, 'office', 'm.tyler@powerlight.de');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Glenn-Duke', 542, 509104682, 'private', 'glenn.d@capital.au');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Tommy-Teng', 543, 562635680, 'office', 'tommy@gagwear.uk');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Eric-Brolin', 544, 503176985, 'private', 'ericb@printingforlesscom.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Holland-Ramirez', 545, 588372661, 'office', 'holland.ramirez@genghisgrill.br');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Rick-Lawrence', 546, 502030970, 'school', 'rickl@kis.it');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Val-Bello', 547, 531019916, 'private', 'valb@capstone.uk');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Guy-Gertner', 548, 565131944, 'school', 'guy@wci.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Sal-Adams', 549, 533522165, 'office', 'sal.adams@aco.se');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Trace-Pfeiffer', 550, 501887686, 'office', 'trace@advertisingventures.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('John-Pollack', 551, 578790008, 'school', 'j.pollack@gbas.nz');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Charlton-Turturro', 552, 503878448, 'private', 'charlton@at.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Lauren-Cusack', 553, 594983546, 'school', 'lauren.cusack@clorox.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Heather-Katt', 554, 513963635, 'office', 'heatherk@comglobalsystems.si');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Dean-Hatfield', 555, 532802778, 'office', 'dhatfield@comnetinternational.br');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Gladys-Dorff', 556, 535557233, 'private', 'gladys.dorff@bowman.jp');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Carla-Keen', 557, 531645200, 'office', 'carla.keen@technica.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Dylan-Herrmann', 558, 540461199, 'office', 'dylan.herrmann@generalmotors.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Geoffrey-Venora', 559, 523091900, 'private', 'g.venora@supplycorecom.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Suzy-Noseworthy', 560, 528373959, 'school', 'suzy.n@techrx.ch');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Collective-Parm', 561, 557986833, 'office', 'collective.parm@oriservices.jp');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Lucy-Danes', 562, 520040926, 'office', 'lucy.danes@unit.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Karen-Byrne', 563, 576377088, 'private', 'k.byrne@pis.in');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Chubby-Holiday', 564, 505174004, 'school', 'chubby.holiday@stonebrewing.es');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Miles-Biehn', 565, 512991196, 'school', 'miles.biehn@loreal.dk');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Kay-McCabe', 566, 529738141, 'private', 'kay.mccabe@authoria.de');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Linda-Day-Lewis', 567, 534242330, 'school', 'lindad@advertisingventures.de');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Nile-King', 568, 578318423, 'school', 'nile.k@philipmorris.br');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Alice-Miller', 569, 531335455, 'school', 'alice.miller@scheringplough.uk');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Linda-Klugh', 570, 509787221, 'office', 'linda.klugh@signature.de');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Avenged-Braugher', 571, 568094992, 'school', 'avenged.braugher@mls.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Marisa-Shelton', 572, 518205480, 'office', 'marisa@mercantilebank.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Cameron-Morton', 573, 599490937, 'school', 'cameron.morton@sears.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Gin-Tobolowsky', 574, 562100410, 'school', 'gin@qls.it');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Charlize-Nicks', 575, 536377380, 'office', 'c.nicks@spotfireholdings.fr');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Fiona-Conlee', 576, 543427695, 'office', 'f.conlee@datawarehouse.br');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Frederic-Horton', 577, 520967488, 'school', 'frederic.horton@onstaff.ca');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Kelli-Kattan', 578, 558913788, 'office', 'kelli.kattan@csi.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Will-Warren', 579, 562599770, 'private', 'will.warren@kellogg.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Roscoe-Gracie', 580, 510170123, 'private', 'roscoe.gracie@printtech.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Roddy-Spears', 581, 522351228, 'school', 'r.spears@insurmark.py');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Alessandro-Crouse', 582, 570218459, 'private', 'acrouse@americanpan.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Hex-Cagle', 583, 556116188, 'private', 'hex.cagle@pragmatechsoftware.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Judy-Bonneville', 584, 532306962, 'office', 'judyb@marsinc.za');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Al-Travers', 585, 597170114, 'office', 'al.travers@sandyspringbancorp.br');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Stephen-Payne', 586, 554386228, 'office', 'stephen.payne@tigris.za');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Isabella-MacPherson', 587, 576624493, 'office', 'imacpherson@printcafesoftware.fr');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Rachel-Heslov', 588, 572155020, 'private', 'rachel.h@typhoon.br');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Nastassja-Dillon', 589, 550227050, 'office', 'nastassja@educationaldevelopment.ca');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Rita-Boorem', 590, 579968653, 'school', 'rita.boorem@acsis.uk');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Benjamin-Doucette', 591, 578245776, 'school', 'benjamin.doucette@qestrel.jp');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Bridget-Hagerty', 592, 533582195, 'office', 'bridget.hagerty@talx.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Carrie-Anne-Cagle', 593, 590446061, 'private', 'carrieanne.cagle@computersource.ca');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Nicolas-Hyde', 594, 592854332, 'office', 'n.hyde@sprint.ch');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Jimmie-Pacino', 595, 521135850, 'private', 'jimmie.pacino@jsa.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Kelli-Mills', 596, 590755213, 'private', 'kelli.mills@ubp.uk');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Merillee-Fehr', 597, 534176077, 'school', 'merillee.fehr@grs.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Omar-Costner', 598, 546437071, 'private', 'omar.costner@mavericktechnologies.jp');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Liam-Arkenstone', 599, 555031860, 'office', 'l.arkenstone@netnumina.de');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Tyrone-Nelligan', 600, 508001343, 'office', 'tyrone.nelligan@dis.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Gerald-Conners', 601, 588847086, 'private', 'gerald.conners@atg.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Dabney-Brooke', 602, 538954444, 'school', 'dabney.brooke@aquascapedesigns.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Johnny-Child', 603, 576794909, 'private', 'johnny.child@fnb.au');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Harvey-Sandoval', 604, 546615519, 'office', 'harvey.sandoval@lms.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Mira-Redgrave', 605, 568137346, 'school', 'mira.redgrave@sds.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Mel-Tsettos', 606, 592501060, 'private', 'melt@virbac.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Julio-Wakeling', 607, 564653874, 'school', 'julio.wakeling@ams.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Owen-Atlas', 608, 563432767, 'private', 'oatlas@electricalsolutions.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Vincent-Rourke', 609, 538221785, 'school', 'vrourke@capellaeducation.de');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Howie-Dempsey', 610, 549977242, 'office', 'howie@clorox.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Woody-Knight', 611, 582068776, 'private', 'woody.knight@yes.de');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Kris-Flemyng', 612, 566805937, 'office', 'k.flemyng@viacom.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Dustin-Jonze', 613, 516796342, 'school', 'dustinj@cmi.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Julie-Moriarty', 614, 533720011, 'school', 'julie.moriarty@cascadebancorp.ca');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Danni-Cozier', 615, 521080863, 'private', 'danni.cozier@investmentscorecard.za');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Lindsay-Gere', 616, 575408154, 'office', 'lindsay.gere@jlphor.fr');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Stephen-Haggard', 617, 520939007, 'private', 'stephen.haggard@fmi.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Chazz-Keith', 618, 501384124, 'private', 'chazz.keith@marsinc.uk');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Rich-Hanks', 619, 582661779, 'office', 'rich@cynergydata.ca');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('April-Henriksen', 620, 581907548, 'school', 'april.henriksen@componentgraphics.br');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Malcolm-Roth', 621, 507354851, 'office', 'malcolmr@wav.uk');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Avenged-Holbrook', 622, 519956414, 'school', 'aholbrook@onesourceprinting.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Angie-Brock', 623, 517035184, 'school', 'angie.b@linacsystems.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Breckin-Osbourne', 624, 517329608, 'private', 'breckin.osbourne@fetchlogistics.dk');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Kristin-Red', 625, 542561813, 'school', 'kred@staffone.ca');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Sylvester-Lithgow', 626, 553413060, 'private', 's.lithgow@escalade.br');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Jena-Nicholas', 627, 595939485, 'school', 'jena@adolph.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Robby-Wells', 628, 501771016, 'private', 'robby.w@chhc.dk');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Salma-Osborne', 629, 564747534, 'office', 'salma.o@bigdoughcom.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Mekhi-Crow', 630, 557505680, 'private', 'mekhic@spenser.jp');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Denis-O''Donnell', 631, 567836800, 'school', 'denis.odonnell@spas.za');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Tamala-MacIsaac', 632, 539150425, 'school', 'tamala.macisaac@learningvoyage.nl');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Trini-Broderick', 633, 528449411, 'private', 'trini.broderick@hfg.mx');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Carlene-Lyonne', 634, 527317937, 'private', 'carlene@travizon.de');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Randall-Gold', 635, 521038840, 'office', 'randall.gold@daimlerchrysler.jp');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Will-Torn', 636, 571774899, 'school', 'will.torn@yashtechnologies.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Emily-Patton', 637, 569520926, 'private', 'emily.patton@wellsfinancial.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Veruca-Cervine', 638, 597902195, 'office', 'veruca.c@fmb.de');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Wally-Foster', 639, 561730514, 'private', 'wallyf@lindin.nl');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Saffron-Raitt', 640, 513775085, 'school', 'sraitt@adeasolutions.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Samuel-Marie', 641, 540577323, 'office', 'smarie@sprint.it');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Ewan-Dale', 642, 585243985, 'school', 'ewand@dearbornbancorp.br');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Bryan-Rubinek', 643, 507701859, 'private', 'bryan.rubinek@hfn.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Lennie-McNeice', 644, 584031007, 'office', 'l.mcneice@mcdonalds.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Ed-Pastore', 645, 578015632, 'school', 'ed.p@balchem.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Gary-Broderick', 646, 552843591, 'school', 'gary@learningvoyage.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Jake-O''Neill', 647, 563122113, 'office', 'jake.oneill@pearllawgroup.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Louise-Posener', 648, 599677561, 'school', 'louise@gulfmarkoffshore.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Jackie-Jackson', 649, 530240288, 'school', 'jackie.jackson@floorgraphics.it');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Solomon-Marie', 650, 560709780, 'school', 'solomon.marie@elite.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Coley-Cube', 651, 517787381, 'school', 'ccube@egroup.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Shannyn-Haynes', 652, 510444397, 'office', 'shannyn.haynes@curagroup.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Aida-Costello', 653, 573476088, 'school', 'aida.c@aco.ch');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Kasey-Sylvian', 654, 548686584, 'office', 'kasey.sylvian@sfb.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Marina-Levy', 655, 524016927, 'private', 'marina.levy@coridiantechnologies.uk');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Christopher-Brando', 656, 566334255, 'office', 'cbrando@fmb.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Ann-Sheen', 657, 579854826, 'private', 'ann.s@irissoftware.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Kylie-Withers', 658, 520686751, 'office', 'kylie.withers@linksys.in');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Denzel-Saxon', 659, 572110117, 'school', 'denzel.saxon@accesssystems.de');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Wang-El-Saher', 660, 588787241, 'school', 'w.elsaher@dataprise.lt');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Lili-Craig', 661, 544560981, 'school', 'lili.craig@cmi.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Larry-Alda', 662, 577815471, 'private', 'larry.alda@elmco.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Nicholas-Ferrer', 663, 556062909, 'office', 'n.ferrer@kelmooreinvestment.br');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Emma-Weisberg', 664, 570015880, 'office', 'eweisberg@tracertechnologies.be');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Deborah-Scheider', 665, 517943652, 'school', 'deborah.scheider@learningvoyage.ca');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Tracy-Reilly', 666, 514635468, 'private', 'tracy.reilly@talx.ca');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Herbie-Day', 667, 549707351, 'school', 'herbie.day@globalwireless.it');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Woody-Serbedzija', 668, 530260665, 'office', 'woody.serbedzija@avs.fr');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Marlon-Brolin', 669, 527118831, 'school', 'marlon.brolin@otbd.jp');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Rory-Buffalo', 670, 502879058, 'office', 'rory.buffalo@ogi.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Ernest-Harmon', 671, 522775380, 'office', 'ernest.harmon@sms.uk');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Faye-Tennison', 672, 571622000, 'office', 'faye@voicelog.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Wallace-Jovovich', 673, 553679458, 'school', 'wallacej@hardwoodwholesalers.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Aida-Paul', 674, 515767437, 'private', 'apaul@ccb.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Judd-Griffith', 675, 565926754, 'office', 'judd@accessus.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Stanley-Cassel', 676, 596068965, 'school', 's.cassel@cws.es');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Shannon-Grant', 677, 568997701, 'school', 'shannon.grant@carteretmortgage.tr');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Nicky-Gooding', 678, 588110379, 'office', 'nicky.gooding@smi.dk');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Ossie-Marie', 679, 536535416, 'private', 'omarie@spenser.au');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Pierce-Creek', 680, 508731456, 'office', 'pierce.creek@mwh.nl');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Steven-Bonham', 681, 520860439, 'private', 'steven.bonham@actechnologies.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Lizzy-Eastwood', 682, 584098862, 'school', 'l.eastwood@yumbrands.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Owen-Klein', 683, 507585075, 'school', 'owen.k@faef.uk');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Sammy-Shearer', 684, 596285735, 'school', 'sammy.shearer@clubone.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Mindy-Crystal', 685, 535850980, 'school', 'mindy.crystal@conagra.de');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Gilberto-Young', 686, 583203672, 'office', 'gilberto.young@amerisourcefunding.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Suzi-Creek', 687, 558844964, 'private', 'suzi.creek@fpf.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Vivica-Shepard', 688, 522502233, 'private', 'vivica.shepard@emt.jp');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Azucar-Coward', 689, 597316606, 'office', 'azucar.coward@microsoft.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Nathan-Soul', 690, 593784882, 'private', 'nsoul@epamsystems.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Spencer-McElhone', 691, 567482083, 'school', 'spencer.mcelhone@lfg.de');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Mike-Hurt', 692, 598188216, 'school', 'mike.hurt@capitalautomotive.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Clarence-Matheson', 693, 509023875, 'private', 'c.matheson@hiltonhotels.es');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Ozzy-Cockburn', 694, 509677143, 'private', 'ozzy.c@doraldentalusa.dk');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Vertical-Borgnine', 695, 557387570, 'office', 'v.borgnine@marsinc.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Diane-Ward', 696, 538794033, 'private', 'dward@usdairyproducers.cy');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Mel-Coltrane', 697, 569794932, 'private', 'mel.coltrane@ivci.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Harris-Cassidy', 698, 542576520, 'school', 'h.cassidy@tama.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Saul-Blaine', 699, 592441543, 'school', 'saulb@capstone.ca');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Spike-Huston', 700, 594483041, 'office', 'spike.huston@atxforms.se');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Joseph-Tyler', 701, 574481600, 'school', 'joseph@hotmail.uk');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Patrick-Whitmore', 702, 590121603, 'private', 'patrick.whitmore@arkidata.at');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Larnelle-Nunn', 703, 555364703, 'school', 'l.nunn@mindworks.de');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Ritchie-Shocked', 704, 547202582, 'school', 'r.shocked@gapinc.de');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Burton-Avital', 705, 550005577, 'school', 'burton.avital@elitemedical.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Hector-McBride', 706, 552749850, 'school', 'hector.m@hudsonriverbancorp.nl');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Loretta-Lachey', 707, 513870140, 'private', 'lorettal@qssgroup.br');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Bobbi-Benson', 708, 524783796, 'office', 'bobbi.benson@cocacola.fr');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Belinda-Fierstein', 709, 592275212, 'school', 'belinda@ubp.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Bobbi-Margulies', 710, 536480769, 'office', 'bobbi.margulies@bigdoughcom.au');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Forest-Madsen', 711, 569929519, 'school', 'forest.madsen@atlanticcredit.uk');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Bonnie-Kutcher', 712, 542270505, 'private', 'bonnie.k@slt.be');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Greg-Hatchet', 713, 513567888, 'office', 'greg.hatchet@gra.au');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Julia-Quinn', 714, 598301378, 'private', 'julia.quinn@capellaeducation.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Rich-Taha', 715, 597455264, 'private', 'rich@trekequipment.ch');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Red-Bedelia', 716, 527293728, 'office', 'red.bedelia@insurmark.nl');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Pablo-Pullman', 717, 525764600, 'school', 'p.pullman@elmco.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Dick-Gold', 718, 575659363, 'private', 'dick.gold@ogi.tr');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Christina-Cromwell', 719, 506240713, 'office', 'christina.cromwell@timberlanewoodcrafters.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Johnette-Bassett', 720, 504722325, 'school', 'jbassett@bioanalytical.nl');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Domingo-Loggins', 721, 540244480, 'private', 'domingo.loggins@circuitcitystores.ca');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Jonny-Goldblum', 722, 560994975, 'office', 'jonny.goldblum@socketinternet.tr');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Lennie-Matarazzo', 723, 507404271, 'school', 'lennie@dbprofessionals.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Kazem-Russell', 724, 561637457, 'private', 'krussell@trekequipment.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Ann-Patrick', 725, 545665136, 'office', 'ann.patrick@viacell.fi');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('William-Grier', 726, 587595413, 'school', 'william.grier@caliber.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Robert-Brolin', 727, 545758288, 'private', 'robert.brolin@montpelierplastics.nz');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Thelma-Shalhoub', 728, 599432470, 'private', 'thelma@teamstudio.at');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Kenneth-Conway', 729, 529093984, 'office', 'k.conway@accessus.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Janeane-Suchet', 730, 520070214, 'private', 'janeanes@reckittbenckiser.il');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Don-Stiers', 731, 523165505, 'office', 'don.stiers@teoco.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Miguel-Glover', 732, 580136386, 'private', 'm.glover@nmr.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Rebeka-Richter', 733, 548462162, 'school', 'rebeka.r@enterprise.uk');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Dabney-Isaak', 734, 578596476, 'office', 'd.isaak@tigris.de');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Bruce-Guzman', 735, 594111463, 'school', 'bruce.guzman@elitemedical.ca');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Rose-Pitney', 736, 582138093, 'office', 'rose.p@smartronix.ca');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Gabriel-Brandt', 737, 559155145, 'office', 'gabriel@printingforlesscom.it');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Warren-Wiest', 738, 597887567, 'private', 'warren.wiest@hiltonhotels.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Gilberto-Eastwood', 739, 508849114, 'school', 'gilberto@conquest.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Rick-Coolidge', 740, 561707846, 'office', 'rick.coolidge@spectrum.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Neneh-Union', 741, 514199411, 'office', 'nunion@clorox.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Praga-Reiner', 742, 590667071, 'school', 'pragar@nlx.de');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Leslie-Jolie', 743, 514853649, 'school', 'ljolie@wyeth.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Pam-Mraz', 744, 503984740, 'school', 'pam.mraz@anheuserbusch.uk');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Donal-Marsden', 745, 584065512, 'private', 'donal.marsden@catamount.ca');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Roberta-Buscemi', 746, 556381037, 'private', 'roberta.buscemi@officedepot.dk');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Udo-Derringer', 747, 512747529, 'private', 'udo@als.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Jonny Lee-Redford', 748, 546555015, 'private', 'jredford@axis.fi');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Paula-Todd', 749, 512072316, 'school', 'p.todd@capitalbank.au');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Gloria-Loeb', 750, 515433718, 'private', 'gloria@y2marketing.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Olga-Hurley', 751, 562254201, 'office', 'olga.hurley@anheuserbusch.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Tia-de Lancie', 752, 538902015, 'private', 'tia.delancie@dcgroup.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Red-Sample', 753, 528003402, 'school', 'red.s@cendant.dk');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Catherine-Palmieri', 754, 596426156, 'school', 'catherine.palmieri@vspan.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Luis-Supernaw', 755, 563543990, 'school', 'luis@codykramerimports.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Cloris-MacIsaac', 756, 594747235, 'school', 'clorism@toyotamotor.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Mandy-Graham', 757, 524410384, 'school', 'm.graham@ads.es');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Burton-Washington', 758, 513393852, 'office', 'burton.washington@sourcegear.de');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Keith-Phillips', 759, 542506887, 'office', 'keith.phillips@gapinc.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Gina-Zappacosta', 760, 552588897, 'school', 'gina.zappacosta@peerlessmanufacturing.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Kiefer-Tisdale', 761, 551371512, 'private', 'kiefer@kiamotors.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Carole-Hong', 762, 508012141, 'school', 'carole.hong@bayer.br');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Rueben-Cook', 763, 577596282, 'private', 'rueben@usenergyservices.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Merillee-Langella', 764, 531287644, 'private', 'merillee.langella@anheuserbusch.au');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Frances-Melvin', 765, 536470076, 'office', 'fmelvin@nobrainerblindscom.br');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Jackson-Gary', 766, 545174698, 'private', 'jackson.gary@bis.nl');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Roscoe-LaBelle', 767, 523702936, 'school', 'rlabelle@httprint.lt');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Diane-Eldard', 768, 500337591, 'office', 'd.eldard@signalperfection.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Boz-Viterelli', 769, 540096074, 'office', 'boz.viterelli@kis.za');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Maury-Delta', 770, 518800095, 'school', 'maury.delta@generalmills.ca');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Tia-Copeland', 771, 564202697, 'school', 'tia@team.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Kathleen-Brooke', 772, 544497486, 'private', 'k.brooke@ogiointernational.ch');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Uma-Getty', 773, 556793330, 'private', 'uma.getty@powerlight.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Maury-Phifer', 774, 526753321, 'office', 'm.phifer@diamondtechnologies.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Pierce-Loring', 775, 538611439, 'office', 'pierce.l@intel.de');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Eliza-Loring', 776, 581431577, 'school', 'eliza.l@montpelierplastics.cz');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Kimberly-Arkenstone', 777, 508472817, 'office', 'kimberly.arkenstone@pulaskifinancial.au');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Elias-Tilly', 778, 522455662, 'office', 'elias.tilly@trc.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Samantha-Klugh', 779, 513454279, 'private', 'samantha@mosaic.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Suzy-Holmes', 780, 597284912, 'office', 's.holmes@generalmills.pl');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Lauren-Brooke', 781, 504064669, 'office', 'lauren.b@marlabs.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Lance-Harrelson', 782, 503785181, 'school', 'lance.h@mission.se');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Will-Walken', 783, 576058118, 'private', 'will.w@gillette.ch');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Nicolas-Hackman', 784, 527819847, 'private', 'nicolas.hackman@intel.fr');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Elvis-Winslet', 785, 564714586, 'school', 'elvis.w@newviewgifts.fr');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Cesar-Loggia', 786, 546413644, 'office', 'cloggia@unicru.fi');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Ali-Perlman', 787, 577048147, 'office', 'ali@campbellsoup.jp');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Edwin-LuPone', 788, 596149080, 'private', 'edwin.lupone@neogen.de');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Kate-Schwarzenegger', 789, 526234786, 'school', 'kate.schwarzenegger@mavericktechnologies.au');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Bridget-Stanley', 790, 576321268, 'office', 'bridget.stanley@nhhc.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Bobbi-Browne', 791, 591071389, 'office', 'bobbi.browne@epiqsystems.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Nikki-Tambor', 792, 596438352, 'school', 'n.tambor@visainternational.de');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Desmond-Davis', 793, 587546321, 'private', 'desmond.davis@staffforce.uk');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Elizabeth-Root', 794, 546686899, 'private', 'elizabeth.root@younginnovations.uk');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Tea-Stiles', 795, 531849136, 'school', 'tea@safeway.dk');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Elizabeth-Wiedlin', 796, 574353737, 'office', 'elizabeth.wiedlin@pioneerdatasystems.no');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Liev-Owen', 797, 593751730, 'private', 'l.owen@jollyenterprises.jp');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Debby-Wiest', 798, 593195415, 'school', 'debby@elite.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Mena-Stevens', 799, 588083704, 'private', 'mena@nhr.com');
insert into CUSTOMERS (customersname, idco, customersphone, customerstype, customersmail)
values ('Junior-Schneider', 800, 570474592, 'office', 'junior.s@fetchlogistics.com');
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
values (4, 26, 2000, 807);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 13, 2001, 842);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 32, 2002, 825);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 4, 2003, 804);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 46, 2004, 826);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 48, 2005, 850);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 41, 2006, 817);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 28, 2007, 847);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 44, 2008, 835);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 27, 2009, 820);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 48, 2010, 848);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 7, 2011, 842);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 34, 2012, 844);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 45, 2013, 818);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 9, 2014, 847);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 34, 2015, 804);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 33, 2016, 832);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 44, 2017, 823);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 8, 2018, 849);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 42, 2019, 830);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 37, 2020, 819);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 2, 2021, 812);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 18, 2022, 826);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 49, 2023, 805);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 20, 2024, 830);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 17, 2025, 839);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 48, 2026, 818);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 5, 2027, 818);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 15, 2028, 823);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 11, 2029, 850);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 46, 2030, 828);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 42, 2031, 805);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 3, 2032, 803);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 14, 2033, 842);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 14, 2034, 836);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 3, 2035, 820);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 28, 2036, 848);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 12, 2037, 835);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 2, 2038, 827);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 2, 2039, 821);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 2, 2040, 808);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 43, 2041, 842);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 46, 2042, 838);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 35, 2043, 848);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 50, 2044, 823);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 45, 2045, 826);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 3, 2046, 850);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 17, 2047, 802);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 47, 2048, 847);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 36, 2049, 807);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 27, 2050, 827);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 27, 2051, 837);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 13, 2052, 801);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 38, 2053, 827);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 43, 2054, 832);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 19, 2055, 834);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 35, 2056, 811);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 40, 2057, 835);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 50, 2058, 834);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 31, 2059, 808);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 15, 2060, 833);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 15, 2061, 835);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 2, 2062, 813);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 16, 2063, 836);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 9, 2064, 801);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 49, 2065, 813);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 50, 2066, 844);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 5, 2067, 823);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 29, 2068, 814);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 50, 2069, 811);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 7, 2070, 804);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 0, 2071, 846);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 49, 2072, 830);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 3, 2073, 821);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 46, 2074, 812);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 28, 2075, 831);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 47, 2076, 811);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 14, 2077, 812);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 12, 2078, 846);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 35, 2079, 805);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 18, 2080, 849);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 35, 2081, 819);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 11, 2082, 847);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 27, 2083, 801);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 26, 2084, 813);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 48, 2085, 844);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 39, 2086, 822);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 11, 2087, 819);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 47, 2088, 802);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 8, 2089, 832);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 47, 2090, 830);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 3, 2091, 804);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 9, 2092, 821);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 15, 2093, 822);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 48, 2094, 828);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 1, 2095, 824);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 7, 2096, 812);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 33, 2097, 823);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 26, 2098, 805);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 18, 2099, 827);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 3, 2100, 802);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 26, 2101, 804);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 3, 2102, 843);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 19, 2103, 833);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 27, 2104, 844);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 14, 2105, 805);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 2, 2106, 809);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 17, 2107, 829);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 29, 2108, 832);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 48, 2109, 835);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 29, 2110, 801);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 22, 2111, 826);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 48, 2112, 841);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 9, 2113, 844);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 41, 2114, 811);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 30, 2115, 843);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 33, 2116, 808);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 37, 2117, 811);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 49, 2118, 820);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 36, 2119, 836);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 14, 2120, 850);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 43, 2121, 809);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 48, 2122, 803);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 50, 2123, 816);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 19, 2124, 849);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 4, 2125, 806);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 30, 2126, 833);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 11, 2127, 814);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 23, 2128, 808);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 17, 2129, 848);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 39, 2130, 845);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 35, 2131, 834);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 41, 2132, 816);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 6, 2133, 812);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 4, 2134, 818);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 5, 2135, 848);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 35, 2136, 828);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 35, 2137, 826);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 3, 2138, 811);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 47, 2139, 845);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 10, 2140, 812);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 12, 2141, 801);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 36, 2142, 838);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 42, 2143, 812);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 8, 2144, 843);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 15, 2145, 828);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 48, 2146, 842);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 11, 2147, 824);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 30, 2148, 815);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 1, 2149, 801);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 33, 2150, 829);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 50, 2151, 814);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 45, 2152, 842);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 20, 2153, 828);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 38, 2154, 846);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 7, 2155, 817);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 27, 2156, 831);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 46, 2157, 829);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 43, 2158, 841);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 32, 2159, 825);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 50, 2160, 827);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 32, 2161, 827);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 35, 2162, 808);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 38, 2163, 838);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 15, 2164, 835);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 48, 2165, 805);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 40, 2166, 837);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 5, 2167, 809);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 12, 2168, 801);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 32, 2169, 803);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 12, 2170, 847);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 25, 2171, 802);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 16, 2172, 829);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 42, 2173, 816);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 10, 2174, 840);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 33, 2175, 835);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 43, 2176, 833);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 35, 2177, 824);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 19, 2178, 832);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 35, 2179, 847);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 47, 2180, 840);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 37, 2181, 807);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 17, 2182, 835);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 16, 2183, 837);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 41, 2184, 802);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 23, 2185, 837);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 36, 2186, 847);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 29, 2187, 849);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 25, 2188, 833);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 19, 2189, 833);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 17, 2190, 825);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 27, 2191, 809);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 8, 2192, 818);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 41, 2193, 807);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 16, 2194, 808);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 50, 2195, 826);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 38, 2196, 815);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 2, 2197, 827);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 6, 2198, 839);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 19, 2199, 840);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 50, 2200, 820);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 31, 2201, 838);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 22, 2202, 839);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 23, 2203, 835);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 29, 2204, 811);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 40, 2205, 830);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 16, 2206, 843);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 10, 2207, 847);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 21, 2208, 808);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 36, 2209, 850);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 48, 2210, 844);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 3, 2211, 805);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 48, 2212, 813);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 29, 2213, 847);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 44, 2214, 806);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 44, 2215, 843);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 3, 2216, 845);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 43, 2217, 819);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 36, 2218, 838);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 30, 2219, 819);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 13, 2220, 819);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 27, 2221, 807);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 30, 2222, 814);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 38, 2223, 843);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 40, 2224, 845);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 39, 2225, 845);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 38, 2226, 830);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 28, 2227, 825);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 3, 2228, 838);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 18, 2229, 844);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 18, 2230, 846);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 46, 2231, 817);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 36, 2232, 829);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 12, 2233, 821);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 4, 2234, 803);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 26, 2235, 847);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 45, 2236, 835);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 30, 2237, 845);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 12, 2238, 844);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 12, 2239, 830);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 32, 2240, 823);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 16, 2241, 829);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 26, 2242, 807);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 8, 2243, 835);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 33, 2244, 842);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 8, 2245, 812);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 22, 2246, 841);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 48, 2247, 824);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 33, 2248, 822);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 26, 2249, 844);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 12, 2250, 846);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 39, 2251, 802);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 5, 2252, 806);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 41, 2253, 836);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 47, 2254, 844);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 28, 2255, 838);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 7, 2256, 834);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 2, 2257, 810);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 10, 2258, 827);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 21, 2259, 803);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 41, 2260, 811);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 36, 2261, 844);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 4, 2262, 811);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 33, 2263, 823);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 5, 2264, 812);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 15, 2265, 824);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 11, 2266, 802);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 31, 2267, 808);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 17, 2268, 831);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 7, 2269, 807);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 49, 2270, 844);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 5, 2271, 844);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 39, 2272, 801);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 8, 2273, 847);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 4, 2274, 823);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 28, 2275, 813);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 38, 2276, 809);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 3, 2277, 812);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 25, 2278, 824);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 38, 2279, 824);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 24, 2280, 821);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 27, 2281, 814);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 18, 2282, 842);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 47, 2283, 837);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 22, 2284, 811);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 0, 2285, 804);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 23, 2286, 808);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 39, 2287, 828);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 48, 2288, 825);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 43, 2289, 829);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 45, 2290, 822);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 14, 2291, 821);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 16, 2292, 816);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 43, 2293, 840);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 9, 2294, 820);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 34, 2295, 840);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 42, 2296, 840);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 35, 2297, 807);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 22, 2298, 841);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 49, 2299, 805);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 11, 2300, 830);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 33, 2301, 812);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 14, 2302, 802);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 32, 2303, 826);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 27, 2304, 824);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 24, 2305, 850);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 37, 2306, 812);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 31, 2307, 807);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 33, 2308, 822);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 33, 2309, 834);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 47, 2310, 818);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 29, 2311, 842);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 24, 2312, 821);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 8, 2313, 819);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 35, 2314, 842);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 9, 2315, 832);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 48, 2316, 802);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 17, 2317, 842);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 9, 2318, 807);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 39, 2319, 831);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 22, 2320, 822);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 0, 2321, 840);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 10, 2322, 807);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 32, 2323, 830);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 31, 2324, 813);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 17, 2325, 814);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 48, 2326, 840);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 50, 2327, 809);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 25, 2328, 821);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 24, 2329, 813);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 45, 2330, 821);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 3, 2331, 840);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 1, 2332, 811);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 39, 2333, 803);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 42, 2334, 835);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 8, 2335, 846);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 5, 2336, 841);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 9, 2337, 843);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 27, 2338, 813);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 21, 2339, 828);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 24, 2340, 816);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 14, 2341, 836);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 44, 2342, 819);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 36, 2343, 833);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 22, 2344, 839);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 38, 2345, 832);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 23, 2346, 805);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 46, 2347, 810);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 23, 2348, 848);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 18, 2349, 831);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 46, 2350, 847);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 19, 2351, 841);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 10, 2352, 841);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 49, 2353, 843);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 28, 2354, 844);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 37, 2355, 823);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 19, 2356, 836);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 36, 2357, 824);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 46, 2358, 821);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 31, 2359, 822);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 35, 2360, 805);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 43, 2361, 822);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 19, 2362, 837);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 33, 2363, 832);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 23, 2364, 806);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 28, 2365, 819);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 5, 2366, 816);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 27, 2367, 850);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 4, 2368, 811);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 39, 2369, 843);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 39, 2370, 837);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 45, 2371, 825);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 0, 2372, 850);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 5, 2373, 847);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 41, 2374, 805);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 23, 2375, 803);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 9, 2376, 828);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 41, 2377, 813);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 23, 2378, 837);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 36, 2379, 810);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 1, 2380, 818);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 5, 2381, 845);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 12, 2382, 843);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 50, 2383, 832);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 18, 2384, 811);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 43, 2385, 845);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 22, 2386, 815);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 29, 2387, 835);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 2, 2388, 844);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 18, 2389, 848);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 50, 2390, 844);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 33, 2391, 825);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 45, 2392, 828);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 5, 2393, 847);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 10, 2394, 827);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 38, 2395, 815);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 22, 2396, 848);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 21, 2397, 849);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 18, 2398, 824);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 8, 2399, 814);
prompt 400 records loaded
prompt Loading WORKERS...
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 8933, 'GAAD4Gvz@gmail.com', 526956196, 'Afternoon', 1, 'Elias Martin');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 8919, '6nH7yatv@gmail.com', 546597191, 'Evening', 2, 'Oliver Young');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 7696, 'gi7BAUJU@gmail.com', 531149208, 'Morning', 3, 'Jackson Murphy');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 11895, 'Y5kCLDmE@gmail.com', 539048194, 'Afternoon', 4, 'Elijah Robinson');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 8712, '1hYiTP6g@gmail.com', 536732435, 'Evening', 5, 'David Carter');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 14350, 'oiTZv76k@gmail.com', 571796738, 'Morning', 6, 'Claire Miller');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 14530, 'eZslowdS@gmail.com', 535796510, 'Evening', 7, 'Aurora Turner');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 10118, 'Jm4gMp5R@gmail.com', 569391226, 'Evening', 8, 'Emma Wright');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 10279, 'x4XJknNp@gmail.com', 572740432, 'Morning', 9, 'Amelia Campbell');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 12829, 'EsdgtOYs@gmail.com', 576945371, 'Morning', 10, 'Sophia King');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 9180, 'WCduuOBr@gmail.com', 536342312, 'Evening', 11, 'Olivia Scott');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 9575, 'UHRBwxhc@gmail.com', 509286034, 'Evening', 12, 'Harper Young');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 10727, 'A9qO1tjN@gmail.com', 595522957, 'Morning', 13, 'Henry Lopez');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 14402, '78OofnqK@gmail.com', 591200672, 'Afternoon', 14, 'Benjamin Hall');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 8113, '1gDaAeE9@gmail.com', 583586434, 'Afternoon', 15, 'William Jones');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 8609, 'TgXQrIAR@gmail.com', 552337692, 'Morning', 16, 'Sophia Anderson');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 12521, 'BwlXs3S0@gmail.com', 514103974, 'Afternoon', 17, 'Claire Miller');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 8627, 'IeI0C6pp@gmail.com', 529814090, 'Evening', 18, 'Elizabeth Lee');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 10277, 'YE1J0PXg@gmail.com', 508291301, 'Afternoon', 19, 'Avah Lewis');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 8961, 'pqMgEsc5@gmail.com', 504357854, 'Afternoon', 20, 'Luna Phillips');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 10323, 'PUFX199h@gmail.com', 572260269, 'Afternoon', 21, 'Violet Young');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 12730, 'PQrlU0DH@gmail.com', 503386039, 'Morning', 22, 'Avery Davis');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 9758, '8BCFLbEI@gmail.com', 533375134, 'Afternoon', 23, 'Oliver Turner');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 9366, 'An40xdkZ@gmail.com', 597321717, 'Afternoon', 24, 'Aaliyah Carter');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 10977, 'm20jWqa7@gmail.com', 557836241, 'Evening', 25, 'Harper Baker');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 7695, 'AiX7Iylg@gmail.com', 565811105, 'Evening', 26, 'Amelia Diaz');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 12888, 'xIo5Rzc4@gmail.com', 591157312, 'Afternoon', 27, 'Isabella Wright');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 8811, 'aR6JSBjz@gmail.com', 548441159, 'Afternoon', 28, 'Liam Nelson');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 12976, 'vyTAEOkY@gmail.com', 562938459, 'Afternoon', 29, 'Liam Smith');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 11248, 'LXPribsA@gmail.com', 528746755, 'Afternoon', 30, 'Aaliyah Hernandez');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 11178, 'V463Osef@gmail.com', 582066880, 'Morning', 31, 'Liam Young');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 8575, '96k9xQ2o@gmail.com', 538201036, 'Evening', 32, 'Abigail Moore');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 7938, 'L1E3kf4V@gmail.com', 570649166, 'Evening', 33, 'Liam Phillips');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 12484, 'W2XH0zYT@gmail.com', 559682130, 'Evening', 34, 'Evelyn Campbell');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 13711, 'TwnwCmkt@gmail.com', 542467998, 'Morning', 35, 'Mason Miller');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 9309, 'yrybonQD@gmail.com', 576716252, 'Morning', 36, 'Abigail Walker');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 12978, 'jP8RHiOr@gmail.com', 562485543, 'Morning', 37, 'Elizabeth Scott');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 9586, 'y33H0Fak@gmail.com', 531392041, 'Evening', 38, 'William Jones');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 9464, 'c6hSZvJG@gmail.com', 519970445, 'Evening', 39, 'William Rodriguez');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 10961, 'tamyBCgo@gmail.com', 550479868, 'Afternoon', 40, 'Ava Wright');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 13431, 'rEvppcLv@gmail.com', 522955072, 'Afternoon', 41, 'Evelyn Rodriguez');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 13288, '8Vp9sFwY@gmail.com', 577536719, 'Afternoon', 42, 'Elijah Wood');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 12635, 'j5c9aE2Y@gmail.com', 563747501, 'Evening', 43, 'Jackson Bell');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 12807, 'LpC6obrr@gmail.com', 525879367, 'Evening', 44, 'James Campbell');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 13882, 'fr07YdqE@gmail.com', 538306078, 'Morning', 45, 'Camila Young');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 14161, 'R7tQK1Sr@gmail.com', 526704387, 'Morning', 46, 'Mateo Robinson');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 13351, 'dgz3BOmZ@gmail.com', 518269520, 'Afternoon', 47, 'Alexander Mitchell');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 10789, 'j4CbgqnF@gmail.com', 558056698, 'Morning', 48, 'Henry Scott');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 14772, 'moQMLCBt@gmail.com', 599394146, 'Afternoon', 49, 'Lucas Wright');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 9844, '2hBAWI0n@gmail.com', 554253415, 'Morning', 50, 'Mason Diaz');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 9148, 'BX18EyNn@gmail.com', 509320960, 'Morning', 51, 'Harper Clark');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 11269, '1sqQ1w5V@gmail.com', 515633392, 'Afternoon', 52, 'Lucas Miller');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 9533, 'LY7TfiiT@gmail.com', 506938505, 'Evening', 53, 'Benjamin Walker');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 9326, 'LBEDM70b@gmail.com', 589856059, 'Morning', 54, 'Charlotte Allen');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 11630, 'yo7rv2m3@gmail.com', 560529370, 'Morning', 55, 'Mia Martin');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 11774, 'OMBpYwxP@gmail.com', 584697110, 'Afternoon', 56, 'William Williams');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 10975, 'cIRI8C7I@gmail.com', 517804862, 'Evening', 57, 'Liam Moore');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 8665, 'ZQzzg1z8@gmail.com', 514869393, 'Morning', 58, 'Charlotte Robinson');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 7683, '1aEjz3kV@gmail.com', 530469739, 'Evening', 59, 'Benjamin Campbell');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 8374, 'Y3KC4Cwy@gmail.com', 514138556, 'Evening', 60, 'Avery Diaz');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 11220, 'ZeJhzX67@gmail.com', 533642917, 'Afternoon', 61, 'Avery Allen');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 13886, 'ZL0p4XNn@gmail.com', 551519517, 'Afternoon', 62, 'Benjamin Wright');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 10830, 'z2VMinVL@gmail.com', 556545258, 'Morning', 63, 'Michael Robinson');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 8913, '2OnnjRrd@gmail.com', 559270669, 'Evening', 64, 'Emma Johnson');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 7527, 'jE3hUxyX@gmail.com', 571219730, 'Afternoon', 65, 'Julian Hall');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 9932, 'QaxWvBKD@gmail.com', 576451537, 'Evening', 66, 'Julian Harris');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 12215, 'wMZR4ZpO@gmail.com', 581288119, 'Afternoon', 67, 'Michael Rodriguez');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 12170, 'mbvL0VI6@gmail.com', 578763693, 'Evening', 68, 'Sofia Thomas');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 10540, 'zsGxd509@gmail.com', 518611303, 'Morning', 69, 'Charlotte Hall');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 10511, 'PdtASed0@gmail.com', 593795124, 'Morning', 70, 'Sofia Wright');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 13331, 'gMhuzYc0@gmail.com', 505817467, 'Morning', 71, 'Noah Rodriguez');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 14284, 'g9qHbSom@gmail.com', 506487681, 'Afternoon', 72, 'Charlotte Lewis');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 9945, 'b28ERxnM@gmail.com', 535336993, 'Evening', 73, 'Noah Young');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 14524, 'UVWpEaTp@gmail.com', 579430329, 'Morning', 74, 'Evelyn Wright');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 8497, 's2af13fR@gmail.com', 541135262, 'Afternoon', 75, 'Sophia Williams');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 11077, 'FqYIP34w@gmail.com', 516256511, 'Afternoon', 76, 'Mason Murphy');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 12885, 'AzIy1pPl@gmail.com', 559027760, 'Morning', 77, 'Elias Gonzalez');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 8059, '3lBcPXTY@gmail.com', 558713988, 'Evening', 78, 'James Wood');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 12201, 'tEXa18Z0@gmail.com', 565641120, 'Morning', 79, 'Mason Walker');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 8051, 'YnbzsL8k@gmail.com', 514677999, 'Morning', 80, 'Lucas Green');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 10016, '6vuL1i45@gmail.com', 592891900, 'Morning', 81, 'Camila Robinson');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 11313, 'R3XSwBgh@gmail.com', 534674181, 'Evening', 82, 'James Moore');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 13596, '1S7eqI8N@gmail.com', 527521685, 'Afternoon', 83, 'Aaliyah Gonzalez');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 13673, 'iiA9miYG@gmail.com', 590019845, 'Morning', 84, 'Liam Davis');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 8972, 'huBX75Wh@gmail.com', 513678912, 'Morning', 85, 'Evelyn Diaz');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 9461, 'EMGWCTS5@gmail.com', 589669940, 'Afternoon', 86, 'Liam Garcia');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 14540, 'oz8Nb2bz@gmail.com', 557015726, 'Evening', 87, 'Charlotte Phillips');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 9141, '4kl334Bn@gmail.com', 531052830, 'Afternoon', 88, 'Mason Phillips');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 13732, 'yMVMCZ7h@gmail.com', 555702962, 'Evening', 89, 'William Murphy');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 12031, '5f1WD2Xo@gmail.com', 511894314, 'Afternoon', 90, 'Avery Lewis');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 12448, '4Wu71MDW@gmail.com', 578702453, 'Afternoon', 91, 'Amelia Rodriguez');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 10246, 'XMCOe0fe@gmail.com', 594196850, 'Afternoon', 92, 'James Thomas');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 10278, 'oFS0IBpL@gmail.com', 591233538, 'Evening', 93, 'Emily Lopez');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 7806, 'VDNcyBOx@gmail.com', 536391125, 'Evening', 94, 'Charlotte Young');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 9260, 'rDjEC4YH@gmail.com', 573536531, 'Afternoon', 95, 'Aaliyah Lewis');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 14311, 'Ddz5l3nJ@gmail.com', 515834600, 'Evening', 96, 'Mia Nelson');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 13960, 'TSDFFn7m@gmail.com', 518387970, 'Afternoon', 97, 'Evelyn Smith');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 13827, 'IliqJvrF@gmail.com', 520689705, 'Morning', 98, 'Sophia Scott');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 8713, 'vN40wQJS@gmail.com', 592974002, 'Morning', 99, 'Zoe King');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 14283, 'vYFi1BNC@gmail.com', 586450881, 'Morning', 100, 'Mason Thomas');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 8072, 'UT4TU1O0@gmail.com', 574137010, 'Evening', 101, 'Elizabeth Cruz');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 8325, 'UiUYf8Kr@gmail.com', 555217403, 'Afternoon', 102, 'Evelyn Baker');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 14993, 'wR9vUehQ@gmail.com', 509569472, 'Evening', 103, 'Alexander Clark');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 12603, 'OeJNOmXf@gmail.com', 524097816, 'Morning', 104, 'Sophia Harris');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 14802, 'clAJN0Nh@gmail.com', 534741037, 'Evening', 105, 'Evelyn Turner');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 14625, 'G0uVF44A@gmail.com', 545070072, 'Afternoon', 106, 'Mia Hall');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 8656, 'RGAB4ucq@gmail.com', 501126493, 'Afternoon', 107, 'Mason Scott');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 14090, 'TYgdOxLE@gmail.com', 548989383, 'Morning', 108, 'Ethan Harris');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 14746, 'aGUQeB5c@gmail.com', 555318955, 'Afternoon', 109, 'Jackson Clark');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 12923, 'XWUIykwf@gmail.com', 565578192, 'Afternoon', 110, 'Ethan Adams');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 10984, 'qfwMbMps@gmail.com', 518829946, 'Morning', 111, 'Evelyn Roberts');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 13586, 'aws8ige6@gmail.com', 527584920, 'Afternoon', 112, 'Lucas Bell');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 14429, 'aYZ6sirl@gmail.com', 582531445, 'Evening', 113, 'Logan Young');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 13857, 'jNnxEo0t@gmail.com', 595609972, 'Afternoon', 114, 'Zoe Harris');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 9403, 'JMRhxR4E@gmail.com', 512946955, 'Afternoon', 115, 'Sophia Moore');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 9912, 'WpbRE2Bg@gmail.com', 528942704, 'Afternoon', 116, 'Aurora Wilson');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 8570, 'SydIGlDu@gmail.com', 573069644, 'Afternoon', 117, 'Luna Moore');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 10361, 'xomIejjz@gmail.com', 543442604, 'Afternoon', 118, 'Oliver Wilson');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 13270, 'srcIaymu@gmail.com', 531311411, 'Morning', 119, 'Claire Moore');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 9735, 'bhMGH8Ps@gmail.com', 546038928, 'Morning', 120, 'Ethan Jackson');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 8371, 'eAajFqMr@gmail.com', 517544772, 'Afternoon', 121, 'Jackson Lee');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 10085, 'Q9v3OY7v@gmail.com', 590831902, 'Afternoon', 122, 'Maverick Thomas');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 11553, 'xlUR5WMd@gmail.com', 574811782, 'Evening', 123, 'Charlotte Brown');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 7815, 'aZ1FtSUv@gmail.com', 566142031, 'Evening', 124, 'Scarlett Lewis');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 9487, 'AZFIAUPh@gmail.com', 586384716, 'Morning', 125, 'Ethan Moore');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 13483, 'tgyP87nU@gmail.com', 566625064, 'Morning', 126, 'Mason Johnson');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 13319, 'cZbJD4ZV@gmail.com', 541758860, 'Morning', 127, 'Harper Allen');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 12537, '8DI1thph@gmail.com', 505065140, 'Morning', 128, 'Scarlett Allen');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 13783, 'IEK1LKdt@gmail.com', 596851087, 'Evening', 129, 'Lucas Campbell');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 13250, 'ivjD1J4C@gmail.com', 589054493, 'Morning', 130, 'Ella Thomas');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 11717, 'VlsjjorT@gmail.com', 595616828, 'Morning', 131, 'Emma Hernandez');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 8807, 'rPPxv09W@gmail.com', 592759653, 'Afternoon', 132, 'Mason Young');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 8994, 'k4MydnyK@gmail.com', 511439653, 'Afternoon', 133, 'Avery Johnson');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 11320, 'ucGpH8gv@gmail.com', 544503063, 'Morning', 134, 'Matthew Davis');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 7850, 'agKPJ3wb@gmail.com', 542738027, 'Afternoon', 135, 'Ethan Robinson');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 11209, 'nHwPrbmO@gmail.com', 584238863, 'Morning', 136, 'Logan Allen');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 12511, 'xs4zal62@gmail.com', 560033171, 'Evening', 137, 'Mason Scott');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 11966, 'zxx8ybq2@gmail.com', 504085308, 'Afternoon', 138, 'Ella Turner');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 12619, 'vZHo0yRM@gmail.com', 558600621, 'Evening', 139, 'Mason Lopez');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 13858, 'vsU037yi@gmail.com', 570833546, 'Afternoon', 140, 'Aaliyah Walker');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 11922, 'JMqdDBMT@gmail.com', 537566076, 'Evening', 141, 'Olivia Mitchell');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 13432, 'pJPqEnHH@gmail.com', 537021434, 'Afternoon', 142, 'Ethan Nelson');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 12410, 'EFUAeDcN@gmail.com', 548756040, 'Morning', 143, 'Alexander Miller');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 13302, 'sDXsGKz7@gmail.com', 586233230, 'Morning', 144, 'Mason King');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 8613, 'I7HPYKIv@gmail.com', 560352029, 'Afternoon', 145, 'Ethan Hall');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 13734, 'pML4bvqf@gmail.com', 565054766, 'Morning', 146, 'Elias Carter');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 10805, '54iAcoEo@gmail.com', 596145348, 'Afternoon', 147, 'Emily Turner');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 11703, 'lWCpHFXn@gmail.com', 559362076, 'Evening', 148, 'Charlotte Rodriguez');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 14417, 'LaPkhLQz@gmail.com', 575258169, 'Morning', 149, 'Mason Clark');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 12917, 'WxnydswT@gmail.com', 527595994, 'Afternoon', 150, 'Elias Miller');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 12555, 'lgolGf2Y@gmail.com', 525772289, 'Afternoon', 151, 'James Carter');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 11227, 'If2sIZSO@gmail.com', 544766314, 'Afternoon', 152, 'Charlotte Hall');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 12294, 'vTyQEpqy@gmail.com', 534884493, 'Evening', 153, 'Oliver Davis');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 13593, 'Wk1Ilwzs@gmail.com', 597121496, 'Morning', 154, 'Emma Turner');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 12565, 'F5GvjfaO@gmail.com', 594766367, 'Morning', 155, 'Liam Moore');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 7814, 'j9jLB4Hv@gmail.com', 574160322, 'Afternoon', 156, 'James Garcia');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 11328, 'vxEoIODK@gmail.com', 527686916, 'Afternoon', 157, 'Mason Jackson');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 13848, '09bBLCcP@gmail.com', 562694889, 'Morning', 158, 'Mason Lee');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 10780, '0V5RCVD8@gmail.com', 577044786, 'Afternoon', 159, 'Avah Robinson');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 8015, 'CQyYvjmI@gmail.com', 523297388, 'Morning', 160, 'Abigail Young');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 14720, 'aoleN6Vt@gmail.com', 509334722, 'Morning', 161, 'William Moore');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 12022, 'HV1XooNy@gmail.com', 513601393, 'Afternoon', 162, 'William Walker');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 10223, '0ZxDdRwA@gmail.com', 507855207, 'Evening', 163, 'Ethan Hernandez');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 13575, 'G58rumS1@gmail.com', 533322083, 'Afternoon', 164, 'Olivia Green');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 9174, 'GooEaANg@gmail.com', 527399786, 'Afternoon', 165, 'Evelyn Diaz');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 14644, '6LlVevcq@gmail.com', 513149746, 'Evening', 166, 'Stella Rodriguez');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 9336, 'QVsHI8BY@gmail.com', 546426321, 'Afternoon', 167, 'Avery Walker');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 9253, 'a1biOq9X@gmail.com', 525700652, 'Afternoon', 168, 'Avah Davis');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 8914, 'VWflwFhY@gmail.com', 532528104, 'Evening', 169, 'Lucas Walker');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 14797, 'yptSwt2n@gmail.com', 553610071, 'Evening', 170, 'William Clark');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 10163, 'jeEdXLde@gmail.com', 505214713, 'Evening', 171, 'Mason Scott');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 7650, 'EV2GPBGD@gmail.com', 563189422, 'Morning', 172, 'Jackson Diaz');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 12444, 'fRfEc48B@gmail.com', 591574501, 'Evening', 173, 'Henry Davis');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 11515, 'fB3pXp5X@gmail.com', 510343881, 'Morning', 174, 'Emma Clark');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 11745, 'C1eJDe9d@gmail.com', 517188523, 'Evening', 175, 'Isabella Allen');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 10706, 'Nh6euYyz@gmail.com', 512850072, 'Afternoon', 176, 'Ava Wright');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 9466, 'IAKsJUuX@gmail.com', 506139868, 'Afternoon', 177, 'Emily Phillips');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 11132, 'xd1DVx7G@gmail.com', 517827818, 'Afternoon', 178, 'Elijah Allen');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 11216, '1YvanWcs@gmail.com', 527082662, 'Afternoon', 179, 'Ava Lopez');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 12052, 'qLuHEmxt@gmail.com', 575352411, 'Morning', 180, 'David Allen');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 9791, 'Sse3B30V@gmail.com', 506840153, 'Afternoon', 181, 'James Roberts');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 12863, '15Kj3rKL@gmail.com', 578405706, 'Evening', 182, 'Noah Anderson');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 13017, 'Du7es9Vi@gmail.com', 560462040, 'Morning', 183, 'Liam Roberts');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 7634, 'E3jatcrq@gmail.com', 528570438, 'Evening', 184, 'Alexander Wright');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 13286, 'zvNKJpct@gmail.com', 596291725, 'Afternoon', 185, 'Lucas Campbell');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 7800, '3VyXMrJI@gmail.com', 566764860, 'Afternoon', 186, 'Logan Hall');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 14213, 'epsYzeoF@gmail.com', 533303640, 'Morning', 187, 'Noah Garcia');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 13598, 'cq9RuSZY@gmail.com', 590571518, 'Morning', 188, 'Mason Williams');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 12204, 'JOILxHhW@gmail.com', 516385582, 'Afternoon', 189, 'Lucas Robinson');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 13835, 'fPmwCbFX@gmail.com', 558461953, 'Morning', 190, 'Mia Garcia');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 8696, 'oyCZpce5@gmail.com', 528718737, 'Morning', 191, 'Emma Clark');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 13411, 'Gb0pNOAc@gmail.com', 542487569, 'Evening', 192, 'Sophia Phillips');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 8385, 'bLCXDjJj@gmail.com', 524998883, 'Afternoon', 193, 'Aaliyah Lee');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 12813, 'eQxsMA9I@gmail.com', 575134006, 'Afternoon', 194, 'Alexander Nelson');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 9990, 'SIItpMkl@gmail.com', 561817795, 'Morning', 195, 'Logan Harris');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 8079, '2V7QmuiF@gmail.com', 534931109, 'Morning', 196, 'Ava Miller');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 11268, 'El96HfMS@gmail.com', 500409706, 'Morning', 197, 'Sofia Lewis');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 7736, 'oxYWZ70x@gmail.com', 531691969, 'Evening', 198, 'Violet Miller');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 11222, 'ncYwERq3@gmail.com', 553931039, 'Morning', 199, 'Lucas Williams');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 8631, 'rpKkYKgY@gmail.com', 562634725, 'Morning', 200, 'Logan Gonzalez');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 13939, 'AwOXCzWZ@gmail.com', 574218628, 'Afternoon', 201, 'Amelia Hall');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 13874, 'svWZ7714@gmail.com', 508026335, 'Evening', 202, 'Oliver Garcia');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 12776, 'jPqXIQLE@gmail.com', 526015865, 'Morning', 203, 'Camila Thomas');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 8489, 'eZwpJHgi@gmail.com', 592889041, 'Afternoon', 204, 'Liam Miller');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 10809, 'kPAEStkz@gmail.com', 579243132, 'Afternoon', 205, 'Luna Robinson');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 8839, 'SyE1GHP9@gmail.com', 588095528, 'Evening', 206, 'Elijah Robinson');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 9726, 'hiULWto3@gmail.com', 577369574, 'Afternoon', 207, 'Alexander Clark');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 9735, 'QyTXC6lB@gmail.com', 512228547, 'Afternoon', 208, 'Harper Lewis');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 9998, '9vBXK02L@gmail.com', 519766797, 'Afternoon', 209, 'Violet Lewis');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 8916, 'SVOw5bN2@gmail.com', 589811074, 'Afternoon', 210, 'Ella Robinson');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 13459, 'XUd2wzmZ@gmail.com', 571386119, 'Afternoon', 211, 'Sophia Allen');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 9847, 'aLVYLpGc@gmail.com', 525483933, 'Morning', 212, 'Emily Lee');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 9284, 'dAraXMZi@gmail.com', 528757463, 'Morning', 213, 'Emily Baker');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 11263, 'pl7oRCHj@gmail.com', 591132607, 'Evening', 214, 'Charlotte Hernandez');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 11256, '7ipiuIGo@gmail.com', 529988373, 'Morning', 215, 'Ava Roberts');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 10188, 'ulG9z5kA@gmail.com', 532130221, 'Evening', 216, 'Ava Harris');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 7979, 'WH8peg4h@gmail.com', 541159511, 'Morning', 217, 'Ella Hall');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 7552, '6mmev0SD@gmail.com', 574913325, 'Evening', 218, 'Amelia King');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 13931, 'qPK7uXjo@gmail.com', 594141307, 'Morning', 219, 'Elias Clark');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 12364, 'NP2YKEOh@gmail.com', 503691848, 'Evening', 220, 'Lucas Robinson');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 11223, 'cnF0Q8r4@gmail.com', 580303312, 'Evening', 221, 'Mason Robinson');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 12523, 'B0wc6qpu@gmail.com', 528715481, 'Afternoon', 222, 'Emily Bell');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 13443, 'z14fOBcW@gmail.com', 525309009, 'Morning', 223, 'Noah Scott');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 13648, 'NU7sEQIj@gmail.com', 510126263, 'Afternoon', 224, 'Henry Lopez');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 9410, 'OlpBc5Xe@gmail.com', 536192517, 'Morning', 225, 'Harper Young');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 13074, 'lXG8nerh@gmail.com', 548228870, 'Morning', 226, 'Ethan Lewis');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 12826, '1ifGUc4B@gmail.com', 547207818, 'Afternoon', 227, 'Avery Rodriguez');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 14517, 'gT4Z3UwM@gmail.com', 571952438, 'Afternoon', 228, 'Charlotte Nelson');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 13919, 'XwwLVDue@gmail.com', 550179038, 'Afternoon', 229, 'Ava Robinson');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 12731, 'BAVz1ro4@gmail.com', 567050759, 'Evening', 230, 'James Clark');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 8616, 'ErJowWVj@gmail.com', 555868937, 'Morning', 231, 'Evelyn Hernandez');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 10494, '4ic3eaE7@gmail.com', 511668852, 'Morning', 232, 'Liam Hall');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 13829, 'nNr3DldY@gmail.com', 580066010, 'Afternoon', 233, 'Avery Carter');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 14582, 'MvkGvUk1@gmail.com', 569188160, 'Evening', 234, 'Levi Walker');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 12241, 'kZZ5j66z@gmail.com', 554897172, 'Morning', 235, 'Zoe Young');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 10535, 'BanWriSM@gmail.com', 577858680, 'Evening', 236, 'Abigail Harris');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 9739, 'UQ5TiUQL@gmail.com', 579261307, 'Evening', 237, 'Abigail Williams');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 9220, '2Rs1uQoO@gmail.com', 570276583, 'Afternoon', 238, 'Henry Hall');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 10004, 'PNV4RoPf@gmail.com', 592218810, 'Afternoon', 239, 'James Moore');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 9475, 'ZsKVuZcW@gmail.com', 581838870, 'Afternoon', 240, 'Isabella Clark');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 11289, 'dIsU4JYG@gmail.com', 598376687, 'Evening', 241, 'William Brown');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 12949, 's7gdMvhE@gmail.com', 567889508, 'Afternoon', 242, 'Ella Hernandez');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 8433, 'hS8ZfmOF@gmail.com', 534110452, 'Evening', 243, 'Evelyn Garcia');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 8098, 'OWzpY2V1@gmail.com', 506705567, 'Morning', 244, 'Ethan Garcia');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 13847, 'yoPGV1cr@gmail.com', 528977163, 'Evening', 245, 'Violet Nelson');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 13986, 'yt1UpmBy@gmail.com', 544910231, 'Evening', 246, 'Alexander Moore');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 13571, 'S2tejpIh@gmail.com', 520022597, 'Evening', 247, 'Elijah Young');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 8478, 'gI76Rufv@gmail.com', 531383560, 'Afternoon', 248, 'Isabella Campbell');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 14112, '5mXEvkUZ@gmail.com', 559346498, 'Afternoon', 249, 'Liam Pierce');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 11721, 'sNsdC7sc@gmail.com', 589537870, 'Morning', 250, 'Logan Allen');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 7576, 'F3ivUYE2@gmail.com', 547593159, 'Evening', 251, 'Evelyn Wilson');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 10006, '7wLDHASG@gmail.com', 540415830, 'Morning', 252, 'Alexander Wright');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 13065, 'Bj1WDAV9@gmail.com', 559828330, 'Evening', 253, 'Claire Lewis');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 14684, '78qrfTPG@gmail.com', 563886939, 'Evening', 254, 'Elijah Wright');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 12550, 'X1bCvrA0@gmail.com', 577713103, 'Morning', 255, 'Evelyn Moore');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 13183, '1MZi0zES@gmail.com', 572292450, 'Morning', 256, 'Mason Nelson');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 11929, 'wjayEG9a@gmail.com', 542436459, 'Morning', 257, 'Ava Garcia');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 8285, '5YM23Phy@gmail.com', 566109080, 'Afternoon', 258, 'Ava Smith');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 8673, '7fysTn9q@gmail.com', 569388320, 'Morning', 259, 'Noah Robinson');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 13564, 'YtRNzE95@gmail.com', 515336181, 'Afternoon', 260, 'Amelia Scott');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 10905, 'ZgOCD7mK@gmail.com', 557732368, 'Afternoon', 261, 'Claire Nelson');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 12531, 'fQoSKNlq@gmail.com', 590957961, 'Afternoon', 262, 'Henry Walker');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 14310, 'n0GNo1C5@gmail.com', 591147522, 'Morning', 263, 'Mateo Scott');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 12651, '7oshZjvY@gmail.com', 557662005, 'Afternoon', 264, 'Noah Adams');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 10483, 'i4p5S5ph@gmail.com', 586488440, 'Morning', 265, 'Ethan Young');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 12167, 'VWQ7pIvC@gmail.com', 546026199, 'Afternoon', 266, 'Logan Wood');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 13115, 'FMtVD4mL@gmail.com', 533068166, 'Morning', 267, 'Oliver Anderson');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 14260, 'pJkHXxo7@gmail.com', 575733860, 'Morning', 268, 'Mason Lewis');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 11521, 'Pwbtidb5@gmail.com', 532540716, 'Morning', 269, 'Aaliyah Scott');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 14058, 'zNgTfUJB@gmail.com', 511838668, 'Morning', 270, 'Scarlett Williams');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 11816, 'zugoH8YT@gmail.com', 598230508, 'Afternoon', 271, 'Elijah Walker');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 8406, '3v7yUitg@gmail.com', 536387642, 'Morning', 272, 'Isabella Davis');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 11015, 'y3fARtvX@gmail.com', 548006453, 'Morning', 273, 'Elijah Diaz');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 10981, '3SPWqyxT@gmail.com', 587853962, 'Evening', 274, 'Abigail Nelson');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 10827, '7BPE475D@gmail.com', 520756674, 'Evening', 275, 'Noah Scott');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 9201, '4oVEzN7D@gmail.com', 584091607, 'Morning', 276, 'Harper Robinson');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 10534, '73CNXgLe@gmail.com', 573579439, 'Afternoon', 277, 'Elijah Turner');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 9310, 'e088K4ub@gmail.com', 554122833, 'Morning', 278, 'Aurora Jones');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 8819, 'e2HoJDXL@gmail.com', 590104781, 'Afternoon', 279, 'Mason Carter');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 10153, 'gSCJQDC9@gmail.com', 595217872, 'Morning', 280, 'Abigail Nelson');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 12699, 'BUl9qC0N@gmail.com', 567653563, 'Morning', 281, 'Evelyn Rodriguez');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 14983, 'ouDk88o5@gmail.com', 577958343, 'Evening', 282, 'Abigail Robinson');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 10818, 'ZDacUbuX@gmail.com', 571561354, 'Evening', 283, 'Amelia Pierce');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 14277, 'wTA5V7Fv@gmail.com', 528898041, 'Evening', 284, 'Avah Brown');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 10623, 'EWbd0j05@gmail.com', 506839883, 'Evening', 285, 'Logan Hernandez');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 14078, 'LoXInppJ@gmail.com', 578454668, 'Evening', 286, 'Levi Lewis');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 11617, 'qKTjenvZ@gmail.com', 594965585, 'Morning', 287, 'Mason Murphy');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 10332, '4AdEhwEm@gmail.com', 555498620, 'Afternoon', 288, 'Alexander Davis');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 8704, 'HDgBIXGB@gmail.com', 569402622, 'Afternoon', 289, 'Aurora Harris');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 10956, 'WLI8MrrN@gmail.com', 554160845, 'Evening', 290, 'Michael Garcia');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 14451, 'XSwBn6TI@gmail.com', 528560931, 'Evening', 291, 'William Garcia');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 12468, 'J8ygK8VI@gmail.com', 575459032, 'Morning', 292, 'Jackson Miller');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 11608, 'Ntqah4QO@gmail.com', 548998380, 'Afternoon', 293, 'Mason Wright');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 8956, 'YneYvek9@gmail.com', 515055408, 'Evening', 294, 'Harper Lewis');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 8094, 'UAUagf14@gmail.com', 534419887, 'Morning', 295, 'Liam Thomas');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 9253, 'EAqRLWEb@gmail.com', 514139407, 'Afternoon', 296, 'Amelia Carter');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 10652, '2vcE6gcn@gmail.com', 592308752, 'Evening', 297, 'Logan Young');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 12670, 'ZYwRHByt@gmail.com', 538598018, 'Morning', 298, 'Amelia Miller');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 8124, 'olmJ4R3f@gmail.com', 598403828, 'Afternoon', 299, 'William Scott');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 12845, 'axg609LC@gmail.com', 579702487, 'Afternoon', 300, 'Matthew Robinson');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 14016, 'fcjcrRPC@gmail.com', 582897136, 'Evening', 301, 'James Allen');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 8438, 'tB4JTkwK@gmail.com', 542834118, 'Evening', 302, 'Liam Young');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 9500, 'kPD4NLhO@gmail.com', 542289097, 'Afternoon', 303, 'Michael Walker');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 8961, 'bYkes5g2@gmail.com', 594398213, 'Evening', 304, 'Charlotte Wright');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 12838, 'XXrYMfLK@gmail.com', 556321193, 'Morning', 305, 'Charlotte Diaz');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 10403, 't3vI17jv@gmail.com', 556859495, 'Evening', 306, 'James Scott');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 14451, 'oWl4bGkg@gmail.com', 592962119, 'Afternoon', 307, 'Olivia Lee');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 12144, 'glyekcR9@gmail.com', 593438995, 'Morning', 308, 'Zoe Young');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 9602, 'axmujlTH@gmail.com', 526872014, 'Afternoon', 309, 'Elijah Scott');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 13431, 'QbFrgMIl@gmail.com', 539648744, 'Afternoon', 310, 'Sophia Lewis');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 14136, 'Hb09H3KW@gmail.com', 568019358, 'Afternoon', 311, 'Mason Walker');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 10706, 'ltHjHuun@gmail.com', 590862113, 'Morning', 312, 'Mia Lee');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 11556, 'dLlGdODf@gmail.com', 591467756, 'Morning', 313, 'Mason Mitchell');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 8363, 'mOwFDV6g@gmail.com', 513199101, 'Evening', 314, 'Noah Hall');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 8122, 'A4nGnp1S@gmail.com', 516364296, 'Morning', 315, 'Harper Carter');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 13267, 'SEerS3Rr@gmail.com', 567924958, 'Morning', 316, 'Amelia Moore');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 9618, '5EFoqgKz@gmail.com', 596620804, 'Morning', 317, 'Amelia Moore');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 12514, 'L01hqvkR@gmail.com', 542440874, 'Evening', 318, 'Charlotte Lopez');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 14084, 'fZLUoxHh@gmail.com', 587109577, 'Evening', 319, 'James Moore');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 10979, 'jEHxNwk0@gmail.com', 569587843, 'Morning', 320, 'Evelyn Rodriguez');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 7755, '3faVsfLj@gmail.com', 590894657, 'Afternoon', 321, 'Charlotte Hall');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 8069, '0zf6SmIz@gmail.com', 501040878, 'Evening', 322, 'Scarlett Sanchez');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 14373, 'aUkJHEDA@gmail.com', 559079275, 'Evening', 323, 'Jackson Adams');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 14851, 'O6fYRwF1@gmail.com', 528031003, 'Morning', 324, 'Elijah Harris');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 10739, 'gkqMbxdr@gmail.com', 507155069, 'Afternoon', 325, 'Noah Diaz');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 11490, 'IPPTfI7v@gmail.com', 525547330, 'Morning', 326, 'Violet Walker');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 9024, 'kNMBdakM@gmail.com', 557583004, 'Evening', 327, 'Ava Scott');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 10337, '5nBtbJz0@gmail.com', 542438189, 'Afternoon', 328, 'Sofia Scott');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 14163, '5JesFpQ2@gmail.com', 523023839, 'Morning', 329, 'Avery Jones');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 10693, 'E06imdQO@gmail.com', 581097012, 'Afternoon', 330, 'Amelia Young');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 12808, 'oVuOgj1n@gmail.com', 526650083, 'Afternoon', 331, 'Evelyn Moore');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 8295, 'ONLZCxI9@gmail.com', 569256757, 'Morning', 332, 'Luna Phillips');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 7578, 'm5wWgZNn@gmail.com', 588967892, 'Afternoon', 333, 'James Wright');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 13078, 'L5a1AmxO@gmail.com', 529437123, 'Morning', 334, 'Mateo Harris');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 8432, '24OsitCY@gmail.com', 524796363, 'Morning', 335, 'Avah Robinson');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 13412, 'h1nSenl1@gmail.com', 538066996, 'Afternoon', 336, 'Evelyn Wright');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 12321, 'PG7Wm3M5@gmail.com', 502971717, 'Afternoon', 337, 'Harper Phillips');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 7600, 'u43EI0Kt@gmail.com', 569442839, 'Morning', 338, 'Charlotte Garcia');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 14970, 'Q8Xgd3IP@gmail.com', 560797933, 'Afternoon', 339, 'Elizabeth King');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 8276, 'vtyUFiSo@gmail.com', 528431079, 'Evening', 340, 'Amelia Pierce');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 10932, 'YvSqAf1h@gmail.com', 541835259, 'Afternoon', 341, 'Amelia Green');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 13480, 'hYjJRn1E@gmail.com', 512881514, 'Morning', 342, 'Charlotte Lewis');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 12683, 'aTTT9QVf@gmail.com', 535597591, 'Morning', 343, 'Elijah Allen');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 9790, 'keCdwFJE@gmail.com', 581356571, 'Evening', 344, 'Noah Murphy');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 13457, 'FTXhOk4V@gmail.com', 508672051, 'Afternoon', 345, 'Emma Turner');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 11100, 'B8ojr5PU@gmail.com', 592310757, 'Morning', 346, 'Harper Bell');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 14518, 'oKnBTdVY@gmail.com', 559661771, 'Evening', 347, 'Elijah Phillips');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 14094, 'cwJigb05@gmail.com', 536065702, 'Evening', 348, 'Emily Wilson');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 9563, 'USbZscUt@gmail.com', 505104160, 'Afternoon', 349, 'Lucas Scott');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 13109, 'bjkuMA2b@gmail.com', 552979798, 'Afternoon', 350, 'Sophia Miller');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 9602, 'Zsw9tfSi@gmail.com', 539768121, 'Evening', 351, 'Amelia Hernandez');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 14967, 'iabiRyfK@gmail.com', 511197573, 'Evening', 352, 'James Robinson');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 8130, 'APY82YDE@gmail.com', 599565362, 'Afternoon', 353, 'Lucas Scott');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 10538, 'TqyI6rLz@gmail.com', 543251627, 'Afternoon', 354, 'Julian Nelson');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 12874, '3dXy9XcC@gmail.com', 514190728, 'Afternoon', 355, 'Penelope Nelson');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 10226, 'CdXNbZ6e@gmail.com', 567216812, 'Afternoon', 356, 'Lucas Bell');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 10144, 'TGAsCZsb@gmail.com', 552195398, 'Afternoon', 357, 'Mateo Campbell');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 8812, 'aTFmk2Vr@gmail.com', 506916652, 'Morning', 358, 'Sofia Moore');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 7505, 'YUXxDp8p@gmail.com', 532665232, 'Morning', 359, 'Abigail Rodriguez');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 8947, 'JlaFoxfF@gmail.com', 588426256, 'Morning', 360, 'Elijah Clark');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 11345, 'It9TwzTP@gmail.com', 507362202, 'Evening', 361, 'Evelyn Diaz');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 14478, 'ky9KCP5H@gmail.com', 583161545, 'Evening', 362, 'Violet Wright');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 10593, 'lpMrHB7V@gmail.com', 595570776, 'Evening', 363, 'Oliver Gonzalez');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 9848, 'XROc5Zko@gmail.com', 515884498, 'Evening', 364, 'Stella Lopez');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 9071, 'RyCRF4fn@gmail.com', 524668969, 'Evening', 365, 'Alexander Diaz');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 7658, '7xZUUbNR@gmail.com', 540463916, 'Morning', 366, 'Camila Walker');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 11295, 'u89Cfmd8@gmail.com', 504254558, 'Morning', 367, 'Sofia Thomas');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 13309, 'L81Gkmp1@gmail.com', 501019696, 'Afternoon', 368, 'Emily Johnson');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 14048, '70cbwBca@gmail.com', 515042721, 'Morning', 369, 'Benjamin Moore');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 13695, 'WGSqXsO2@gmail.com', 500046415, 'Morning', 370, 'Ava Davis');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 14609, 'QOSvrh1r@gmail.com', 502776679, 'Morning', 371, 'Sophia Nelson');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 12950, 'A7kfOh7V@gmail.com', 527984176, 'Evening', 372, 'Layla Miller');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 11208, 'bP8ZZNbn@gmail.com', 591335142, 'Afternoon', 373, 'Mateo Allen');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 9092, 'lDx57p3s@gmail.com', 511729022, 'Morning', 374, 'Julian Pierce');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 10995, 'g5Hx7qCv@gmail.com', 596598587, 'Morning', 375, 'Evelyn Robinson');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 9579, '6UZpSdeG@gmail.com', 531347364, 'Evening', 376, 'Aaliyah Lewis');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 13829, 'n4J8tgWh@gmail.com', 594695462, 'Evening', 377, 'Ethan Clark');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 8060, 'Ac40NdiY@gmail.com', 536280685, 'Morning', 378, 'Harper Wright');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 11108, 'CMqwVbmj@gmail.com', 532415772, 'Evening', 379, 'Claire Rodriguez');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 12764, '4gWpq6Aq@gmail.com', 564311166, 'Afternoon', 380, 'Evelyn Lewis');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 11786, 'PE1IcXUk@gmail.com', 583541376, 'Afternoon', 381, 'Evelyn Clark');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 14709, 'oUGgwero@gmail.com', 593240846, 'Evening', 382, 'Ella Smith');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 9678, 'gzcqytz9@gmail.com', 591195411, 'Afternoon', 391, 'Evelyn Cruz');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 8419, '4gAOCGvY@gmail.com', 520820659, 'Morning', 392, 'Harper Moore');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 7788, 'j9jGVpkE@gmail.com', 583742734, 'Evening', 393, 'Isabella Garcia');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 7853, '43H2rpoa@gmail.com', 508996068, 'Afternoon', 394, 'Sophia Moore');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 11016, '0wjVxlQp@gmail.com', 504583403, 'Morning', 395, 'Luna Robinson');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 9458, 'HxKvLbhu@gmail.com', 583027794, 'Afternoon', 396, 'Noah Moore');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 8506, 'VZ66xbGU@gmail.com', 553864574, 'Morning', 397, 'Olivia Clark');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 11625, '4BVRYEYO@gmail.com', 588097735, 'Morning', 398, 'Stella Thomas');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 10117, 'Q8WCuvvG@gmail.com', 545871829, 'Evening', 399, 'Levi Carter');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 14744, 'KDRiP8Oh@gmail.com', 568170451, 'Evening', 400, 'Benjamin Clark');
prompt 392 records loaded
prompt Loading ORDERS...
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1893, to_date('17-03-2022', 'dd-mm-yyyy'), to_date('24-12-2021', 'dd-mm-yyyy'), 2000, 254, 833, 2381, 492);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1884, to_date('31-05-2023', 'dd-mm-yyyy'), to_date('06-04-2021', 'dd-mm-yyyy'), 2001, 225, 809, 2035, 724);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1733, to_date('27-10-2020', 'dd-mm-yyyy'), to_date('27-10-2023', 'dd-mm-yyyy'), 2002, 255, 811, 2226, 647);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1470, to_date('21-11-2023', 'dd-mm-yyyy'), to_date('11-08-2023', 'dd-mm-yyyy'), 2003, 84, 814, 2041, 770);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1324, to_date('10-04-2023', 'dd-mm-yyyy'), to_date('03-04-2023', 'dd-mm-yyyy'), 2004, 10, 826, 2294, 662);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1151, to_date('01-07-2020', 'dd-mm-yyyy'), to_date('31-08-2021', 'dd-mm-yyyy'), 2005, 73, 838, 2177, 540);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1462, to_date('21-10-2023', 'dd-mm-yyyy'), to_date('03-01-2020', 'dd-mm-yyyy'), 2006, 206, 803, 2103, 644);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1949, to_date('01-11-2021', 'dd-mm-yyyy'), to_date('09-12-2021', 'dd-mm-yyyy'), 2007, 113, 823, 2079, 662);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1361, to_date('20-04-2021', 'dd-mm-yyyy'), to_date('25-05-2023', 'dd-mm-yyyy'), 2008, 34, 813, 2193, 738);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1972, to_date('21-01-2023', 'dd-mm-yyyy'), to_date('23-08-2020', 'dd-mm-yyyy'), 2009, 339, 803, 2390, 544);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1032, to_date('20-12-2020', 'dd-mm-yyyy'), to_date('08-08-2023', 'dd-mm-yyyy'), 2010, 213, 817, 2175, 641);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1313, to_date('03-07-2023', 'dd-mm-yyyy'), to_date('12-06-2022', 'dd-mm-yyyy'), 2011, 191, 803, 2020, 423);
prompt 12 records loaded
prompt Loading PAYMENTS...
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('17-10-2021', 'dd-mm-yyyy'), 6, 'Paid', 'CreditCard', 1000, 692);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('14-09-2015', 'dd-mm-yyyy'), 9, 'Paid', 'CreditCard', 1001, 596);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('22-06-2013', 'dd-mm-yyyy'), 8, 'Paid', 'cash', 1002, 428);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('02-12-2007', 'dd-mm-yyyy'), 1, 'not paid', 'CreditCard', 1003, 569);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('14-01-2006', 'dd-mm-yyyy'), 7, 'not paid', 'CreditCard', 1004, 407);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('23-07-2011', 'dd-mm-yyyy'), 6, 'Paid', 'cash', 1005, 437);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('12-02-2022', 'dd-mm-yyyy'), 4, 'Paid', 'CreditCard', 1006, 716);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('23-07-2011', 'dd-mm-yyyy'), 5, 'Paid', 'cash', 1007, 424);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('16-02-2013', 'dd-mm-yyyy'), 4, 'Paid', 'bank transfer', 1008, 536);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('26-02-2017', 'dd-mm-yyyy'), 5, 'Paid', 'cash', 1009, 694);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('03-09-2020', 'dd-mm-yyyy'), 9, 'Paid', 'CreditCard', 1010, 747);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('06-04-2016', 'dd-mm-yyyy'), 1, 'not paid', 'cash', 1011, 489);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('10-12-2007', 'dd-mm-yyyy'), 3, 'not paid', 'bank transfer', 1012, 404);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('24-03-2020', 'dd-mm-yyyy'), 4, 'not paid', 'cash', 1013, 595);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('06-03-2008', 'dd-mm-yyyy'), 6, 'Paid', 'cash', 1014, 628);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('20-12-2009', 'dd-mm-yyyy'), 8, 'not paid', 'bank transfer', 1015, 455);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('06-12-2014', 'dd-mm-yyyy'), 10, 'Paid', 'cash', 1016, 474);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('18-06-2014', 'dd-mm-yyyy'), 10, 'Paid', 'CreditCard', 1017, 735);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('26-07-2011', 'dd-mm-yyyy'), 5, 'Paid', 'cash', 1018, 784);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('20-04-2008', 'dd-mm-yyyy'), 9, 'not paid', 'cash', 1019, 787);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('16-04-2023', 'dd-mm-yyyy'), 6, 'not paid', 'CreditCard', 1020, 747);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('25-08-2018', 'dd-mm-yyyy'), 3, 'Paid', 'bank transfer', 1021, 555);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('14-10-2009', 'dd-mm-yyyy'), 9, 'not paid', 'cash', 1022, 674);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('15-06-2023', 'dd-mm-yyyy'), 7, 'Paid', 'CreditCard', 1023, 708);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('01-02-2007', 'dd-mm-yyyy'), 5, 'not paid', 'bank transfer', 1024, 601);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('21-11-2014', 'dd-mm-yyyy'), 10, 'not paid', 'cash', 1025, 746);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('17-04-2009', 'dd-mm-yyyy'), 5, 'Paid', 'cash', 1026, 565);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('25-06-2014', 'dd-mm-yyyy'), 10, 'not paid', 'CreditCard', 1027, 407);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('03-01-2021', 'dd-mm-yyyy'), 10, 'Paid', 'cash', 1028, 409);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('02-11-2011', 'dd-mm-yyyy'), 9, 'not paid', 'bank transfer', 1029, 404);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('20-07-2005', 'dd-mm-yyyy'), 4, 'not paid', 'bank transfer', 1030, 728);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('17-06-2017', 'dd-mm-yyyy'), 6, 'Paid', 'bank transfer', 1031, 742);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('26-10-2008', 'dd-mm-yyyy'), 10, 'not paid', 'cash', 1032, 579);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('19-11-2023', 'dd-mm-yyyy'), 4, 'not paid', 'CreditCard', 1033, 440);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('09-04-2010', 'dd-mm-yyyy'), 10, 'Paid', 'cash', 1034, 585);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('15-12-2018', 'dd-mm-yyyy'), 7, 'Paid', 'cash', 1035, 593);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('13-10-2006', 'dd-mm-yyyy'), 5, 'not paid', 'bank transfer', 1036, 566);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('04-04-2022', 'dd-mm-yyyy'), 10, 'not paid', 'CreditCard', 1037, 481);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('21-01-2009', 'dd-mm-yyyy'), 5, 'Paid', 'bank transfer', 1038, 771);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('18-03-2021', 'dd-mm-yyyy'), 4, 'Paid', 'bank transfer', 1039, 554);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('16-03-2009', 'dd-mm-yyyy'), 3, 'Paid', 'CreditCard', 1040, 492);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('07-12-2018', 'dd-mm-yyyy'), 7, 'Paid', 'bank transfer', 1041, 559);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('26-02-2019', 'dd-mm-yyyy'), 10, 'Paid', 'cash', 1042, 422);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('11-07-2012', 'dd-mm-yyyy'), 6, 'not paid', 'bank transfer', 1043, 514);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('21-04-2008', 'dd-mm-yyyy'), 2, 'not paid', 'cash', 1044, 520);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('29-04-2009', 'dd-mm-yyyy'), 9, 'not paid', 'bank transfer', 1045, 634);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('17-12-2021', 'dd-mm-yyyy'), 6, 'Paid', 'CreditCard', 1046, 473);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('02-04-2021', 'dd-mm-yyyy'), 9, 'Paid', 'CreditCard', 1047, 408);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('26-07-2005', 'dd-mm-yyyy'), 6, 'not paid', 'cash', 1048, 430);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('07-09-2004', 'dd-mm-yyyy'), 7, 'Paid', 'CreditCard', 1049, 639);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('18-01-2010', 'dd-mm-yyyy'), 5, 'not paid', 'CreditCard', 1050, 671);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('25-10-2016', 'dd-mm-yyyy'), 5, 'not paid', 'bank transfer', 1051, 705);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('23-10-2016', 'dd-mm-yyyy'), 9, 'not paid', 'cash', 1052, 736);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('20-02-2010', 'dd-mm-yyyy'), 1, 'not paid', 'CreditCard', 1053, 695);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('23-04-2013', 'dd-mm-yyyy'), 7, 'Paid', 'cash', 1054, 483);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('06-04-2006', 'dd-mm-yyyy'), 10, 'not paid', 'CreditCard', 1055, 494);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('13-02-2018', 'dd-mm-yyyy'), 10, 'Paid', 'CreditCard', 1056, 790);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('25-04-2009', 'dd-mm-yyyy'), 4, 'Paid', 'CreditCard', 1057, 795);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('20-12-2013', 'dd-mm-yyyy'), 7, 'not paid', 'cash', 1058, 607);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('11-09-2019', 'dd-mm-yyyy'), 6, 'not paid', 'bank transfer', 1059, 745);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('07-11-2004', 'dd-mm-yyyy'), 5, 'Paid', 'cash', 1060, 615);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('23-06-2021', 'dd-mm-yyyy'), 5, 'Paid', 'bank transfer', 1061, 583);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('19-02-2005', 'dd-mm-yyyy'), 10, 'not paid', 'CreditCard', 1062, 662);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('07-02-2023', 'dd-mm-yyyy'), 8, 'Paid', 'cash', 1063, 413);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('18-11-2020', 'dd-mm-yyyy'), 5, 'not paid', 'cash', 1064, 510);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('19-02-2022', 'dd-mm-yyyy'), 1, 'Paid', 'cash', 1065, 744);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('21-07-2012', 'dd-mm-yyyy'), 3, 'Paid', 'cash', 1066, 773);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('20-12-2021', 'dd-mm-yyyy'), 3, 'not paid', 'bank transfer', 1067, 747);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('26-04-2020', 'dd-mm-yyyy'), 7, 'Paid', 'cash', 1068, 582);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('13-01-2023', 'dd-mm-yyyy'), 3, 'not paid', 'bank transfer', 1069, 431);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('18-04-2004', 'dd-mm-yyyy'), 5, 'not paid', 'cash', 1070, 424);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('16-02-2004', 'dd-mm-yyyy'), 10, 'Paid', 'cash', 1071, 483);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('23-10-2008', 'dd-mm-yyyy'), 7, 'Paid', 'CreditCard', 1072, 423);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('23-06-2012', 'dd-mm-yyyy'), 4, 'not paid', 'cash', 1073, 437);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('08-01-2018', 'dd-mm-yyyy'), 5, 'not paid', 'bank transfer', 1074, 489);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('20-04-2015', 'dd-mm-yyyy'), 10, 'Paid', 'CreditCard', 1075, 681);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('16-09-2016', 'dd-mm-yyyy'), 1, 'not paid', 'cash', 1076, 509);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('04-12-2021', 'dd-mm-yyyy'), 1, 'not paid', 'cash', 1077, 739);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('19-07-2020', 'dd-mm-yyyy'), 8, 'Paid', 'CreditCard', 1078, 417);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('24-09-2005', 'dd-mm-yyyy'), 4, 'not paid', 'cash', 1079, 478);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('15-03-2021', 'dd-mm-yyyy'), 4, 'not paid', 'bank transfer', 1080, 536);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('19-10-2009', 'dd-mm-yyyy'), 4, 'not paid', 'CreditCard', 1081, 728);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('20-05-2019', 'dd-mm-yyyy'), 2, 'Paid', 'CreditCard', 1082, 690);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('23-05-2011', 'dd-mm-yyyy'), 10, 'not paid', 'CreditCard', 1083, 724);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('30-08-2019', 'dd-mm-yyyy'), 7, 'not paid', 'bank transfer', 1084, 454);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('03-06-2018', 'dd-mm-yyyy'), 3, 'not paid', 'CreditCard', 1085, 550);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('25-11-2010', 'dd-mm-yyyy'), 3, 'Paid', 'cash', 1086, 718);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('27-02-2018', 'dd-mm-yyyy'), 2, 'Paid', 'cash', 1087, 578);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('09-05-2021', 'dd-mm-yyyy'), 9, 'not paid', 'bank transfer', 1088, 438);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('19-01-2005', 'dd-mm-yyyy'), 4, 'Paid', 'bank transfer', 1089, 465);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('25-11-2014', 'dd-mm-yyyy'), 7, 'Paid', 'cash', 1090, 490);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('03-06-2022', 'dd-mm-yyyy'), 9, 'Paid', 'CreditCard', 1091, 623);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('21-09-2009', 'dd-mm-yyyy'), 3, 'not paid', 'bank transfer', 1092, 532);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('06-12-2012', 'dd-mm-yyyy'), 1, 'not paid', 'CreditCard', 1093, 455);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('06-03-2010', 'dd-mm-yyyy'), 5, 'not paid', 'bank transfer', 1094, 760);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('23-07-2006', 'dd-mm-yyyy'), 6, 'not paid', 'bank transfer', 1095, 563);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('08-06-2012', 'dd-mm-yyyy'), 7, 'Paid', 'CreditCard', 1096, 429);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('19-04-2013', 'dd-mm-yyyy'), 1, 'Paid', 'CreditCard', 1097, 799);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('24-10-2010', 'dd-mm-yyyy'), 2, 'not paid', 'cash', 1098, 665);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('16-09-2012', 'dd-mm-yyyy'), 3, 'Paid', 'cash', 1099, 498);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('13-05-2021', 'dd-mm-yyyy'), 7, 'not paid', 'CreditCard', 1100, 706);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('08-04-2014', 'dd-mm-yyyy'), 1, 'Paid', 'CreditCard', 1101, 418);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('19-11-2007', 'dd-mm-yyyy'), 3, 'Paid', 'CreditCard', 1102, 577);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('15-04-2023', 'dd-mm-yyyy'), 5, 'Paid', 'bank transfer', 1103, 412);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('03-09-2009', 'dd-mm-yyyy'), 7, 'not paid', 'cash', 1104, 578);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('01-08-2017', 'dd-mm-yyyy'), 8, 'Paid', 'cash', 1105, 732);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('10-04-2006', 'dd-mm-yyyy'), 5, 'Paid', 'bank transfer', 1106, 466);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('29-08-2021', 'dd-mm-yyyy'), 7, 'Paid', 'bank transfer', 1107, 662);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('08-04-2018', 'dd-mm-yyyy'), 3, 'not paid', 'CreditCard', 1108, 505);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('09-02-2009', 'dd-mm-yyyy'), 1, 'not paid', 'CreditCard', 1109, 428);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('06-04-2011', 'dd-mm-yyyy'), 1, 'not paid', 'cash', 1110, 584);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('18-06-2011', 'dd-mm-yyyy'), 6, 'Paid', 'bank transfer', 1111, 741);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('17-09-2008', 'dd-mm-yyyy'), 10, 'Paid', 'CreditCard', 1112, 498);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('18-01-2014', 'dd-mm-yyyy'), 7, 'Paid', 'CreditCard', 1113, 674);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('30-07-2004', 'dd-mm-yyyy'), 8, 'not paid', 'CreditCard', 1114, 556);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('08-12-2017', 'dd-mm-yyyy'), 10, 'not paid', 'cash', 1115, 464);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('06-11-2004', 'dd-mm-yyyy'), 9, 'Paid', 'bank transfer', 1116, 668);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('10-10-2012', 'dd-mm-yyyy'), 6, 'Paid', 'cash', 1117, 779);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('22-08-2014', 'dd-mm-yyyy'), 7, 'Paid', 'cash', 1118, 672);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('11-10-2019', 'dd-mm-yyyy'), 9, 'Paid', 'cash', 1119, 665);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('18-04-2010', 'dd-mm-yyyy'), 5, 'not paid', 'bank transfer', 1120, 658);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('19-04-2018', 'dd-mm-yyyy'), 3, 'Paid', 'bank transfer', 1121, 438);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('14-08-2010', 'dd-mm-yyyy'), 1, 'Paid', 'bank transfer', 1122, 474);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('21-11-2004', 'dd-mm-yyyy'), 8, 'Paid', 'bank transfer', 1123, 563);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('06-01-2014', 'dd-mm-yyyy'), 8, 'not paid', 'cash', 1124, 711);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('11-03-2021', 'dd-mm-yyyy'), 7, 'Paid', 'CreditCard', 1125, 768);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('12-01-2015', 'dd-mm-yyyy'), 4, 'not paid', 'CreditCard', 1126, 634);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('14-07-2008', 'dd-mm-yyyy'), 8, 'not paid', 'cash', 1127, 674);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('19-02-2021', 'dd-mm-yyyy'), 10, 'Paid', 'bank transfer', 1128, 407);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('08-01-2013', 'dd-mm-yyyy'), 6, 'Paid', 'CreditCard', 1129, 454);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('05-08-2014', 'dd-mm-yyyy'), 8, 'not paid', 'bank transfer', 1130, 616);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('28-03-2017', 'dd-mm-yyyy'), 5, 'Paid', 'cash', 1131, 623);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('17-03-2011', 'dd-mm-yyyy'), 8, 'Paid', 'bank transfer', 1132, 421);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('23-02-2004', 'dd-mm-yyyy'), 8, 'Paid', 'cash', 1133, 629);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('10-12-2013', 'dd-mm-yyyy'), 5, 'Paid', 'bank transfer', 1134, 712);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('22-12-2006', 'dd-mm-yyyy'), 4, 'not paid', 'CreditCard', 1135, 546);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('02-02-2011', 'dd-mm-yyyy'), 10, 'not paid', 'cash', 1136, 737);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('07-11-2016', 'dd-mm-yyyy'), 10, 'Paid', 'bank transfer', 1137, 606);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('23-12-2021', 'dd-mm-yyyy'), 6, 'not paid', 'CreditCard', 1138, 753);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('31-12-2008', 'dd-mm-yyyy'), 6, 'Paid', 'bank transfer', 1139, 433);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('30-08-2014', 'dd-mm-yyyy'), 10, 'Paid', 'cash', 1140, 474);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('09-10-2019', 'dd-mm-yyyy'), 6, 'Paid', 'bank transfer', 1141, 678);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('25-06-2005', 'dd-mm-yyyy'), 2, 'not paid', 'CreditCard', 1142, 676);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('24-10-2021', 'dd-mm-yyyy'), 7, 'not paid', 'cash', 1143, 683);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('13-07-2006', 'dd-mm-yyyy'), 9, 'not paid', 'bank transfer', 1144, 556);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('28-06-2014', 'dd-mm-yyyy'), 1, 'not paid', 'cash', 1145, 701);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('20-09-2009', 'dd-mm-yyyy'), 3, 'not paid', 'cash', 1146, 663);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('01-09-2012', 'dd-mm-yyyy'), 10, 'not paid', 'CreditCard', 1147, 456);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('09-12-2011', 'dd-mm-yyyy'), 5, 'Paid', 'cash', 1148, 575);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('21-04-2010', 'dd-mm-yyyy'), 5, 'Paid', 'CreditCard', 1149, 495);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('08-09-2010', 'dd-mm-yyyy'), 2, 'Paid', 'cash', 1150, 618);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('22-01-2017', 'dd-mm-yyyy'), 10, 'not paid', 'CreditCard', 1151, 464);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('09-01-2020', 'dd-mm-yyyy'), 6, 'not paid', 'bank transfer', 1152, 497);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('26-01-2008', 'dd-mm-yyyy'), 3, 'not paid', 'cash', 1153, 556);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('18-09-2008', 'dd-mm-yyyy'), 7, 'not paid', 'bank transfer', 1154, 497);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('25-08-2009', 'dd-mm-yyyy'), 3, 'not paid', 'cash', 1155, 597);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('09-09-2012', 'dd-mm-yyyy'), 8, 'Paid', 'cash', 1156, 732);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('21-01-2019', 'dd-mm-yyyy'), 10, 'not paid', 'bank transfer', 1157, 525);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('09-02-2018', 'dd-mm-yyyy'), 2, 'not paid', 'CreditCard', 1158, 678);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('20-01-2005', 'dd-mm-yyyy'), 5, 'not paid', 'cash', 1159, 432);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('13-03-2016', 'dd-mm-yyyy'), 5, 'not paid', 'CreditCard', 1160, 649);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('09-10-2009', 'dd-mm-yyyy'), 2, 'not paid', 'CreditCard', 1161, 513);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('04-07-2012', 'dd-mm-yyyy'), 2, 'Paid', 'CreditCard', 1162, 461);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('07-12-2011', 'dd-mm-yyyy'), 4, 'Paid', 'cash', 1163, 402);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('12-09-2017', 'dd-mm-yyyy'), 8, 'not paid', 'bank transfer', 1164, 441);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('03-09-2008', 'dd-mm-yyyy'), 7, 'not paid', 'CreditCard', 1165, 506);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('27-08-2010', 'dd-mm-yyyy'), 8, 'not paid', 'CreditCard', 1166, 495);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('17-10-2008', 'dd-mm-yyyy'), 4, 'not paid', 'bank transfer', 1167, 701);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('30-11-2013', 'dd-mm-yyyy'), 8, 'Paid', 'cash', 1168, 612);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('14-09-2015', 'dd-mm-yyyy'), 8, 'Paid', 'cash', 1169, 779);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('04-04-2012', 'dd-mm-yyyy'), 4, 'Paid', 'CreditCard', 1170, 630);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('08-01-2015', 'dd-mm-yyyy'), 3, 'not paid', 'cash', 1171, 676);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('16-02-2004', 'dd-mm-yyyy'), 8, 'not paid', 'CreditCard', 1172, 613);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('13-08-2020', 'dd-mm-yyyy'), 5, 'Paid', 'cash', 1173, 719);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('30-08-2018', 'dd-mm-yyyy'), 7, 'not paid', 'CreditCard', 1174, 779);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('19-06-2015', 'dd-mm-yyyy'), 9, 'not paid', 'CreditCard', 1175, 793);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('27-08-2004', 'dd-mm-yyyy'), 4, 'not paid', 'CreditCard', 1176, 678);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('29-12-2020', 'dd-mm-yyyy'), 6, 'Paid', 'CreditCard', 1177, 794);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('13-12-2017', 'dd-mm-yyyy'), 3, 'Paid', 'cash', 1178, 488);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('13-02-2022', 'dd-mm-yyyy'), 1, 'Paid', 'cash', 1179, 532);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('22-01-2007', 'dd-mm-yyyy'), 7, 'not paid', 'cash', 1180, 607);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('30-11-2015', 'dd-mm-yyyy'), 8, 'not paid', 'bank transfer', 1181, 470);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('01-04-2019', 'dd-mm-yyyy'), 9, 'Paid', 'cash', 1182, 611);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('08-04-2021', 'dd-mm-yyyy'), 5, 'not paid', 'cash', 1183, 492);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('06-03-2007', 'dd-mm-yyyy'), 10, 'not paid', 'cash', 1184, 532);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('08-03-2016', 'dd-mm-yyyy'), 3, 'not paid', 'CreditCard', 1185, 615);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('07-11-2005', 'dd-mm-yyyy'), 5, 'not paid', 'cash', 1186, 582);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('24-07-2019', 'dd-mm-yyyy'), 6, 'Paid', 'cash', 1187, 660);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('09-04-2017', 'dd-mm-yyyy'), 8, 'not paid', 'CreditCard', 1188, 408);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('19-02-2017', 'dd-mm-yyyy'), 10, 'Paid', 'bank transfer', 1189, 586);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('21-11-2021', 'dd-mm-yyyy'), 3, 'Paid', 'bank transfer', 1190, 468);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('17-06-2007', 'dd-mm-yyyy'), 1, 'Paid', 'bank transfer', 1191, 530);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('26-05-2018', 'dd-mm-yyyy'), 3, 'not paid', 'bank transfer', 1192, 689);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('29-10-2004', 'dd-mm-yyyy'), 5, 'not paid', 'cash', 1193, 736);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('24-03-2012', 'dd-mm-yyyy'), 3, 'Paid', 'cash', 1194, 716);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('23-06-2023', 'dd-mm-yyyy'), 1, 'not paid', 'CreditCard', 1195, 424);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('01-04-2015', 'dd-mm-yyyy'), 2, 'not paid', 'cash', 1196, 712);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('01-09-2011', 'dd-mm-yyyy'), 2, 'not paid', 'bank transfer', 1197, 748);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('04-04-2020', 'dd-mm-yyyy'), 7, 'not paid', 'cash', 1198, 570);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('29-08-2007', 'dd-mm-yyyy'), 6, 'not paid', 'CreditCard', 1199, 696);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('27-07-2020', 'dd-mm-yyyy'), 6, 'not paid', 'bank transfer', 1200, 647);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('14-05-2022', 'dd-mm-yyyy'), 5, 'Paid', 'cash', 1201, 725);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('21-04-2013', 'dd-mm-yyyy'), 7, 'not paid', 'CreditCard', 1202, 660);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('26-09-2017', 'dd-mm-yyyy'), 9, 'Paid', 'cash', 1203, 782);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('19-06-2021', 'dd-mm-yyyy'), 1, 'Paid', 'cash', 1204, 549);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('01-03-2016', 'dd-mm-yyyy'), 4, 'not paid', 'bank transfer', 1205, 441);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('22-04-2010', 'dd-mm-yyyy'), 4, 'Paid', 'cash', 1206, 558);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('29-05-2006', 'dd-mm-yyyy'), 9, 'Paid', 'bank transfer', 1207, 567);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('24-08-2004', 'dd-mm-yyyy'), 8, 'Paid', 'CreditCard', 1208, 565);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('31-03-2016', 'dd-mm-yyyy'), 10, 'not paid', 'CreditCard', 1209, 690);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('21-06-2011', 'dd-mm-yyyy'), 2, 'not paid', 'cash', 1210, 586);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('18-02-2023', 'dd-mm-yyyy'), 8, 'not paid', 'cash', 1211, 635);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('27-11-2022', 'dd-mm-yyyy'), 7, 'Paid', 'CreditCard', 1212, 423);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('28-04-2022', 'dd-mm-yyyy'), 9, 'Paid', 'cash', 1213, 731);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('07-08-2014', 'dd-mm-yyyy'), 10, 'not paid', 'cash', 1214, 488);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('20-12-2008', 'dd-mm-yyyy'), 10, 'not paid', 'bank transfer', 1215, 472);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('15-12-2009', 'dd-mm-yyyy'), 2, 'not paid', 'cash', 1216, 471);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('13-04-2007', 'dd-mm-yyyy'), 6, 'Paid', 'bank transfer', 1217, 768);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('30-09-2007', 'dd-mm-yyyy'), 8, 'not paid', 'CreditCard', 1218, 431);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('16-10-2017', 'dd-mm-yyyy'), 8, 'Paid', 'CreditCard', 1219, 595);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('02-11-2015', 'dd-mm-yyyy'), 9, 'not paid', 'bank transfer', 1220, 582);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('10-11-2023', 'dd-mm-yyyy'), 1, 'Paid', 'CreditCard', 1221, 467);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('30-11-2012', 'dd-mm-yyyy'), 2, 'Paid', 'cash', 1222, 760);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('22-05-2022', 'dd-mm-yyyy'), 5, 'not paid', 'CreditCard', 1223, 668);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('31-01-2020', 'dd-mm-yyyy'), 3, 'not paid', 'CreditCard', 1224, 594);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('10-04-2012', 'dd-mm-yyyy'), 5, 'not paid', 'cash', 1225, 641);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('29-06-2020', 'dd-mm-yyyy'), 5, 'not paid', 'CreditCard', 1226, 580);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('13-11-2008', 'dd-mm-yyyy'), 1, 'not paid', 'CreditCard', 1227, 581);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('30-10-2004', 'dd-mm-yyyy'), 1, 'Paid', 'cash', 1228, 410);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('02-10-2004', 'dd-mm-yyyy'), 6, 'not paid', 'cash', 1229, 511);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('25-01-2019', 'dd-mm-yyyy'), 2, 'not paid', 'bank transfer', 1230, 565);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('17-10-2007', 'dd-mm-yyyy'), 5, 'not paid', 'bank transfer', 1231, 756);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('14-01-2015', 'dd-mm-yyyy'), 2, 'not paid', 'cash', 1232, 414);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('20-11-2007', 'dd-mm-yyyy'), 4, 'not paid', 'cash', 1233, 675);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('15-05-2010', 'dd-mm-yyyy'), 8, 'Paid', 'bank transfer', 1234, 686);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('24-06-2015', 'dd-mm-yyyy'), 3, 'not paid', 'cash', 1235, 445);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('16-01-2018', 'dd-mm-yyyy'), 6, 'Paid', 'bank transfer', 1236, 543);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('29-09-2008', 'dd-mm-yyyy'), 3, 'not paid', 'bank transfer', 1237, 787);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('27-12-2023', 'dd-mm-yyyy'), 2, 'Paid', 'CreditCard', 1238, 460);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('11-12-2023', 'dd-mm-yyyy'), 5, 'Paid', 'CreditCard', 1239, 508);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('17-08-2019', 'dd-mm-yyyy'), 4, 'Paid', 'CreditCard', 1240, 449);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('28-09-2015', 'dd-mm-yyyy'), 8, 'Paid', 'CreditCard', 1241, 684);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('21-07-2011', 'dd-mm-yyyy'), 2, 'Paid', 'bank transfer', 1242, 598);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('11-11-2022', 'dd-mm-yyyy'), 3, 'not paid', 'CreditCard', 1243, 410);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('25-09-2018', 'dd-mm-yyyy'), 1, 'not paid', 'CreditCard', 1244, 517);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('27-01-2010', 'dd-mm-yyyy'), 4, 'Paid', 'CreditCard', 1245, 561);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('29-01-2005', 'dd-mm-yyyy'), 6, 'not paid', 'CreditCard', 1246, 666);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('17-01-2022', 'dd-mm-yyyy'), 5, 'Paid', 'bank transfer', 1247, 532);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('14-02-2008', 'dd-mm-yyyy'), 1, 'not paid', 'CreditCard', 1248, 755);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('23-10-2008', 'dd-mm-yyyy'), 7, 'Paid', 'CreditCard', 1249, 724);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('08-03-2009', 'dd-mm-yyyy'), 2, 'Paid', 'CreditCard', 1250, 627);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('30-10-2007', 'dd-mm-yyyy'), 1, 'Paid', 'cash', 1251, 549);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('13-01-2013', 'dd-mm-yyyy'), 1, 'Paid', 'cash', 1252, 730);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('18-06-2005', 'dd-mm-yyyy'), 4, 'Paid', 'cash', 1253, 741);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('15-10-2021', 'dd-mm-yyyy'), 6, 'not paid', 'cash', 1254, 692);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('23-10-2011', 'dd-mm-yyyy'), 7, 'not paid', 'bank transfer', 1255, 751);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('25-02-2005', 'dd-mm-yyyy'), 5, 'not paid', 'cash', 1256, 561);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('07-01-2019', 'dd-mm-yyyy'), 2, 'Paid', 'cash', 1257, 700);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('05-02-2023', 'dd-mm-yyyy'), 2, 'Paid', 'bank transfer', 1258, 733);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('05-06-2015', 'dd-mm-yyyy'), 7, 'Paid', 'cash', 1259, 476);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('25-12-2013', 'dd-mm-yyyy'), 2, 'Paid', 'CreditCard', 1260, 742);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('18-05-2007', 'dd-mm-yyyy'), 1, 'not paid', 'cash', 1261, 606);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('11-06-2017', 'dd-mm-yyyy'), 8, 'Paid', 'CreditCard', 1262, 688);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('26-09-2018', 'dd-mm-yyyy'), 8, 'not paid', 'CreditCard', 1263, 713);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('10-11-2022', 'dd-mm-yyyy'), 8, 'not paid', 'cash', 1264, 620);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('11-02-2006', 'dd-mm-yyyy'), 2, 'Paid', 'cash', 1265, 416);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('07-10-2017', 'dd-mm-yyyy'), 10, 'not paid', 'cash', 1266, 633);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('19-11-2006', 'dd-mm-yyyy'), 4, 'not paid', 'cash', 1267, 467);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('15-10-2021', 'dd-mm-yyyy'), 3, 'Paid', 'bank transfer', 1268, 684);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('04-07-2018', 'dd-mm-yyyy'), 5, 'not paid', 'CreditCard', 1269, 558);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('06-05-2007', 'dd-mm-yyyy'), 7, 'not paid', 'cash', 1270, 514);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('09-09-2012', 'dd-mm-yyyy'), 3, 'Paid', 'bank transfer', 1271, 525);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('12-04-2014', 'dd-mm-yyyy'), 10, 'not paid', 'CreditCard', 1272, 694);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('14-10-2007', 'dd-mm-yyyy'), 3, 'not paid', 'CreditCard', 1273, 429);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('09-07-2018', 'dd-mm-yyyy'), 3, 'not paid', 'cash', 1274, 444);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('11-10-2018', 'dd-mm-yyyy'), 3, 'not paid', 'bank transfer', 1275, 412);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('11-05-2020', 'dd-mm-yyyy'), 2, 'not paid', 'bank transfer', 1276, 610);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('05-07-2007', 'dd-mm-yyyy'), 7, 'not paid', 'bank transfer', 1277, 500);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('01-02-2013', 'dd-mm-yyyy'), 2, 'not paid', 'CreditCard', 1278, 543);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('11-09-2007', 'dd-mm-yyyy'), 9, 'not paid', 'CreditCard', 1279, 409);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('01-01-2023', 'dd-mm-yyyy'), 8, 'Paid', 'cash', 1280, 555);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('11-01-2011', 'dd-mm-yyyy'), 4, 'Paid', 'CreditCard', 1281, 548);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('03-01-2014', 'dd-mm-yyyy'), 5, 'not paid', 'cash', 1282, 638);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('19-06-2013', 'dd-mm-yyyy'), 9, 'Paid', 'CreditCard', 1283, 579);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('27-01-2010', 'dd-mm-yyyy'), 5, 'Paid', 'bank transfer', 1284, 558);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('29-12-2005', 'dd-mm-yyyy'), 1, 'Paid', 'cash', 1285, 635);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('05-03-2023', 'dd-mm-yyyy'), 9, 'not paid', 'bank transfer', 1286, 583);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('28-12-2012', 'dd-mm-yyyy'), 3, 'not paid', 'CreditCard', 1287, 492);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('28-01-2009', 'dd-mm-yyyy'), 5, 'Paid', 'bank transfer', 1288, 520);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('08-10-2004', 'dd-mm-yyyy'), 10, 'Paid', 'cash', 1289, 744);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('26-11-2004', 'dd-mm-yyyy'), 5, 'not paid', 'cash', 1290, 534);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('08-10-2020', 'dd-mm-yyyy'), 7, 'not paid', 'bank transfer', 1291, 612);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('21-10-2016', 'dd-mm-yyyy'), 1, 'not paid', 'cash', 1292, 547);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('15-10-2006', 'dd-mm-yyyy'), 8, 'Paid', 'bank transfer', 1293, 700);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('28-10-2019', 'dd-mm-yyyy'), 3, 'Paid', 'CreditCard', 1294, 528);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('05-05-2015', 'dd-mm-yyyy'), 6, 'Paid', 'bank transfer', 1295, 407);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('23-02-2011', 'dd-mm-yyyy'), 2, 'not paid', 'cash', 1296, 702);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('19-09-2013', 'dd-mm-yyyy'), 5, 'Paid', 'bank transfer', 1297, 491);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('14-11-2018', 'dd-mm-yyyy'), 3, 'not paid', 'bank transfer', 1298, 506);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('27-11-2010', 'dd-mm-yyyy'), 5, 'Paid', 'CreditCard', 1299, 757);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('11-03-2017', 'dd-mm-yyyy'), 1, 'Paid', 'cash', 1300, 495);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('27-05-2023', 'dd-mm-yyyy'), 9, 'not paid', 'CreditCard', 1301, 410);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('25-01-2012', 'dd-mm-yyyy'), 8, 'not paid', 'cash', 1302, 730);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('30-07-2012', 'dd-mm-yyyy'), 4, 'not paid', 'CreditCard', 1303, 731);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('07-11-2004', 'dd-mm-yyyy'), 7, 'Paid', 'CreditCard', 1304, 594);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('02-07-2013', 'dd-mm-yyyy'), 3, 'not paid', 'bank transfer', 1305, 531);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('08-10-2011', 'dd-mm-yyyy'), 2, 'Paid', 'CreditCard', 1306, 723);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('29-08-2018', 'dd-mm-yyyy'), 1, 'Paid', 'CreditCard', 1307, 500);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('02-03-2020', 'dd-mm-yyyy'), 1, 'Paid', 'bank transfer', 1308, 458);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('14-10-2010', 'dd-mm-yyyy'), 3, 'not paid', 'bank transfer', 1309, 743);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('01-02-2015', 'dd-mm-yyyy'), 8, 'Paid', 'bank transfer', 1310, 501);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('03-06-2018', 'dd-mm-yyyy'), 9, 'Paid', 'cash', 1311, 644);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('26-06-2017', 'dd-mm-yyyy'), 10, 'not paid', 'cash', 1312, 572);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('06-01-2007', 'dd-mm-yyyy'), 3, 'Paid', 'CreditCard', 1313, 663);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('16-02-2015', 'dd-mm-yyyy'), 8, 'not paid', 'cash', 1314, 408);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('24-10-2018', 'dd-mm-yyyy'), 5, 'Paid', 'bank transfer', 1315, 644);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('22-09-2004', 'dd-mm-yyyy'), 4, 'Paid', 'bank transfer', 1316, 403);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('27-04-2007', 'dd-mm-yyyy'), 1, 'Paid', 'bank transfer', 1317, 436);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('20-10-2015', 'dd-mm-yyyy'), 7, 'Paid', 'bank transfer', 1318, 734);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('09-07-2018', 'dd-mm-yyyy'), 9, 'not paid', 'bank transfer', 1319, 608);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('18-11-2018', 'dd-mm-yyyy'), 10, 'Paid', 'bank transfer', 1320, 530);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('21-01-2022', 'dd-mm-yyyy'), 3, 'not paid', 'CreditCard', 1321, 758);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('01-11-2009', 'dd-mm-yyyy'), 3, 'Paid', 'CreditCard', 1322, 425);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('01-11-2012', 'dd-mm-yyyy'), 4, 'Paid', 'CreditCard', 1323, 405);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('15-12-2013', 'dd-mm-yyyy'), 6, 'Paid', 'cash', 1324, 697);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('20-01-2018', 'dd-mm-yyyy'), 1, 'not paid', 'cash', 1325, 518);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('11-09-2004', 'dd-mm-yyyy'), 4, 'not paid', 'bank transfer', 1326, 656);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('07-10-2017', 'dd-mm-yyyy'), 3, 'not paid', 'CreditCard', 1327, 482);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('25-07-2008', 'dd-mm-yyyy'), 3, 'not paid', 'CreditCard', 1328, 426);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('07-03-2010', 'dd-mm-yyyy'), 5, 'not paid', 'CreditCard', 1329, 602);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('13-02-2006', 'dd-mm-yyyy'), 4, 'not paid', 'bank transfer', 1330, 792);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('23-10-2006', 'dd-mm-yyyy'), 7, 'not paid', 'CreditCard', 1331, 728);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('20-04-2005', 'dd-mm-yyyy'), 2, 'Paid', 'cash', 1332, 529);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('15-03-2019', 'dd-mm-yyyy'), 9, 'not paid', 'CreditCard', 1333, 458);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('01-12-2013', 'dd-mm-yyyy'), 3, 'Paid', 'CreditCard', 1334, 699);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('06-11-2018', 'dd-mm-yyyy'), 3, 'Paid', 'cash', 1335, 650);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('27-02-2019', 'dd-mm-yyyy'), 3, 'not paid', 'bank transfer', 1336, 774);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('27-10-2006', 'dd-mm-yyyy'), 5, 'not paid', 'CreditCard', 1337, 555);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('02-10-2009', 'dd-mm-yyyy'), 4, 'not paid', 'bank transfer', 1338, 719);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('06-08-2020', 'dd-mm-yyyy'), 7, 'not paid', 'bank transfer', 1339, 639);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('04-02-2017', 'dd-mm-yyyy'), 4, 'not paid', 'CreditCard', 1340, 647);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('19-11-2023', 'dd-mm-yyyy'), 4, 'Paid', 'bank transfer', 1341, 743);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('07-08-2021', 'dd-mm-yyyy'), 8, 'Paid', 'bank transfer', 1342, 700);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('17-01-2012', 'dd-mm-yyyy'), 3, 'Paid', 'bank transfer', 1343, 584);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('09-01-2016', 'dd-mm-yyyy'), 6, 'not paid', 'bank transfer', 1344, 641);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('26-08-2012', 'dd-mm-yyyy'), 9, 'Paid', 'bank transfer', 1345, 645);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('05-07-2014', 'dd-mm-yyyy'), 4, 'not paid', 'cash', 1346, 765);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('16-04-2008', 'dd-mm-yyyy'), 6, 'not paid', 'bank transfer', 1347, 613);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('29-04-2011', 'dd-mm-yyyy'), 4, 'Paid', 'cash', 1348, 434);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('10-02-2009', 'dd-mm-yyyy'), 8, 'not paid', 'bank transfer', 1349, 685);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('16-06-2022', 'dd-mm-yyyy'), 5, 'Paid', 'CreditCard', 1350, 626);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('17-04-2016', 'dd-mm-yyyy'), 8, 'not paid', 'CreditCard', 1351, 424);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('26-02-2013', 'dd-mm-yyyy'), 5, 'not paid', 'cash', 1352, 782);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('21-03-2016', 'dd-mm-yyyy'), 9, 'Paid', 'cash', 1353, 484);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('16-11-2020', 'dd-mm-yyyy'), 1, 'Paid', 'CreditCard', 1354, 729);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('17-11-2009', 'dd-mm-yyyy'), 8, 'not paid', 'cash', 1355, 571);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('30-08-2012', 'dd-mm-yyyy'), 5, 'not paid', 'CreditCard', 1356, 492);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('20-01-2004', 'dd-mm-yyyy'), 8, 'Paid', 'cash', 1357, 640);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('14-08-2004', 'dd-mm-yyyy'), 10, 'Paid', 'cash', 1358, 624);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('30-06-2011', 'dd-mm-yyyy'), 6, 'not paid', 'CreditCard', 1359, 788);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('07-05-2005', 'dd-mm-yyyy'), 6, 'Paid', 'CreditCard', 1360, 693);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('17-10-2017', 'dd-mm-yyyy'), 2, 'not paid', 'CreditCard', 1361, 402);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('07-01-2021', 'dd-mm-yyyy'), 7, 'Paid', 'bank transfer', 1362, 460);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('04-03-2014', 'dd-mm-yyyy'), 2, 'Paid', 'bank transfer', 1363, 500);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('26-09-2023', 'dd-mm-yyyy'), 8, 'Paid', 'cash', 1364, 769);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('27-06-2019', 'dd-mm-yyyy'), 2, 'Paid', 'cash', 1365, 669);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('19-09-2012', 'dd-mm-yyyy'), 10, 'Paid', 'bank transfer', 1366, 792);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('20-01-2022', 'dd-mm-yyyy'), 8, 'Paid', 'bank transfer', 1367, 408);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('26-07-2016', 'dd-mm-yyyy'), 5, 'not paid', 'bank transfer', 1368, 792);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('28-06-2014', 'dd-mm-yyyy'), 10, 'not paid', 'CreditCard', 1369, 619);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('28-12-2009', 'dd-mm-yyyy'), 1, 'not paid', 'bank transfer', 1370, 795);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('02-01-2013', 'dd-mm-yyyy'), 5, 'not paid', 'cash', 1371, 501);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('25-08-2016', 'dd-mm-yyyy'), 2, 'not paid', 'CreditCard', 1372, 594);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('31-07-2018', 'dd-mm-yyyy'), 5, 'not paid', 'bank transfer', 1373, 409);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('19-03-2017', 'dd-mm-yyyy'), 3, 'not paid', 'cash', 1374, 682);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('12-09-2011', 'dd-mm-yyyy'), 2, 'not paid', 'cash', 1375, 783);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('16-08-2004', 'dd-mm-yyyy'), 10, 'not paid', 'CreditCard', 1376, 526);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('22-08-2006', 'dd-mm-yyyy'), 1, 'Paid', 'cash', 1377, 430);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('11-03-2023', 'dd-mm-yyyy'), 1, 'Paid', 'bank transfer', 1378, 619);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('21-08-2006', 'dd-mm-yyyy'), 5, 'Paid', 'CreditCard', 1379, 659);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('06-10-2020', 'dd-mm-yyyy'), 9, 'not paid', 'bank transfer', 1380, 650);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('11-11-2008', 'dd-mm-yyyy'), 8, 'not paid', 'bank transfer', 1381, 578);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('31-12-2009', 'dd-mm-yyyy'), 10, 'not paid', 'bank transfer', 1382, 522);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('11-07-2009', 'dd-mm-yyyy'), 2, 'Paid', 'CreditCard', 1383, 669);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('21-01-2022', 'dd-mm-yyyy'), 4, 'not paid', 'cash', 1384, 800);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('30-05-2005', 'dd-mm-yyyy'), 7, 'Paid', 'bank transfer', 1385, 620);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('29-01-2020', 'dd-mm-yyyy'), 3, 'not paid', 'CreditCard', 1386, 451);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('14-06-2020', 'dd-mm-yyyy'), 3, 'not paid', 'CreditCard', 1387, 737);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('17-09-2006', 'dd-mm-yyyy'), 1, 'Paid', 'bank transfer', 1388, 465);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('22-06-2015', 'dd-mm-yyyy'), 1, 'not paid', 'bank transfer', 1389, 502);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('20-03-2006', 'dd-mm-yyyy'), 7, 'Paid', 'CreditCard', 1390, 565);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('24-04-2007', 'dd-mm-yyyy'), 7, 'Paid', 'bank transfer', 1391, 783);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('15-04-2013', 'dd-mm-yyyy'), 10, 'Paid', 'cash', 1392, 732);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('29-08-2021', 'dd-mm-yyyy'), 2, 'not paid', 'cash', 1393, 706);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('17-02-2014', 'dd-mm-yyyy'), 7, 'not paid', 'cash', 1394, 560);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('19-11-2012', 'dd-mm-yyyy'), 5, 'Paid', 'CreditCard', 1395, 502);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('02-09-2006', 'dd-mm-yyyy'), 4, 'not paid', 'bank transfer', 1396, 632);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('26-08-2015', 'dd-mm-yyyy'), 1, 'Paid', 'CreditCard', 1397, 469);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('09-05-2012', 'dd-mm-yyyy'), 8, 'Paid', 'bank transfer', 1398, 564);
insert into PAYMENTS (paymentdate, numberoftransaction, status, paymenttype, paymentid, idco)
values (to_date('24-01-2008', 'dd-mm-yyyy'), 8, 'Paid', 'CreditCard', 1399, 738);
prompt 400 records loaded
prompt Enabling foreign key constraints for INVENTORY...
alter table INVENTORY enable constraint SYS_C007339;
prompt Enabling foreign key constraints for ORDERS...
alter table ORDERS enable constraint SYS_C007346;
alter table ORDERS enable constraint SYS_C007347;
alter table ORDERS enable constraint SYS_C007348;
alter table ORDERS enable constraint SYS_C007349;
prompt Enabling foreign key constraints for PAYMENTS...
alter table PAYMENTS enable constraint SYS_C007335;
prompt Enabling triggers for CUSTOMERS...
alter table CUSTOMERS enable all triggers;
prompt Enabling triggers for NEWCATALOG...
alter table NEWCATALOG enable all triggers;
prompt Enabling triggers for INVENTORY...
alter table INVENTORY enable all triggers;
prompt Enabling triggers for WORKERS...
alter table WORKERS enable all triggers;
prompt Enabling triggers for ORDERS...
alter table ORDERS enable all triggers;
prompt Enabling triggers for PAYMENTS...
alter table PAYMENTS enable all triggers;
set feedback on
set define on
prompt Done.
