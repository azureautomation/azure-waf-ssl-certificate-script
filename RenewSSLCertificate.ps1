#Parameters
$WAFName = "<WAFResourceName>";
$ResourceGroup = "<ResourceGroupName>";
$OldCert = "<OldCertficateName";
$NewCertName = "<NewCertficateName>";
$NewCertPath = "<FullCertficatePath (PFX only)>";
$CertPass = Read-Host -AsSecureString -Prompt:"Insert PFX Password";

#Main
#Get WAF Resource (ApplicationGateway)
$WAF = Get-AzureRmApplicationGateway -Name:$WAFName -ResourceGroupName:$ResourceGroup;
#Get Existing Certificates
$Cert = Get-AzureRmApplicationGatewaySslCertificate -Name:$OldCert -ApplicationGateway:$WAF;
#Remove Certificate
Remove-AzureRmApplicationGatewaySslCertificate -Name:$Cert.Name -ApplicationGateway:$WAF | Out-Null;
#Add New Certificate
Add-AzureRmApplicationGatewaySslCertificate -Name:$NewCertName -CertificateFile:$NewCertPath -Password:$CertPass -ApplicationGateway:$WAF | Out-Null;
#Set WAF Configuration
Set-AzureRmApplicationGateway -ApplicationGateway:$WAF;
