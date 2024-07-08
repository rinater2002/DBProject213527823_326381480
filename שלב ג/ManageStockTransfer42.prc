CREATE OR REPLACE PROCEDURE ManageStockTransfer IS
  CURSOR overstocked_shelves IS
    SELECT Shelf
    FROM Inventory
    GROUP BY Shelf
    HAVING COUNT(*) > 42
    ORDER BY Shelf;

  understocked_shelves SYS_REFCURSOR;

  v_over_shelf Inventory.Shelf%TYPE;
  v_under_shelf Inventory.Shelf%TYPE;
  v_inventory_id Inventory.InventoryID%TYPE;
  v_overstock_count INTEGER;
  v_understock_count INTEGER;
  v_transfer_units INTEGER;
BEGIN
  OPEN overstocked_shelves;

  LOOP
    FETCH overstocked_shelves INTO v_over_shelf;
    EXIT WHEN overstocked_shelves%NOTFOUND;

    -- Calculate the number of products on the overstocked shelf
    SELECT COUNT(*) INTO v_overstock_count FROM Inventory WHERE Shelf = v_over_shelf;

    -- Find understocked shelves
    understocked_shelves := FindShelfUnder40();

    LOOP
      FETCH understocked_shelves INTO v_under_shelf;
      EXIT WHEN understocked_shelves%NOTFOUND;

      -- Calculate the number of products on the understocked shelf
      SELECT COUNT(*) INTO v_understock_count FROM Inventory WHERE Shelf = v_under_shelf;

      -- Calculate how many products can be transferred
      v_transfer_units := LEAST(v_overstock_count - 42, 42 - v_understock_count);

      -- Transfer products
      FOR i IN 1 .. v_transfer_units LOOP
        SELECT InventoryID INTO v_inventory_id
        FROM Inventory
        WHERE Shelf = v_over_shelf AND ROWNUM = 1;

        UPDATE Inventory
        SET Shelf = v_under_shelf
        WHERE InventoryID = v_inventory_id;

        -- Commit each update
        COMMIT;

        -- Update the overstock count
        v_overstock_count := v_overstock_count - 1;

        -- Exit if the overstocked shelf has been normalized
        EXIT WHEN v_overstock_count <= 42;
      END LOOP;

      EXIT WHEN v_overstock_count <= 42;
    END LOOP;

    CLOSE understocked_shelves;

  END LOOP;

  CLOSE overstocked_shelves;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    RAISE;
END;
/
