function InstallHDF5() {
    Write-Host "Installing HDF5..."
    Write-Host "ls C:/Program Files/7-zip"
    ls "C:/Program Files/7-zip"
    Start-Process "C:/Program Files/7-zip/7z.exe" -Wait -ArgumentList 'x ./hdf5-1.12.1-Std-win10_64-vs16.zip'
    ls
    cd hdf
    ls
    Write-Host "Installing HDF5-1.12.1..."
    Start-Process -FilePath msiexec.exe -ArgumentList "/quiet /qn /i HDF5-1.12.1-win64.msi" -Wait
    Write-Host "HDF5-1.12.1 installation complete"
	$HDF5_InstallDir = "C:/Program Files/HDF_Group/HDF5/1.12.1"
	Write-Host "ls $HDF5_InstallDir"
	ls $HDF5_InstallDir
	Write-Host "-------------------------------------------"
	$Program_Dir = "C:/Program Files"
	Write-Host "ls $Program_Dir"
	ls $Program_Dir
    ModifyEnvironmentVariable	
}

function ModifyEnvironmentVariable() {
    $varName = "HDF5_DIR"
	$varValue = "C:\Program Files\HDF_Group\HDF5\1.12.1\share\cmake"
    #Write-Host "varName = $varName"
    #Write-Host "varValue = $varValue"
    ModifyMachineEnvironmentVariable $varName $varValue
}

function ModifyMachineEnvironmentVariable( $varName, $varValue ) {
    $target = "Machine"
    [Environment]::SetEnvironmentVariable($varName, $varValue, $target)
}

function DownloadHDF5() {
	Write-Host "Downloading HDF5-1.12.1..."
	$download_url = "https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-1.12/hdf5-1.12.1/bin/windows/"
	$hdf5_filename = "hdf5-1.12.1-Std-win10_64-vs16.zip"
	$hdf5_webfilename = $download_url + $hdf5_filename

	MyDownloadFile( $hdf5_webfilename )
	Write-Host "HDF5-1.12.1 downloading complete"
}

function MyGetFileName( $filePath ) {
	$file_name_complete = [System.IO.Path]::GetFileName("$filePath")
	$file_name_complete
	#Write-Host "fileNameFull :" $file_name_complete	
}

function MyDownloadFile( $fullFilePath ) {
	$my_filename = MyGetFileName("$fullFilePath")
	$my_location = Get-Location
	$my_local_filename = "$my_location" + "/" + $my_filename
	
	$my_client = new-object System.Net.WebClient
	$my_client.DownloadFile( $fullFilePath, $my_local_filename )	
}

function main() {
	DownloadHDF5
    InstallHDF5
}

main
