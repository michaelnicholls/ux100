class ZCL_Z_DYNAMIC_TILE_DPC_EXT definition
  public
  inheriting from ZCL_Z_DYNAMIC_TILE_DPC
  create public .

public section.
protected section.

  methods CALC
    importing
      !IV_OP1 type I
      !IV_OP2 type I
      !IV_OP type STRING
    exporting
      !EV_RES type F
      !EV_ERROR type STRING .

  methods DATASET_GET_ENTITY
    redefinition .
  PRIVATE SECTION.
  class-data validops type string value '+-*/%'.
ENDCLASS.



CLASS ZCL_Z_DYNAMIC_TILE_DPC_EXT IMPLEMENTATION.


  METHOD dataset_get_entity.
    DATA text TYPE c LENGTH 20.
    DATA: ran1 TYPE qf00-ran_int,
          ran2 LIKE ran1,
          ran3 LIKE ran1,
          ran4 LIKE ran1,
          ran5 LIKE ran1..

    WRITE sy-datum TO text DD/MM/YYYY.
    er_entity-numberunit = text.
    WRITE sy-uzeit TO text ENVIRONMENT TIME FORMAT.
    er_entity-info = text.
    CALL FUNCTION 'QF05_RANDOM_INTEGER'
      IMPORTING
        ran_int = ran1.
    CALL FUNCTION 'QF05_RANDOM_INTEGER'
      IMPORTING
        ran_int = ran2.
    CALL FUNCTION 'QF05_RANDOM_INTEGER'
      IMPORTING
        ran_int = ran3.
    CALL FUNCTION 'QF05_RANDOM_INTEGER'
      IMPORTING
        ran_int = ran4.
    CALL FUNCTION 'QF05_RANDOM_INTEGER'
      IMPORTING
        ran_int = ran5.


    er_entity-infostate = 'Positive'.
    IF ran1 < 25. er_entity-infostate = 'Negative'. ENDIF.
    IF ran1 > 50. er_entity-infostate = 'Neutral'. ENDIF.
    IF ran1 > 75. er_entity-infostate = 'Critical'. ENDIF.

    er_entity-number = ran4.
    er_entity-numberDigits = 2.
    er_entity-numberstate = 'Positive'.
    IF ran2 < 25. er_entity-numberstate = 'Negative'. ENDIF.
    IF ran2 > 50. er_entity-numberstate = 'Neutral'. ENDIF.
    IF ran2 > 75. er_entity-numberstate = 'Critical'. ENDIF.
    er_entity-subtitle = sy-sysid.
    er_entity-statearrow = 'Up'.
    IF ran3 < 30. er_entity-statearrow = 'Down'. ENDIF.
    IF ran3 > 60. er_entity-statearrow = 'Neutral'. ENDIF.
    er_entity-title = sy-uname.
    text = 'in-process'.
    IF ran5 < 20. text = 'completed'. ENDIF.
    IF ran5 > 40. text = 'critical'. ENDIF.
    IF ran5 > 60. text = 'inactive'. ENDIF.
    er_entity-icon = |sap-ICON://status-{ text }|.
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
ENDCLASS.
