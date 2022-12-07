class ZCL_Z_DYNAMIC_TILE_DPC_EXT definition
  public
  inheriting from ZCL_Z_DYNAMIC_TILE_DPC
  create public .

public section.
protected section.

  methods DATASET_GET_ENTITY
    redefinition .
private section.
ENDCLASS.



CLASS ZCL_Z_DYNAMIC_TILE_DPC_EXT IMPLEMENTATION.


  method DATASET_GET_ENTITY.
  data text type c length 20.
  data: ran1 type qf00-ran_int,
        ran2 like ran1,
        ran3 like ran1,
        ran4 like ran1,
        ran5 like ran1.     .

write sy-datum to text DD/MM/YYYY.
er_entity-numberunit = text.
write sy-uzeit to text ENVIRONMENT TIME FORMAT.
er_entity-info = text.
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
if ran1 < 25. er_entity-infostate = 'Negative'. endif.
if ran1 > 50. er_entity-infostate = 'Neutral'. endif.
if ran1 > 75. er_entity-infostate = 'Critical'. endif.

er_entity-number = ran4.
er_entity-numberDigits = 2.
er_entity-numberstate = 'Positive'.
if ran2 < 25. er_entity-numberstate = 'Negative'. endif.
if ran2 > 50. er_entity-numberstate = 'Neutral'. endif.
if ran2 > 75. er_entity-numberstate = 'Critical'. endif.
er_entity-subtitle = sy-sysid.
er_entity-statearrow = 'Up'.
if ran3 < 30. er_entity-statearrow = 'Down'. endif.
if ran3 > 60. er_entity-statearrow = 'Neutral'. endif.
er_entity-title = sy-uname.
text = 'in-process'.
if ran5 < 20. text = 'completed'. endif.
if ran5 > 40. text = 'critical'. endif.
if ran5 > 60. text = 'inactive'. endif.
er_entity-icon = |sap-icon://status-{ text }|.
  endmethod.
ENDCLASS.
