# ux100

Use ZABAPGITHUB_STANDALONE to import the contents from https://github.com/michaelnicholls/ux100.git

You may need to follow https://docs.abapgit.org/guide-ssl-setup.html#:~:text=Downloading%20The%20Certificate%20File# to handle the SSL certificates

In SEGW, open the project Z_DYNAMIC_TILE
Under Service Maintenance, right click LOCAL_GW and select Maintain

Select the line Z_DYNAMIC_TILE_SRV and use the Add System Alias button

In the view, select New Entries

Select service doc identifier Z_DYNAMIC_TILE_SRV_0001, SAP System alias: LOCAL and check Default system

Save and add/create a transport

Go back to the service catalog and select SAP Gateway Client

You should be able to get a list of entity sets and test them

To use the dynamic tile, use /sap/opu/odata/sap/Z_DYNAMIC_TILE_SRV/dataSet('')

In SEGW, open the project ZCALCULATOR

Under Service Maintenance, right click LOCAL_GW and select Maintain

Select the line Z_DYNAMIC_TILE_SRV and use the Add System Alias button

In the view, select New Entries

Select service doc identifier ZCALCULATOR_SRV_0001, SAP System alias: LOCAL and check Default system

Save and add/create a transport

Go back to the service catalog and select SAP Gateway Client

You should be able to get a list of entity sets and test them



In SE80, select BSP applications and open ZCALCULATOR

Expand Pages with Flow logic and right click index.html to Select Test

Skip past the warning and enter your ABAP credentials

Sample CDS calculator OData URL

/sap/opu/odata/sap/ZCALC_CDS/ZCALC(operand1=10,operand2=20,operator='+')/Set

or

/sap/opu/odata/sap/ZCALC_CDS/ZCALCSet(operand1=10,operand2=20,operator='%2B',x='')


With the calculator services, you need to replace the operator with its encoded value:

>for  +, use %2B
 
>for - (ok as is)

>for *, use %2A

>for /, use %2F

>for %, use %25

Adding the parameter &source=CDS to the UI5 app will use the CDS service instead of the Gateway service

You can add the Fiori app to a catalog using /UI2/FLPCM_CUST, create/select a catalog and then use the designer
Suggested target mapping...
semantic object: calculator
action: start
title: Calculator
url: /sap/bc/ui5_ui5/sap/zcalculator
ID: p1

Suggested dynamic tile...
Title: Calculator
semantic object: calculator
action: start
service URL: /sap/opu/odata/sap/Z_DYNAMIC_TILE_SRV/dataSet('') (or some other value in '')
refresh interval: 120 (or some other value)

Use PFCG to create/change a role to use your catalog and assign to some users

Launch FLP and use App Finder to add the Calculator tile to a group or page




