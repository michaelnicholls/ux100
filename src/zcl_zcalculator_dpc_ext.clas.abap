class ZCL_ZCALCULATOR_DPC_EXT definition
  PUBLIC
  INHERITING FROM zcl_zcalculator_dpc
  CREATE PUBLIC .

  PUBLIC SECTION.

protected section.

  methods CALC
    importing
      !IV_OP1 type I
      !IV_OP2 type I
      !IV_OP type string
    exporting
      !EV_RES type F
      !EV_ERROR type STRING .

  methods CALCULATORSET_GET_ENTITY
    redefinition .
  methods CALCULATORSET_GET_ENTITYSET
    redefinition .

  PRIVATE SECTION.
  class-data validops type string value '+-*/%'.
ENDCLASS.



CLASS ZCL_ZCALCULATOR_DPC_EXT IMPLEMENTATION.


  METHOD calc .
    CLEAR ev_error.
    CLEAR ev_res.
    CASE iv_op.
      WHEN '+'.
        ev_res = iv_op1 + iv_op2.
      WHEN '-'.
        ev_res = iv_op1 - iv_op2.
      WHEN '*'.
        ev_res = iv_op1 * iv_op2.
      WHEN '/'.
        IF iv_op2 = 0.
          ev_error = 'no division by 0 allowed'(dbz).
        ELSE.
          ev_res = iv_op1 / iv_op2.
        ENDIF.
      WHEN '%'.
        IF iv_op2 = 0.
          ev_error = 'no percent of 0 allowed'(npz).
        ELSE.
          ev_res = iv_op1 * 100 /  iv_op2.
        ENDIF.
      WHEN OTHERS.
        ev_error = | { text-bop }: { iv_op } |.
    ENDCASE.


  ENDMETHOD.


  METHOD calculatorset_get_entity.
    io_tech_request_context->get_converted_keys( IMPORTING
      es_key_values = er_entity ).
    DATA lv_op type string.
    lv_op  = er_entity-operator.
    data lv_op1 type i.
    lv_op1 = er_entity-operand1.
    data lv_op2 type i.
    lv_op2  = er_entity-operand2.
    call METHOD calc(
      EXPORTING
        iv_op = lv_op
          iv_op1 = lv_op1
          iv_op2 = lv_op2
        IMPORTING
          ev_error = DATA(lv_error)
          ev_res = DATA(lv_res)
          ).
  er_entity-error = lv_error.
  er_entity-result = lv_res.
  er_entity-ops = validops.
  ENDMETHOD.


METHOD calculatorset_get_entityset.
  DATA(lv_op1) = 30.
  DATA(lv_op2) = 20.
  DATA lv_op TYPE string VALUE '+'.
*    data(validops) =  '+-*/%'.
  data(top) = io_tech_request_context->get_top( ).
  if top > strlen( validops ) or top is initial . top = strlen( validops ). endif.
  DO top TIMES.
    DATA(I) = sy-INDEX.
    I = I - 1.
    lv_op = validops+i(1).
    CALL FUNCTION 'QF05_RANDOM_INTEGER'
      IMPORTING
        ran_int = lv_op1.
    CALL FUNCTION 'QF05_RANDOM_INTEGER'
      IMPORTING
        ran_int = lv_op2.
    CALL METHOD calc(
    EXPORTING
      iv_op    = lv_op
      iv_op1   = lv_op1
      iv_op2   = lv_op2
    IMPORTING
    ev_error = DATA(ev_error)
    ev_res   = DATA(ev_res) ).
    et_entityset = VALUE #( BASE et_entityset
    ( operand1 = lv_op1 operand2 = lv_op2 operator = lv_op result = ev_res error = ev_error ops = validops ) ).
  ENDDO.
ENDMETHOD.
ENDCLASS.
