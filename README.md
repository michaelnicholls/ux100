# ux100

Use ZABAPGITHUB_STANDALONE to import the contents from https://github.com/michaelnicholls/ux100.git

You may need to follow https://docs.abapgit.org/guide-ssl-setup.html#:~:text=Downloading%20The%20Certificate%20File# to handle the SSL certificates

Use Pull to get the contents

Use transaction SCPR20 to activate BC set ZCALCULATOR

Test the services using transaction /IWFND/GW_CLIENT

URI for testing dynamic tile: use /sap/opu/odata/sap/Z_DYNAMIC_TILE_SRV/dataSet('')
URI for testing calculator service: /sap/opu/odata/SAP/ZCALCULATOR_SRV/calculatorSet

(this service also returns the generated formula)

In SE80, select BSP applications and open ZCALCULATOR

Expand Pages with Flow logic and right click index.html to Select Test

Skip past the warning and enter your ABAP credentials

Sample CDS calculator OData URL

/sap/opu/odata/sap/ZCALC_CDS/ZCALC(operand1=10,operand2=20,operator='+')/Set

or

/sap/opu/odata/sap/ZCALC_CDS/ZCALCSet(operand1=10,operand2=20,operator='%2B',x='')

(
to see the complete formula, use /sap/opu/odata/sap/ZCALC_FORMULA_CDS/ZCALC_FORMULASet(operand1=10,operand2=20,operator='%2B',x='')
 
)


With the calculator services, you need to replace the operator with its encoded value:

>for  +, use %2B
 
>for - (ok as is)

>for *, use %2A

>for /, use %2F

>for %, use %25

Adding the parameter &source=CDS to the UI5 app will use the CDS service instead of the Gateway service

Use transaction /ui2/flpcat to create a new technical catalog, suggested name Z_TC_CALCULATOR.

* semantic object: zcalculator
* action: start
* title: Calculator
* type: SAPUi5 Fiori app
* url: /sap/bc/ui5_ui5/sap/zcalculator
* ID: p1

Add a new dynamic tile

* Title: Calculator
* service URL: /sap/opu/odata/sap/Z_DYNAMIC_TILE_SRV/dataSet('') (or some other value in '')
* refresh interval: 120 (or some other value)
* optionally, you can add a parameter: source, with value CDS or Gateway

You may need to create your own catalog as a copy of the contents of Z_TC_CALCULATOR using transaction /ui2/flpcm_cust or /ui2/lflpd_cust

Use PFCG to create/change a role to use your catalog and assign to some users

Launch FLP and use App Finder to add the Calculator tile to a group or page




