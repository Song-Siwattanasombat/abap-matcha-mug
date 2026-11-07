@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Matcha Mug product view'
define view entity ZI_SH2_PRODUCT
  as select from zsh2_product
{
  key product_id as ProductId,
      name       as ProductName,
      @Semantics.amount.currencyCode: 'Currency'
      price      as Price,
      currency   as Currency,
      stock      as Stock,
      case
           when stock = 0  then 'Out of stock'
           when stock < 15 then 'Low stock'
           else 'In stock'
         end     as StockStatus
}
