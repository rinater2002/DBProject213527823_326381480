CREATE OR REPLACE FUNCTION FindShelfUnder40 RETURN NUMERIC IS
  shelf_num NUMERIC;
BEGIN
  SELECT Shelf INTO shelf_num
  FROM Inventory
  WHERE UnitsInStock < 40
  AND ROWNUM = 1;
  
  RETURN shelf_num;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RETURN NULL;
END;
/
