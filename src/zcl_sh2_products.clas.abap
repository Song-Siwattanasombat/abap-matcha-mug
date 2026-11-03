CLASS zcl_sh2_products DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_sh2_products IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    " Clear old data, so we can run this class again
    DELETE FROM zsh2_product.

    DATA lt_products TYPE STANDARD TABLE OF zsh2_product WITH EMPTY KEY.
    lt_products = VALUE #(
      ( product_id = 'MUG01'    name = 'Matcha Mug'         price = '19.00' currency = 'AUD' stock = 25 )
      ( product_id = 'WHISK01'  name = 'Bamboo Whisk'       price = '24.50' currency = 'AUD' stock = 12 )
      ( product_id = 'POWDER01' name = 'Matcha Powder 100g' price = '32.00' currency = 'AUD' stock = 40 )
      ( product_id = 'BOWL01'   name = 'Tea Bowl'           price = '45.00' currency = 'AUD' stock = 6 )
      ( product_id = 'HOLDER01' name = 'Whisk Holder'       price = '12.00' currency = 'AUD' stock = 0 )
      ( product_id = 'TIN01'    name = 'Matcha Tin'         price = '15.50' currency = 'AUD' stock = 30 ) ).

    INSERT zsh2_product FROM TABLE @lt_products.
    out->write( |Inserted { sy-dbcnt } products| ).

    SELECT FROM zsh2_product
        FIELDS product_id, name, price, currency, stock
        ORDER BY product_id
        INTO TABLE @DATA(lt_all).
    out->write( lt_all ).

    SELECT FROM zsh2_product
       FIELDS name, price
       WHERE price >= 30
       ORDER BY price DESCENDING
       INTO TABLE @DATA(lt_premium).

    LOOP AT lt_premium INTO DATA(ls_premium).
      out->write( |Premium: { ls_premium-name } { ls_premium-price } AUD| ).
    ENDLOOP.

    SELECT FROM zsh2_product
    FIELDS name
    WHERE stock = 0
    INTO TABLE @DATA(lt_out_of_stock).

    LOOP AT lt_out_of_stock INTO DATA(ls_out).
      out->write( |Out of stock: { ls_out-name }| ).
    ENDLOOP.


  ENDMETHOD.
ENDCLASS.


