CREATE OR REPLACE PROCEDURE ManageStockTransfer AS
  CURSOR overstock_cursor IS
    SELECT Shelf, UnitsInStock
    FROM Inventory
    WHERE UnitsInStock > 40;
    
  overstock_rec overstock_cursor%ROWTYPE;
  target_shelf NUMERIC;
  units_to_transfer NUMERIC;
BEGIN
  OPEN overstock_cursor;
  LOOP
    FETCH overstock_cursor INTO overstock_rec;
    EXIT WHEN overstock_cursor%NOTFOUND;
    
    target_shelf := FindShelfUnder40();
    
    IF target_shelf IS NOT NULL THEN
      units_to_transfer := overstock_rec.UnitsInStock - 40;
      
      -- עדכון המדף המקורי
      UPDATE Inventory
      SET UnitsInStock = 40
      WHERE Shelf = overstock_rec.Shelf;
      
      -- עדכון המדף הריק
      UPDATE Inventory
      SET UnitsInStock = UnitsInStock + units_to_transfer
      WHERE Shelf = target_shelf;
    END IF;
  END LOOP;
  CLOSE overstock_cursor;
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/
