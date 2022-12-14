sap.ui.define([                                                                                                                                                                                                                                                
	"sap/ui/core/mvc/Controller"                                                                                                                                                                                                                                  
], function(Controller) {                                                                                                                                                                                                                                      
	"use strict";                                                                                                                                                                                                                                                 
                                                                                                                                                                                                                                                               
	return Controller.extend("p1.controller.View1", {                                                                                                                                                                                                             
		onInit: function() {                                                                                                                                                                                                                                         
                                                                                                                                                                                                                                                               
			var fixed = "/sap/opu/odata/SAP/Z_DYNAMIC_TILE_SRV";                                                                                                                                                                                                        
			var params = "/calculatorSet(operand1=30,operator='%2B',operand2=20)?$format=json";                                                                                                                                                                         
			var oModel = new sap.ui.model.odata.ODataModel(fixed, true);                                                                                                                                                                                                
			var jsonModel = new sap.ui.model.json.JSONModel();                                                                                                                                                                                                          
			oModel.read(params, null, null, true, function(odata, response) {                                                                                                                                                                                           
				jsonModel.setData(odata);                                                                                                                                                                                                                                  
                                                                                                                                                                                                                                                               
			});                                                                                                                                                                                                                                                         
			this.getView().setModel(jsonModel);                                                                                                                                                                                                                         
		},                                                                                                                                                                                                                                                           
		onGo: function(oEvent) {                                                                                                                                                                                                                                     
			var op1 = this.getView().getModel().getProperty('/operand1');                                                                                                                                                                                               
			var op2 = this.getView().getModel().getProperty('/operand2');                                                                                                                                                                                               
			var op = this.getView().getModel().getProperty('/operator');                                                                                                                                                                                                
			                                                                                                                                                                                                                                                            
			var fixed = "/sap/opu/odata/SAP/Z_DYNAMIC_TILE_SRV";                                                                                                                                                                                                        
			var params = "/calculatorSet(operand1="+op1+",operator='"+encodeURIComponent(op)+"',operand2="+op2+")?$format=json";                                                                                                                                        
			var oModel = new sap.ui.model.odata.ODataModel(fixed, true);                                                                                                                                                                                                
			var jsonModel = new sap.ui.model.json.JSONModel();                                                                                                                                                                                                          
			oModel.read(params, null, null, true, function(odata, response) {                                                                                                                                                                                           
				jsonModel.setData(odata);                                                                                                                                                                                                                                  
                                                                                                                                                                                                                                                               
			});                                                                                                                                                                                                                                                         
			this.getView().setModel(jsonModel);                                                                                                                                                                                                                         
		}                                                                                                                                                                                                                                                            
	});                                                                                                                                                                                                                                                           
});                                                                                                                                                                                                                                                            