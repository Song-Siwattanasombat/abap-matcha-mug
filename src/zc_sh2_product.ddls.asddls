@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Matcha Mug product app'
@Metadata.allowExtensions: true
@Search.searchable: true
define root view entity ZC_SH2_PRODUCT
  provider contract transactional_query
  as projection on ZR_SH2_PRODUCT
 {
      @Search.defaultSearchElement: true
  key ProductId,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      ProductName,
      Price,
      Currency,
      Stock
  }
