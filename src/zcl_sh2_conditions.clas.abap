CLASS zcl_sh2_conditions DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_sh2_conditions IMPLEMENTATION.
    METHOD if_oo_adt_classrun~main.
    CONSTANTS lc_gst_rate TYPE p LENGTH 3 DECIMALS 2 VALUE '0.10'.
    CONSTANTS lc_ship_fee TYPE p LENGTH 10 DECIMALS 2 VALUE '9.95'.
    CONSTANTS lc_free_ship_min TYPE p LENGTH 10 DECIMALS 2 VALUE '100.00'.


    DATA lv_product             TYPE string.
    DATA lv_member              TYPE string.
    DATA lv_qty                 TYPE i.
    DATA lv_price               TYPE p LENGTH 10 DECIMALS 2.
    DATA lv_subtotal            TYPE p LENGTH 10 DECIMALS 2.
    DATA lv_disc_rate           TYPE p LENGTH 3 DECIMALS 2.
    DATA lv_discount            TYPE p LENGTH 10 DECIMALS 2.
    DATA lv_net                 TYPE p LENGTH 10 DECIMALS 2.
    DATA lv_shipping            TYPE p LENGTH 10 DECIMALS 2.
    DATA lv_gst                 TYPE p LENGTH 10 DECIMALS 2.
    DATA lv_grand_total         TYPE p LENGTH 10 DECIMALS 2.

    lv_product = `Matcha Mug`.
    lv_member = `SILVER`.
    lv_qty = 105.
    lv_price = '19.00'.

    lv_subtotal = lv_qty * lv_price.

    IF lv_qty >= 20.
        lv_disc_rate = '0.10'.
    ELSEIF lv_qty >= 10.
        lv_disc_rate = '0.05'.
    ELSE.
        lv_disc_rate = 0.
    ENDIF.

    lv_discount = lv_subtotal * lv_disc_rate.
    lv_net      = lv_subtotal - lv_discount.

    IF lv_net >= lc_free_ship_min OR lv_member = `GOLD`.
        lv_shipping = 0.
    ELSE.
        lv_shipping = lc_ship_fee.
    ENDIF.

    lv_gst         = ( lv_net + lv_shipping ) * lc_gst_rate.
    lv_grand_total = lv_net + lv_shipping + lv_gst.

    IF lv_qty > 100.
      out->write( `Bulk order: please contact our sales team.` ).
    ENDIF.

    out->write( |Product: { lv_product }| ).
    out->write( |Qty: { lv_qty } x { lv_price } AUD| ).
    out->write( |Subtotal: { lv_subtotal } AUD| ).
    out->write( |Discount: -{ lv_discount } AUD| ).
    out->write( |Shipping: { lv_shipping } AUD| ).
    out->write( |GST 10%: { lv_gst } AUD| ).
    out->write( |Grand total: { lv_grand_total } AUD| ).

    CASE lv_member.
      WHEN `GOLD`.
        out->write( `Gold member: free shipping, always!` ).
      WHEN `SILVER`.
        out->write( `Silver member: you earn double points!` ).
      WHEN OTHERS.
        out->write( `Join our membership for free shipping!` ).

    ENDCASE.
  ENDMETHOD.
ENDCLASS.
