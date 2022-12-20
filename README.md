# ux100

Use ZABAPGITHUB_STANDALONE to import the contents
You may need to follow https://docs.abapgit.org/guide-ssl-setup.html#:~:text=Downloading%20The%20Certificate%20File# to handle
certificates

In SEGW, open the project Z_DYNAMIC_TILE
Under Service Maintenance, right click LOCAL_GW and select Maintain

Select the line Z_DYNAMIC_TILE_SRV and use the Add System Alias button

In the view, select New Entries
  
Select service doc identifier Z_DYNAMIC_TILE_SRV_0001, SAP System alias: LOCAL and check Default system
Save and add/create a transport
Go back to the service catalog and select SAP Gateway Client
You should be able to get a loist of entities and test them

To test the dynamic tile, use /sap/opu/odata/sap/Z_DYNAMIC_TILE_SRV/dataSet('')


In SE80, select BSP applications and open ZCALCULATOR

Expand Pages with Flow logic and right click index.html to Select Test

Skip past the warning and enter your ABAP credentials

Sample CDS calculator URL

/sap/opu/odata/sap/ZCALC_CDS/ZCALC(op1=10,op2=20,op='+')/Set

With the calculator services, you need to replace the operator with its encoded value:

>for  +, use %2B
 
>for - (ok as is)

>for *, use %2A

>for /, use %2F

>for %, use %25



