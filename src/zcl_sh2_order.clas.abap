CLASS zcl_sh2_order DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_sh2_order IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    TYPES: BEGIN OF ty_item,
             product TYPE string,
             qty     TYPE i,
             price   TYPE p LENGTH 10 DECIMALS 2,
           END OF ty_item.
    TYPES tt_items TYPE STANDARD TABLE OF ty_item WITH EMPTY KEY.

    CONSTANTS lc_gst_rate      TYPE p LENGTH 3 DECIMALS 2 VALUE '0.10'.
    CONSTANTS lc_ship_fee      TYPE p LENGTH 10 DECIMALS 2 VALUE '9.95'.
    CONSTANTS lc_free_ship_min TYPE p LENGTH 10 DECIMALS 2 VALUE '100.00'.

    DATA lv_line_total  TYPE p LENGTH 10 DECIMALS 2.
    DATA lv_subtotal    TYPE p LENGTH 10 DECIMALS 2.
    DATA lv_total_qty   TYPE i.
    DATA lv_shipping    TYPE p LENGTH 10 DECIMALS 2.
    DATA lv_gst         TYPE p LENGTH 10 DECIMALS 2.
    DATA lv_grand_total TYPE p LENGTH 10 DECIMALS 2.

    DATA(lt_items) = VALUE tt_items(
        ( product = `Matcha Mug`         qty = 2 price = '19.00' )
      ( product = `Bamboo Whisk`       qty = 1 price = '24.50' )
      ( product = `Matcha Powder 100g` qty = 3 price = '32.00' )
      ( product = `Tea Bowl`           qty = 1 price = '45.00' ) ).

    APPEND VALUE #( product = `Whisk Holder` qty = 1 price = '12.00' ) TO lt_items.

    LOOP AT lt_items INTO DATA(ls_item).
      lv_line_total = ls_item-qty * ls_item-price.
      lv_subtotal   = lv_subtotal + lv_line_total.
      lv_total_qty  = lv_total_qty + ls_item-qty.
      out->write( |{ ls_item-product }: { ls_item-qty } x { ls_item-price } = { lv_line_total } AUD| ).
      IF ls_item-price >= 40.
        out->write( `  (Fragile: packed with extra care)` ).
      ENDIF.
    ENDLOOP.

    IF lv_subtotal >= lc_free_ship_min.
      lv_shipping = 0.
    ELSE.
      lv_shipping = lc_ship_fee.
    ENDIF.

    lv_gst         = ( lv_subtotal + lv_shipping ) * lc_gst_rate.
    lv_grand_total = lv_subtotal + lv_shipping + lv_gst.

    out->write( `--------------------` ).
    out->write( |Items: { lines( lt_items ) } lines, { lv_total_qty } pieces| ).
    out->write( |Subtotal: { lv_subtotal } AUD| ).
    out->write( |Shipping: { lv_shipping } AUD| ).
    out->write( |GST 10%: { lv_gst } AUD| ).
    out->write( |Grand total: { lv_grand_total } AUD| ).
  ENDMETHOD.
ENDCLASS.





