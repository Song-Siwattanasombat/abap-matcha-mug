CLASS zcl_sh2_sale DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_sh2_sale IMPLEMENTATION.
 METHOD if_oo_adt_classrun~main.
    TYPES: BEGIN OF ty_order,
           product_id TYPE zsh2_product-product_id,
           qty TYPE i,
           END OF ty_order.
    DATA lt_orders TYPE STANDARD TABLE OF ty_order WITH EMPTY KEY.

    lt_orders = VALUE #(
       ( product_id = 'MUG01' qty = 2 )
       ( product_id = 'BOWL01' qty = 10 )
       ( product_id = 'CUP99' qty = 1 ) ).

    LOOP AT lt_orders INTO DATA(ls_order).
    SELECT SINGLE FROM zsh2_product
        FIELDS name, stock
        WHERE product_id = @ls_order-product_id
        INTO @DATA(ls_product).

    IF sy-subrc <> 0.
        out->write( | { ls_order-product_id }: product not found | ).
      ELSEIF ls_product-stock < ls_order-qty.
       out->write( | { ls_product-name }: not enough stock (only { ls_product-stock } left)| ).
      ELSE.
        UPDATE zsh2_product
        SET stock = stock - @ls_order-qty
        WHERE product_id = @ls_order-product_id.
        out->write( |{ ls_product-name }: sold { ls_order-qty }, stock now { ls_product-stock - ls_order-qty }| ).
    ENDIF.
    ENDLOOP.

    SELECT SINGLE FROM zsh2_product
      FIELDS *
      WHERE product_id = 'BOWL01'
      INTO @DATA(ls_bowl).
    ls_bowl-price = '42.00'.
    UPDATE zsh2_product FROM @ls_bowl.
    out->write( |Tea Bowl new price: { ls_bowl-price } AUD| ).

 DATA(ls_tin) = VALUE zsh2_product( product_id = 'TIN01' name = 'Matcha Tin'
                                       price = '15.50' currency = 'AUD' stock = 30 ).
    MODIFY zsh2_product FROM @ls_tin.

 DELETE FROM zsh2_product WHERE stock = 0.
    out->write( |Removed { sy-dbcnt } out-of-stock products| ).

  SELECT FROM zsh2_product
      FIELDS product_id, name, price, stock
      ORDER BY product_id
      INTO TABLE @DATA(lt_all).
    out->write( lt_all ).
  ENDMETHOD.
ENDCLASS.
