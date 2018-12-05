<#	
	===========================================================================
	 Created on:   	2018-12-05 5:07 PM
	 Created by:   	Marc Collins
	 Filename:     	MenuSelect.psm1
	-------------------------------------------------------------------------
	 Module Name: MenuSelect
	===========================================================================
#>

function New-MenuSelect
{
	[CmdletBinding()]
	param
	(
		$Items,
		$DisplayProperty,
		[switch]$AlwaysAsk
	)
	
	$LoopSelection = $true
	
	if (($Items | measure).count -gt 1 -or $AlwaysAsk)
	{
		while ($LoopSelection -eq $true)
		{
			$CountItems = 0
			Write-host "======================================================" -ForegroundColor DarkGreen
			foreach ($Item in $Items)
			{
				Write-Host "$($CountItems)" -NoNewline -ForegroundColor Green
				if ($null -ne $DisplayProperty)
				{
					Write-Host ": $($Item.$($DisplayProperty))"
				}
				else
				{
					Write-Host ": $($Item)"
				}
				$CountItems++
			}
			Write-Host "E" -NoNewline -ForegroundColor Green
			Write-Host ": to Exit"
			$CountItems--
			
			$global:Response = Read-Host "Please Make a Selection (0 - $CountItems)"
			if ($Response -eq "e")
			{
				$LoopSelection = $false
				$Selected = $Null
			}
			
			if ($null -ne ($Response -as [int]))
			{
				if (($Response -as [int]) -le $CountItems)
				{
					$LoopSelection = $false
					$Selected = $Items[$Response]
				}
			}
		}
	}
	else
	{
		$Selected = $Items
	}
	$Selected
}

