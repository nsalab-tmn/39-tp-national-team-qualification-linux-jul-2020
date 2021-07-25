 
 #rg create
 1..9 | ForEach-Object -Parallel  {
 
 New-AzResourceGroup -Name "moda-rg-0$_" -Location " North Central US"
 
 }
 
  10..43 | ForEach-Object -Parallel  {
 
 New-AzResourceGroup -Name "moda-rg-$_" -Location " North Central US"
 
 }
 
 #res deploy
  1..9 | ForEach-Object -Parallel  {
 
New-AzResourceGroupDeployment    -Name "moda-deployment-0$_" -ResourceGroupName "moda-rg-0$_"  -TemplateFile "C:\Users\rgass\Desktop\Module\template.json" -TemplateParameterFile "C:\Users\rgass\Desktop\ModuleA\final\parameters.json" 
 }
 
 
  10..43 | ForEach-Object -Parallel  {
 
New-AzResourceGroupDeployment    -Name "moda-deployment-$_" -ResourceGroupName "moda-rg-$_"  -TemplateFile "C:\Users\rgass\Desktop\ModuleA\template.json" -TemplateParameterFile "C:\Users\rgass\Desktop\ModuleA\final\parameters.json"
 
 }
 
 #Role assingment
   1..9 | ForEach-Object -Parallel  {

 New-AzRoleAssignment -SignInName "competitor0$_@nsalab.org" -RoleDefinitionName "Reader" -ResourceGroupName "moda-rg-0$_"
 }
  
   10..42 | ForEach-Object -Parallel  {

 New-AzRoleAssignment -SignInName "competitor$_@nsalab.org" -RoleDefinitionName "Reader" -ResourceGroupName "moda-rg-$_"
 }
  
  
  #Removing role assignment
  
  
   1..9 | ForEach-Object -Parallel  {

 Remove-AzRoleAssignment -SignInName "competitor0$_@nsalab.org" -RoleDefinitionName "Reader" -ResourceGroupName "moda-rg-0$_"
 }
  
   10..42 | ForEach-Object -Parallel  {

 Remove-AzRoleAssignment -SignInName "competitor$_@nsalab.org" -RoleDefinitionName "Reader" -ResourceGroupName "moda-rg-$_"
 }


#Unblock user login

 1..9 | ForEach-Object -Parallel  {

 Set-AzADUser -UserPrincipalName "competitor0$_@nsalab.org" -EnableAccount $true

 }
 
 
  10..42 | ForEach-Object -Parallel  {

 Set-AzADUser -UserPrincipalName "competitor$_@nsalab.org" -EnableAccount $true

 }
 
 #Block user login 
 
  1..9 | ForEach-Object -Parallel  {

 Set-AzADUser -UserPrincipalName "competitor0$_@nsalab.org" -EnableAccount $false
 }
 
 
  10..42 | ForEach-Object -Parallel  {

 Set-AzADUser -UserPrincipalName "competitor$_@nsalab.org" -EnableAccount $false
 }
 
 
 
 #rg remove
  1..9 | ForEach-Object -Parallel  {
 
 Remove-AzResourceGroup -Name "moda-rg-0$_" -force
 
 }
 
  10..43 | ForEach-Object -Parallel  {
 
 Remove-AzResourceGroup -Name "moda-rg-$_" -force
 
}