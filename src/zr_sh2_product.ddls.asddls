@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Matcha Mug product BO'
@UI.headerInfo: { typeName: 'Product',
                 typeNamePlural: 'Products',
                 title: { type: #STANDARD, value: 'ProductName' } }
define root view entity ZR_SH2_PRODUCT
  as select from zsh2_product
{
      @UI.facet: [{ id: 'Product',
                    purpose: #STANDARD,
                    type: #IDENTIFICATION_REFERENCE,
                    label: 'Product',
                    position: 10 }]
      @EndUserText.label: 'Product ID'
      @UI.lineItem:       [{ position: 10 }]
      @UI.identification: [{ position: 10 }]
  key product_id as ProductId,

      @EndUserText.label: 'Product Name'
      @UI.lineItem:       [{ position: 20 }]
      @UI.identification: [{ position: 20 }]
      name       as ProductName,

      @EndUserText.label: 'Price'
      @Semantics.amount.currencyCode: 'Currency'
      @UI.lineItem:       [{ position: 30 }]
      @UI.identification: [{ position: 30 }]
      price      as Price,

      @EndUserText.label: 'Currency'
      @UI.identification: [{ position: 40 }]
      currency   as Currency,

      @EndUserText.label: 'Stock'
      @UI.lineItem:       [{ position: 40 }]
      @UI.identification: [{ position: 50 }]
      stock      as Stock
}
