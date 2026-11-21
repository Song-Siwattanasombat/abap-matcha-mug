@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Matcha Mug product BO'
define root view entity ZR_SH2_PRODUCT
  as select from zsh2_product
{
      @EndUserText.label: 'Product ID'
  key product_id as ProductId,

      @EndUserText.label: 'Product Name'
      name       as ProductName,

      @EndUserText.label: 'Price'
      @Semantics.amount.currencyCode: 'Currency'
      price      as Price,

      @EndUserText.label: 'Currency'
      currency   as Currency,

      @EndUserText.label: 'Stock'
      stock      as Stock,
      
      @EndUserText.label: 'Stock status'
     case
        when stock = 0  then 1
        when stock < 10 then 2
        else 0
     end        as StockCriticality
}

