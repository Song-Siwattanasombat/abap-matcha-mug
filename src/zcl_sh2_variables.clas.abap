CLASS zcl_sh2_variables DEFINITION
    PUBLIC
    FINAL
    CREATE PUBLIC .

    PUBLIC SECTION.
        INTERFACES if_oo_adt_classrun.
    PROTECTED SECTION.
    PRIVATE SECTION.
ENDCLASS.

CLASS zcl_sh2_variables IMPLEMENTATION.
    METHOD if_oo_adt_classrun~main.
        DATA lv_product TYPE string.
    DATA lv_qty TYPE i.
    DATA lv_price TYPE p LENGTH 10 DECIMALS 2.
    DATA lv_total TYPE p LENGTH 10 DECIMALS 2.

    CONSTANTS lc_gst_rate TYPE p LENGTH 3 DECIMALS 2 VALUE '0.10'.
    DATA lv_gst TYPE p LENGTH 10 DECIMALS 2.
    DATA lv_grand_total TYPE p LENGTH 10 DECIMALS 2.

    lv_product = `Matcha Mug`.
    lv_qty = 25.
    lv_price = '19.00'.


    lv_total = lv_qty * lv_price.

    lv_gst         = lv_total * lc_gst_rate.
    lv_grand_total = lv_total + lv_gst.

    DATA(lv_today) = cl_abap_context_info=>get_system_date( ).

        out->write( | date: { lv_today DATE = ISO }| ).
        out->write( | product: { lv_product } | ).
        out->write( | qty: { lv_qty } unit | ).
        out->write( | price: { lv_price } AUD | ).
        out->write( | subtotal: { lv_total } AUD | ).
        out->write( | GST 10%: { lv_gst } AUD| ).
        out->write( | grand total: { lv_grand_total } AUD| ).
    ENDMETHOD.
ENDCLASS.

