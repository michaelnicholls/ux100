
@OData.publish: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Calculator with formula'
define view entity ZCALC_FORMULA
  with parameters
    operand1 :int4,
    operand2 :int4,
    operator :char1
  as select from ZCALC( operand1 : $parameters.operand1, operand2 : $parameters.operand2, operator: $parameters.operator )
{

  key x,
      res,
      error,
      ops,
      concat_with_space(    
      concat_with_space(   
       concat_with_space(     
       concat_with_space( ltrim(cast($parameters.operand1 as abap.char( 12 )),' '), $parameters.operator, 1 ),    
       ltrim( cast($parameters.operand2 as abap.char( 12 )), ' ' ), 1),' = ',1), 
       cast( res as abap.char( 30 )) ,1) as formula


}
