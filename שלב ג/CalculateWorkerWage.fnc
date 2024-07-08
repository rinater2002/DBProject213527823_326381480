CREATE OR REPLACE FUNCTION CalculateWorkerWage(p_worker_id IN NUMBER)
RETURN NUMBER IS
    v_order_count NUMBER;
    v_wage_per_order NUMBER := 50; -- סכום קבוע עבור כל הזמנה
    v_total_wage NUMBER;
BEGIN
    -- מחשב את מספר ההזמנות שטיפל בהן העובד
    SELECT COUNT(*) INTO v_order_count
    FROM Orders
    WHERE IdWo = p_worker_id;

    -- מחשב את השכר הכולל של העובד
    v_total_wage := v_order_count * v_wage_per_order;

    RETURN v_total_wage;
EXCEPTION
    WHEN OTHERS THEN
        RETURN 0;
END;
/
