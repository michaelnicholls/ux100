@AbapCatalog.sqlViewName: 'Z__CALC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS calculator'

@OData.publish: true
define view ZCALC
  with parameters
    op1 :int4,
    op2 :int4,
    op  :char1
  as select from t000 
{
  key $parameters.op1                   as operand1,
  key $parameters.op2                   as operand2,
  key $parameters.op                    as operator,
    case $parameters.op
        when '+' then
      $parameters.op1 + $parameters.op2 
        when '-' then
      $parameters.op1 - $parameters.op2 
        when '*' then
      $parameters.op1 * $parameters.op2 
        when '/' then
      div($parameters.op1, $parameters.op2 )
      else
        0
      end as res,
      
      case $parameters.op
        when '+' then
      ''
        when '-' then
     ''
        when '*' then
      '' 
        when '/' then
      ''
      else
        'Bad operator'
      end as error

}
where mandt ='000'
