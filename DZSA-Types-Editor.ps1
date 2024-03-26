if ($psISE)
{
    $scriptPath = Split-Path -Path $psISE.CurrentFile.FullPath        
}
else
{
    $scriptPath = $PSScriptRoot
}
Write-Host "Detected ScriptPath: $scriptPath"

$xmlFilePath 		= Join-Path $scriptPath 'types.xml'
$CountCsvPath 		= Join-Path $scriptPath 'itemTypes.csv'
$LifeTimeCsvPath 	= Join-Path $scriptPath 'itemLifeTime.csv'
$modifierCSV 		= Join-Path $scriptPath 'categoryModifier.csv'
$xml 				= [xml](Get-Content -Path $xmlFilePath)

$csvModifierData     = Import-Csv $modifierCSV
$clothesModifier     = $csvModifierData | Where-Object {$_.category -eq 'clothes'}| Select-Object -ExpandProperty modifier
$containerModifier   = $csvModifierData | Where-Object {$_.category -eq 'containers'} | Select-Object -ExpandProperty modifier
$explosivesModifier  = $csvModifierData | Where-Object {$_.category -eq 'explosives'} | Select-Object -ExpandProperty modifier
$foodModifier        = $csvModifierData | Where-Object {$_.category -eq 'food'} | Select-Object -ExpandProperty modifier
$toolsModifier       = $csvModifierData | Where-Object {$_.category -eq 'tools'} | Select-Object -ExpandProperty modifier
$weaponsModifier     = $csvModifierData | Where-Object {$_.category -eq 'weapons'} | Select-Object -ExpandProperty modifier

Write-Host "Creating backup of original XML..."
Copy-Item -Path $xmlFilePath -Destination "$scriptPath\types_original.xml"

#CLOTHES
Write-Host "-------------------------------------------------------"
Write-Host "Processing Min/Max Count for CLOTHES: $(($xml.types.type | Where-Object {$_.category.name -eq 'clothes'}).Count) Items with modifier $clothesModifier."
Write-Host "-------------------------------------------------------"
Start-Sleep 1
$xml.types.type | Where-Object {$_.category.name -eq "clothes"} | ForEach-Object {
    [int]$oldNominal = $_.nominal
    [int]$oldMinimal = $_.min
    [string]$newNominal = [math]::Round($oldNominal * $clothesModifier)
    [string]$newMinimal = [math]::Round($oldMinimal * $clothesModifier)
    Write-Host "Setting Min/Max for: $($_.Name), Max: $newNominal Min: $newMinimal"
    $_.nominal = $newNominal
    $_.min = $newMinimal
}

#CONTAINERS
Write-Host ""
Write-Host "-------------------------------------------------------"
Write-Host "Processing Min/Max Count for CONTAINERS: $(($xml.types.type | Where-Object {$_.category.name -eq 'containers'}).Count) Items with modifier: $containerModifier."
Write-Host "-------------------------------------------------------"
Start-Sleep 1
$xml.types.type | Where-Object {$_.category.name -eq "containers"} | ForEach-Object {
    [int]$oldNominal = $_.nominal
    [int]$oldMinimal = $_.min
    [string]$newNominal = [math]::Round($oldNominal * $containerModifier)
    [string]$newMinimal = [math]::Round($oldMinimal * $containerModifier)
    Write-Host "Setting Min/Max for: $($_.Name), Max: $newNominal Min: $newMinimal"
    $_.nominal = $newNominal
    $_.min = $newMinimal
}

#EXPLOSIVES
Write-Host ""
Write-Host "-------------------------------------------------------"
Write-Host "Processing Min/Max Count for EXPLOSIVES: $(($xml.types.type | Where-Object {$_.category.name -eq 'explosives'}).Count) Items with modifier: $explosivesModifier."
Write-Host "-------------------------------------------------------"
Start-Sleep 1
$xml.types.type | Where-Object {$_.category.name -eq "explosives"} | ForEach-Object {
    [int]$oldNominal = $_.nominal
    [int]$oldMinimal = $_.min
    [string]$newNominal = [math]::Round($oldNominal * $explosivesModifier)
    [string]$newMinimal = [math]::Round($oldMinimal * $explosivesModifier)
    Write-Host "Setting Min/Max for: $($_.Name), Max: $newNominal Min: $newMinimal"
    $_.nominal = $newNominal
    $_.min = $newMinimal
}

#FOOD
Write-Host ""
Write-Host "-------------------------------------------------------"
Write-Host "Processing Min/Max Count for FOOD: $(($xml.types.type | Where-Object {$_.category.name -eq 'food'}).Count) Items with modifier: $foodModifier."
Write-Host "-------------------------------------------------------"
Start-Sleep 1
$xml.types.type | Where-Object {$_.category.name -eq "food"} | ForEach-Object {
    [int]$oldNominal = $_.nominal
    [int]$oldMinimal = $_.min
    [string]$newNominal = [math]::Round($oldNominal * $foodModifier)
    [string]$newMinimal = [math]::Round($oldMinimal * $foodModifier)
    Write-Host "Setting Min/Max for: $($_.Name), Max: $newNominal Min: $newMinimal"
    $_.nominal = $newNominal
    $_.min = $newMinimal
}

#TOOLS
Write-Host ""
Write-Host "-------------------------------------------------------"
Write-Host "Processing Min/Max Count for TOOLS: $(($xml.types.type | Where-Object {$_.category.name -eq 'tools'}).Count) Items with modifier: $toolsModifier."
Write-Host "-------------------------------------------------------"
Start-Sleep 1
$xml.types.type | Where-Object {$_.category.name -eq "tools"} | ForEach-Object {
    [int]$oldNominal = $_.nominal
    [int]$oldMinimal = $_.min
    [string]$newNominal = [math]::Round($oldNominal * $toolsModifier)
    [string]$newMinimal = [math]::Round($oldMinimal * $toolsModifier)
    Write-Host "Setting Min/Max for: $($_.Name), Max: $newNominal Min: $newMinimal"
    $_.nominal = $newNominal
    $_.min = $newMinimal
}

#WEAPONS
Write-Host ""
Write-Host "-------------------------------------------------------"
Write-Host "Processing Min/Max Count for WEAPONS: $(($xml.types.type | Where-Object {$_.category.name -eq 'weapons'}).Count) Items with modifier: $weaponsModifier."
Write-Host "-------------------------------------------------------"
Start-Sleep 1
$xml.types.type | Where-Object {$_.category.name -eq "weapons"} | ForEach-Object {
    [int]$oldNominal = $_.nominal
    [int]$oldMinimal = $_.min
    [string]$newNominal = [math]::Round($oldNominal * $weaponsModifier)
    [string]$newMinimal = [math]::Round($oldMinimal * $weaponsModifier)
    Write-Host "Setting Min/Max for: $($_.Name), Max: $newNominal Min: $newMinimal"
    $_.nominal = $newNominal
    $_.min = $newMinimal
}

$xml.Save($xmlFilePath)

Write-Host ""
### Item Nominal/Min
$csvData = Import-Csv $CountCsvPath
Write-Host "-------------------------------------------------------"
Write-Host "Processing Min/Max Count for $($csvData.Count) Items..."
Write-Host "-------------------------------------------------------"
Start-Sleep 1
$csvData | ForEach-Object{
    $itemName = $_.ItemKeyName
    $itemNominal = $_.ItemNominal
    $itemMin = $_.ItemMin
    Write-Host "Processing Type: $itemName with Nominal: $itemNominal and Minimal: $itemMin..."

    $node = $xml.types.type | Where-Object {$_.Name -eq $itemName}
    $node.nominal = $itemNominal
    $node.min = $itemMin
}
$xml.Save($xmlFilePath)

Write-Host ""

### Item Lifetimes
$csvData = Import-Csv $LifeTimeCsvPath
Write-Host "-------------------------------------------------------"
Write-Host "Processing LifeTime for $($csvData.Count) Items..."
Write-Host "-------------------------------------------------------"
Start-Sleep 1
$csvData | ForEach-Object{
    $itemName = $_.ItemKeyName
    $itemLifetime = $_.ItemLifetime
    Write-Host "Processing Type: $itemName with LifeTime: $itemLifetime..."

    $node = $xml.types.type | Where-Object {$_.Name -eq $itemName}
    $node.lifetime = $itemLifetime
}
$xml.Save($xmlFilePath)
Write-host ""
$date = Get-Date -Format 'yyyy.MM.dd - HH:mm:ss'
$header = @"
<!--
    Generated with DZSA-Types-Editor v1.1.0 (https://github.com/LunaCB/DZSA-Types-Editor)
    XML Generated at: $date
    Modifiers:
        clothes: $clothesModifier
        containers: $containerModifier
        explosives: $explosivesModifier
        food: $foodModifier
        tools: $toolsModifier
        weapons: $weaponsModifier
-->
"@
$fileContent = Get-Content -Raw $xmlFilePath
$header, $fileContent | Set-Content $xmlFilePath
Write-Host "All done."
Pause
