Begin Try
	Use Master;
	If Exists(Select Name From SysDatabases Where Name = 'INFO_430_Proj_04')
	 Begin 
	  Alter Database [INFO_430_Proj_04] set Single_user With Rollback Immediate;
	  Drop Database INFO_430_Proj_04;
	 End
	Create Database INFO_430_Proj_04;
End Try
Begin Catch
	Print Error_Number();
End Catch
go

Use INFO_430_Proj_04;