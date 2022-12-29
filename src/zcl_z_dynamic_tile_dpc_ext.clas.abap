class ZCL_Z_DYNAMIC_TILE_DPC_EXT definition
  public
  inheriting from ZCL_Z_DYNAMIC_TILE_DPC
  create public .

public section.
protected section.

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
    io_tech_request_context->get_converted_keys(
      IMPORTING es_key_values = er_entity ).

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
    er_entity-subtitle = | { sy-sysid }:{ sy-uname } |.
    er_entity-statearrow = 'Up'.
    IF ran3 < 30. er_entity-statearrow = 'Down'. ENDIF.
    IF ran3 > 60. er_entity-statearrow = 'None'. ENDIF.
    er_entity-title = er_entity-key.
    text = 'in-process'.
    IF ran5 < 20. text = 'completed'. ENDIF.
    IF ran5 > 40. text = 'critical'. ENDIF.
    IF ran5 > 60. text = 'inactive'. ENDIF.
    er_entity-icon = |sap-ICON://status-{ text }|.
  ENDMETHOD.
ENDCLASS.
