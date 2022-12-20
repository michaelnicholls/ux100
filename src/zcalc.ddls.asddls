@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'entity'
@OData.publish: true
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZCALC  with parameters
    op1 :int4,
    op2 :int4,
    op  :char1
  as select from t000
{
//  key $parameters.op1 as operand1,
//  key $parameters.op2 as operand2,
//  key $parameters.op  as operator,
    key '' as x,
      case $parameters.op
          when '+' then
        $parameters.op1 + $parameters.op2
          when '-' then
        $parameters.op1 - $parameters.op2
          when '*' then
        $parameters.op1 * $parameters.op2
          when '/' then
          case  $parameters.op2 when  0 then 0
//
// handle division by 0
//
          else division($parameters.op1, $parameters.op2, 2 )
          end
           when '%' then
          case  $parameters.op2 when  0 then 0
//
// handle percentage of 0
//


          else div(100 * $parameters.op1, $parameters.op2 )
          end
        else
          0
        end           as res,

      case $parameters.op
        when '+' then
      ''
        when '-' then
      ''
        when '*' then
      ''
        when '/' then
        case $parameters.op2 when 0 then 'No division by 0'
        else
      ''
      end
        when '%' then
        case $parameters.op2 when 0 then 'No percentage of 0'
        else
      ''
      end
      else
        'Bad operator'
      end             as error

}
where
  mandt = '000'
