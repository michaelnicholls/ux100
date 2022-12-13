CLASS zcl_z_dynamic_tile_dpc_ext DEFINITION
  PUBLIC
  INHERITING FROM zcl_z_dynamic_tile_dpc
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
  methods DATASET_GET_ENTITY
    redefinition .
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_Z_DYNAMIC_TILE_DPC_EXT IMPLEMENTATION.


  METHOD DATASET_GET_ENTITY.
    DATA TEXT TYPE C length 20.
    DATA: ran1 TYPE qf00-ran_int,
          ran2 LIKE ran1,
          ran3 LIKE ran1,
          ran4 LIKE ran1,
          ran5 LIKE ran1.     .

    WRITE sy-datum TO TEXT DD/MM/YYYY.
    er_entity-numberunit = TEXT.
    WRITE sy-uzeit TO TEXT ENVIRONMENT TIME FORMAT.
    er_entity-info = TEXT.
    CALL FUNCTION 'QF05_RANDOM_INTEGER'
    IMPORTING RAN_INT = ran1.
    CALL FUNCTION 'QF05_RANDOM_INTEGER'
    IMPORTING RAN_INT = ran2.
    CALL FUNCTION 'QF05_RANDOM_INTEGER'
    IMPORTING RAN_INT = ran3.
    CALL FUNCTION 'QF05_RANDOM_INTEGER'
    IMPORTING RAN_INT = ran4.
    CALL FUNCTION 'QF05_RANDOM_INTEGER'
    IMPORTING RAN_INT = ran5.


    er_entity-infostate = 'Positive'.
    IF ran1 < 25. er_entity-infostate = 'Negative'. ENDIF.
    IF ran1 > 50. er_entity-infostate = 'Neutral'. ENDIF.
    IF ran1 > 75. er_entity-infostate = 'Critical'. ENDIF.

    er_entity-NUMBER = ran4.
    er_entity-numberDigits = 2.
    er_entity-numberstate = 'Positive'.
    IF ran2 < 25. er_entity-numberstate = 'Negative'. ENDIF.
    IF ran2 > 50. er_entity-numberstate = 'Neutral'. ENDIF.
    IF ran2 > 75. er_entity-numberstate = 'Critical'. ENDIF.
    er_entity-subtitle = sy-sysid.
    er_entity-statearrow = 'Up'.
    IF ran3 < 30. er_entity-statearrow = 'Down'. ENDIF.
    IF ran3 > 60. er_entity-statearrow = 'Neutral'. ENDIF.
    er_entity-TITLE = sy-uname.
    TEXT = 'in-process'.
    IF ran5 < 20. TEXT = 'completed'. ENDIF.
    IF ran5 > 40. TEXT = 'critical'. ENDIF.
    IF ran5 > 60. TEXT = 'inactive'. ENDIF.
    er_entity-ICON = |sap-ICON://status-{ TEXT }|.
  ENDMETHOD.


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
        ev_error = 'no division by 0'(dbz).
      ELSE.
        ev_res = iv_op1 / iv_op2.
      ENDIF.
    WHEN '%'.
      IF iv_op2 = 0.
        ev_error = 'no percent of 0'(npz).
      ELSE.
        ev_res = iv_op1 * 100 /  iv_op2.
      ENDIF.
    WHEN OTHERS.
      ev_error = 'bad operator'(bop).
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
  ENDMETHOD.


  METHOD CALCULATORSET_GET_ENTITYSET.
    DATA(lv_op1) = 30.
    DATA(lv_op2) = 20.
    data lv_op type string VALUE '+'.

    CALL METHOD calc( EXPORTING     iv_op = lv_op     iv_op1 = lv_op1      iv_op2 = lv_op2
    IMPORTING   ev_error = DATA(ev_error)   ev_res = DATA(ev_res) ).
    et_entityset = VALUE #( base et_entityset ( operand1 = lv_op1 operand2 = lv_op2 operator = lv_op result = ev_res error = ev_error ) ).

    lv_op = '-'.
    CALL METHOD calc( EXPORTING     iv_op = lv_op     iv_op1 = lv_op1      iv_op2 = lv_op2
    IMPORTING   ev_error = ev_error  ev_res = ev_res ).
    et_entityset = VALUE #( base et_entityset ( operand1 = lv_op1 operand2 = lv_op2 operator = lv_op result = ev_res error = ev_error ) ).

    lv_op = '*'.
    CALL METHOD calc( EXPORTING     iv_op = lv_op     iv_op1 = lv_op1      iv_op2 = lv_op2
   IMPORTING   ev_error = ev_error  ev_res = ev_res ).
    et_entityset = VALUE #( base et_entityset ( operand1 = lv_op1 operand2 = lv_op2 operator = lv_op result = ev_res error = ev_error ) ).

    lv_op = '/'.
    CALL METHOD calc( EXPORTING     iv_op = lv_op     iv_op1 = lv_op1      iv_op2 = lv_op2
    IMPORTING   ev_error = ev_error  ev_res = ev_res ).
    et_entityset = VALUE #( base et_entityset ( operand1 = lv_op1 operand2 = lv_op2 operator = lv_op result = ev_res error = ev_error ) ).

    lv_op = '%'.
    CALL METHOD calc( EXPORTING     iv_op = lv_op     iv_op1 = lv_op1      iv_op2 = lv_op2
    IMPORTING   ev_error = ev_error  ev_res = ev_res ).
    et_entityset = VALUE #( base et_entityset ( operand1 = lv_op1 operand2 = lv_op2 operator = lv_op result = ev_res error = ev_error ) ).

  ENDMETHOD.
ENDCLASS.
