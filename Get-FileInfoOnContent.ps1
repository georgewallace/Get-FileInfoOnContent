<#
.SYNOPSIS
Get file info based on content .
.DESCRIPTION
This command will files in a directory based on a filter and pattern and return the files that have that pattern.
.PARAMETER Filepath
The path to the files that will be queried.
.PARAMETER Pattern
The pattern to be searched for in the files
.PARAMETER Filter
The filter to filter out file types, i.e (*.md)

.EXAMPLE
PS C:\> Get-FileNameOnContent -filepath C:\users\gwallace\azure-content-pr -pattern application-gateway -filter "*.md" 

Filename   : application-gateway-create-gateway-arm-template.md
LineNumber : 6
Matches    : {application-gateway}
Path       : C:\users\gwallace\azure-content-pr\articles\application-gateway\application-gateway-create-gateway-arm-template.md
Pattern    : application-gateway
IgnoreCase : True

Filename   : application-gateway-create-gateway-arm.md
LineNumber : 5
Matches    : {application-gateway}
Path       : C:\users\gwallace\azure-content-pr\articles\application-gateway\application-gateway-create-gateway-arm.md
Pattern    : application-gateway
IgnoreCase : True

.Notes
Last Updated: August 24, 2016
Version     : 0.1


#>

[cmdletbinding()]
param(
[ValidateNotNullorEmpty()]
[Parameter(Mandatory=$True,Position=1)]
[string]$Filepath,
[Parameter(Mandatory=$True,Position=2)]
[ValidateNotNullorEmpty()]
[array]$Pattern,
[string]$Filter,
[switch]$CaseSensitive
)
$files = Get-ChildItem -Path "$filepath" -Filter $filter -Recurse
if($CaseSensitive)
{
foreach ($file in $files | Select-String -pattern $pattern -List -CaseSensitive) 
{

$obj = new-object psobject
$obj | add-member noteproperty Filename ($file.Filename)
$obj | add-member noteproperty Line ($file.Line)
$obj | add-member noteproperty LineNumber ($file.LineNumber)
$obj | add-member noteproperty Matches ($file.Matches)
$obj | add-member noteproperty Path ($file.Path)
$obj | add-member noteproperty Pattern ($file.Pattern)
$obj | add-member noteproperty IgnoreCase ($file.IgnoreCase)

write-output $obj

}
}
else
{
foreach ($file in $files | Select-String -pattern $pattern -List) 
{

$obj = new-object psobject
$obj | add-member noteproperty Filename ($file.Filename)
$obj | add-member noteproperty Line ($file.Line)
$obj | add-member noteproperty LineNumber ($file.LineNumber)
$obj | add-member noteproperty Matches ($file.Matches)
$obj | add-member noteproperty Path ($file.Path)
$obj | add-member noteproperty Pattern ($file.Pattern)
$obj | add-member noteproperty IgnoreCase ($file.IgnoreCase)

write-output $obj

}



