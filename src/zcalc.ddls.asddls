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
    operand1 :int4,
    operand2 :int4,
    operator  :char1
  as select from t000
{

    key '' as x,
      case $parameters.operator
          when '+' then
        $parameters.operand1 + $parameters.operand2
          when '-' then
        $parameters.operand1 - $parameters.operand2
          when '*' then
        $parameters.operand1 * $parameters.operand2
          when '/' then
          case  $parameters.operand2 when  0 then 0
//
// handle division by 0
//
          else division($parameters.operand1, $parameters.operand2, 2 )
          end
           when '%' then
          case  $parameters.operand2 when  0 then 0
//
// handle percentage of 0
//


          else div(100 * $parameters.operand1, $parameters.operand2 )
          end
        else
          0
        end           as res,

      case $parameters.operator
        when '+' then
      ''
        when '-' then
      ''
        when '*' then
      ''
        when '/' then
        case $parameters.operand2 when 0 then 'No division by 0'
        else
      ''
      end
        when '%' then
        case $parameters.operand2 when 0 then 'No percentage of 0'
        else
      ''
      end
      else
        'Bad operator'
      end             as error,
    '+-*/%' as ops
}
where
  mandt = '000'
