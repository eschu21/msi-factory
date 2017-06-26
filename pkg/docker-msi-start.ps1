docker run -t -v c:/pkg:c:/pkg msi-factory powershell "c:\pkg\msi-build.ps1"

## Change permissions on output files
$Acl = Get-Acl "C:\pkg\output"
$Ar = New-Object  system.security.accesscontrol.filesystemaccessrule("Administrator","FullControl","Allow")
$Acl.SetAccessRule($Ar)
Set-Acl "C:\pkg\output" $Acl
