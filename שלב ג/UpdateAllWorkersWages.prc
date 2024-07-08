CREATE OR REPLACE PROCEDURE UpdateAllWorkersWages AS
    CURSOR c_workers IS
        SELECT IdWo
        FROM Workers;

    worker_rec c_workers%ROWTYPE;
    v_new_wage NUMBER;
BEGIN
    OPEN c_workers;
    LOOP
        FETCH c_workers INTO worker_rec;
        EXIT WHEN c_workers%NOTFOUND;
        
        -- ���� �� ���� ���� �� �����
        v_new_wage := CalculateWorkerWage(worker_rec.IdWo);
        
        -- ����� �� ���� �� ����� ����� �������
        UPDATE Workers
        SET Wage = v_new_wage
        WHERE IdWo = worker_rec.IdWo;
    END LOOP;
    CLOSE c_workers;
END;
/
