CLASS zcl_sh2_product_view DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_sh2_product_view IMPLEMENTATION.
METHOD if_oo_adt_classrun~main.
SELECT FROM zi_sh2_product
FIELDS ProductId, ProductName, Price, Stock, StockStatus
ORDER BY ProductId
INTO TABLE @DATA(lt_view).
out->write( lt_view ).

SELECT FROM zi_sh2_product
FIELDS ProductName, Stock, StockStatus
WHERE Stockstatus <> 'In stock'
ORDER BY stock
INTO TABLE @DATA(lt_attention).

LOOP AT lt_attention INTO DATA(ls_attention).
      out->write( |Attention: { ls_attention-ProductName } - { ls_attention-StockStatus } ({ ls_attention-Stock })| ).
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.

