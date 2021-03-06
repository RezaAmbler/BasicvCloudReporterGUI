#------------------------------------------------------------------------
# Source File Information (DO NOT MODIFY)
# Source ID: 38fe65c7-645b-4317-9546-35071e77c31e
# Source File: Cloud Reports.pff
#------------------------------------------------------------------------
#========================================================================
# Code Generated By: SAPIEN Technologies, Inc., PowerShell Studio 2012 v3.1.29
# Generated On: 4/1/2014 10:31 AM
# Generated By: ndavieau-rambler
# Organization: nil
#========================================================================
#----------------------------------------------
#region Application Functions
#----------------------------------------------

#endregion Application Functions

#----------------------------------------------
# Generated Form Function
#----------------------------------------------
function Call-Cloud_Reports_pff {

	#----------------------------------------------
	#region Import the Assemblies
	#----------------------------------------------
	[void][reflection.assembly]::Load("mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089")
	[void][reflection.assembly]::Load("System.Windows.Forms, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089")
	[void][reflection.assembly]::Load("System.Drawing, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a")
	[void][reflection.assembly]::Load("System, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089")
	[void][reflection.assembly]::Load("System.Data, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089")
	[void][reflection.assembly]::Load("System.Xml, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089")
	[void][reflection.assembly]::Load("System.DirectoryServices, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a")
	[void][reflection.assembly]::Load("System.Core, Version=3.5.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089")
	[void][reflection.assembly]::Load("System.ServiceProcess, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a")
	#endregion Import Assemblies

	#----------------------------------------------
	#region Generated Form Objects
	#----------------------------------------------
	[System.Windows.Forms.Application]::EnableVisualStyles()
	$formCloudUsageReports = New-Object 'System.Windows.Forms.Form'
	$Both = New-Object 'System.Windows.Forms.Button'
	$buttonOpenReportFolder = New-Object 'System.Windows.Forms.Button'
	$dc2Report = New-Object 'System.Windows.Forms.Button'
	$dc1Report = New-Object 'System.Windows.Forms.Button'
	$InitialFormWindowState = New-Object 'System.Windows.Forms.FormWindowState'
	#endregion Generated Form Objects

	#----------------------------------------------
	# User Generated Script
	#----------------------------------------------
	Add-PSSnapin *vmware*
	
	#region Functions
	Function Export-Xlsx {
		[CmdletBinding()]
		Param (
	   	[Parameter(Position=0,Mandatory=$True,ValueFromPipeline=$True)]
	   	[ValidateNotNullOrEmpty()]
	   	$InputData,
	   	[Parameter(Position=1)]
	   	[ValidateScript({
			$ReqExt = [System.IO.Path]::GetExtension($_)
	       	(          $ReqExt -eq ".xls") -or
	       	(          $ReqExt -eq ".xlsx")
	   	})]
	   	$Path = (Join-Path $env:HomeDrive "Export.xlsx"),
	   	[Parameter(Position=2)] $WorksheetName = [System.IO.Path]::GetFileNameWithoutExtension($Path),
	   	[Parameter(Position=3)]
	   	[ValidateSet("xl3DArea","xl3DAreaStacked","xl3DAreaStacked100","xl3DBarClustered",
	   	"xl3DBarStacked","xl3DBarStacked100","xl3DColumn","xl3DColumnClustered",
	   	"xl3DColumnStacked","xl3DColumnStacked100","xl3DLine","xl3DPie",
	   	"xl3DPieExploded","xlArea","xlAreaStacked","xlAreaStacked100",
	   	"xlBarClustered","xlBarOfPie","xlBarStacked","xlBarStacked100",
	   	"xlBubble","xlBubble3DEffect","xlColumnClustered","xlColumnStacked",
	   	"xlColumnStacked100","xlConeBarClustered","xlConeBarStacked","xlConeBarStacked100",
	   	"xlConeCol","xlConeColClustered","xlConeColStacked","xlConeColStacked100",
	   	"xlCylinderBarClustered","xlCylinderBarStacked","xlCylinderBarStacked100","xlCylinderCol",
	   	"xlCylinderColClustered","xlCylinderColStacked","xlCylinderColStacked100","xlDoughnut",
	   	"xlDoughnutExploded","xlLine","xlLineMarkers","xlLineMarkersStacked",
	   	"xlLineMarkersStacked100","xlLineStacked","xlLineStacked100","xlPie",
	   	"xlPieExploded","xlPieOfPie","xlPyramidBarClustered","xlPyramidBarStacked",
	   	"xlPyramidBarStacked100","xlPyramidCol","xlPyramidColClustered","xlPyramidColStacked",
	   	"xlPyramidColStacked100","xlRadar","xlRadarFilled","xlRadarMarkers",
	   	"xlStockHLC","xlStockOHLC","xlStockVHLC","xlStockVOHLC",
	   	"xlSurface","xlSurfaceTopView","xlSurfaceTopViewWireframe","xlSurfaceWireframe",
	   	"xlXYScatter","xlXYScatterLines","xlXYScatterLinesNoMarkers","xlXYScatterSmooth",
	   	"xlXYScatterSmoothNoMarkers")]
	  	[PSObject] $ChartType,
	   	[Parameter(Position=4)] $Title,
	   	[Parameter(Position=5)] [ValidateSet("begin","end")] $SheetPosition = "begin",
	   	[Switch] $ChartOnNewSheet,
	   	[Switch] $AppendWorksheet,
	   	[Switch] $Borders = $True,
	   	[Switch] $HeaderColor = $True,
	   	[Switch] $AutoFit = $True,
	   	[Switch] $AutoFilter = $True,
	   	[Switch] $PassThrough,
	   	[Switch] $Force
		)
		Begin {
	   		Function Convert-NumberToA1 {
	   			Param([parameter(Mandatory=$true)] [int]$number)
	   			$a1Value = $null
	   			While ($number -gt 0) {
					$multiplier = [int][system.math]::Floor(($number / 26))
	       			$charNumber = $number - ($multiplier * 26)
	       			If ($charNumber -eq 0) { $multiplier-- ; $charNumber = 26 }
	       			$a1Value = [char]($charNumber + 96) + $a1Value
	       			$number = $multiplier
	   			}
	   			Return $a1Value
	   		}
	   		$Script:WorkingData = @()
		}
		Process {
	   		$Script:WorkingData += $InputData
		}
		End {
	   		$Props = $Script:WorkingData[0].PSObject.properties | % { $_.Name }
	   		$Rows = $Script:WorkingData.Count+1
	   		$Cols = $Props.Count
	   		$A1Cols = Convert-NumberToA1 $Cols
	   		$Array = New-Object 'object[,]' $Rows,$Cols
	   		$Col = 0
	   		$Props | % {
	   			$Array[0,$Col] = $_.ToString()
	   			$Col++
	   		}
	   		$Row = 1
	   		$Script:WorkingData | % {
	   			$Item = $_
	   			$Col = 0
	   			$Props | % {
	       			If ($Item.($_) -eq $Null) {
	       				$Array[$Row,$Col] = ""
	       			} Else {
	       				$Array[$Row,$Col] = $Item.($_).ToString()
	       			}
	   				$Col++
	   			}
	   			$Row++
	   		}
	   		$xl = New-Object -ComObject Excel.Application
			$xl.DisplayAlerts = $False
	   		$xlFixedFormat = [Microsoft.Office.Interop.Excel.XLFileFormat]::xlWorkbookNormal
	   		If ([System.IO.Path]::GetExtension($Path) -eq '.xlsx') {
	   			If ($xl.Version -lt 12) {
	      			$Path = $Path.Replace(".xlsx",".xls")
	   			} Else {
	       			$xlFixedFormat = [Microsoft.Office.Interop.Excel.XLFileFormat]::xlWorkbookDefault
	   			}
	   		}
	   		If (Test-Path -Path $Path -PathType "Leaf") {
	   			If ($AppendWorkSheet) {
	       			$wb = $xl.Workbooks.Open($Path)
	       			If ($SheetPosition -eq "end") {
	       				$wb.Worksheets.Add([System.Reflection.Missing]::Value,$wb.Sheets.Item($wb.Sheets.Count)) | Out-Null
	       			} Else {
	       				$wb.Worksheets.Add($wb.Worksheets.Item(1)) | Out-Null
	       			}
	   			} Else {
	       			If (!($Force)) {
	       				$Path = $Path.Insert($Path.LastIndexOf(".")," - $(Get-Date -Format "ddMMyyyy-HHmm")")
	   				}
	       		$wb = $xl.Workbooks.Add()
	       		While ($wb.Worksheets.Count -gt 1) { $wb.Worksheets.Item(1).Delete() }
	   			}
	   		} Else {
	   			$wb = $xl.Workbooks.Add()
	   			While ($wb.Worksheets.Count -gt 1) { $wb.Worksheets.Item(1).Delete() }
	   		}
			$ws = $wb.ActiveSheet
	   		Try { $ws.Name = $WorksheetName }
	   		Catch { }
	   		If ($Title) {
	   			$ws.Cells.Item(1,1) = $Title
	   			$TitleRange = $ws.Range("a1","$($A1Cols)2")
	  	 		$TitleRange.Font.Size = 18
	   			$TitleRange.Font.Bold=$True
	   			$TitleRange.Font.Name = "Cambria"
	   			$TitleRange.Font.ThemeFont = 1
	   			$TitleRange.Font.ThemeColor = 4
	   			$TitleRange.Font.ColorIndex = 55
	   			$TitleRange.Font.Color = 8210719
	   			$TitleRange.Merge()
	   			$TitleRange.VerticalAlignment = -4160
	   			$usedRange = $ws.Range("a3","$($A1Cols)$($Rows + 2)")
	   			If ($HeaderColor) {
	      			$ws.Range("a3","$($A1Cols)3").Interior.ColorIndex = 48
	       			$ws.Range("a3","$($A1Cols)3").Font.Bold = $True
	   			}
	   		} Else {
	   			$usedRange = $ws.Range("a1","$($A1Cols)$($Rows)")
	   			If ($HeaderColor) {
	      			$ws.Range("a1","$($A1Cols)1").Interior.ColorIndex = 48
	       			$ws.Range("a1","$($A1Cols)1").Font.Bold = $True
	   			}
			}
	   		$usedRange.Value2 = $Array
	   		If ($Borders) {
	   			$usedRange.Borders.LineStyle = 1
	   			$usedRange.Borders.Weight = 2
	   		}
	   		If ($AutoFilter) { $usedRange.AutoFilter() | Out-Null }
	   		If ($AutoFit) { $ws.UsedRange.EntireColumn.AutoFit() | Out-Null }
	   		If ($ChartType) {
	   			[Microsoft.Office.Interop.Excel.XlChartType]$ChartType = $ChartType
	   			If ($ChartOnNewSheet) {
	       			$wb.Charts.Add().ChartType = $ChartType
	       			$wb.ActiveChart.setSourceData($usedRange)
	       			Try { $wb.ActiveChart.Name = "$($WorksheetName) - Chart" }
	       			Catch { }
	       			$wb.ActiveChart.Move([System.Reflection.Missing]::Value,$wb.Sheets.Item($ws.Name))
	   			} Else {
	       			$ws.Shapes.AddChart($ChartType).Chart.setSourceData($usedRange) | Out-Null
	   			}
	   		}
	   		$wb.SaveAs($Path,$xlFixedFormat)
	   		$wb.Close()
	   		$xl.Quit()
	   		While ([System.Runtime.Interopservices.Marshal]::ReleaseComObject($usedRange)) {}
	   		While ([System.Runtime.Interopservices.Marshal]::ReleaseComObject($ws)) {}
	   		If ($Title) { While ([System.Runtime.Interopservices.Marshal]::ReleaseComObject($TitleRange)) {} }
	   		While ([System.Runtime.Interopservices.Marshal]::ReleaseComObject($wb)) {}
	   		While ([System.Runtime.Interopservices.Marshal]::ReleaseComObject($xl)) {}
	   		[GC]::Collect()
	   		If ($PassThrough) { Return Get-Item $Path }
		}
	}
	
	Function Get-CIMetaData {
		param(
		[parameter(Mandatory=$true,ValueFromPipeline=$true,ValueFromPipelineByPropertyName=$true)]
		[PSObject[]]$CIObject,
		$Key 
		)
		Process { 
			Foreach ($Object in $CIObject) {
				If ($Key) {
				($Object.ExtensionData.GetMetadata()).MetadataEntry | Where {$_.Key -eq $key } | Select @{N="CIObject";E={$Object.Name}}, Key, @{Name="Value"; E={$_.TypedValue.value}}
				} Else {
					#if($Object.ExtensionData.GetMetadata()).MetadataEntry.Domain) {
					($Object.ExtensionData.GetMetadata()).MetadataEntry | Select @{N="CIObject";E={$Object.Name}}, Key, @{Name="Value"; E={$_.TypedValue.value}}, @{N="Domain.Visibility";E={$_.Domain.Visibility}}, @{N="Domain.Value";E={$_.Domain.Value}}
					#}
					#else {
						#    ($Object.ExtensionData.GetMetadata()).MetadataEntry | Select @{N="CIObject";E={$Object.Name}}, Key, @{Name="Value"; E={$_.TypedValue.value}}
						#}
				}
			}
		}
	}
	
	function Get-Report {
		get-orgvdc | %{new-object psobject -Property @{
			'Org' = $_.Org
			'VDC' = $_.Name
			'Max CPU GHz' = [math]::round($_.CpuLimitGhz, 2)
			'Used CPU GHz' = [math]::round($_.CpuUsedGhz, 2)
			'Used Mem GB' = [math]::round($_.MemoryUsedGB, 2)
			'Max Mem GB' = [math]::round($_.memorylimitgb, 2)
			'VDC Enabled' = $_.Enabled
			'vCPU Count' = [math]::round(($_.CpuLimitGhz) / 2.5)
			'Account Type' = (Get-CIMetaData -CIObject ($_.Org) -Key AccountType).Value
			'Running VMs' = ($_ | Get-CIVM | where Status -EQ "PoweredOn").count
			'S-Storage Used GB' = Get-StandardStorage
			'S-Storage Allocated GB' =  [math]::round((($_.ExtensionData.VdcStorageProfiles.VdcStorageProfile.GetCIView() | where name -eq "Standard Storage").Limit) /1024, 2)
			'P-Storage Used GB' = Get-PerformanceStorage
			'P-Storage Allocated GB' = [math]::round((($_.ExtensionData.VdcStorageProfiles.VdcStorageProfile.GetCIView() | where name -eq "Performance Storage").Limit) /1024, 2)}
		}
	}
	
	Function New-Popup {
	    <#
	    .Synopsis
	    Display a Popup Message
	    .Description
	    This command uses the Wscript.Shell PopUp method to display a graphical message
	    box. You can customize its appearance of icons and buttons. By default the user
	    must click a button to dismiss but you can set a timeout value in seconds to
	    automatically dismiss the popup.
	 
	    The command will write the return value of the clicked button to the pipeline:
	      OK     = 1
	      Cancel = 2
	      Abort  = 3
	      Retry  = 4
	      Ignore = 5
	      Yes    = 6
	      No     = 7
	 
	    If no button is clicked, the return value is -1.
	    .Example
	    PS C:\> new-popup -message "The update script has completed" -title "Finished" -time 5
	 
	    This will display a popup message using the default OK button and default
	    Information icon. The popup will automatically dismiss after 5 seconds.
	    .Notes
	    Last Updated: April 8, 2013
	    Version     : 1.0
	 
	    .Inputs
	    None
	    .Outputs
	    integer
	 
	    Null   = -1
	    OK     = 1
	    Cancel = 2
	    Abort  = 3
	    Retry  = 4
	    Ignore = 5
	    Yes    = 6
	    No     = 7
	    #>
	 
	    Param (
	        [Parameter(Position=0,Mandatory=$True,HelpMessage="Enter a message for the popup")]
	        [ValidateNotNullorEmpty()]
	        [string]$Message,
	        [Parameter(Position=1,Mandatory=$True,HelpMessage="Enter a title for the popup")]
	        [ValidateNotNullorEmpty()]
	        [string]$Title,
	        [Parameter(Position=2,HelpMessage="How many seconds to display? Use 0 require a button click.")]
	        [ValidateScript({$_ -ge 0})]
	        [int]$Time=0,
	        [Parameter(Position=3,HelpMessage="Enter a button group")]
	        [ValidateNotNullorEmpty()]
	        [ValidateSet("OK","OKCancel","AbortRetryIgnore","YesNo","YesNoCancel","RetryCancel")]
	        [string]$Buttons="OK",
	        [Parameter(Position=4,HelpMessage="Enter an icon set")]
	        [ValidateNotNullorEmpty()]
	        [ValidateSet("Stop","Question","Exclamation","Information" )]
	        [string]$Icon="Information"
	    )
	 
	    #convert buttons to their integer equivalents
	    Switch ($Buttons) {
	        "OK"               {$ButtonValue = 0}
	        "OKCancel"         {$ButtonValue = 1}
	        "AbortRetryIgnore" {$ButtonValue = 2}
	        "YesNo"            {$ButtonValue = 4}
	        "YesNoCancel"      {$ButtonValue = 3}
	        "RetryCancel"      {$ButtonValue = 5}
	    }
	 
	    #set an integer value for Icon type
	    Switch ($Icon) {
	        "Stop"        {$iconValue = 16}
	        "Question"    {$iconValue = 32}
	        "Exclamation" {$iconValue = 48}
	        "Information" {$iconValue = 64}
	    }
	 
	    #create the COM Object
	    Try {
	        $wshell = New-Object -ComObject Wscript.Shell -ErrorAction Stop
	        #Button and icon type values are added together to create an integer value
	        $wshell.Popup($Message,$Time,$Title,$ButtonValue+$iconValue)
	    }
	    Catch {
	        #You should never really run into an exception in normal usage
	        Write-Warning "Failed to create Wscript.Shell COM object"
	        Write-Warning $_.exception.message
	    }
	}
	
	Function Get-StandardStorage{
	    $vmlist = ($_ | Get-CIVM)
	    $medialist = Get-Media
	    $temlatelist = Get-CIVAppTemplate
	    $sstorage = 0
	    foreach ($vm in $vmlist){
	        if($VM.ExtensionData.StorageProfile.Name -eq "Standard Storage"){
	            $storage = (get-civapp $vm.vapp | get-civm $vm | Get-CIVMHardDisk).capacity
	            foreach ($vhd in $storage){
	                $sstorage = $sstorage + $vhd
	            }
	            $mem = (get-civapp $vm.vapp | get-civm $vm).MemoryMB
	            $sstorage = $sstorage + $mem
	        }
	    }
	    foreach ($media in $medialist){
	        if ($media.extensiondata.vdcstorageprofile.name -eq "Standard Storage"){
	            if ($_ -eq $media.orgvdc){
	                $sstorage = $sstorage + $media.StorageUsedMB
	            }
	        }
	    }
	    $sstoragegb = $sstorage / 1024
	    foreach ($template in $temlatelist){
	        if ($template.OrgVdc.Name -eq $_){
	            $sstoragegb = $sstoragegb + $template.StorageUsedGB
	        }
	    }
	    [math]::round($sstoragegb, 2)
	}
	
	Function Get-PerformanceStorage{
	    $vmlist = ($_ | Get-CIVM)
	    $medialist = Get-Media
	    $pstorage = 0
	    foreach ($vm in $vmlist){
	        if($VM.ExtensionData.StorageProfile.Name -eq "Performance Storage"){
	            $storage = (get-civapp $vm.vapp | get-civm $vm | Get-CIVMHardDisk).capacity
	            foreach ($vhd in $storage){
	                $pstorage = $pstorage + $vhd
	            }
	        $mem = (get-civapp $vm.vapp | get-civm $vm).MemoryMB
	        $pstorage = $pstorage + $mem
	        }
	    }
	    foreach ($media in $medialist){
	        if ($media.extensiondata.vdcstorageprofile.name -eq "Performance Storage"){
	            if ($_ -eq $media.orgvdc){
	                $pstorage = $pstorage + $media.StorageUsedMB
	            }
	        }
	    }
	    $pstoragegb = $pstorage / 1024
	    [math]::round($pstoragegb, 2)
	}
	
	Function Get-CIVMHardDisk{
		Param (
			[Parameter(Mandatory=$True,ValueFromPipeline=$True,ValueFromPipelinebyPropertyName=$True)]
			$CIVM
		)
		Process {
			$AllHDD = $CIVM.ExtensionData.getvirtualhardwaresection().Item | Where { $_.Description -like “Hard Disk”}
			$HDInfo = @()
			Foreach ($HD in $AllHDD) {
				$HD | Add-Member -MemberType NoteProperty -Name “Capacity” -Value $HD.HostResource[0].AnyAttr[0].”#text”
				$HD | Add-Member -MemberType NoteProperty -Name “VMName” -Value $CIVM.Name
				$HDInfo += $HD
			}
			$HDInfo
		}
	}
	#endregion Functions
	
	#region Date and folder configuration
	$date = Get-Date -format "MM-dd-yy"
	$dc1 = "dc1.mycloud.net"
	$dc2 = "dc2.mycloud.net"
	
	
	try{
		#Set folder to user profile\Desktop\vCloudReports
		$folder = $env:userprofile + "\Desktop\vCloudReports"
		
		#Create folder if it does not exist
		if (!(Test-Path $folder)) {
			[void](new-item $folder -itemType directory)
		}
	}
	catch{}
	#endregion Date and folder configuration
	
	$dc1Report_Click={
		try{
			#Connect to dc1.
			$loginsuccess = $null
			Connect-CIServer $dc1 -ErrorAction Stop
			$loginsuccess = "Yes"
		}
		catch{
			New-Popup -Message "There was an error logging in.  Please check your username and password and try again." -Title "Login Failed" -Icon stop
		}
		
		#If login was successfull continue generating report.
		if ($loginsuccess -eq "Yes"){
			Try{
				Get-Report | Select 'Org', 'VDC', 'Running VMs', 'vCPU Count', 'Max CPU GHz', 'Used CPU GHz', 'Max Mem GB', 'Used Mem GB', 'S-Storage Used GB', 'S-Storage Allocated GB', 'P-Storage Used GB', 'P-Storage Allocated GB', 'VDC Enabled', 'Account Type' | Export-Xlsx -path $folder\dc1-Report-$date.xlsx
				Disconnect-CIServer -server $dc1 -Confirm:$false
			
				#Display success message.
				New-Popup -Message "Your dc1 report is ready." -Title "Report Complete" -Icon information
			}
			catch{
				New-Popup -Message "There was an unknown error generating the report." -Title "Report Error" -Icon information
			}
		}
	} #Gereate dc1 Cloud report
	
	$dc2Report_Click={
		try{
			#Connect to dc2.
			$loginsuccess = $null
			Connect-CIServer $dc2 -ErrorAction Stop
			$loginsuccess = "Yes"
		}
		catch{
			New-Popup -Message "There was an error logging in.  Please check your username and password and try again." -Title "Login Failed" -Icon stop
		}
		
		#If login was successfull continue generating report.
		if ($loginsuccess -eq "Yes"){
			Try{
				Get-Report | Select 'Org', 'VDC', 'Running VMs', 'vCPU Count', 'Max CPU GHz', 'Used CPU GHz', 'Max Mem GB', 'Used Mem GB', 'S-Storage Used GB', 'S-Storage Allocated GB', 'P-Storage Used GB', 'P-Storage Allocated GB', 'VDC Enabled', 'Account Type' | Export-Xlsx -path $folder\dc2-Report-$date.xlsx
				Disconnect-CIServer -server $dc2 -Confirm:$false
			
				#Display success message.
				New-Popup -Message "Your dc2 report is ready." -Title "Report Complete" -Icon information
			}
			catch{
				New-Popup -Message "There was an unknown error generating the report." -Title "Report Error" -Icon information
			}
		}
	} #Generate dc2 Cloud report
	
	$Both_Click={
		#Display cloud login order message.
		New-Popup -Message "The first login box is for dc1.`nThe second login box is for dc2." -Title "Cloud Login" -Icon information
			
		try{
			#Connect to dc1.
			$loginsuccess = $null
			Connect-CIServer $dc1 -ErrorAction Stop
			$loginsuccess = "Yes"
		}
		catch{
			New-Popup -Message "There was an error logging in.  Please check your username and password and try again." -Title "Login Failed" -Icon stop
		}
		
		#If login was successfull continue generating report.
		if ($loginsuccess -eq "Yes"){
			Try{
				Get-Report | Select 'Org', 'VDC', 'Running VMs', 'vCPU Count', 'Max CPU GHz', 'Used CPU GHz', 'Max Mem GB', 'Used Mem GB', 'S-Storage Used GB', 'S-Storage Allocated GB', 'P-Storage Used GB', 'P-Storage Allocated GB', 'VDC Enabled', 'Account Type' | Export-Xlsx -path $folder\dc1-Report-$date.xlsx
				Disconnect-CIServer -server $dc1 -Confirm:$false
			}
			catch{
				New-Popup -Message "There was an unknown error generating the dc1 report." -Title "Report Error" -Icon information
			}
		}
			
		try{
			#Connect to dc2.
			$loginsuccess = $null
			Connect-CIServer $dc2 -ErrorAction Stop
			$loginsuccess = "Yes"
		}
		catch{
			New-Popup -Message "There was an error logging in.  Please check your username and password and try again." -Title "Login Failed" -Icon stop
		}
		
		#If login was successfull continue generating report.
		if ($loginsuccess -eq "Yes"){
			Try{
				Get-Report | Select 'Org', 'VDC', 'Running VMs', 'vCPU Count', 'Max CPU GHz', 'Used CPU GHz', 'Max Mem GB', 'Used Mem GB', 'S-Storage Used GB', 'S-Storage Allocated GB', 'P-Storage Used GB', 'P-Storage Allocated GB', 'VDC Enabled', 'Account Type' | Export-Xlsx -path $folder\dc2-Report-$date.xlsx
				Disconnect-CIServer -server $dc2 -Confirm:$false
			}
			catch{
				New-Popup -Message "There was an unknown error generating the dc2 report." -Title "Report Error" -Icon information
			}
		}
			
		#Display Success Message
		New-Popup -Message "Your cloud reports are ready." -Title "Reports Complete" -Icon information
	} #Generate dc1 and dc2 Cloud reports
	
	$buttonOpenReportFolder_Click={
		Try{
			#Open cloud report location in explorer.
			explorer.exe $folder
		}
		Catch{
			New-Popup -Message "There was an error opening this folder.`n  Please make sure that the folder vCloudReports exists on your desktop and try again." -Title "Cannot Find Folder" -Icon stop
		}
	} #Open Cloud report location
	
	# --End User Generated Script--
	#----------------------------------------------
	#region Generated Events
	#----------------------------------------------
	
	$Form_StateCorrection_Load=
	{
		#Correct the initial state of the form to prevent the .Net maximized form issue
		$formCloudUsageReports.WindowState = $InitialFormWindowState
	}
	
	$Form_Cleanup_FormClosed=
	{
		#Remove all event handlers from the controls
		try
		{
			$Both.remove_Click($Both_Click)
			$buttonOpenReportFolder.remove_Click($buttonOpenReportFolder_Click)
			$dc2Report.remove_Click($dc2Report_Click)
			$dc1Report.remove_Click($dc1Report_Click)
			$formCloudUsageReports.remove_Load($Form_StateCorrection_Load)
			$formCloudUsageReports.remove_FormClosed($Form_Cleanup_FormClosed)
		}
		catch [Exception]
		{ }
	}
	#endregion Generated Events

	#----------------------------------------------
	#region Generated Form Code
	#----------------------------------------------
	#
	# formCloudUsageReports
	#
	$formCloudUsageReports.Controls.Add($Both)
	$formCloudUsageReports.Controls.Add($buttonOpenReportFolder)
	$formCloudUsageReports.Controls.Add($dc2Report)
	$formCloudUsageReports.Controls.Add($dc1Report)
	$formCloudUsageReports.ClientSize = '284, 153'
	$formCloudUsageReports.FormBorderStyle = 'FixedDialog'
	$formCloudUsageReports.MaximizeBox = $False
	$formCloudUsageReports.MinimizeBox = $False
	$formCloudUsageReports.Name = "formCloudUsageReports"
	$formCloudUsageReports.StartPosition = 'CenterScreen'
	$formCloudUsageReports.Text = "Cloud Usage Reports"
	#
	# Both
	#
	$Both.Location = '40, 67'
	$Both.Name = "Both"
	$Both.Size = '200, 30'
	$Both.TabIndex = 4
	$Both.Text = "Generate dc1 and dc2 Reports"
	$Both.UseVisualStyleBackColor = $True
	$Both.add_Click($Both_Click)
	#
	# buttonOpenReportFolder
	#
	$buttonOpenReportFolder.Location = '78, 111'
	$buttonOpenReportFolder.Name = "buttonOpenReportFolder"
	$buttonOpenReportFolder.Size = '120, 30'
	$buttonOpenReportFolder.TabIndex = 5
	$buttonOpenReportFolder.Text = "Open Report Folder"
	$buttonOpenReportFolder.UseVisualStyleBackColor = $True
	$buttonOpenReportFolder.add_Click($buttonOpenReportFolder_Click)
	#
	# dc2Report
	#
	$dc2Report.Location = '152, 12'
	$dc2Report.Name = "dc2Report"
	$dc2Report.Size = '120, 40'
	$dc2Report.TabIndex = 1
	$dc2Report.Text = "Generate dc2 Report"
	$dc2Report.UseVisualStyleBackColor = $True
	$dc2Report.add_Click($dc2Report_Click)
	#
	# dc1Report
	#
	$dc1Report.Location = '12, 12'
	$dc1Report.Name = "dc1Report"
	$dc1Report.Size = '120, 40'
	$dc1Report.TabIndex = 0
	$dc1Report.Text = "Generate dc1 Report"
	$dc1Report.UseVisualStyleBackColor = $True
	$dc1Report.add_Click($dc1Report_Click)
	#endregion Generated Form Code

	#----------------------------------------------

	#Save the initial state of the form
	$InitialFormWindowState = $formCloudUsageReports.WindowState
	#Init the OnLoad event to correct the initial state of the form
	$formCloudUsageReports.add_Load($Form_StateCorrection_Load)
	#Clean up the control events
	$formCloudUsageReports.add_FormClosed($Form_Cleanup_FormClosed)
	#Show the Form
	return $formCloudUsageReports.ShowDialog()

} #End Function

#Call the form
Call-Cloud_Reports_pff | Out-Null
