CREATE OR REPLACE PROCEDURE PrintW3orkerOrders (
    IdWo IN NUMERIC
) IS
    CURSOR worker_orders_cursor IS
        SELECT o.OrderID, o.OrderDate, nc.NewCatalogName
        FROM Orders o
        JOIN NewCatalog nc ON o.CatalogNumber = nc.NewCatalogNumber
        WHERE o.IdWo = IdWo;
        
    order_record worker_orders_cursor%ROWTYPE;
    
BEGIN
    OPEN worker_orders_cursor;
    LOOP
        FETCH worker_orders_cursor INTO order_record;
        EXIT WHEN worker_orders_cursor%NOTFOUND;
        
        DBMS_OUTPUT.PUT_LINE('Order ID: ' || order_record.OrderID);
        DBMS_OUTPUT.PUT_LINE('Order Date: ' || order_record.OrderDate);
        DBMS_OUTPUT.PUT_LINE('Product Name: ' || order_record.NewCatalogName);
        DBMS_OUTPUT.PUT_LINE('-----------------------');
    END LOOP;
    CLOSE worker_orders_cursor;
END;
/
