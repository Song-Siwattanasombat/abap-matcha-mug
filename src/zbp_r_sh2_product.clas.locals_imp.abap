CLASS lhc_product DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS validatePrice FOR VALIDATE ON SAVE
      IMPORTING keys FOR Product~validatePrice.
    METHODS validateStock FOR VALIDATE ON SAVE
      IMPORTING keys FOR Product~validateStock.
ENDCLASS.

CLASS lhc_product IMPLEMENTATION.

  METHOD validatePrice.
    READ ENTITIES OF zr_sh2_product IN LOCAL MODE
      ENTITY Product
        FIELDS ( Price ) WITH CORRESPONDING #( keys )
      RESULT DATA(products).

    LOOP AT products INTO DATA(product).
      IF product-Price <= 0.
        APPEND VALUE #( %tky = product-%tky ) TO failed-product.
        APPEND VALUE #( %tky = product-%tky
                        %msg = new_message_with_text(
                                 severity = if_abap_behv_message=>severity-error
                                 text     = 'Price must be greater than 0' )
                        %element-Price = if_abap_behv=>mk-on )
          TO reported-product.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD validateStock.
    READ ENTITIES OF zr_sh2_product IN LOCAL MODE
      ENTITY Product
        FIELDS ( Stock ) WITH CORRESPONDING #( keys )
      RESULT DATA(products).

    LOOP AT products INTO DATA(product).
      IF product-Stock < 0.
        APPEND VALUE #( %tky = product-%tky ) TO failed-product.
        APPEND VALUE #( %tky = product-%tky
                        %msg = new_message_with_text(
                                 severity = if_abap_behv_message=>severity-error
                                 text     = 'Stock must not be negative' )
                        %element-Stock = if_abap_behv=>mk-on )
          TO reported-product.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.
