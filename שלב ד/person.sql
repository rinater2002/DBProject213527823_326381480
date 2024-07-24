-- ����� ���� PERSON
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

-- ����� id_person ����� TRAVELERS ������ ���� ��
BEGIN
  -- ����� id_person ����� TRAVELERS �� �� ����
  BEGIN
    EXECUTE IMMEDIATE 'ALTER TABLE TRAVELERS ADD (id_person INTEGER)';
  EXCEPTION
    WHEN OTHERS THEN
      IF SQLCODE = -01430 THEN
        NULL; -- ������ ��� �����
      ELSE
        RAISE;
      END IF;
  END;

  -- ����� ����� �� �-TRAVELERS
  EXECUTE IMMEDIATE 'ALTER TABLE TRAVELERS ADD CONSTRAINT fk_travelers_person FOREIGN KEY (id_person) REFERENCES PERSON (id_person)';
END;

-- ����� id_person ����� WORKERS ������ ���� ��
BEGIN
  -- ����� id_person ����� WORKERS �� �� ����
  BEGIN
    EXECUTE IMMEDIATE 'ALTER TABLE WORKERS ADD (id_person INTEGER)';
  EXCEPTION
    WHEN OTHERS THEN
      IF SQLCODE = -01430 THEN
        NULL; -- ������ ��� �����
      ELSE 
        RAISE;
      END IF;
  END;

  -- ����� ����� �� �-WORKERS
  EXECUTE IMMEDIATE 'ALTER TABLE WORKERS ADD CONSTRAINT fk_workers_person FOREIGN KEY (id_person) REFERENCES PERSON (id_person)';
END;

-- ����� id_person ����� ORDERS ������ ���� ��
BEGIN
  EXECUTE IMMEDIATE 'ALTER TABLE ORDERS ADD (id_person INTEGER)';
  EXECUTE IMMEDIATE 'ALTER TABLE ORDERS ADD CONSTRAINT fk_orders_person FOREIGN KEY (id_person) REFERENCES PERSON (id_person)';
END;


-- ����� id_person ����� TRAVELERS_LIST ������ ���� ��
BEGIN
  EXECUTE IMMEDIATE 'ALTER TABLE TRAVELERS_LIST ADD (id_person INTEGER)';
  EXECUTE IMMEDIATE 'ALTER TABLE TRAVELERS_LIST ADD CONSTRAINT fk_travelers_list_person FOREIGN KEY (id_person) REFERENCES PERSON (id_person)';
END;

--����� ���� ����� PERSON
BEGIN
  -- ����� ������ �-TRAVELERS �-PERSON ������ id_person
  BEGIN
  FOR rec IN (SELECT id_travels, name, year_of_birth FROM TRAVELERS) LOOP
    -- ����� ������ �-PERSON
    EXECUTE IMMEDIATE 'INSERT INTO PERSON (id_person, name, year_of_birth, phone, email)
                       VALUES (' || rec.id_travels || ', ''' || rec.name || ''', ' || rec.year_of_birth || ', NULL, NULL)';

    -- ����� id_person ����� TRAVELERS
    EXECUTE IMMEDIATE 'UPDATE TRAVELERS
                       SET id_person = ' || rec.id_travels || '
                       WHERE id_travels = ' || rec.id_travels;
  END LOOP;
  END;

  -- ����� ������ �-WORKERS �-PERSON ������ id_person
  BEGIN
  FOR rec IN (SELECT IDWO, workersname, workersphone, workersmail FROM WORKERS) LOOP
    -- ����� ������ �-PERSON
    EXECUTE IMMEDIATE 'INSERT INTO PERSON (id_person, name, year_of_birth, phone, email)
                       VALUES (' || rec.IDWO || ', ''' || rec.workersname || ''', NULL, ''' || rec.workersphone || ''', ''' || rec.workersmail || ''')';

    -- ����� id_person ����� WORKERS
    EXECUTE IMMEDIATE 'UPDATE WORKERS
                       SET id_person = ' || rec.IDWO || '
                       WHERE IDWO = ' || rec.IDWO;
  END LOOP;
  END;

  
 -- ����� date_of_birth ����� PERSON �� year_of_birth �-TRAVELERS
 BEGIN
 FOR rec IN (SELECT id_travels, year_of_birth FROM TRAVELERS) LOOP
    EXECUTE IMMEDIATE 'UPDATE PERSON
                       SET year_of_birth = ' || rec.year_of_birth || '
                       WHERE id_person = ' || rec.id_travels;
  END LOOP;
END;
  -- ����� phone �-email ����� PERSON �� ������� �-WORKERS
  BEGIN
  FOR rec IN (SELECT IDWO, workersphone, workersmail FROM WORKERS) LOOP
    EXECUTE IMMEDIATE 'UPDATE PERSON
                       SET phone = ''' || rec.workersphone || ''',
                           email = ''' || rec.workersmail || '''
                       WHERE id_person = ' || rec.IDWO;
  END LOOP;
  END;
END;


-- ����� ���� �� id_person �-TRAVELERS
BEGIN
  EXECUTE IMMEDIATE 'UPDATE TRAVELERS t
                     SET id_person = (SELECT id_person FROM PERSON p WHERE p.id_person = t.id_travels)';
END;


-- ����� ���� �� id_person �-WORKERS
BEGIN
  EXECUTE IMMEDIATE 'UPDATE WORKERS w
                     SET id_person = (SELECT id_person FROM PERSON p WHERE p.id_person = w.IDWO)';
END;

select * from person;
select * from workers;
select * from TRAVELERS;

BEGIN
  -- ����� ���� ��� ��� ������ �������
  EXECUTE IMMEDIATE 'CREATE TABLE WORKER_TRAVEL (
      worker_id NUMBER NOT NULL,
      travel_id NUMBER NOT NULL,
      CONSTRAINT pk_worker_travel PRIMARY KEY (worker_id, travel_id),
      CONSTRAINT fk_worker FOREIGN KEY (worker_id) REFERENCES WORKERS(IDWO),
      CONSTRAINT fk_travel FOREIGN KEY (travel_id) REFERENCES TRAVELERS(id_travels)
    )';
    END;
    
  BEGIN
  -- ����� ����� ��� ������ ������� ���� WORKERS �-TRAVELERS
  FOR i IN 1..30 LOOP
    INSERT INTO WORKER_TRAVEL (worker_id, travel_id)
    select
        (SELECT IDWO FROM (SELECT IDWO FROM WORKERS ORDER BY DBMS_RANDOM.VALUE) WHERE ROWNUM = 1),
        (SELECT id_travels FROM (SELECT id_travels FROM TRAVELERS ORDER BY DBMS_RANDOM.VALUE) WHERE ROWNUM = 1)
    FROM DUAL;
            
  END LOOP;
  END;




select * from WORKER_TRAVEL;

