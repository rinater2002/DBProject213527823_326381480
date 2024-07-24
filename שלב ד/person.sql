-- יצירת טבלת PERSON
BEGIN
  EXECUTE IMMEDIATE 'CREATE TABLE PERSON
  (
    id_person     INTEGER NOT NULL,
    name          VARCHAR2(50) NOT NULL,
    year_of_birth NUMBER,
    phone         VARCHAR2(15),
    email         VARCHAR2(50),
    CONSTRAINT pk_person PRIMARY KEY (id_person)
  )';
END;

select * from person;

-- הוספת id_person לטבלת TRAVELERS והגדרת מפתח זר
BEGIN
  -- הוספת id_person לטבלת TRAVELERS אם לא קיים
  BEGIN
    EXECUTE IMMEDIATE 'ALTER TABLE TRAVELERS ADD (id_person INTEGER)';
  EXCEPTION
    WHEN OTHERS THEN
      IF SQLCODE = -01430 THEN
        NULL; -- העמודה כבר קיימת
      ELSE
        RAISE;
      END IF;
  END;

  -- הוספת קישור זר ל-TRAVELERS
  EXECUTE IMMEDIATE 'ALTER TABLE TRAVELERS ADD CONSTRAINT fk_travelers_person FOREIGN KEY (id_person) REFERENCES PERSON (id_person)';
END;

-- הוספת id_person לטבלת WORKERS והגדרת מפתח זר
BEGIN
  -- הוספת id_person לטבלת WORKERS אם לא קיים
  BEGIN
    EXECUTE IMMEDIATE 'ALTER TABLE WORKERS ADD (id_person INTEGER)';
  EXCEPTION
    WHEN OTHERS THEN
      IF SQLCODE = -01430 THEN
        NULL; -- העמודה כבר קיימת
      ELSE 
        RAISE;
      END IF;
  END;

  -- הוספת קישור זר ל-WORKERS
  EXECUTE IMMEDIATE 'ALTER TABLE WORKERS ADD CONSTRAINT fk_workers_person FOREIGN KEY (id_person) REFERENCES PERSON (id_person)';
END;

-- הוספת id_person לטבלת ORDERS והגדרת מפתח זר
BEGIN
  EXECUTE IMMEDIATE 'ALTER TABLE ORDERS ADD (id_person INTEGER)';
  EXECUTE IMMEDIATE 'ALTER TABLE ORDERS ADD CONSTRAINT fk_orders_person FOREIGN KEY (id_person) REFERENCES PERSON (id_person)';
END;


-- הוספת id_person לטבלת TRAVELERS_LIST והגדרת מפתח זר
BEGIN
  EXECUTE IMMEDIATE 'ALTER TABLE TRAVELERS_LIST ADD (id_person INTEGER)';
  EXECUTE IMMEDIATE 'ALTER TABLE TRAVELERS_LIST ADD CONSTRAINT fk_travelers_list_person FOREIGN KEY (id_person) REFERENCES PERSON (id_person)';
END;

--מילוי תוכן הטבלה PERSON
BEGIN
  -- הוספת נתונים מ-TRAVELERS ל-PERSON ועדכון id_person
  BEGIN
  FOR rec IN (SELECT id_travels, name, year_of_birth FROM TRAVELERS) LOOP
    -- הוספת נתונים ל-PERSON
    EXECUTE IMMEDIATE 'INSERT INTO PERSON (id_person, name, year_of_birth, phone, email)
                       VALUES (' || rec.id_travels || ', ''' || rec.name || ''', ' || rec.year_of_birth || ', NULL, NULL)';

    -- עדכון id_person בטבלה TRAVELERS
    EXECUTE IMMEDIATE 'UPDATE TRAVELERS
                       SET id_person = ' || rec.id_travels || '
                       WHERE id_travels = ' || rec.id_travels;
  END LOOP;
  END;

  -- הוספת נתונים מ-WORKERS ל-PERSON ועדכון id_person
  BEGIN
  FOR rec IN (SELECT IDWO, workersname, workersphone, workersmail FROM WORKERS) LOOP
    -- הוספת נתונים ל-PERSON
    EXECUTE IMMEDIATE 'INSERT INTO PERSON (id_person, name, year_of_birth, phone, email)
                       VALUES (' || rec.IDWO || ', ''' || rec.workersname || ''', NULL, ''' || rec.workersphone || ''', ''' || rec.workersmail || ''')';

    -- עדכון id_person בטבלה WORKERS
    EXECUTE IMMEDIATE 'UPDATE WORKERS
                       SET id_person = ' || rec.IDWO || '
                       WHERE IDWO = ' || rec.IDWO;
  END LOOP;
  END;

  
 -- עדכון date_of_birth בטבלה PERSON עם year_of_birth מ-TRAVELERS
 BEGIN
 FOR rec IN (SELECT id_travels, year_of_birth FROM TRAVELERS) LOOP
    EXECUTE IMMEDIATE 'UPDATE PERSON
                       SET year_of_birth = ' || rec.year_of_birth || '
                       WHERE id_person = ' || rec.id_travels;
  END LOOP;
END;
  -- עדכון phone ו-email בטבלה PERSON עם הנתונים מ-WORKERS
  BEGIN
  FOR rec IN (SELECT IDWO, workersphone, workersmail FROM WORKERS) LOOP
    EXECUTE IMMEDIATE 'UPDATE PERSON
                       SET phone = ''' || rec.workersphone || ''',
                           email = ''' || rec.workersmail || '''
                       WHERE id_person = ' || rec.IDWO;
  END LOOP;
  END;
END;


-- עדכון הקשר של id_person ב-TRAVELERS
BEGIN
  EXECUTE IMMEDIATE 'UPDATE TRAVELERS t
                     SET id_person = (SELECT id_person FROM PERSON p WHERE p.id_person = t.id_travels)';
END;


-- עדכון הקשר של id_person ב-WORKERS
BEGIN
  EXECUTE IMMEDIATE 'UPDATE WORKERS w
                     SET id_person = (SELECT id_person FROM PERSON p WHERE p.id_person = w.IDWO)';
END;

select * from person;
select * from workers;
select * from TRAVELERS;

BEGIN
  -- יצירת טבלת קשר בין עובדים לטיולים
  EXECUTE IMMEDIATE 'CREATE TABLE WORKER_TRAVEL (
      worker_id NUMBER NOT NULL,
      travel_id NUMBER NOT NULL,
      CONSTRAINT pk_worker_travel PRIMARY KEY (worker_id, travel_id),
      CONSTRAINT fk_worker FOREIGN KEY (worker_id) REFERENCES WORKERS(IDWO),
      CONSTRAINT fk_travel FOREIGN KEY (travel_id) REFERENCES TRAVELERS(id_travels)
    )';
    END;
    
  BEGIN
  -- הוספת קשרים בין עובדים לטיולים מתוך WORKERS ו-TRAVELERS
  FOR i IN 1..30 LOOP
    INSERT INTO WORKER_TRAVEL (worker_id, travel_id)
    select
        (SELECT IDWO FROM (SELECT IDWO FROM WORKERS ORDER BY DBMS_RANDOM.VALUE) WHERE ROWNUM = 1),
        (SELECT id_travels FROM (SELECT id_travels FROM TRAVELERS ORDER BY DBMS_RANDOM.VALUE) WHERE ROWNUM = 1)
    FROM DUAL;
            
  END LOOP;
  END;




select * from WORKER_TRAVEL;

