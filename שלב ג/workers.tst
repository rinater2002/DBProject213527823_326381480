PL/SQL Developer Test script 3.0
12
DECLARE
    v_worker_id NUMBER := 1; -- ID �� ���� �����
    v_new_wage NUMBER;
BEGIN
    -- ����� ��������� ������ ���� ����� �� �� �������
    UpdateAllWorkersWages;
    
    -- ����� �������� ������ ���� ���� �� ���� �����
    v_new_wage := CalculateWorkerWage(v_worker_id);
    DBMS_OUTPUT.PUT_LINE('The new wage for worker ID ' || v_worker_id || ' is ' || v_new_wage);
END;

0
0
