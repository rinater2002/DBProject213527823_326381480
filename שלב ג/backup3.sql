prompt PL/SQL Developer import file
prompt Created on יום ראשון 07 יולי 2024 by USER
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
;
alter table WORKERS
  add primary key (IDWO);
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
  idco          INTEGER not null
)
;
alter table ORDERS
  add primary key (ORDERID);
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
alter table INVENTORY disable constraint SYS_C007457;
prompt Disabling foreign key constraints for ORDERS...
alter table ORDERS disable constraint SYS_C007466;
alter table ORDERS disable constraint SYS_C007467;
alter table ORDERS disable constraint SYS_C007468;
alter table ORDERS disable constraint SYS_C007469;
prompt Disabling foreign key constraints for PAYMENTS...
alter table PAYMENTS disable constraint SYS_C007472;
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
values ('Chant׳™-Ledger', 419, 583801842, 'private', 'chant.l@inzone.com');
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
values (1, 40, 2000, 809);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 40, 2001, 834);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 40, 2002, 817);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 40, 2003, 822);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 40, 2004, 845);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 40, 2005, 821);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 66, 2006, 808);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 40, 2007, 810);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 40, 2008, 834);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 56, 2009, 844);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 72, 2010, 837);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 70, 2011, 840);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 40, 2012, 847);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 40, 2013, 849);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 54, 2014, 804);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 40, 2015, 812);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 40, 2016, 844);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 40, 2017, 830);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 40, 2018, 802);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 40, 2019, 850);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 40, 2020, 814);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 40, 2021, 819);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 55, 2022, 822);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 40, 2023, 812);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 40, 2024, 817);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 40, 2025, 835);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 40, 2026, 807);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 40, 2027, 828);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 40, 2028, 822);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 40, 2029, 804);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 59, 2030, 835);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 40, 2031, 824);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 40, 2032, 825);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 40, 2033, 828);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 40, 2034, 810);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 40, 2035, 838);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 40, 2036, 826);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 40, 2037, 817);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 40, 2038, 837);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 40, 2039, 805);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 40, 2040, 816);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 40, 2041, 812);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 40, 2042, 813);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 40, 2043, 804);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 84, 2044, 826);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 40, 2045, 845);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 40, 2046, 815);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 40, 2047, 809);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 40, 2048, 827);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 40, 2049, 802);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 47, 2050, 850);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 40, 2051, 817);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 40, 2052, 848);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 40, 2053, 841);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 40, 2054, 825);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 40, 2055, 824);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 40, 2056, 823);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 40, 2057, 817);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 40, 2058, 822);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 40, 2059, 833);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 40, 2060, 819);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 65, 2061, 839);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 40, 2062, 816);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 40, 2063, 805);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 40, 2064, 820);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 40, 2065, 834);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 40, 2066, 840);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 40, 2067, 810);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 40, 2068, 808);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 40, 2069, 827);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 40, 2070, 813);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 40, 2071, 848);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 40, 2072, 826);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 40, 2073, 816);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 40, 2074, 817);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 79, 2075, 844);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 40, 2076, 849);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 40, 2077, 847);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 40, 2078, 848);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 82, 2079, 849);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 40, 2080, 819);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 40, 2081, 843);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 40, 2082, 818);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 40, 2083, 830);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 40, 2084, 843);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 40, 2085, 847);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 40, 2086, 848);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 40, 2087, 808);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 73, 2088, 848);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 40, 2089, 825);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 40, 2090, 808);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 40, 2091, 834);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 40, 2092, 839);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 40, 2093, 810);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 40, 2094, 823);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 62, 2095, 825);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 40, 2096, 815);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 40, 2097, 813);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 40, 2098, 809);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 40, 2099, 836);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 40, 2100, 838);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 40, 2101, 841);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 40, 2102, 811);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 40, 2103, 833);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 40, 2104, 836);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 40, 2105, 839);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 40, 2106, 803);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 40, 2107, 825);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 40, 2108, 830);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 40, 2109, 823);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 40, 2110, 820);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 40, 2111, 823);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 40, 2112, 823);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 41, 2113, 818);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 40, 2114, 843);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 40, 2115, 833);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 40, 2116, 812);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 40, 2117, 839);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 40, 2118, 833);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 41, 2119, 809);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 40, 2120, 806);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 40, 2121, 811);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 41, 2122, 818);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 40, 2123, 808);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 40, 2124, 822);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 55, 2125, 811);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 40, 2126, 802);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 40, 2127, 838);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 40, 2128, 819);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 40, 2129, 808);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 40, 2130, 816);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 81, 2131, 828);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 40, 2132, 815);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 40, 2133, 846);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 40, 2134, 811);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 40, 2135, 830);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 41, 2136, 829);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 40, 2137, 827);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 40, 2138, 846);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 40, 2139, 805);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 40, 2140, 811);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 40, 2141, 812);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 40, 2142, 830);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 40, 2143, 825);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 40, 2144, 830);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 40, 2145, 828);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 40, 2146, 809);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 40, 2147, 832);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 40, 2148, 816);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 40, 2149, 815);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 91, 2150, 826);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 40, 2151, 802);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 40, 2152, 825);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 40, 2153, 838);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 41, 2154, 822);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 40, 2155, 818);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 40, 2156, 833);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 40, 2157, 803);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 40, 2158, 830);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 41, 2159, 803);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 40, 2160, 829);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 40, 2161, 801);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 40, 2162, 801);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 40, 2163, 815);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 40, 2164, 841);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 41, 2165, 828);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 40, 2166, 803);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 40, 2167, 842);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 40, 2168, 803);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 40, 2169, 834);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 40, 2170, 839);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 40, 2171, 833);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 40, 2172, 805);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 40, 2173, 828);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 40, 2174, 808);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 40, 2175, 805);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 40, 2176, 819);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 40, 2177, 806);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 40, 2178, 840);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 40, 2179, 804);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 40, 2180, 818);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 41, 2181, 823);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 40, 2182, 832);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 40, 2183, 839);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 41, 2184, 849);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 75, 2185, 827);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 40, 2186, 811);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 48, 2187, 823);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 40, 2188, 813);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 40, 2189, 825);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 41, 2190, 816);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 40, 2191, 834);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 41, 2192, 831);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 41, 2193, 806);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 40, 2194, 801);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 40, 2195, 843);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 41, 2196, 815);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 41, 2197, 820);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 40, 2198, 831);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 40, 2199, 849);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 40, 2200, 819);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 41, 2201, 825);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 86, 2202, 843);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 40, 2203, 801);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 40, 2204, 805);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 40, 2205, 807);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 41, 2206, 817);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 40, 2207, 816);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 40, 2208, 808);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 41, 2209, 825);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 40, 2210, 807);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 40, 2211, 841);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 41, 2212, 831);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 41, 2213, 806);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 40, 2214, 813);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 40, 2215, 802);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 40, 2216, 831);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 40, 2217, 812);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 40, 2218, 844);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 40, 2219, 822);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 40, 2220, 830);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 40, 2221, 836);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 40, 2222, 802);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 40, 2223, 849);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 40, 2224, 849);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 40, 2225, 825);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 40, 2226, 845);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 40, 2227, 825);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 41, 2228, 838);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 40, 2229, 803);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 40, 2230, 849);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 40, 2231, 808);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 40, 2232, 802);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 41, 2233, 824);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 40, 2234, 843);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 40, 2235, 840);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 76, 2236, 828);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 40, 2237, 806);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 40, 2238, 802);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 78, 2239, 814);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 40, 2240, 801);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 40, 2241, 839);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 41, 2242, 827);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 40, 2243, 849);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 40, 2244, 820);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 40, 2245, 806);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 40, 2246, 837);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 41, 2247, 803);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 61, 2248, 841);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 40, 2249, 833);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 75, 2250, 802);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 40, 2251, 805);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 40, 2252, 825);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 40, 2253, 817);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 47, 2254, 810);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 40, 2255, 819);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 40, 2256, 846);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 40, 2257, 843);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 71, 2258, 809);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 40, 2259, 840);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 40, 2260, 814);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 40, 2261, 805);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 40, 2262, 816);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 52, 2263, 808);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 63, 2264, 839);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 41, 2265, 817);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 40, 2266, 839);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 40, 2267, 823);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 40, 2268, 818);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 40, 2269, 806);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 40, 2270, 841);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 40, 2271, 809);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 40, 2272, 844);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 40, 2273, 838);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 72, 2274, 808);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 40, 2275, 804);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 40, 2276, 801);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 50, 2277, 814);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 40, 2278, 830);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 40, 2279, 830);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 40, 2280, 810);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 40, 2281, 845);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 41, 2282, 834);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 40, 2283, 803);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 40, 2284, 818);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 40, 2285, 824);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 78, 2286, 848);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 40, 2287, 817);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 41, 2288, 822);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 40, 2289, 830);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 40, 2290, 813);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 40, 2291, 831);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 40, 2292, 845);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 40, 2293, 801);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 40, 2294, 847);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 40, 2295, 816);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 40, 2296, 831);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 40, 2297, 849);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 40, 2298, 803);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 40, 2299, 815);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 40, 2300, 842);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 40, 2301, 812);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 40, 2302, 841);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 40, 2303, 817);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 40, 2304, 818);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 40, 2305, 850);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 40, 2306, 805);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 40, 2307, 846);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 40, 2308, 838);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 91, 2309, 816);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 40, 2310, 824);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 40, 2311, 803);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 44, 2312, 833);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 40, 2313, 809);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 41, 2314, 808);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 40, 2315, 839);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 40, 2316, 802);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 40, 2317, 833);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 41, 2318, 801);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 40, 2319, 825);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 40, 2320, 816);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 40, 2321, 842);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 40, 2322, 821);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 78, 2323, 812);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 40, 2324, 836);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 40, 2325, 816);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 41, 2326, 818);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 40, 2327, 826);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 40, 2328, 841);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 40, 2329, 825);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 41, 2330, 825);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 40, 2331, 822);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 40, 2332, 846);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 40, 2333, 848);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 49, 2334, 845);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 40, 2335, 805);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 40, 2336, 843);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 40, 2337, 835);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 40, 2338, 818);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 40, 2339, 833);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 41, 2340, 850);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 40, 2341, 848);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 40, 2342, 809);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 40, 2343, 818);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 40, 2344, 818);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 40, 2345, 849);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 40, 2346, 811);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 40, 2347, 828);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 41, 2348, 848);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 41, 2349, 845);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 41, 2350, 840);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 40, 2351, 823);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 40, 2352, 805);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 41, 2353, 822);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 40, 2354, 841);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 68, 2355, 809);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 40, 2356, 840);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 40, 2357, 821);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 40, 2358, 809);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 40, 2359, 814);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 40, 2360, 848);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 40, 2361, 811);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 40, 2362, 817);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 40, 2363, 842);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 73, 2364, 801);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 40, 2365, 815);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 40, 2366, 824);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 41, 2367, 847);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 40, 2368, 830);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 40, 2369, 839);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 40, 2370, 838);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 40, 2371, 838);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 40, 2372, 802);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 40, 2373, 841);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 40, 2374, 832);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 40, 2375, 803);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 40, 2376, 836);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 40, 2377, 849);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 90, 2378, 803);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 40, 2379, 826);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (7, 40, 2380, 802);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 40, 2381, 832);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 41, 2382, 816);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 40, 2383, 850);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 40, 2384, 805);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 40, 2385, 844);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 40, 2386, 827);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 41, 2387, 818);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (8, 40, 2388, 813);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 40, 2389, 835);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 40, 2390, 807);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 41, 2391, 833);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 44, 2392, 842);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 40, 2393, 833);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 40, 2394, 808);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (9, 41, 2395, 815);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (2, 40, 2396, 801);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (5, 69, 2397, 832);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 40, 2398, 835);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (4, 40, 2399, 818);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 40, 3000, 825);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (6, 40, 3001, 836);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 40, 3002, 840);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (3, 40, 3003, 846);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (10, 40, 3004, 804);
insert into INVENTORY (shelf, unitsinstock, inventoryid, catalognumber)
values (1, 40, 1, 802);
prompt 406 records loaded
prompt Loading WORKERS...
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 50, 'GAAD4Gvz@gmail.com', 526956196, 'Afternoon', 1, 'Elias Martin');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 50, '6nH7yatv@gmail.com', 546597191, 'Evening', 2, 'Oliver Young');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 0, 'gi7BAUJU@gmail.com', 531149208, 'Morning', 3, 'Jackson Murphy');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 100, 'Y5kCLDmE@gmail.com', 539048194, 'Afternoon', 4, 'Elijah Robinson');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 100, '1hYiTP6g@gmail.com', 536732435, 'Evening', 5, 'David Carter');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 100, 'oiTZv76k@gmail.com', 571796738, 'Morning', 6, 'Claire Miller');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 0, 'eZslowdS@gmail.com', 535796510, 'Evening', 7, 'Aurora Turner');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 0, 'Jm4gMp5R@gmail.com', 569391226, 'Evening', 8, 'Emma Wright');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 0, 'x4XJknNp@gmail.com', 572740432, 'Morning', 9, 'Amelia Campbell');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 0, 'EsdgtOYs@gmail.com', 576945371, 'Morning', 10, 'Sophia King');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 50, 'WCduuOBr@gmail.com', 536342312, 'Evening', 11, 'Olivia Scott');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 0, 'UHRBwxhc@gmail.com', 509286034, 'Evening', 12, 'Harper Young');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 0, 'A9qO1tjN@gmail.com', 595522957, 'Morning', 13, 'Henry Lopez');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 50, '78OofnqK@gmail.com', 591200672, 'Afternoon', 14, 'Benjamin Hall');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 100, '1gDaAeE9@gmail.com', 583586434, 'Afternoon', 15, 'William Jones');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 0, 'TgXQrIAR@gmail.com', 552337692, 'Morning', 16, 'Sophia Anderson');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 0, 'BwlXs3S0@gmail.com', 514103974, 'Afternoon', 17, 'Claire Miller');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 50, 'IeI0C6pp@gmail.com', 529814090, 'Evening', 18, 'Elizabeth Lee');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 50, 'YE1J0PXg@gmail.com', 508291301, 'Afternoon', 19, 'Avah Lewis');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 0, 'pqMgEsc5@gmail.com', 504357854, 'Afternoon', 20, 'Luna Phillips');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 0, 'PUFX199h@gmail.com', 572260269, 'Afternoon', 21, 'Violet Young');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 0, 'PQrlU0DH@gmail.com', 503386039, 'Morning', 22, 'Avery Davis');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 50, '8BCFLbEI@gmail.com', 533375134, 'Afternoon', 23, 'Oliver Turner');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 50, 'An40xdkZ@gmail.com', 597321717, 'Afternoon', 24, 'Aaliyah Carter');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 0, 'm20jWqa7@gmail.com', 557836241, 'Evening', 25, 'Harper Baker');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 50, 'AiX7Iylg@gmail.com', 565811105, 'Evening', 26, 'Amelia Diaz');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 100, 'xIo5Rzc4@gmail.com', 591157312, 'Afternoon', 27, 'Isabella Wright');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 50, 'aR6JSBjz@gmail.com', 548441159, 'Afternoon', 28, 'Liam Nelson');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 100, 'vyTAEOkY@gmail.com', 562938459, 'Afternoon', 29, 'Liam Smith');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 0, 'LXPribsA@gmail.com', 528746755, 'Afternoon', 30, 'Aaliyah Hernandez');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 50, 'V463Osef@gmail.com', 582066880, 'Morning', 31, 'Liam Young');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 100, '96k9xQ2o@gmail.com', 538201036, 'Evening', 32, 'Abigail Moore');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 100, 'L1E3kf4V@gmail.com', 570649166, 'Evening', 33, 'Liam Phillips');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 0, 'W2XH0zYT@gmail.com', 559682130, 'Evening', 34, 'Evelyn Campbell');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 50, 'TwnwCmkt@gmail.com', 542467998, 'Morning', 35, 'Mason Miller');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 0, 'yrybonQD@gmail.com', 576716252, 'Morning', 36, 'Abigail Walker');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 0, 'jP8RHiOr@gmail.com', 562485543, 'Morning', 37, 'Elizabeth Scott');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 50, 'y33H0Fak@gmail.com', 531392041, 'Evening', 38, 'William Jones');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 50, 'c6hSZvJG@gmail.com', 519970445, 'Evening', 39, 'William Rodriguez');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 0, 'tamyBCgo@gmail.com', 550479868, 'Afternoon', 40, 'Ava Wright');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 50, 'rEvppcLv@gmail.com', 522955072, 'Afternoon', 41, 'Evelyn Rodriguez');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 0, '8Vp9sFwY@gmail.com', 577536719, 'Afternoon', 42, 'Elijah Wood');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 100, 'j5c9aE2Y@gmail.com', 563747501, 'Evening', 43, 'Jackson Bell');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 0, 'LpC6obrr@gmail.com', 525879367, 'Evening', 44, 'James Campbell');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 50, 'fr07YdqE@gmail.com', 538306078, 'Morning', 45, 'Camila Young');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 50, 'R7tQK1Sr@gmail.com', 526704387, 'Morning', 46, 'Mateo Robinson');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 0, 'dgz3BOmZ@gmail.com', 518269520, 'Afternoon', 47, 'Alexander Mitchell');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 50, 'j4CbgqnF@gmail.com', 558056698, 'Morning', 48, 'Henry Scott');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 0, 'moQMLCBt@gmail.com', 599394146, 'Afternoon', 49, 'Lucas Wright');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 50, '2hBAWI0n@gmail.com', 554253415, 'Morning', 50, 'Mason Diaz');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 0, 'BX18EyNn@gmail.com', 509320960, 'Morning', 51, 'Harper Clark');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 0, '1sqQ1w5V@gmail.com', 515633392, 'Afternoon', 52, 'Lucas Miller');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 100, 'LY7TfiiT@gmail.com', 506938505, 'Evening', 53, 'Benjamin Walker');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 100, 'LBEDM70b@gmail.com', 589856059, 'Morning', 54, 'Charlotte Allen');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 50, 'yo7rv2m3@gmail.com', 560529370, 'Morning', 55, 'Mia Martin');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 50, 'OMBpYwxP@gmail.com', 584697110, 'Afternoon', 56, 'William Williams');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 0, 'cIRI8C7I@gmail.com', 517804862, 'Evening', 57, 'Liam Moore');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 50, 'ZQzzg1z8@gmail.com', 514869393, 'Morning', 58, 'Charlotte Robinson');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 50, '1aEjz3kV@gmail.com', 530469739, 'Evening', 59, 'Benjamin Campbell');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 0, 'Y3KC4Cwy@gmail.com', 514138556, 'Evening', 60, 'Avery Diaz');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 0, 'ZeJhzX67@gmail.com', 533642917, 'Afternoon', 61, 'Avery Allen');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 0, 'ZL0p4XNn@gmail.com', 551519517, 'Afternoon', 62, 'Benjamin Wright');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 50, 'z2VMinVL@gmail.com', 556545258, 'Morning', 63, 'Michael Robinson');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 0, '2OnnjRrd@gmail.com', 559270669, 'Evening', 64, 'Emma Johnson');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 50, 'jE3hUxyX@gmail.com', 571219730, 'Afternoon', 65, 'Julian Hall');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 0, 'QaxWvBKD@gmail.com', 576451537, 'Evening', 66, 'Julian Harris');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 0, 'wMZR4ZpO@gmail.com', 581288119, 'Afternoon', 67, 'Michael Rodriguez');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 100, 'mbvL0VI6@gmail.com', 578763693, 'Evening', 68, 'Sofia Thomas');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 0, 'zsGxd509@gmail.com', 518611303, 'Morning', 69, 'Charlotte Hall');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 0, 'PdtASed0@gmail.com', 593795124, 'Morning', 70, 'Sofia Wright');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 50, 'gMhuzYc0@gmail.com', 505817467, 'Morning', 71, 'Noah Rodriguez');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 0, 'g9qHbSom@gmail.com', 506487681, 'Afternoon', 72, 'Charlotte Lewis');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 0, 'b28ERxnM@gmail.com', 535336993, 'Evening', 73, 'Noah Young');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 50, 'UVWpEaTp@gmail.com', 579430329, 'Morning', 74, 'Evelyn Wright');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 0, 's2af13fR@gmail.com', 541135262, 'Afternoon', 75, 'Sophia Williams');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 50, 'FqYIP34w@gmail.com', 516256511, 'Afternoon', 76, 'Mason Murphy');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 150, 'AzIy1pPl@gmail.com', 559027760, 'Morning', 77, 'Elias Gonzalez');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 0, '3lBcPXTY@gmail.com', 558713988, 'Evening', 78, 'James Wood');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 0, 'tEXa18Z0@gmail.com', 565641120, 'Morning', 79, 'Mason Walker');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 50, 'YnbzsL8k@gmail.com', 514677999, 'Morning', 80, 'Lucas Green');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 100, '6vuL1i45@gmail.com', 592891900, 'Morning', 81, 'Camila Robinson');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 100, 'R3XSwBgh@gmail.com', 534674181, 'Evening', 82, 'James Moore');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 0, '1S7eqI8N@gmail.com', 527521685, 'Afternoon', 83, 'Aaliyah Gonzalez');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 50, 'iiA9miYG@gmail.com', 590019845, 'Morning', 84, 'Liam Davis');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 0, 'huBX75Wh@gmail.com', 513678912, 'Morning', 85, 'Evelyn Diaz');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 50, 'EMGWCTS5@gmail.com', 589669940, 'Afternoon', 86, 'Liam Garcia');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 0, 'oz8Nb2bz@gmail.com', 557015726, 'Evening', 87, 'Charlotte Phillips');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 50, '4kl334Bn@gmail.com', 531052830, 'Afternoon', 88, 'Mason Phillips');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 0, 'yMVMCZ7h@gmail.com', 555702962, 'Evening', 89, 'William Murphy');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 50, '5f1WD2Xo@gmail.com', 511894314, 'Afternoon', 90, 'Avery Lewis');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 50, '4Wu71MDW@gmail.com', 578702453, 'Afternoon', 91, 'Amelia Rodriguez');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 100, 'XMCOe0fe@gmail.com', 594196850, 'Afternoon', 92, 'James Thomas');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 0, 'oFS0IBpL@gmail.com', 591233538, 'Evening', 93, 'Emily Lopez');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 50, 'VDNcyBOx@gmail.com', 536391125, 'Evening', 94, 'Charlotte Young');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 0, 'rDjEC4YH@gmail.com', 573536531, 'Afternoon', 95, 'Aaliyah Lewis');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 50, 'Ddz5l3nJ@gmail.com', 515834600, 'Evening', 96, 'Mia Nelson');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 50, 'TSDFFn7m@gmail.com', 518387970, 'Afternoon', 97, 'Evelyn Smith');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 0, 'IliqJvrF@gmail.com', 520689705, 'Morning', 98, 'Sophia Scott');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 0, 'vN40wQJS@gmail.com', 592974002, 'Morning', 99, 'Zoe King');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 50, 'vYFi1BNC@gmail.com', 586450881, 'Morning', 100, 'Mason Thomas');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 50, 'UT4TU1O0@gmail.com', 574137010, 'Evening', 101, 'Elizabeth Cruz');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 50, 'UiUYf8Kr@gmail.com', 555217403, 'Afternoon', 102, 'Evelyn Baker');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 0, 'wR9vUehQ@gmail.com', 509569472, 'Evening', 103, 'Alexander Clark');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 0, 'OeJNOmXf@gmail.com', 524097816, 'Morning', 104, 'Sophia Harris');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 50, 'clAJN0Nh@gmail.com', 534741037, 'Evening', 105, 'Evelyn Turner');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 50, 'G0uVF44A@gmail.com', 545070072, 'Afternoon', 106, 'Mia Hall');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 0, 'RGAB4ucq@gmail.com', 501126493, 'Afternoon', 107, 'Mason Scott');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 0, 'TYgdOxLE@gmail.com', 548989383, 'Morning', 108, 'Ethan Harris');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 50, 'aGUQeB5c@gmail.com', 555318955, 'Afternoon', 109, 'Jackson Clark');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 50, 'XWUIykwf@gmail.com', 565578192, 'Afternoon', 110, 'Ethan Adams');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 50, 'qfwMbMps@gmail.com', 518829946, 'Morning', 111, 'Evelyn Roberts');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 50, 'aws8ige6@gmail.com', 527584920, 'Afternoon', 112, 'Lucas Bell');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 50, 'aYZ6sirl@gmail.com', 582531445, 'Evening', 113, 'Logan Young');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 50, 'jNnxEo0t@gmail.com', 595609972, 'Afternoon', 114, 'Zoe Harris');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 0, 'JMRhxR4E@gmail.com', 512946955, 'Afternoon', 115, 'Sophia Moore');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 50, 'WpbRE2Bg@gmail.com', 528942704, 'Afternoon', 116, 'Aurora Wilson');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 50, 'SydIGlDu@gmail.com', 573069644, 'Afternoon', 117, 'Luna Moore');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 50, 'xomIejjz@gmail.com', 543442604, 'Afternoon', 118, 'Oliver Wilson');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 0, 'srcIaymu@gmail.com', 531311411, 'Morning', 119, 'Claire Moore');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 50, 'bhMGH8Ps@gmail.com', 546038928, 'Morning', 120, 'Ethan Jackson');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 0, 'eAajFqMr@gmail.com', 517544772, 'Afternoon', 121, 'Jackson Lee');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 0, 'Q9v3OY7v@gmail.com', 590831902, 'Afternoon', 122, 'Maverick Thomas');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 0, 'xlUR5WMd@gmail.com', 574811782, 'Evening', 123, 'Charlotte Brown');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 0, 'aZ1FtSUv@gmail.com', 566142031, 'Evening', 124, 'Scarlett Lewis');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 0, 'AZFIAUPh@gmail.com', 586384716, 'Morning', 125, 'Ethan Moore');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 50, 'tgyP87nU@gmail.com', 566625064, 'Morning', 126, 'Mason Johnson');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 0, 'cZbJD4ZV@gmail.com', 541758860, 'Morning', 127, 'Harper Allen');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 50, '8DI1thph@gmail.com', 505065140, 'Morning', 128, 'Scarlett Allen');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 0, 'IEK1LKdt@gmail.com', 596851087, 'Evening', 129, 'Lucas Campbell');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 100, 'ivjD1J4C@gmail.com', 589054493, 'Morning', 130, 'Ella Thomas');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 0, 'VlsjjorT@gmail.com', 595616828, 'Morning', 131, 'Emma Hernandez');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 100, 'rPPxv09W@gmail.com', 592759653, 'Afternoon', 132, 'Mason Young');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 50, 'k4MydnyK@gmail.com', 511439653, 'Afternoon', 133, 'Avery Johnson');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 0, 'ucGpH8gv@gmail.com', 544503063, 'Morning', 134, 'Matthew Davis');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 0, 'agKPJ3wb@gmail.com', 542738027, 'Afternoon', 135, 'Ethan Robinson');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 100, 'nHwPrbmO@gmail.com', 584238863, 'Morning', 136, 'Logan Allen');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 0, 'xs4zal62@gmail.com', 560033171, 'Evening', 137, 'Mason Scott');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 50, 'zxx8ybq2@gmail.com', 504085308, 'Afternoon', 138, 'Ella Turner');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 50, 'vZHo0yRM@gmail.com', 558600621, 'Evening', 139, 'Mason Lopez');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 0, 'vsU037yi@gmail.com', 570833546, 'Afternoon', 140, 'Aaliyah Walker');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 0, 'JMqdDBMT@gmail.com', 537566076, 'Evening', 141, 'Olivia Mitchell');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 50, 'pJPqEnHH@gmail.com', 537021434, 'Afternoon', 142, 'Ethan Nelson');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 100, 'EFUAeDcN@gmail.com', 548756040, 'Morning', 143, 'Alexander Miller');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 0, 'sDXsGKz7@gmail.com', 586233230, 'Morning', 144, 'Mason King');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 0, 'I7HPYKIv@gmail.com', 560352029, 'Afternoon', 145, 'Ethan Hall');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 50, 'pML4bvqf@gmail.com', 565054766, 'Morning', 146, 'Elias Carter');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 50, '54iAcoEo@gmail.com', 596145348, 'Afternoon', 147, 'Emily Turner');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 0, 'lWCpHFXn@gmail.com', 559362076, 'Evening', 148, 'Charlotte Rodriguez');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 100, 'LaPkhLQz@gmail.com', 575258169, 'Morning', 149, 'Mason Clark');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 50, 'WxnydswT@gmail.com', 527595994, 'Afternoon', 150, 'Elias Miller');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 50, 'lgolGf2Y@gmail.com', 525772289, 'Afternoon', 151, 'James Carter');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 50, 'If2sIZSO@gmail.com', 544766314, 'Afternoon', 152, 'Charlotte Hall');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 100, 'vTyQEpqy@gmail.com', 534884493, 'Evening', 153, 'Oliver Davis');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 0, 'Wk1Ilwzs@gmail.com', 597121496, 'Morning', 154, 'Emma Turner');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 0, 'F5GvjfaO@gmail.com', 594766367, 'Morning', 155, 'Liam Moore');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 50, 'j9jLB4Hv@gmail.com', 574160322, 'Afternoon', 156, 'James Garcia');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 0, 'vxEoIODK@gmail.com', 527686916, 'Afternoon', 157, 'Mason Jackson');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 50, '09bBLCcP@gmail.com', 562694889, 'Morning', 158, 'Mason Lee');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 50, '0V5RCVD8@gmail.com', 577044786, 'Afternoon', 159, 'Avah Robinson');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 100, 'CQyYvjmI@gmail.com', 523297388, 'Morning', 160, 'Abigail Young');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 100, 'aoleN6Vt@gmail.com', 509334722, 'Morning', 161, 'William Moore');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 50, 'HV1XooNy@gmail.com', 513601393, 'Afternoon', 162, 'William Walker');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 50, '0ZxDdRwA@gmail.com', 507855207, 'Evening', 163, 'Ethan Hernandez');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 50, 'G58rumS1@gmail.com', 533322083, 'Afternoon', 164, 'Olivia Green');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 0, 'GooEaANg@gmail.com', 527399786, 'Afternoon', 165, 'Evelyn Diaz');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 0, '6LlVevcq@gmail.com', 513149746, 'Evening', 166, 'Stella Rodriguez');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 50, 'QVsHI8BY@gmail.com', 546426321, 'Afternoon', 167, 'Avery Walker');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 50, 'a1biOq9X@gmail.com', 525700652, 'Afternoon', 168, 'Avah Davis');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 0, 'VWflwFhY@gmail.com', 532528104, 'Evening', 169, 'Lucas Walker');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 50, 'yptSwt2n@gmail.com', 553610071, 'Evening', 170, 'William Clark');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 50, 'jeEdXLde@gmail.com', 505214713, 'Evening', 171, 'Mason Scott');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 0, 'EV2GPBGD@gmail.com', 563189422, 'Morning', 172, 'Jackson Diaz');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 0, 'fRfEc48B@gmail.com', 591574501, 'Evening', 173, 'Henry Davis');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 100, 'fB3pXp5X@gmail.com', 510343881, 'Morning', 174, 'Emma Clark');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 50, 'C1eJDe9d@gmail.com', 517188523, 'Evening', 175, 'Isabella Allen');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 0, 'Nh6euYyz@gmail.com', 512850072, 'Afternoon', 176, 'Ava Wright');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 0, 'IAKsJUuX@gmail.com', 506139868, 'Afternoon', 177, 'Emily Phillips');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 0, 'xd1DVx7G@gmail.com', 517827818, 'Afternoon', 178, 'Elijah Allen');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 100, '1YvanWcs@gmail.com', 527082662, 'Afternoon', 179, 'Ava Lopez');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 0, 'qLuHEmxt@gmail.com', 575352411, 'Morning', 180, 'David Allen');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 0, 'Sse3B30V@gmail.com', 506840153, 'Afternoon', 181, 'James Roberts');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 0, '15Kj3rKL@gmail.com', 578405706, 'Evening', 182, 'Noah Anderson');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 50, 'Du7es9Vi@gmail.com', 560462040, 'Morning', 183, 'Liam Roberts');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 0, 'E3jatcrq@gmail.com', 528570438, 'Evening', 184, 'Alexander Wright');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 0, 'zvNKJpct@gmail.com', 596291725, 'Afternoon', 185, 'Lucas Campbell');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 100, '3VyXMrJI@gmail.com', 566764860, 'Afternoon', 186, 'Logan Hall');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 100, 'epsYzeoF@gmail.com', 533303640, 'Morning', 187, 'Noah Garcia');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 50, 'cq9RuSZY@gmail.com', 590571518, 'Morning', 188, 'Mason Williams');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 0, 'JOILxHhW@gmail.com', 516385582, 'Afternoon', 189, 'Lucas Robinson');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 0, 'fPmwCbFX@gmail.com', 558461953, 'Morning', 190, 'Mia Garcia');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 0, 'oyCZpce5@gmail.com', 528718737, 'Morning', 191, 'Emma Clark');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 0, 'Gb0pNOAc@gmail.com', 542487569, 'Evening', 192, 'Sophia Phillips');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 0, 'bLCXDjJj@gmail.com', 524998883, 'Afternoon', 193, 'Aaliyah Lee');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 0, 'eQxsMA9I@gmail.com', 575134006, 'Afternoon', 194, 'Alexander Nelson');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 0, 'SIItpMkl@gmail.com', 561817795, 'Morning', 195, 'Logan Harris');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 50, '2V7QmuiF@gmail.com', 534931109, 'Morning', 196, 'Ava Miller');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 200, 'El96HfMS@gmail.com', 500409706, 'Morning', 197, 'Sofia Lewis');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 0, 'oxYWZ70x@gmail.com', 531691969, 'Evening', 198, 'Violet Miller');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 100, 'ncYwERq3@gmail.com', 553931039, 'Morning', 199, 'Lucas Williams');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 0, 'rpKkYKgY@gmail.com', 562634725, 'Morning', 200, 'Logan Gonzalez');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 50, 'AwOXCzWZ@gmail.com', 574218628, 'Afternoon', 201, 'Amelia Hall');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 50, 'svWZ7714@gmail.com', 508026335, 'Evening', 202, 'Oliver Garcia');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 50, 'jPqXIQLE@gmail.com', 526015865, 'Morning', 203, 'Camila Thomas');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 50, 'eZwpJHgi@gmail.com', 592889041, 'Afternoon', 204, 'Liam Miller');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 150, 'kPAEStkz@gmail.com', 579243132, 'Afternoon', 205, 'Luna Robinson');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 0, 'SyE1GHP9@gmail.com', 588095528, 'Evening', 206, 'Elijah Robinson');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 0, 'hiULWto3@gmail.com', 577369574, 'Afternoon', 207, 'Alexander Clark');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 0, 'QyTXC6lB@gmail.com', 512228547, 'Afternoon', 208, 'Harper Lewis');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 50, '9vBXK02L@gmail.com', 519766797, 'Afternoon', 209, 'Violet Lewis');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 0, 'SVOw5bN2@gmail.com', 589811074, 'Afternoon', 210, 'Ella Robinson');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 0, 'XUd2wzmZ@gmail.com', 571386119, 'Afternoon', 211, 'Sophia Allen');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 100, 'aLVYLpGc@gmail.com', 525483933, 'Morning', 212, 'Emily Lee');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 50, 'dAraXMZi@gmail.com', 528757463, 'Morning', 213, 'Emily Baker');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 0, 'pl7oRCHj@gmail.com', 591132607, 'Evening', 214, 'Charlotte Hernandez');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 0, '7ipiuIGo@gmail.com', 529988373, 'Morning', 215, 'Ava Roberts');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 0, 'ulG9z5kA@gmail.com', 532130221, 'Evening', 216, 'Ava Harris');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 0, 'WH8peg4h@gmail.com', 541159511, 'Morning', 217, 'Ella Hall');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 100, '6mmev0SD@gmail.com', 574913325, 'Evening', 218, 'Amelia King');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 0, 'qPK7uXjo@gmail.com', 594141307, 'Morning', 219, 'Elias Clark');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 50, 'NP2YKEOh@gmail.com', 503691848, 'Evening', 220, 'Lucas Robinson');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 50, 'cnF0Q8r4@gmail.com', 580303312, 'Evening', 221, 'Mason Robinson');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 0, 'B0wc6qpu@gmail.com', 528715481, 'Afternoon', 222, 'Emily Bell');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 150, 'z14fOBcW@gmail.com', 525309009, 'Morning', 223, 'Noah Scott');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 0, 'NU7sEQIj@gmail.com', 510126263, 'Afternoon', 224, 'Henry Lopez');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 100, 'OlpBc5Xe@gmail.com', 536192517, 'Morning', 225, 'Harper Young');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 0, 'lXG8nerh@gmail.com', 548228870, 'Morning', 226, 'Ethan Lewis');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 0, '1ifGUc4B@gmail.com', 547207818, 'Afternoon', 227, 'Avery Rodriguez');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 0, 'gT4Z3UwM@gmail.com', 571952438, 'Afternoon', 228, 'Charlotte Nelson');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 0, 'XwwLVDue@gmail.com', 550179038, 'Afternoon', 229, 'Ava Robinson');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 100, 'BAVz1ro4@gmail.com', 567050759, 'Evening', 230, 'James Clark');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 0, 'ErJowWVj@gmail.com', 555868937, 'Morning', 231, 'Evelyn Hernandez');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 100, '4ic3eaE7@gmail.com', 511668852, 'Morning', 232, 'Liam Hall');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 150, 'nNr3DldY@gmail.com', 580066010, 'Afternoon', 233, 'Avery Carter');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 50, 'MvkGvUk1@gmail.com', 569188160, 'Evening', 234, 'Levi Walker');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 0, 'kZZ5j66z@gmail.com', 554897172, 'Morning', 235, 'Zoe Young');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 100, 'BanWriSM@gmail.com', 577858680, 'Evening', 236, 'Abigail Harris');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 0, 'UQ5TiUQL@gmail.com', 579261307, 'Evening', 237, 'Abigail Williams');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 0, '2Rs1uQoO@gmail.com', 570276583, 'Afternoon', 238, 'Henry Hall');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 0, 'PNV4RoPf@gmail.com', 592218810, 'Afternoon', 239, 'James Moore');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 0, 'ZsKVuZcW@gmail.com', 581838870, 'Afternoon', 240, 'Isabella Clark');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 0, 'dIsU4JYG@gmail.com', 598376687, 'Evening', 241, 'William Brown');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 0, 's7gdMvhE@gmail.com', 567889508, 'Afternoon', 242, 'Ella Hernandez');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 0, 'hS8ZfmOF@gmail.com', 534110452, 'Evening', 243, 'Evelyn Garcia');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 50, 'OWzpY2V1@gmail.com', 506705567, 'Morning', 244, 'Ethan Garcia');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 50, 'yoPGV1cr@gmail.com', 528977163, 'Evening', 245, 'Violet Nelson');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 0, 'yt1UpmBy@gmail.com', 544910231, 'Evening', 246, 'Alexander Moore');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 0, 'S2tejpIh@gmail.com', 520022597, 'Evening', 247, 'Elijah Young');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 100, 'gI76Rufv@gmail.com', 531383560, 'Afternoon', 248, 'Isabella Campbell');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 0, '5mXEvkUZ@gmail.com', 559346498, 'Afternoon', 249, 'Liam Pierce');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 50, 'sNsdC7sc@gmail.com', 589537870, 'Morning', 250, 'Logan Allen');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 0, 'F3ivUYE2@gmail.com', 547593159, 'Evening', 251, 'Evelyn Wilson');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 0, '7wLDHASG@gmail.com', 540415830, 'Morning', 252, 'Alexander Wright');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 0, 'Bj1WDAV9@gmail.com', 559828330, 'Evening', 253, 'Claire Lewis');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 50, '78qrfTPG@gmail.com', 563886939, 'Evening', 254, 'Elijah Wright');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 0, 'X1bCvrA0@gmail.com', 577713103, 'Morning', 255, 'Evelyn Moore');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 50, '1MZi0zES@gmail.com', 572292450, 'Morning', 256, 'Mason Nelson');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 100, 'wjayEG9a@gmail.com', 542436459, 'Morning', 257, 'Ava Garcia');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 50, '5YM23Phy@gmail.com', 566109080, 'Afternoon', 258, 'Ava Smith');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 50, '7fysTn9q@gmail.com', 569388320, 'Morning', 259, 'Noah Robinson');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 0, 'YtRNzE95@gmail.com', 515336181, 'Afternoon', 260, 'Amelia Scott');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 100, 'ZgOCD7mK@gmail.com', 557732368, 'Afternoon', 261, 'Claire Nelson');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 0, 'fQoSKNlq@gmail.com', 590957961, 'Afternoon', 262, 'Henry Walker');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 0, 'n0GNo1C5@gmail.com', 591147522, 'Morning', 263, 'Mateo Scott');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 0, '7oshZjvY@gmail.com', 557662005, 'Afternoon', 264, 'Noah Adams');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 150, 'i4p5S5ph@gmail.com', 586488440, 'Morning', 265, 'Ethan Young');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 100, 'VWQ7pIvC@gmail.com', 546026199, 'Afternoon', 266, 'Logan Wood');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 0, 'FMtVD4mL@gmail.com', 533068166, 'Morning', 267, 'Oliver Anderson');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 50, 'pJkHXxo7@gmail.com', 575733860, 'Morning', 268, 'Mason Lewis');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 50, 'Pwbtidb5@gmail.com', 532540716, 'Morning', 269, 'Aaliyah Scott');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 0, 'zNgTfUJB@gmail.com', 511838668, 'Morning', 270, 'Scarlett Williams');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 50, 'zugoH8YT@gmail.com', 598230508, 'Afternoon', 271, 'Elijah Walker');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 0, '3v7yUitg@gmail.com', 536387642, 'Morning', 272, 'Isabella Davis');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 0, 'y3fARtvX@gmail.com', 548006453, 'Morning', 273, 'Elijah Diaz');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 0, '3SPWqyxT@gmail.com', 587853962, 'Evening', 274, 'Abigail Nelson');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 0, '7BPE475D@gmail.com', 520756674, 'Evening', 275, 'Noah Scott');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 0, '4oVEzN7D@gmail.com', 584091607, 'Morning', 276, 'Harper Robinson');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 100, '73CNXgLe@gmail.com', 573579439, 'Afternoon', 277, 'Elijah Turner');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 0, 'e088K4ub@gmail.com', 554122833, 'Morning', 278, 'Aurora Jones');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 0, 'e2HoJDXL@gmail.com', 590104781, 'Afternoon', 279, 'Mason Carter');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 50, 'gSCJQDC9@gmail.com', 595217872, 'Morning', 280, 'Abigail Nelson');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 50, 'BUl9qC0N@gmail.com', 567653563, 'Morning', 281, 'Evelyn Rodriguez');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 0, 'ouDk88o5@gmail.com', 577958343, 'Evening', 282, 'Abigail Robinson');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 0, 'ZDacUbuX@gmail.com', 571561354, 'Evening', 283, 'Amelia Pierce');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 0, 'wTA5V7Fv@gmail.com', 528898041, 'Evening', 284, 'Avah Brown');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 50, 'EWbd0j05@gmail.com', 506839883, 'Evening', 285, 'Logan Hernandez');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 50, 'LoXInppJ@gmail.com', 578454668, 'Evening', 286, 'Levi Lewis');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 0, 'qKTjenvZ@gmail.com', 594965585, 'Morning', 287, 'Mason Murphy');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 0, '4AdEhwEm@gmail.com', 555498620, 'Afternoon', 288, 'Alexander Davis');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 0, 'HDgBIXGB@gmail.com', 569402622, 'Afternoon', 289, 'Aurora Harris');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 0, 'WLI8MrrN@gmail.com', 554160845, 'Evening', 290, 'Michael Garcia');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 0, 'XSwBn6TI@gmail.com', 528560931, 'Evening', 291, 'William Garcia');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 100, 'J8ygK8VI@gmail.com', 575459032, 'Morning', 292, 'Jackson Miller');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 100, 'Ntqah4QO@gmail.com', 548998380, 'Afternoon', 293, 'Mason Wright');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 0, 'YneYvek9@gmail.com', 515055408, 'Evening', 294, 'Harper Lewis');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 50, 'UAUagf14@gmail.com', 534419887, 'Morning', 295, 'Liam Thomas');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 100, 'EAqRLWEb@gmail.com', 514139407, 'Afternoon', 296, 'Amelia Carter');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 50, '2vcE6gcn@gmail.com', 592308752, 'Evening', 297, 'Logan Young');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 0, 'ZYwRHByt@gmail.com', 538598018, 'Morning', 298, 'Amelia Miller');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 100, 'olmJ4R3f@gmail.com', 598403828, 'Afternoon', 299, 'William Scott');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 0, 'axg609LC@gmail.com', 579702487, 'Afternoon', 300, 'Matthew Robinson');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 0, 'fcjcrRPC@gmail.com', 582897136, 'Evening', 301, 'James Allen');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 0, 'tB4JTkwK@gmail.com', 542834118, 'Evening', 302, 'Liam Young');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 50, 'kPD4NLhO@gmail.com', 542289097, 'Afternoon', 303, 'Michael Walker');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 0, 'bYkes5g2@gmail.com', 594398213, 'Evening', 304, 'Charlotte Wright');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 0, 'XXrYMfLK@gmail.com', 556321193, 'Morning', 305, 'Charlotte Diaz');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 0, 't3vI17jv@gmail.com', 556859495, 'Evening', 306, 'James Scott');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 100, 'oWl4bGkg@gmail.com', 592962119, 'Afternoon', 307, 'Olivia Lee');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 200, 'glyekcR9@gmail.com', 593438995, 'Morning', 308, 'Zoe Young');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 0, 'axmujlTH@gmail.com', 526872014, 'Afternoon', 309, 'Elijah Scott');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 100, 'QbFrgMIl@gmail.com', 539648744, 'Afternoon', 310, 'Sophia Lewis');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 0, 'Hb09H3KW@gmail.com', 568019358, 'Afternoon', 311, 'Mason Walker');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 50, 'ltHjHuun@gmail.com', 590862113, 'Morning', 312, 'Mia Lee');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 50, 'dLlGdODf@gmail.com', 591467756, 'Morning', 313, 'Mason Mitchell');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 0, 'mOwFDV6g@gmail.com', 513199101, 'Evening', 314, 'Noah Hall');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 0, 'A4nGnp1S@gmail.com', 516364296, 'Morning', 315, 'Harper Carter');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 0, 'SEerS3Rr@gmail.com', 567924958, 'Morning', 316, 'Amelia Moore');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 50, '5EFoqgKz@gmail.com', 596620804, 'Morning', 317, 'Amelia Moore');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 0, 'L01hqvkR@gmail.com', 542440874, 'Evening', 318, 'Charlotte Lopez');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 50, 'fZLUoxHh@gmail.com', 587109577, 'Evening', 319, 'James Moore');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 0, 'jEHxNwk0@gmail.com', 569587843, 'Morning', 320, 'Evelyn Rodriguez');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 0, '3faVsfLj@gmail.com', 590894657, 'Afternoon', 321, 'Charlotte Hall');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 50, '0zf6SmIz@gmail.com', 501040878, 'Evening', 322, 'Scarlett Sanchez');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 0, 'aUkJHEDA@gmail.com', 559079275, 'Evening', 323, 'Jackson Adams');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 0, 'O6fYRwF1@gmail.com', 528031003, 'Morning', 324, 'Elijah Harris');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 50, 'gkqMbxdr@gmail.com', 507155069, 'Afternoon', 325, 'Noah Diaz');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 50, 'IPPTfI7v@gmail.com', 525547330, 'Morning', 326, 'Violet Walker');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 50, 'kNMBdakM@gmail.com', 557583004, 'Evening', 327, 'Ava Scott');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 0, '5nBtbJz0@gmail.com', 542438189, 'Afternoon', 328, 'Sofia Scott');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 0, '5JesFpQ2@gmail.com', 523023839, 'Morning', 329, 'Avery Jones');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 0, 'E06imdQO@gmail.com', 581097012, 'Afternoon', 330, 'Amelia Young');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 100, 'oVuOgj1n@gmail.com', 526650083, 'Afternoon', 331, 'Evelyn Moore');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 50, 'ONLZCxI9@gmail.com', 569256757, 'Morning', 332, 'Luna Phillips');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 0, 'm5wWgZNn@gmail.com', 588967892, 'Afternoon', 333, 'James Wright');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 100, 'L5a1AmxO@gmail.com', 529437123, 'Morning', 334, 'Mateo Harris');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 100, '24OsitCY@gmail.com', 524796363, 'Morning', 335, 'Avah Robinson');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 100, 'h1nSenl1@gmail.com', 538066996, 'Afternoon', 336, 'Evelyn Wright');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 0, 'PG7Wm3M5@gmail.com', 502971717, 'Afternoon', 337, 'Harper Phillips');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 0, 'u43EI0Kt@gmail.com', 569442839, 'Morning', 338, 'Charlotte Garcia');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 0, 'Q8Xgd3IP@gmail.com', 560797933, 'Afternoon', 339, 'Elizabeth King');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 0, 'vtyUFiSo@gmail.com', 528431079, 'Evening', 340, 'Amelia Pierce');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 50, 'YvSqAf1h@gmail.com', 541835259, 'Afternoon', 341, 'Amelia Green');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 0, 'hYjJRn1E@gmail.com', 512881514, 'Morning', 342, 'Charlotte Lewis');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 50, 'aTTT9QVf@gmail.com', 535597591, 'Morning', 343, 'Elijah Allen');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 0, 'keCdwFJE@gmail.com', 581356571, 'Evening', 344, 'Noah Murphy');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 0, 'FTXhOk4V@gmail.com', 508672051, 'Afternoon', 345, 'Emma Turner');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 0, 'B8ojr5PU@gmail.com', 592310757, 'Morning', 346, 'Harper Bell');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 0, 'oKnBTdVY@gmail.com', 559661771, 'Evening', 347, 'Elijah Phillips');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 50, 'cwJigb05@gmail.com', 536065702, 'Evening', 348, 'Emily Wilson');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 50, 'USbZscUt@gmail.com', 505104160, 'Afternoon', 349, 'Lucas Scott');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 50, 'bjkuMA2b@gmail.com', 552979798, 'Afternoon', 350, 'Sophia Miller');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 100, 'Zsw9tfSi@gmail.com', 539768121, 'Evening', 351, 'Amelia Hernandez');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 0, 'iabiRyfK@gmail.com', 511197573, 'Evening', 352, 'James Robinson');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 0, 'APY82YDE@gmail.com', 599565362, 'Afternoon', 353, 'Lucas Scott');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 0, 'TqyI6rLz@gmail.com', 543251627, 'Afternoon', 354, 'Julian Nelson');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 0, '3dXy9XcC@gmail.com', 514190728, 'Afternoon', 355, 'Penelope Nelson');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 150, 'CdXNbZ6e@gmail.com', 567216812, 'Afternoon', 356, 'Lucas Bell');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 0, 'TGAsCZsb@gmail.com', 552195398, 'Afternoon', 357, 'Mateo Campbell');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 0, 'aTFmk2Vr@gmail.com', 506916652, 'Morning', 358, 'Sofia Moore');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 0, 'YUXxDp8p@gmail.com', 532665232, 'Morning', 359, 'Abigail Rodriguez');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 150, 'JlaFoxfF@gmail.com', 588426256, 'Morning', 360, 'Elijah Clark');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 50, 'It9TwzTP@gmail.com', 507362202, 'Evening', 361, 'Evelyn Diaz');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 50, 'ky9KCP5H@gmail.com', 583161545, 'Evening', 362, 'Violet Wright');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 50, 'lpMrHB7V@gmail.com', 595570776, 'Evening', 363, 'Oliver Gonzalez');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 100, 'XROc5Zko@gmail.com', 515884498, 'Evening', 364, 'Stella Lopez');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 0, 'RyCRF4fn@gmail.com', 524668969, 'Evening', 365, 'Alexander Diaz');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 50, '7xZUUbNR@gmail.com', 540463916, 'Morning', 366, 'Camila Walker');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 50, 'u89Cfmd8@gmail.com', 504254558, 'Morning', 367, 'Sofia Thomas');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 100, 'L81Gkmp1@gmail.com', 501019696, 'Afternoon', 368, 'Emily Johnson');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 0, '70cbwBca@gmail.com', 515042721, 'Morning', 369, 'Benjamin Moore');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 50, 'WGSqXsO2@gmail.com', 500046415, 'Morning', 370, 'Ava Davis');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 50, 'QOSvrh1r@gmail.com', 502776679, 'Morning', 371, 'Sophia Nelson');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 0, 'A7kfOh7V@gmail.com', 527984176, 'Evening', 372, 'Layla Miller');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 0, 'bP8ZZNbn@gmail.com', 591335142, 'Afternoon', 373, 'Mateo Allen');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 0, 'lDx57p3s@gmail.com', 511729022, 'Morning', 374, 'Julian Pierce');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 50, 'g5Hx7qCv@gmail.com', 596598587, 'Morning', 375, 'Evelyn Robinson');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 0, '6UZpSdeG@gmail.com', 531347364, 'Evening', 376, 'Aaliyah Lewis');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 0, 'n4J8tgWh@gmail.com', 594695462, 'Evening', 377, 'Ethan Clark');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 50, 'Ac40NdiY@gmail.com', 536280685, 'Morning', 378, 'Harper Wright');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 50, 'CMqwVbmj@gmail.com', 532415772, 'Evening', 379, 'Claire Rodriguez');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 0, '4gWpq6Aq@gmail.com', 564311166, 'Afternoon', 380, 'Evelyn Lewis');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 50, 'PE1IcXUk@gmail.com', 583541376, 'Afternoon', 381, 'Evelyn Clark');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 50, 'oUGgwero@gmail.com', 593240846, 'Evening', 382, 'Logan Davis');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 50, 'gzcqytz9@gmail.com', 591195411, 'Afternoon', 391, 'Evelyn Cruz');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 0, '4gAOCGvY@gmail.com', 520820659, 'Morning', 392, 'Harper Moore');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 50, 'j9jGVpkE@gmail.com', 583742734, 'Evening', 393, 'Isabella Garcia');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 0, '43H2rpoa@gmail.com', 508996068, 'Afternoon', 394, 'Sophia Moore');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Customer Service Representative', 50, '0wjVxlQp@gmail.com', 504583403, 'Morning', 395, 'Luna Robinson');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values (' Graphic Designer', 0, 'HxKvLbhu@gmail.com', 583027794, 'Afternoon', 396, 'Noah Moore');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 0, 'VZ66xbGU@gmail.com', 553864574, 'Morning', 397, 'Olivia Clark');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 0, '4BVRYEYO@gmail.com', 588097735, 'Morning', 398, 'Stella Thomas');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Prepress Technician', 0, 'Q8WCuvvG@gmail.com', 545871829, 'Evening', 399, 'Levi Carter');
insert into WORKERS (workersrole, wage, workersmail, workersphone, shift, idwo, workersname)
values ('Press Operator', 50, 'KDRiP8Oh@gmail.com', 568170451, 'Evening', 400, 'Benjamin Clark');
prompt 392 records loaded
prompt Loading ORDERS...
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1949, to_date('18-09-2020', 'dd-mm-yyyy'), to_date('07-08-2023', 'dd-mm-yyyy'), 2002, 43, 807, 2100, 514);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1702, to_date('04-11-2021', 'dd-mm-yyyy'), to_date('03-05-2022', 'dd-mm-yyyy'), 2003, 19, 850, 2326, 451);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1198, to_date('22-09-2023', 'dd-mm-yyyy'), to_date('20-01-2022', 'dd-mm-yyyy'), 2004, 223, 829, 2137, 675);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1778, to_date('01-10-2020', 'dd-mm-yyyy'), to_date('27-02-2023', 'dd-mm-yyyy'), 2005, 218, 827, 2098, 421);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1401, to_date('02-02-2022', 'dd-mm-yyyy'), to_date('25-04-2023', 'dd-mm-yyyy'), 2007, 197, 803, 2210, 779);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1451, to_date('26-06-2020', 'dd-mm-yyyy'), to_date('09-05-2021', 'dd-mm-yyyy'), 2009, 382, 816, 2353, 674);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1527, to_date('01-04-2020', 'dd-mm-yyyy'), to_date('17-09-2023', 'dd-mm-yyyy'), 2010, 199, 824, 2398, 777);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1942, to_date('15-12-2022', 'dd-mm-yyyy'), to_date('18-06-2022', 'dd-mm-yyyy'), 2013, 82, 810, 2171, 514);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1080, to_date('18-11-2020', 'dd-mm-yyyy'), to_date('04-02-2020', 'dd-mm-yyyy'), 2014, 96, 804, 2223, 504);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1142, to_date('25-05-2020', 'dd-mm-yyyy'), to_date('27-07-2020', 'dd-mm-yyyy'), 2015, 223, 834, 2393, 600);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1219, to_date('12-09-2020', 'dd-mm-yyyy'), to_date('05-12-2020', 'dd-mm-yyyy'), 2016, 245, 847, 2259, 615);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1478, to_date('05-02-2022', 'dd-mm-yyyy'), to_date('12-12-2021', 'dd-mm-yyyy'), 2018, 33, 844, 2299, 434);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1722, to_date('09-03-2023', 'dd-mm-yyyy'), to_date('03-05-2020', 'dd-mm-yyyy'), 2019, 356, 808, 2263, 434);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1783, to_date('17-05-2022', 'dd-mm-yyyy'), to_date('17-07-2023', 'dd-mm-yyyy'), 2021, 100, 827, 2239, 738);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1825, to_date('01-07-2023', 'dd-mm-yyyy'), to_date('12-10-2023', 'dd-mm-yyyy'), 2022, 15, 832, 2298, 478);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1923, to_date('02-11-2022', 'dd-mm-yyyy'), to_date('23-02-2021', 'dd-mm-yyyy'), 2024, 153, 805, 2142, 495);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1569, to_date('12-06-2022', 'dd-mm-yyyy'), to_date('16-02-2021', 'dd-mm-yyyy'), 2025, 38, 832, 2236, 570);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1695, to_date('27-02-2021', 'dd-mm-yyyy'), to_date('17-12-2022', 'dd-mm-yyyy'), 2027, 132, 805, 2131, 464);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1065, to_date('02-11-2021', 'dd-mm-yyyy'), to_date('14-12-2021', 'dd-mm-yyyy'), 2028, 335, 838, 2359, 756);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1419, to_date('29-09-2021', 'dd-mm-yyyy'), to_date('29-12-2022', 'dd-mm-yyyy'), 2030, 109, 809, 2060, 603);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1589, to_date('13-06-2021', 'dd-mm-yyyy'), to_date('20-03-2020', 'dd-mm-yyyy'), 2032, 48, 808, 2095, 720);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1600, to_date('22-12-2020', 'dd-mm-yyyy'), to_date('21-02-2023', 'dd-mm-yyyy'), 2033, 53, 826, 2304, 792);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1657, to_date('03-12-2020', 'dd-mm-yyyy'), to_date('18-10-2023', 'dd-mm-yyyy'), 2035, 58, 818, 2094, 571);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1857, to_date('13-10-2021', 'dd-mm-yyyy'), to_date('30-11-2023', 'dd-mm-yyyy'), 2037, 4, 820, 2244, 554);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1458, to_date('04-05-2022', 'dd-mm-yyyy'), to_date('05-06-2021', 'dd-mm-yyyy'), 2038, 80, 850, 2040, 477);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1638, to_date('16-05-2022', 'dd-mm-yyyy'), to_date('11-02-2023', 'dd-mm-yyyy'), 2039, 23, 849, 2120, 502);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1680, to_date('09-12-2020', 'dd-mm-yyyy'), to_date('29-10-2023', 'dd-mm-yyyy'), 2040, 199, 823, 2216, 779);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1143, to_date('18-09-2020', 'dd-mm-yyyy'), to_date('13-09-2023', 'dd-mm-yyyy'), 2043, 212, 826, 2135, 613);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1419, to_date('28-03-2020', 'dd-mm-yyyy'), to_date('14-05-2021', 'dd-mm-yyyy'), 2049, 244, 803, 2361, 589);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1073, to_date('23-08-2022', 'dd-mm-yyyy'), to_date('22-08-2021', 'dd-mm-yyyy'), 2050, 54, 824, 2379, 686);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1646, to_date('19-02-2021', 'dd-mm-yyyy'), to_date('19-08-2023', 'dd-mm-yyyy'), 2051, 54, 843, 2296, 795);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1208, to_date('17-12-2022', 'dd-mm-yyyy'), to_date('01-04-2023', 'dd-mm-yyyy'), 2053, 143, 850, 2082, 719);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1113, to_date('22-11-2021', 'dd-mm-yyyy'), to_date('09-03-2020', 'dd-mm-yyyy'), 2056, 116, 811, 2149, 403);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1607, to_date('12-09-2022', 'dd-mm-yyyy'), to_date('23-09-2022', 'dd-mm-yyyy'), 2057, 59, 817, 2042, 453);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1554, to_date('12-03-2022', 'dd-mm-yyyy'), to_date('29-08-2020', 'dd-mm-yyyy'), 2060, 175, 849, 2064, 438);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1319, to_date('28-09-2020', 'dd-mm-yyyy'), to_date('24-03-2023', 'dd-mm-yyyy'), 2061, 277, 811, 2065, 640);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1867, to_date('16-07-2022', 'dd-mm-yyyy'), to_date('08-06-2021', 'dd-mm-yyyy'), 2062, 205, 843, 2184, 437);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1325, to_date('27-03-2022', 'dd-mm-yyyy'), to_date('09-12-2022', 'dd-mm-yyyy'), 2064, 261, 845, 2311, 539);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1657, to_date('03-02-2021', 'dd-mm-yyyy'), to_date('04-08-2022', 'dd-mm-yyyy'), 2065, 356, 805, 2123, 514);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1076, to_date('31-08-2021', 'dd-mm-yyyy'), to_date('30-11-2023', 'dd-mm-yyyy'), 2066, 161, 822, 2020, 581);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1620, to_date('09-10-2021', 'dd-mm-yyyy'), to_date('02-03-2022', 'dd-mm-yyyy'), 2067, 186, 812, 2175, 403);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1552, to_date('04-10-2020', 'dd-mm-yyyy'), to_date('26-01-2023', 'dd-mm-yyyy'), 2068, 91, 835, 2251, 567);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1285, to_date('03-09-2022', 'dd-mm-yyyy'), to_date('08-06-2020', 'dd-mm-yyyy'), 2069, 299, 835, 2395, 647);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1976, to_date('06-02-2022', 'dd-mm-yyyy'), to_date('11-04-2023', 'dd-mm-yyyy'), 2071, 391, 814, 2269, 575);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1667, to_date('24-05-2021', 'dd-mm-yyyy'), to_date('15-09-2022', 'dd-mm-yyyy'), 2073, 366, 838, 2014, 493);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1167, to_date('18-12-2021', 'dd-mm-yyyy'), to_date('09-07-2020', 'dd-mm-yyyy'), 2076, 364, 833, 2285, 425);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1770, to_date('20-08-2021', 'dd-mm-yyyy'), to_date('23-04-2021', 'dd-mm-yyyy'), 2077, 33, 837, 2344, 598);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1606, to_date('10-03-2022', 'dd-mm-yyyy'), to_date('13-03-2023', 'dd-mm-yyyy'), 2078, 14, 831, 2118, 580);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1880, to_date('07-09-2021', 'dd-mm-yyyy'), to_date('09-08-2023', 'dd-mm-yyyy'), 2081, 218, 816, 2352, 482);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1239, to_date('17-01-2021', 'dd-mm-yyyy'), to_date('02-11-2022', 'dd-mm-yyyy'), 2082, 128, 802, 2195, 562);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1618, to_date('30-11-2022', 'dd-mm-yyyy'), to_date('15-05-2020', 'dd-mm-yyyy'), 2083, 28, 828, 2097, 770);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1818, to_date('18-09-2022', 'dd-mm-yyyy'), to_date('01-02-2020', 'dd-mm-yyyy'), 2084, 220, 839, 2240, 664);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1586, to_date('21-09-2022', 'dd-mm-yyyy'), to_date('21-07-2023', 'dd-mm-yyyy'), 2085, 50, 812, 2120, 438);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1550, to_date('11-10-2022', 'dd-mm-yyyy'), to_date('08-08-2020', 'dd-mm-yyyy'), 2086, 118, 832, 2254, 503);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1863, to_date('25-02-2020', 'dd-mm-yyyy'), to_date('16-11-2022', 'dd-mm-yyyy'), 2087, 368, 814, 2190, 466);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1857, to_date('28-05-2021', 'dd-mm-yyyy'), to_date('22-07-2020', 'dd-mm-yyyy'), 2088, 266, 841, 2025, 727);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1687, to_date('09-02-2023', 'dd-mm-yyyy'), to_date('25-07-2023', 'dd-mm-yyyy'), 2093, 204, 801, 2337, 779);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (2000, to_date('30-08-2021', 'dd-mm-yyyy'), to_date('07-09-2022', 'dd-mm-yyyy'), 2094, 81, 820, 2117, 656);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1348, to_date('25-01-2023', 'dd-mm-yyyy'), to_date('14-04-2020', 'dd-mm-yyyy'), 2095, 94, 821, 2359, 570);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1442, to_date('18-11-2023', 'dd-mm-yyyy'), to_date('19-10-2023', 'dd-mm-yyyy'), 2097, 153, 839, 2076, 542);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1470, to_date('06-07-2021', 'dd-mm-yyyy'), to_date('13-11-2022', 'dd-mm-yyyy'), 2098, 186, 813, 2311, 445);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1096, to_date('07-01-2021', 'dd-mm-yyyy'), to_date('06-02-2021', 'dd-mm-yyyy'), 2099, 81, 836, 2106, 483);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1482, to_date('27-03-2021', 'dd-mm-yyyy'), to_date('13-11-2023', 'dd-mm-yyyy'), 2100, 205, 805, 2190, 476);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1475, to_date('13-03-2022', 'dd-mm-yyyy'), to_date('04-02-2023', 'dd-mm-yyyy'), 2101, 158, 825, 2119, 603);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1284, to_date('06-04-2022', 'dd-mm-yyyy'), to_date('12-08-2022', 'dd-mm-yyyy'), 2102, 136, 827, 2216, 731);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1462, to_date('21-09-2020', 'dd-mm-yyyy'), to_date('18-07-2021', 'dd-mm-yyyy'), 2103, 27, 805, 2063, 481);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1099, to_date('14-10-2022', 'dd-mm-yyyy'), to_date('11-04-2023', 'dd-mm-yyyy'), 2104, 174, 820, 2081, 658);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1844, to_date('22-07-2023', 'dd-mm-yyyy'), to_date('16-06-2023', 'dd-mm-yyyy'), 2105, 174, 842, 2179, 722);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1665, to_date('19-02-2022', 'dd-mm-yyyy'), to_date('08-03-2023', 'dd-mm-yyyy'), 2106, 130, 834, 2222, 764);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1472, to_date('18-04-2020', 'dd-mm-yyyy'), to_date('31-12-2020', 'dd-mm-yyyy'), 2107, 117, 820, 2234, 442);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1261, to_date('26-07-2022', 'dd-mm-yyyy'), to_date('15-03-2023', 'dd-mm-yyyy'), 2108, 159, 818, 2132, 792);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1546, to_date('20-06-2020', 'dd-mm-yyyy'), to_date('23-03-2021', 'dd-mm-yyyy'), 2110, 179, 808, 2065, 775);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1683, to_date('12-11-2020', 'dd-mm-yyyy'), to_date('01-03-2020', 'dd-mm-yyyy'), 2111, 331, 802, 2397, 734);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1294, to_date('09-07-2021', 'dd-mm-yyyy'), to_date('10-06-2022', 'dd-mm-yyyy'), 2113, 26, 831, 2214, 593);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1993, to_date('18-09-2021', 'dd-mm-yyyy'), to_date('27-03-2021', 'dd-mm-yyyy'), 2117, 53, 818, 2001, 589);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1160, to_date('19-02-2021', 'dd-mm-yyyy'), to_date('24-05-2021', 'dd-mm-yyyy'), 2118, 149, 837, 2371, 512);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1036, to_date('31-05-2021', 'dd-mm-yyyy'), to_date('29-10-2020', 'dd-mm-yyyy'), 2119, 102, 845, 2242, 436);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1015, to_date('22-02-2023', 'dd-mm-yyyy'), to_date('08-08-2021', 'dd-mm-yyyy'), 2120, 331, 850, 2074, 438);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1131, to_date('29-04-2021', 'dd-mm-yyyy'), to_date('16-04-2022', 'dd-mm-yyyy'), 2124, 6, 844, 2330, 493);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1904, to_date('30-09-2022', 'dd-mm-yyyy'), to_date('07-08-2023', 'dd-mm-yyyy'), 2125, 250, 839, 2151, 457);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1227, to_date('23-10-2023', 'dd-mm-yyyy'), to_date('02-09-2020', 'dd-mm-yyyy'), 2126, 341, 806, 2138, 495);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1479, to_date('03-03-2022', 'dd-mm-yyyy'), to_date('13-11-2021', 'dd-mm-yyyy'), 2127, 147, 838, 2029, 457);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1580, to_date('13-07-2022', 'dd-mm-yyyy'), to_date('04-07-2021', 'dd-mm-yyyy'), 2128, 223, 827, 2271, 682);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1799, to_date('31-08-2020', 'dd-mm-yyyy'), to_date('27-11-2023', 'dd-mm-yyyy'), 2129, 248, 848, 2002, 518);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1271, to_date('20-09-2022', 'dd-mm-yyyy'), to_date('01-08-2022', 'dd-mm-yyyy'), 2130, 367, 815, 2296, 692);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1297, to_date('11-05-2021', 'dd-mm-yyyy'), to_date('22-07-2022', 'dd-mm-yyyy'), 2131, 167, 814, 2329, 679);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1986, to_date('07-10-2023', 'dd-mm-yyyy'), to_date('26-11-2023', 'dd-mm-yyyy'), 2132, 39, 805, 2078, 699);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1668, to_date('09-09-2023', 'dd-mm-yyyy'), to_date('26-01-2021', 'dd-mm-yyyy'), 2133, 11, 823, 2145, 505);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1097, to_date('03-10-2020', 'dd-mm-yyyy'), to_date('26-12-2022', 'dd-mm-yyyy'), 2135, 111, 817, 2316, 735);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1365, to_date('20-10-2023', 'dd-mm-yyyy'), to_date('05-06-2020', 'dd-mm-yyyy'), 2136, 348, 808, 2324, 597);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1440, to_date('15-04-2020', 'dd-mm-yyyy'), to_date('10-02-2020', 'dd-mm-yyyy'), 2137, 248, 814, 2185, 654);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1093, to_date('31-10-2020', 'dd-mm-yyyy'), to_date('29-05-2023', 'dd-mm-yyyy'), 2139, 360, 815, 2238, 452);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1033, to_date('22-06-2023', 'dd-mm-yyyy'), to_date('07-01-2021', 'dd-mm-yyyy'), 2140, 322, 842, 2086, 522);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1467, to_date('14-10-2021', 'dd-mm-yyyy'), to_date('22-11-2023', 'dd-mm-yyyy'), 2141, 46, 825, 2239, 504);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1072, to_date('07-11-2021', 'dd-mm-yyyy'), to_date('01-09-2023', 'dd-mm-yyyy'), 2142, 201, 823, 2325, 443);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1114, to_date('28-10-2020', 'dd-mm-yyyy'), to_date('24-03-2022', 'dd-mm-yyyy'), 2143, 126, 813, 2398, 513);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1527, to_date('11-06-2022', 'dd-mm-yyyy'), to_date('23-09-2021', 'dd-mm-yyyy'), 2144, 151, 842, 2392, 620);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1852, to_date('07-10-2020', 'dd-mm-yyyy'), to_date('03-06-2022', 'dd-mm-yyyy'), 2146, 187, 819, 2258, 679);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1841, to_date('27-08-2022', 'dd-mm-yyyy'), to_date('21-09-2023', 'dd-mm-yyyy'), 2147, 183, 826, 2268, 499);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1334, to_date('22-07-2020', 'dd-mm-yyyy'), to_date('18-11-2023', 'dd-mm-yyyy'), 2149, 197, 802, 2129, 445);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1910, to_date('07-10-2022', 'dd-mm-yyyy'), to_date('19-01-2021', 'dd-mm-yyyy'), 2150, 74, 812, 2003, 770);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1343, to_date('08-09-2022', 'dd-mm-yyyy'), to_date('21-09-2023', 'dd-mm-yyyy'), 2152, 163, 828, 2280, 514);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1588, to_date('04-07-2021', 'dd-mm-yyyy'), to_date('29-06-2021', 'dd-mm-yyyy'), 2153, 160, 807, 2039, 531);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1003, to_date('04-02-2021', 'dd-mm-yyyy'), to_date('28-01-2020', 'dd-mm-yyyy'), 2155, 110, 824, 2055, 504);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1091, to_date('13-07-2022', 'dd-mm-yyyy'), to_date('06-05-2022', 'dd-mm-yyyy'), 2156, 257, 807, 2164, 530);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1647, to_date('29-08-2023', 'dd-mm-yyyy'), to_date('15-11-2023', 'dd-mm-yyyy'), 2157, 142, 806, 2226, 519);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1724, to_date('21-12-2020', 'dd-mm-yyyy'), to_date('21-11-2021', 'dd-mm-yyyy'), 2158, 293, 841, 2355, 746);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1145, to_date('04-05-2022', 'dd-mm-yyyy'), to_date('12-11-2021', 'dd-mm-yyyy'), 2161, 375, 818, 2395, 565);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1134, to_date('17-07-2023', 'dd-mm-yyyy'), to_date('20-10-2022', 'dd-mm-yyyy'), 2163, 35, 844, 2195, 589);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1664, to_date('30-11-2020', 'dd-mm-yyyy'), to_date('16-07-2020', 'dd-mm-yyyy'), 2164, 310, 823, 2313, 669);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1836, to_date('10-10-2023', 'dd-mm-yyyy'), to_date('20-12-2023', 'dd-mm-yyyy'), 2167, 280, 830, 2046, 483);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1637, to_date('05-08-2023', 'dd-mm-yyyy'), to_date('04-10-2020', 'dd-mm-yyyy'), 2168, 362, 803, 2248, 642);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1581, to_date('17-08-2020', 'dd-mm-yyyy'), to_date('01-05-2022', 'dd-mm-yyyy'), 2169, 76, 834, 2315, 556);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1983, to_date('05-09-2020', 'dd-mm-yyyy'), to_date('06-05-2022', 'dd-mm-yyyy'), 2170, 112, 811, 2387, 670);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1312, to_date('16-09-2021', 'dd-mm-yyyy'), to_date('08-08-2021', 'dd-mm-yyyy'), 2172, 327, 801, 2063, 650);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1302, to_date('15-06-2023', 'dd-mm-yyyy'), to_date('20-05-2023', 'dd-mm-yyyy'), 2175, 335, 836, 2019, 415);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1688, to_date('10-04-2020', 'dd-mm-yyyy'), to_date('24-06-2022', 'dd-mm-yyyy'), 2176, 379, 840, 2059, 667);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1081, to_date('09-05-2020', 'dd-mm-yyyy'), to_date('06-12-2023', 'dd-mm-yyyy'), 2177, 326, 839, 2075, 675);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1486, to_date('05-06-2021', 'dd-mm-yyyy'), to_date('20-05-2020', 'dd-mm-yyyy'), 2184, 139, 844, 2311, 736);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1995, to_date('17-12-2021', 'dd-mm-yyyy'), to_date('30-03-2020', 'dd-mm-yyyy'), 2185, 32, 841, 2350, 526);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1922, to_date('28-05-2023', 'dd-mm-yyyy'), to_date('29-08-2023', 'dd-mm-yyyy'), 2186, 160, 827, 2290, 410);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1636, to_date('30-05-2020', 'dd-mm-yyyy'), to_date('08-02-2023', 'dd-mm-yyyy'), 2187, 230, 842, 2029, 648);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1648, to_date('19-02-2023', 'dd-mm-yyyy'), to_date('02-10-2020', 'dd-mm-yyyy'), 2188, 371, 808, 2147, 523);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1919, to_date('03-06-2020', 'dd-mm-yyyy'), to_date('26-09-2021', 'dd-mm-yyyy'), 2189, 5, 837, 2236, 589);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1431, to_date('17-06-2020', 'dd-mm-yyyy'), to_date('23-05-2021', 'dd-mm-yyyy'), 2190, 310, 842, 2307, 558);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1152, to_date('28-04-2023', 'dd-mm-yyyy'), to_date('04-04-2021', 'dd-mm-yyyy'), 2192, 130, 818, 2006, 643);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1764, to_date('27-01-2022', 'dd-mm-yyyy'), to_date('18-03-2023', 'dd-mm-yyyy'), 2196, 197, 818, 2072, 530);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1250, to_date('01-11-2022', 'dd-mm-yyyy'), to_date('06-08-2020', 'dd-mm-yyyy'), 2198, 307, 839, 2167, 567);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1584, to_date('29-05-2022', 'dd-mm-yyyy'), to_date('07-03-2020', 'dd-mm-yyyy'), 2199, 232, 808, 2079, 702);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1754, to_date('17-06-2023', 'dd-mm-yyyy'), to_date('05-04-2021', 'dd-mm-yyyy'), 2200, 364, 827, 2060, 477);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1471, to_date('03-03-2023', 'dd-mm-yyyy'), to_date('03-08-2023', 'dd-mm-yyyy'), 2201, 233, 825, 2111, 578);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1343, to_date('12-09-2021', 'dd-mm-yyyy'), to_date('11-04-2021', 'dd-mm-yyyy'), 2202, 90, 811, 2334, 483);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1062, to_date('11-02-2021', 'dd-mm-yyyy'), to_date('24-08-2022', 'dd-mm-yyyy'), 2204, 269, 836, 2163, 721);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1437, to_date('21-06-2023', 'dd-mm-yyyy'), to_date('15-07-2022', 'dd-mm-yyyy'), 2205, 281, 828, 2006, 582);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1882, to_date('12-11-2023', 'dd-mm-yyyy'), to_date('14-06-2021', 'dd-mm-yyyy'), 2206, 236, 811, 2110, 431);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1747, to_date('09-05-2021', 'dd-mm-yyyy'), to_date('16-11-2021', 'dd-mm-yyyy'), 2208, 351, 832, 2223, 410);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1949, to_date('07-04-2022', 'dd-mm-yyyy'), to_date('12-02-2022', 'dd-mm-yyyy'), 2209, 296, 812, 2176, 455);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1604, to_date('24-01-2023', 'dd-mm-yyyy'), to_date('15-09-2021', 'dd-mm-yyyy'), 2210, 308, 811, 2235, 729);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1694, to_date('09-06-2020', 'dd-mm-yyyy'), to_date('26-07-2020', 'dd-mm-yyyy'), 2211, 317, 831, 2376, 408);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1582, to_date('13-07-2021', 'dd-mm-yyyy'), to_date('15-12-2023', 'dd-mm-yyyy'), 2212, 307, 829, 2399, 475);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1335, to_date('29-01-2020', 'dd-mm-yyyy'), to_date('08-03-2020', 'dd-mm-yyyy'), 2214, 209, 830, 2274, 531);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1271, to_date('23-07-2023', 'dd-mm-yyyy'), to_date('10-10-2022', 'dd-mm-yyyy'), 2215, 265, 836, 2148, 575);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1979, to_date('28-07-2022', 'dd-mm-yyyy'), to_date('11-02-2022', 'dd-mm-yyyy'), 2216, 370, 801, 2315, 495);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1533, to_date('02-07-2023', 'dd-mm-yyyy'), to_date('12-09-2020', 'dd-mm-yyyy'), 2217, 92, 834, 2217, 520);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1398, to_date('17-10-2023', 'dd-mm-yyyy'), to_date('27-11-2021', 'dd-mm-yyyy'), 2219, 356, 838, 2182, 775);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1588, to_date('20-05-2023', 'dd-mm-yyyy'), to_date('29-03-2021', 'dd-mm-yyyy'), 2220, 259, 822, 2171, 570);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1050, to_date('03-03-2022', 'dd-mm-yyyy'), to_date('12-05-2023', 'dd-mm-yyyy'), 2221, 361, 823, 2014, 673);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1251, to_date('10-01-2022', 'dd-mm-yyyy'), to_date('11-12-2022', 'dd-mm-yyyy'), 2224, 120, 844, 2194, 508);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1379, to_date('24-09-2021', 'dd-mm-yyyy'), to_date('27-03-2020', 'dd-mm-yyyy'), 2225, 179, 818, 2242, 569);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1817, to_date('28-04-2021', 'dd-mm-yyyy'), to_date('09-05-2021', 'dd-mm-yyyy'), 2226, 308, 818, 2257, 644);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1886, to_date('10-10-2022', 'dd-mm-yyyy'), to_date('27-04-2020', 'dd-mm-yyyy'), 2227, 31, 811, 2385, 599);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1169, to_date('10-06-2021', 'dd-mm-yyyy'), to_date('24-05-2021', 'dd-mm-yyyy'), 2228, 88, 817, 2115, 728);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1111, to_date('11-10-2021', 'dd-mm-yyyy'), to_date('02-12-2020', 'dd-mm-yyyy'), 2229, 236, 813, 2237, 633);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1211, to_date('26-08-2022', 'dd-mm-yyyy'), to_date('07-12-2022', 'dd-mm-yyyy'), 2230, 45, 812, 2206, 780);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1201, to_date('13-05-2020', 'dd-mm-yyyy'), to_date('15-08-2022', 'dd-mm-yyyy'), 2231, 114, 850, 2246, 600);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1394, to_date('24-01-2020', 'dd-mm-yyyy'), to_date('28-02-2021', 'dd-mm-yyyy'), 2233, 24, 850, 2367, 751);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1678, to_date('05-01-2020', 'dd-mm-yyyy'), to_date('11-10-2023', 'dd-mm-yyyy'), 2234, 395, 803, 2265, 644);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1204, to_date('03-11-2023', 'dd-mm-yyyy'), to_date('18-10-2023', 'dd-mm-yyyy'), 2235, 363, 806, 2206, 527);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1393, to_date('05-05-2020', 'dd-mm-yyyy'), to_date('25-11-2023', 'dd-mm-yyyy'), 2236, 77, 834, 2265, 783);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1524, to_date('15-08-2021', 'dd-mm-yyyy'), to_date('17-10-2022', 'dd-mm-yyyy'), 2237, 71, 844, 2022, 465);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1076, to_date('27-09-2023', 'dd-mm-yyyy'), to_date('10-01-2022', 'dd-mm-yyyy'), 2238, 168, 845, 2178, 761);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1219, to_date('28-06-2020', 'dd-mm-yyyy'), to_date('02-07-2020', 'dd-mm-yyyy'), 2240, 5, 811, 2217, 766);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1761, to_date('17-05-2020', 'dd-mm-yyyy'), to_date('24-12-2023', 'dd-mm-yyyy'), 2241, 233, 847, 2351, 469);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1254, to_date('10-11-2022', 'dd-mm-yyyy'), to_date('21-05-2020', 'dd-mm-yyyy'), 2242, 1, 838, 2088, 432);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1090, to_date('05-07-2022', 'dd-mm-yyyy'), to_date('05-11-2021', 'dd-mm-yyyy'), 2243, 106, 811, 2094, 599);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1031, to_date('05-01-2021', 'dd-mm-yyyy'), to_date('29-11-2020', 'dd-mm-yyyy'), 2244, 77, 834, 2132, 675);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1451, to_date('13-10-2022', 'dd-mm-yyyy'), to_date('03-09-2023', 'dd-mm-yyyy'), 2245, 233, 844, 2193, 499);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1432, to_date('28-02-2021', 'dd-mm-yyyy'), to_date('05-09-2023', 'dd-mm-yyyy'), 2246, 133, 804, 2220, 671);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1366, to_date('15-12-2020', 'dd-mm-yyyy'), to_date('04-12-2021', 'dd-mm-yyyy'), 2247, 56, 814, 2128, 408);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1247, to_date('20-02-2023', 'dd-mm-yyyy'), to_date('04-07-2020', 'dd-mm-yyyy'), 2248, 312, 833, 2120, 787);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1775, to_date('22-01-2020', 'dd-mm-yyyy'), to_date('16-01-2021', 'dd-mm-yyyy'), 2249, 92, 834, 2163, 787);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1189, to_date('27-02-2021', 'dd-mm-yyyy'), to_date('25-11-2023', 'dd-mm-yyyy'), 2250, 2, 838, 2369, 582);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1697, to_date('30-11-2021', 'dd-mm-yyyy'), to_date('11-05-2022', 'dd-mm-yyyy'), 2251, 86, 814, 2380, 669);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1704, to_date('04-08-2020', 'dd-mm-yyyy'), to_date('21-09-2023', 'dd-mm-yyyy'), 2253, 170, 807, 2347, 760);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1064, to_date('26-03-2020', 'dd-mm-yyyy'), to_date('14-04-2022', 'dd-mm-yyyy'), 2254, 256, 845, 2334, 441);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1140, to_date('23-08-2023', 'dd-mm-yyyy'), to_date('13-09-2021', 'dd-mm-yyyy'), 2259, 308, 807, 2340, 552);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1405, to_date('08-01-2022', 'dd-mm-yyyy'), to_date('25-08-2020', 'dd-mm-yyyy'), 2260, 6, 818, 2383, 420);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1300, to_date('05-10-2023', 'dd-mm-yyyy'), to_date('28-03-2020', 'dd-mm-yyyy'), 2261, 205, 837, 2257, 772);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1510, to_date('13-08-2022', 'dd-mm-yyyy'), to_date('20-04-2023', 'dd-mm-yyyy'), 2266, 197, 803, 2100, 603);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1849, to_date('17-10-2022', 'dd-mm-yyyy'), to_date('25-01-2020', 'dd-mm-yyyy'), 2267, 32, 836, 2092, 696);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1551, to_date('07-11-2020', 'dd-mm-yyyy'), to_date('08-03-2023', 'dd-mm-yyyy'), 2268, 297, 824, 2031, 593);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1682, to_date('18-03-2021', 'dd-mm-yyyy'), to_date('27-06-2021', 'dd-mm-yyyy'), 2270, 188, 839, 2041, 582);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1709, to_date('18-01-2021', 'dd-mm-yyyy'), to_date('23-10-2021', 'dd-mm-yyyy'), 2273, 138, 848, 2292, 423);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1036, to_date('26-09-2022', 'dd-mm-yyyy'), to_date('11-09-2022', 'dd-mm-yyyy'), 2274, 299, 804, 2376, 755);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1729, to_date('22-04-2023', 'dd-mm-yyyy'), to_date('30-01-2022', 'dd-mm-yyyy'), 2275, 29, 837, 2116, 582);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1154, to_date('10-06-2022', 'dd-mm-yyyy'), to_date('22-04-2022', 'dd-mm-yyyy'), 2277, 319, 807, 2085, 737);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1507, to_date('28-04-2020', 'dd-mm-yyyy'), to_date('27-01-2022', 'dd-mm-yyyy'), 2278, 164, 808, 2296, 735);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1607, to_date('15-12-2021', 'dd-mm-yyyy'), to_date('17-03-2020', 'dd-mm-yyyy'), 2280, 334, 807, 2038, 613);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1369, to_date('21-02-2023', 'dd-mm-yyyy'), to_date('14-04-2023', 'dd-mm-yyyy'), 2281, 82, 829, 2369, 677);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1051, to_date('09-03-2021', 'dd-mm-yyyy'), to_date('11-10-2020', 'dd-mm-yyyy'), 2282, 196, 830, 2336, 484);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1471, to_date('05-11-2021', 'dd-mm-yyyy'), to_date('27-08-2021', 'dd-mm-yyyy'), 2284, 146, 820, 2000, 544);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1865, to_date('13-12-2021', 'dd-mm-yyyy'), to_date('11-08-2022', 'dd-mm-yyyy'), 2285, 360, 836, 2179, 419);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1701, to_date('13-09-2023', 'dd-mm-yyyy'), to_date('06-08-2020', 'dd-mm-yyyy'), 2286, 343, 809, 2244, 590);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1632, to_date('21-02-2020', 'dd-mm-yyyy'), to_date('26-08-2020', 'dd-mm-yyyy'), 2287, 334, 819, 2283, 515);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1380, to_date('29-08-2020', 'dd-mm-yyyy'), to_date('20-06-2021', 'dd-mm-yyyy'), 2288, 187, 823, 2085, 421);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1714, to_date('01-01-2022', 'dd-mm-yyyy'), to_date('31-01-2022', 'dd-mm-yyyy'), 2291, 277, 821, 2398, 724);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1123, to_date('31-10-2020', 'dd-mm-yyyy'), to_date('23-12-2022', 'dd-mm-yyyy'), 2293, 266, 812, 2355, 791);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1882, to_date('23-10-2022', 'dd-mm-yyyy'), to_date('10-11-2020', 'dd-mm-yyyy'), 2298, 65, 842, 2290, 468);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1927, to_date('02-12-2022', 'dd-mm-yyyy'), to_date('16-05-2020', 'dd-mm-yyyy'), 2300, 136, 831, 2103, 413);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1268, to_date('02-06-2020', 'dd-mm-yyyy'), to_date('05-02-2023', 'dd-mm-yyyy'), 2301, 378, 819, 2147, 507);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1562, to_date('21-08-2021', 'dd-mm-yyyy'), to_date('23-11-2021', 'dd-mm-yyyy'), 2303, 303, 831, 2045, 519);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1564, to_date('17-03-2022', 'dd-mm-yyyy'), to_date('24-09-2021', 'dd-mm-yyyy'), 2305, 113, 838, 2347, 507);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1933, to_date('31-10-2022', 'dd-mm-yyyy'), to_date('17-10-2023', 'dd-mm-yyyy'), 2306, 55, 807, 2310, 795);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1438, to_date('12-11-2021', 'dd-mm-yyyy'), to_date('13-12-2020', 'dd-mm-yyyy'), 2307, 171, 821, 2369, 445);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1167, to_date('16-10-2023', 'dd-mm-yyyy'), to_date('30-01-2021', 'dd-mm-yyyy'), 2308, 336, 806, 2276, 594);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1745, to_date('23-06-2021', 'dd-mm-yyyy'), to_date('13-01-2022', 'dd-mm-yyyy'), 2309, 265, 850, 2392, 567);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1889, to_date('10-12-2021', 'dd-mm-yyyy'), to_date('26-10-2020', 'dd-mm-yyyy'), 2311, 336, 827, 2041, 536);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1266, to_date('03-09-2023', 'dd-mm-yyyy'), to_date('10-12-2022', 'dd-mm-yyyy'), 2312, 150, 822, 2059, 581);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1560, to_date('27-05-2021', 'dd-mm-yyyy'), to_date('22-04-2021', 'dd-mm-yyyy'), 2315, 265, 844, 2314, 552);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1851, to_date('25-01-2023', 'dd-mm-yyyy'), to_date('19-08-2020', 'dd-mm-yyyy'), 2317, 296, 811, 2209, 799);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1966, to_date('12-11-2023', 'dd-mm-yyyy'), to_date('16-01-2023', 'dd-mm-yyyy'), 2318, 27, 817, 2361, 456);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1473, to_date('02-10-2020', 'dd-mm-yyyy'), to_date('25-04-2022', 'dd-mm-yyyy'), 2319, 292, 838, 2194, 719);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1504, to_date('21-06-2023', 'dd-mm-yyyy'), to_date('14-09-2021', 'dd-mm-yyyy'), 2320, 68, 813, 2181, 531);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1888, to_date('09-08-2022', 'dd-mm-yyyy'), to_date('24-10-2021', 'dd-mm-yyyy'), 2321, 225, 846, 2215, 650);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1782, to_date('09-01-2021', 'dd-mm-yyyy'), to_date('28-03-2021', 'dd-mm-yyyy'), 2322, 212, 827, 2007, 572);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1034, to_date('29-11-2020', 'dd-mm-yyyy'), to_date('23-04-2021', 'dd-mm-yyyy'), 2323, 101, 813, 2041, 571);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1793, to_date('14-09-2023', 'dd-mm-yyyy'), to_date('10-03-2023', 'dd-mm-yyyy'), 2325, 105, 843, 2195, 660);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1173, to_date('09-03-2023', 'dd-mm-yyyy'), to_date('16-12-2020', 'dd-mm-yyyy'), 2326, 351, 834, 2279, 674);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1650, to_date('02-02-2021', 'dd-mm-yyyy'), to_date('11-02-2022', 'dd-mm-yyyy'), 2328, 202, 817, 2384, 477);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1358, to_date('24-11-2021', 'dd-mm-yyyy'), to_date('30-10-2021', 'dd-mm-yyyy'), 2329, 257, 839, 2304, 700);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1348, to_date('18-03-2020', 'dd-mm-yyyy'), to_date('14-01-2021', 'dd-mm-yyyy'), 2330, 325, 811, 2220, 602);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1024, to_date('27-02-2020', 'dd-mm-yyyy'), to_date('11-06-2022', 'dd-mm-yyyy'), 2331, 161, 829, 2008, 439);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1048, to_date('21-08-2021', 'dd-mm-yyyy'), to_date('01-06-2021', 'dd-mm-yyyy'), 2332, 203, 825, 2104, 612);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1059, to_date('16-09-2020', 'dd-mm-yyyy'), to_date('10-05-2022', 'dd-mm-yyyy'), 2333, 213, 806, 2256, 767);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1372, to_date('18-11-2023', 'dd-mm-yyyy'), to_date('20-09-2021', 'dd-mm-yyyy'), 2334, 225, 815, 2386, 635);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1956, to_date('24-08-2023', 'dd-mm-yyyy'), to_date('22-03-2020', 'dd-mm-yyyy'), 2335, 43, 839, 2025, 660);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1677, to_date('02-05-2021', 'dd-mm-yyyy'), to_date('29-08-2023', 'dd-mm-yyyy'), 2337, 368, 806, 2321, 589);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1941, to_date('02-08-2023', 'dd-mm-yyyy'), to_date('24-05-2020', 'dd-mm-yyyy'), 2338, 63, 835, 2230, 503);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1096, to_date('17-11-2023', 'dd-mm-yyyy'), to_date('27-04-2023', 'dd-mm-yyyy'), 2341, 152, 831, 2057, 751);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1355, to_date('12-02-2022', 'dd-mm-yyyy'), to_date('12-10-2023', 'dd-mm-yyyy'), 2342, 68, 829, 2202, 434);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1255, to_date('21-04-2021', 'dd-mm-yyyy'), to_date('07-06-2020', 'dd-mm-yyyy'), 2343, 77, 848, 2275, 436);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1323, to_date('26-09-2022', 'dd-mm-yyyy'), to_date('25-06-2023', 'dd-mm-yyyy'), 2344, 393, 808, 2257, 507);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1609, to_date('06-09-2022', 'dd-mm-yyyy'), to_date('06-07-2020', 'dd-mm-yyyy'), 2345, 162, 814, 2167, 547);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1470, to_date('05-11-2022', 'dd-mm-yyyy'), to_date('17-01-2021', 'dd-mm-yyyy'), 2346, 292, 808, 2010, 594);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1956, to_date('07-06-2020', 'dd-mm-yyyy'), to_date('15-02-2021', 'dd-mm-yyyy'), 2347, 285, 837, 2114, 565);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1851, to_date('16-02-2020', 'dd-mm-yyyy'), to_date('13-08-2022', 'dd-mm-yyyy'), 2348, 230, 847, 2392, 547);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1304, to_date('29-04-2023', 'dd-mm-yyyy'), to_date('16-03-2023', 'dd-mm-yyyy'), 2349, 132, 837, 2094, 633);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1628, to_date('06-08-2020', 'dd-mm-yyyy'), to_date('27-06-2023', 'dd-mm-yyyy'), 2350, 271, 815, 2180, 569);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1047, to_date('20-03-2022', 'dd-mm-yyyy'), to_date('18-04-2023', 'dd-mm-yyyy'), 2352, 258, 824, 2041, 598);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1362, to_date('29-10-2021', 'dd-mm-yyyy'), to_date('21-06-2022', 'dd-mm-yyyy'), 2353, 381, 810, 2148, 653);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1833, to_date('23-07-2021', 'dd-mm-yyyy'), to_date('15-04-2021', 'dd-mm-yyyy'), 2354, 18, 846, 2119, 658);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1234, to_date('05-07-2021', 'dd-mm-yyyy'), to_date('09-07-2021', 'dd-mm-yyyy'), 2355, 295, 818, 2056, 477);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1346, to_date('25-08-2023', 'dd-mm-yyyy'), to_date('27-09-2021', 'dd-mm-yyyy'), 2357, 400, 813, 2197, 531);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1929, to_date('26-07-2022', 'dd-mm-yyyy'), to_date('28-07-2022', 'dd-mm-yyyy'), 2359, 268, 832, 2114, 451);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1767, to_date('04-04-2020', 'dd-mm-yyyy'), to_date('13-08-2023', 'dd-mm-yyyy'), 2360, 156, 819, 2392, 782);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1091, to_date('16-04-2022', 'dd-mm-yyyy'), to_date('11-03-2020', 'dd-mm-yyyy'), 2363, 149, 805, 2209, 570);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1494, to_date('29-10-2022', 'dd-mm-yyyy'), to_date('23-03-2020', 'dd-mm-yyyy'), 2366, 15, 814, 2059, 526);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1649, to_date('06-03-2022', 'dd-mm-yyyy'), to_date('30-11-2021', 'dd-mm-yyyy'), 2367, 232, 819, 2332, 752);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1235, to_date('17-05-2023', 'dd-mm-yyyy'), to_date('07-12-2021', 'dd-mm-yyyy'), 2368, 84, 830, 2221, 736);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1071, to_date('03-10-2021', 'dd-mm-yyyy'), to_date('14-10-2022', 'dd-mm-yyyy'), 2370, 313, 813, 2008, 688);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1735, to_date('24-07-2022', 'dd-mm-yyyy'), to_date('13-03-2022', 'dd-mm-yyyy'), 2372, 350, 820, 2382, 692);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1912, to_date('14-03-2022', 'dd-mm-yyyy'), to_date('08-06-2021', 'dd-mm-yyyy'), 2373, 261, 837, 2378, 630);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1673, to_date('27-08-2020', 'dd-mm-yyyy'), to_date('12-08-2023', 'dd-mm-yyyy'), 2374, 293, 831, 2387, 755);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1945, to_date('15-12-2021', 'dd-mm-yyyy'), to_date('28-07-2022', 'dd-mm-yyyy'), 2377, 286, 838, 2000, 637);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1671, to_date('02-05-2022', 'dd-mm-yyyy'), to_date('18-09-2022', 'dd-mm-yyyy'), 2378, 234, 832, 2146, 642);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1199, to_date('01-09-2020', 'dd-mm-yyyy'), to_date('21-07-2020', 'dd-mm-yyyy'), 2381, 29, 824, 2046, 632);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1621, to_date('12-09-2021', 'dd-mm-yyyy'), to_date('26-03-2020', 'dd-mm-yyyy'), 2383, 308, 844, 2079, 578);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1035, to_date('13-11-2021', 'dd-mm-yyyy'), to_date('05-08-2021', 'dd-mm-yyyy'), 2384, 97, 816, 2163, 567);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1019, to_date('02-01-2022', 'dd-mm-yyyy'), to_date('08-11-2022', 'dd-mm-yyyy'), 2386, 349, 811, 2150, 646);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1590, to_date('24-02-2021', 'dd-mm-yyyy'), to_date('28-07-2021', 'dd-mm-yyyy'), 2388, 360, 820, 2267, 717);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1650, to_date('03-07-2020', 'dd-mm-yyyy'), to_date('26-04-2022', 'dd-mm-yyyy'), 2389, 41, 837, 2337, 737);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1153, to_date('21-10-2023', 'dd-mm-yyyy'), to_date('25-01-2021', 'dd-mm-yyyy'), 2391, 4, 819, 2048, 567);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1472, to_date('10-05-2021', 'dd-mm-yyyy'), to_date('31-07-2021', 'dd-mm-yyyy'), 2392, 143, 816, 2038, 728);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1768, to_date('26-05-2021', 'dd-mm-yyyy'), to_date('10-03-2021', 'dd-mm-yyyy'), 2397, 332, 850, 2341, 477);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1102, to_date('11-11-2022', 'dd-mm-yyyy'), to_date('01-02-2021', 'dd-mm-yyyy'), 2398, 221, 807, 2312, 426);
insert into ORDERS (amount, dateofsupply, orderdate, orderid, idwo, catalognumber, inventoryid, idco)
values (1316, to_date('04-04-2021', 'dd-mm-yyyy'), to_date('11-08-2023', 'dd-mm-yyyy'), 2399, 254, 835, 2104, 543);
prompt 266 records loaded
prompt Loading PAYMENTS...
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
prompt 272 records loaded
prompt Enabling foreign key constraints for INVENTORY...
alter table INVENTORY enable constraint SYS_C007457;
prompt Enabling foreign key constraints for ORDERS...
alter table ORDERS enable constraint SYS_C007466;
alter table ORDERS enable constraint SYS_C007467;
alter table ORDERS enable constraint SYS_C007468;
alter table ORDERS enable constraint SYS_C007469;
prompt Enabling foreign key constraints for PAYMENTS...
alter table PAYMENTS enable constraint SYS_C007472;
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
