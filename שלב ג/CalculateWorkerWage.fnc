CREATE OR REPLACE FUNCTION CalculateWorkerWage(p_worker_id IN NUMBER)
RETURN NUMBER IS
    v_order_count NUMBER;
    v_wage_per_order NUMBER := 50; -- ���� ���� ���� �� �����
    v_total_wage NUMBER;
BEGIN
    -- ���� �� ���� ������� ����� ��� �����
    SELECT COUNT(*) INTO v_order_count
    FROM Orders
    WHERE IdWo = p_worker_id;

    -- ���� �� ���� ����� �� �����
    v_total_wage := v_order_count * v_wage_per_order;

    RETURN v_total_wage;
EXCEPTION
    WHEN OTHERS THEN
        RETURN 0;
END;
/
