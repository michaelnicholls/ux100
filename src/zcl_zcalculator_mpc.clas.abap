class ZCL_ZCALCULATOR_MPC definition
  public
  inheriting from /IWBEP/CL_MGW_PUSH_ABS_MODEL
  create public .

public section.

  types:
  begin of TS_CALCULATOR,
     OPERAND1 type /IWBEP/SB_ODATA_TY_INT2,
     OPERATOR type C length 1,
     OPERAND2 type /IWBEP/SB_ODATA_TY_INT2,
     RESULT type P length 6 decimals 2,
     FORMULA type C length 20,
     ERROR type C length 30,
     OPS type C length 20,
  end of TS_CALCULATOR .
  types:
TT_CALCULATOR type standard table of TS_CALCULATOR .
  types:
   begin of ts_text_element,
      artifact_name  type c length 40,       " technical name
      artifact_type  type c length 4,
      parent_artifact_name type c length 40, " technical name
      parent_artifact_type type c length 4,
      text_symbol    type textpoolky,
   end of ts_text_element .
  types:
         tt_text_elements type standard table of ts_text_element with key text_symbol .

  constants GC_CALCULATOR type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'calculator' ##NO_TEXT.

  methods LOAD_TEXT_ELEMENTS
  final
    returning
      value(RT_TEXT_ELEMENTS) type TT_TEXT_ELEMENTS
    raising
      /IWBEP/CX_MGW_MED_EXCEPTION .

  methods DEFINE
    redefinition .
  methods GET_LAST_MODIFIED
    redefinition .
protected section.

  methods DEFINE_VOCAB_ANNOTATIONS
    raising
      /IWBEP/CX_MGW_MED_EXCEPTION .
  methods IS_SUBSCRIPTION_ENABLED
    returning
      value(RV_SUBSCRIPTION_ENABLED) type ABAP_BOOL
    raising
      /IWBEP/CX_MGW_MED_EXCEPTION .
private section.

  methods DEFINE_CALCULATOR
    raising
      /IWBEP/CX_MGW_MED_EXCEPTION .
ENDCLASS.



CLASS ZCL_ZCALCULATOR_MPC IMPLEMENTATION.


  method DEFINE.
*&---------------------------------------------------------------------*
*&           Generated code for the MODEL PROVIDER BASE CLASS          &*
*&                                                                     &*
*&  !!!NEVER MODIFY THIS CLASS. IN CASE YOU WANT TO CHANGE THE MODEL   &*
*&        DO THIS IN THE MODEL PROVIDER SUBCLASS!!!                    &*
*&                                                                     &*
*&---------------------------------------------------------------------*

model->set_schema_namespace( 'ZCALCULATOR_SRV' ).


define_calculator( ).
define_vocab_annotations( ).
 IF me->is_subscription_enabled( ) EQ abap_true.
    super->define( ).
  ENDIF.
  endmethod.


  method DEFINE_CALCULATOR.
*&---------------------------------------------------------------------*
*&           Generated code for the MODEL PROVIDER BASE CLASS          &*
*&                                                                     &*
*&  !!!NEVER MODIFY THIS CLASS. IN CASE YOU WANT TO CHANGE THE MODEL   &*
*&        DO THIS IN THE MODEL PROVIDER SUBCLASS!!!                    &*
*&                                                                     &*
*&---------------------------------------------------------------------*


  data:
        lo_annotation     type ref to /iwbep/if_mgw_odata_annotation,                "#EC NEEDED
        lo_entity_type    type ref to /iwbep/if_mgw_odata_entity_typ,                "#EC NEEDED
        lo_complex_type   type ref to /iwbep/if_mgw_odata_cmplx_type,                "#EC NEEDED
        lo_property       type ref to /iwbep/if_mgw_odata_property,                  "#EC NEEDED
        lo_entity_set     type ref to /iwbep/if_mgw_odata_entity_set.                "#EC NEEDED

***********************************************************************************************************************************
*   ENTITY - calculator
***********************************************************************************************************************************

lo_entity_type = model->create_entity_type( iv_entity_type_name = 'calculator' iv_def_entity_set = abap_false ). "#EC NOTEXT


***********************************************************************************************************************************
*Properties
***********************************************************************************************************************************

lo_property = lo_entity_type->create_property( iv_property_name = 'operand1' iv_abap_fieldname = 'OPERAND1' ). "#EC NOTEXT

lo_property->set_is_key( ).

lo_property->set_type_edm_int16( ).


lo_property->set_nullable( abap_false ).

lo_property = lo_entity_type->create_property( iv_property_name = 'operator' iv_abap_fieldname = 'OPERATOR' ). "#EC NOTEXT

lo_property->set_is_key( ).

lo_property->set_type_edm_string( ).
lo_property->set_maxlength( iv_max_length = 1 ). "#EC NOTEXT


lo_property->set_nullable( abap_false ).

lo_property = lo_entity_type->create_property( iv_property_name = 'operand2' iv_abap_fieldname = 'OPERAND2' ). "#EC NOTEXT

lo_property->set_is_key( ).

lo_property->set_type_edm_int16( ).


lo_property->set_nullable( abap_false ).

lo_property = lo_entity_type->create_property( iv_property_name = 'res' iv_abap_fieldname = 'RESULT' ). "#EC NOTEXT


lo_property->set_type_edm_decimal( ).
lo_property->set_precison( iv_precision = 2 ). "#EC NOTEXT
lo_property->set_maxlength( iv_max_length = 10 ). "#EC NOTEXT


lo_property->set_nullable( abap_false ).

lo_property = lo_entity_type->create_property( iv_property_name = 'formula' iv_abap_fieldname = 'FORMULA' ). "#EC NOTEXT


lo_property->set_type_edm_string( ).
lo_property->set_maxlength( iv_max_length = 20 ). "#EC NOTEXT


lo_property->set_nullable( abap_false ).

lo_property = lo_entity_type->create_property( iv_property_name = 'error' iv_abap_fieldname = 'ERROR' ). "#EC NOTEXT


lo_property->set_type_edm_string( ).
lo_property->set_maxlength( iv_max_length = 30 ). "#EC NOTEXT


lo_property->set_nullable( abap_false ).

lo_property = lo_entity_type->create_property( iv_property_name = 'ops' iv_abap_fieldname = 'OPS' ). "#EC NOTEXT


lo_property->set_type_edm_string( ).
lo_property->set_maxlength( iv_max_length = 20 ). "#EC NOTEXT


lo_property->set_nullable( abap_false ).


lo_entity_type->bind_structure( iv_structure_name  = 'ZCL_ZCALCULATOR_MPC=>TS_CALCULATOR' ). "#EC NOTEXT


***********************************************************************************************************************************
*   ENTITY SETS
***********************************************************************************************************************************
lo_entity_set = lo_entity_type->create_entity_set( 'calculatorSet' ). "#EC NOTEXT
  endmethod.


  method DEFINE_VOCAB_ANNOTATIONS.
data: lo_ann_target type ref to /iwbep/if_mgw_vocan_ann_target.   " Vocabulary Annotation Target                     "#EC NEEDED
DATA: lo_annotation TYPE REF TO /iwbep/if_mgw_vocan_annotation.   " Vocabulary Annotation                            "#EC NEEDED
DATA: lo_collection TYPE REF TO /iwbep/if_mgw_vocan_collection.   " Vocabulary Annotation Collection                 "#EC NEEDED
DATA: lo_function   TYPE REF TO /iwbep/if_mgw_vocan_function.     " Vocabulary Annotation Function                   "#EC NEEDED
DATA: lo_fun_param  TYPE REF TO /iwbep/if_mgw_vocan_fun_param.    " Vocabulary Annotation Function Parameter         "#EC NEEDED
DATA: lo_property   TYPE REF TO /iwbep/if_mgw_vocan_property.     " Vocabulary Annotation Property                   "#EC NEEDED
DATA: lo_record     TYPE REF TO /iwbep/if_mgw_vocan_record.       " Vocabulary Annotation Record                     "#EC NEEDED
DATA: lo_simp_value TYPE REF TO /iwbep/if_mgw_vocan_simple_val.   " Vocabulary Annotation Simple Value               "#EC NEEDED
DATA: lo_url        TYPE REF TO /iwbep/if_mgw_vocan_url.          " Vocabulary Annotation URL                        "#EC NEEDED
DATA: lo_label_elem TYPE REF TO /iwbep/if_mgw_vocan_label_elem.   " Vocabulary Annotation Labeled Element            "#EC NEEDED
DATA: lo_reference  TYPE REF TO /iwbep/if_mgw_vocan_reference.    " Vocabulary Annotation Reference


  lo_reference = vocab_anno_model->create_vocabulary_reference( iv_vocab_id = '/IWBEP/VOC_UI'
                                                                iv_vocab_version = '0001').    "#EC NOTEXT
  lo_reference->create_include( iv_namespace = 'com.sap.vocabularies.UI.v1' ).    "#EC NOTEXT
  lo_reference = vocab_anno_model->create_vocabulary_reference( iv_vocab_id = '/IWBEP/VOC_CORE'
                                                                iv_vocab_version = '0001').    "#EC NOTEXT
  lo_reference->create_include( iv_namespace = 'Org.OData.Core.V1' ).    "#EC NOTEXT
  lo_reference = vocab_anno_model->create_vocabulary_reference( iv_vocab_id = '/IWBEP/VOC_VALIDATION'
                                                                iv_vocab_version = '0001').    "#EC NOTEXT
  lo_reference->create_include( iv_namespace = 'Org.OData.Validation.V1' ).    "#EC NOTEXT
  lo_reference = vocab_anno_model->create_vocabulary_reference( iv_vocab_id = '/IWBEP/VOC_COMMUNICATION'
                                                                iv_vocab_version = '0001').    "#EC NOTEXT
  lo_reference->create_include( iv_namespace = 'com.sap.vocabularies.Communication.v1' ).    "#EC NOTEXT
  lo_reference = vocab_anno_model->create_vocabulary_reference( iv_vocab_id = '/IWBEP/VOC_COMMON'
                                                                iv_vocab_version = '0001').    "#EC NOTEXT
  lo_reference->create_include( iv_namespace = 'com.sap.vocabularies.Common.v1' ).    "#EC NOTEXT
  lo_reference = vocab_anno_model->create_vocabulary_reference( iv_vocab_id = '/IWBEP/VOC_AGGREGATION'
                                                                iv_vocab_version = '0001').    "#EC NOTEXT
  lo_reference->create_include( iv_namespace = 'Org.OData.Aggregation.V1' ).    "#EC NOTEXT
  lo_reference = vocab_anno_model->create_vocabulary_reference( iv_vocab_id = '/IWBEP/VOC_UI'
                                                                iv_vocab_version = '0001').    "#EC NOTEXT
  lo_reference->create_include( iv_namespace = 'com.sap.vocabularies.UI.v1' ).    "#EC NOTEXT
  lo_reference = vocab_anno_model->create_vocabulary_reference( iv_vocab_id = '/IWBEP/VOC_COMMON'
                                                                iv_vocab_version = '0001').    "#EC NOTEXT
  lo_reference->create_include( iv_namespace = 'com.sap.vocabularies.Common.v1' ).    "#EC NOTEXT
  lo_reference = vocab_anno_model->create_vocabulary_reference( iv_vocab_id = '/IWBEP/VOC_UI'
                                                                iv_vocab_version = '0001').    "#EC NOTEXT
  lo_reference->create_include( iv_namespace = 'com.sap.vocabularies.UI.v1' ).    "#EC NOTEXT
  lo_reference = vocab_anno_model->create_vocabulary_reference( iv_vocab_id = '/IWBEP/VOC_ANALYTICS'
                                                                iv_vocab_version = '0001').    "#EC NOTEXT
  lo_reference->create_include( iv_namespace = 'com.sap.vocabularies.Analytics.v1' ).    "#EC NOTEXT
  lo_reference = vocab_anno_model->create_vocabulary_reference( iv_vocab_id = '/IWBEP/VOC_AUTHORIZATION'
                                                                iv_vocab_version = '0001').    "#EC NOTEXT
  lo_reference->create_include( iv_namespace = 'Org.OData.Authorization.V1' ).    "#EC NOTEXT
  lo_reference = vocab_anno_model->create_vocabulary_reference( iv_vocab_id = '/IWBEP/VOC_CAPABILITIES'
                                                                iv_vocab_version = '0001').    "#EC NOTEXT
  lo_reference->create_include( iv_namespace = 'Org.OData.Capabilities.V1' ).    "#EC NOTEXT
  lo_reference = vocab_anno_model->create_vocabulary_reference( iv_vocab_id = '/IWBEP/VOC_CODELIST'
                                                                iv_vocab_version = '0001').    "#EC NOTEXT
  lo_reference->create_include( iv_namespace = 'com.sap.vocabularies.CodeList.v1' ).    "#EC NOTEXT
  lo_reference = vocab_anno_model->create_vocabulary_reference( iv_vocab_id = '/IWBEP/VOC_HIERARCHY'
                                                                iv_vocab_version = '0001').    "#EC NOTEXT
  lo_reference->create_include( iv_namespace = 'com.sap.vocabularies.Hierarchy.v1' ).    "#EC NOTEXT
  lo_reference = vocab_anno_model->create_vocabulary_reference( iv_vocab_id = '/IWBEP/VOC_MEASURES'
                                                                iv_vocab_version = '0001').    "#EC NOTEXT
  lo_reference->create_include( iv_namespace = 'Org.OData.Measures.V1' ).    "#EC NOTEXT
  lo_reference = vocab_anno_model->create_vocabulary_reference( iv_vocab_id = '/IWBEP/VOC_PERSONALDATA'
                                                                iv_vocab_version = '0001').    "#EC NOTEXT
  lo_reference->create_include( iv_namespace = 'com.sap.vocabularies.PersonalData.v1' ).    "#EC NOTEXT
  lo_reference = vocab_anno_model->create_vocabulary_reference( iv_vocab_id = '/IWBEP/VOC_SESSION'
                                                                iv_vocab_version = '0001').    "#EC NOTEXT
  lo_reference->create_include( iv_namespace = 'com.sap.vocabularies.Session.v1' ).    "#EC NOTEXT
  lo_reference = vocab_anno_model->create_vocabulary_reference( iv_vocab_id = '/IWBEP/VOC_TIMELINE'
                                                                iv_vocab_version = '0001').    "#EC NOTEXT
  lo_reference->create_include( iv_namespace = 'com.sap.vocabularies.Timeline.v1' ).    "#EC NOTEXT
  lo_reference = vocab_anno_model->create_vocabulary_reference( iv_vocab_id = 'RSODP_CLOUD_DATA_INTEGRATION'
                                                                iv_vocab_version = '0001').    "#EC NOTEXT
  lo_reference->create_include( iv_namespace = 'com.sap.vocabularies.DataIntegration.v1' ).    "#EC NOTEXT


  lo_ann_target = vocab_anno_model->create_annotations_target( 'calculator/operand1' ).    "#EC NOTEXT
  lo_ann_target->set_namespace_qualifier( 'ZCALCULATOR_SRV' ).    "#EC NOTEXT
  lo_annotation = lo_ann_target->create_annotation( iv_term = 'com.sap.vocabularies.Common.v1.Text' ).    "#EC NOTEXT
  lo_simp_value = lo_annotation->create_simple_value( ).
  lo_simp_value->set_string( 'Operand1' ).    "#EC NOTEXT
  lo_ann_target = vocab_anno_model->create_annotations_target( 'calculator/operand2' ).    "#EC NOTEXT
  lo_ann_target->set_namespace_qualifier( 'ZCALCULATOR_SRV' ).    "#EC NOTEXT
  lo_annotation = lo_ann_target->create_annotation( iv_term = 'com.sap.vocabularies.Common.v1.Text' ).    "#EC NOTEXT
  lo_simp_value = lo_annotation->create_simple_value( ).
  lo_simp_value->set_string( 'Operand2' ).    "#EC NOTEXT
  lo_ann_target = vocab_anno_model->create_annotations_target( 'calculator/operator' ).    "#EC NOTEXT
  lo_ann_target->set_namespace_qualifier( 'ZCALCULATOR_SRV' ).    "#EC NOTEXT
  lo_annotation = lo_ann_target->create_annotation( iv_term = 'com.sap.vocabularies.Common.v1.Text' ).    "#EC NOTEXT
  lo_simp_value = lo_annotation->create_simple_value( ).
  lo_simp_value->set_string( '' ).    "#EC NOTEXT
  lo_ann_target = vocab_anno_model->create_annotations_target( 'calculator/res' ).    "#EC NOTEXT
  lo_ann_target->set_namespace_qualifier( 'ZCALCULATOR_SRV' ).    "#EC NOTEXT
  lo_annotation = lo_ann_target->create_annotation( iv_term = 'com.sap.vocabularies.Common.v1.Text' ).    "#EC NOTEXT
  lo_simp_value = lo_annotation->create_simple_value( ).
  lo_simp_value->set_string( 'Result' ).    "#EC NOTEXT
  lo_ann_target = vocab_anno_model->create_annotations_target( 'calculator/ops' ).    "#EC NOTEXT
  lo_ann_target->set_namespace_qualifier( 'ZCALCULATOR_SRV' ).    "#EC NOTEXT
  lo_annotation = lo_ann_target->create_annotation( iv_term = 'com.sap.vocabularies.UI.v1.Hidden' ).    "#EC NOTEXT
  lo_simp_value = lo_annotation->create_simple_value( ).
  lo_simp_value->set_boolean( 'X' ).
  endmethod.


  method GET_LAST_MODIFIED.
*&---------------------------------------------------------------------*
*&           Generated code for the MODEL PROVIDER BASE CLASS          &*
*&                                                                     &*
*&  !!!NEVER MODIFY THIS CLASS. IN CASE YOU WANT TO CHANGE THE MODEL   &*
*&        DO THIS IN THE MODEL PROVIDER SUBCLASS!!!                    &*
*&                                                                     &*
*&---------------------------------------------------------------------*


  CONSTANTS: lc_gen_date_time TYPE timestamp VALUE '20230101003451'.                  "#EC NOTEXT
  rv_last_modified = super->get_last_modified( ).
  IF rv_last_modified LT lc_gen_date_time.
    rv_last_modified = lc_gen_date_time.
  ENDIF.
  endmethod.


  method IS_SUBSCRIPTION_ENABLED.
*&---------------------------------------------------------------------*
*&           Generated code for the MODEL PROVIDER BASE CLASS          &*
*&                                                                     &*
*&  !!!NEVER MODIFY THIS CLASS. IN CASE YOU WANT TO CHANGE THE MODEL   &*
*&        DO THIS IN THE MODEL PROVIDER SUBCLASS!!!                    &*
*&                                                                     &*
*&---------------------------------------------------------------------*

DATA:
     ls_subscription_enabled TYPE abap_bool value abap_false.

     rv_subscription_enabled = ls_subscription_enabled.
  endmethod.


  method LOAD_TEXT_ELEMENTS.
*&---------------------------------------------------------------------*
*&           Generated code for the MODEL PROVIDER BASE CLASS          &*
*&                                                                     &*
*&  !!!NEVER MODIFY THIS CLASS. IN CASE YOU WANT TO CHANGE THE MODEL   &*
*&        DO THIS IN THE MODEL PROVIDER SUBCLASS!!!                    &*
*&                                                                     &*
*&---------------------------------------------------------------------*


DATA:
     ls_text_element TYPE ts_text_element.                                 "#EC NEEDED
  endmethod.
ENDCLASS.
