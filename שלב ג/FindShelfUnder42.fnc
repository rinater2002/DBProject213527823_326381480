CREATE OR REPLACE FUNCTION FindShelfUnder40 RETURN SYS_REFCURSOR IS
  shelf_cursor SYS_REFCURSOR;
BEGIN
  OPEN shelf_cursor FOR
    SELECT Shelf
    FROM Inventory
    GROUP BY Shelf
    HAVING COUNT(*) < 42
    ORDER BY Shelf;

  RETURN shelf_cursor;
END;
/
