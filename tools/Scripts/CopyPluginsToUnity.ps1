$RootDirectory = Join-Path -Path $PSScriptRoot -ChildPath "\..\..\src\SpectatorView.Native"
$MetaFiles = Join-Path -Path $RootDirectory -ChildPath "UnityMetaFiles"

$PluginDirectory = Join-Path -Path $PSScriptRoot -ChildPath "\..\..\src\SpectatorView.Unity\Assets\SpectatorView.Native\Plugins"
$DesktopDirectory = Join-Path -Path $PluginDirectory -ChildPath "x64"
$WSAx86Directory = Join-Path -Path $PluginDirectory -ChildPath "WSA\x86"

New-Item -ItemType Directory -Force -Path $PluginDirectory | Out-Null
New-Item -ItemType Directory -Force -Path $DesktopDirectory | Out-Null
New-Item -ItemType Directory -Force -Path $WSAx86Directory | Out-Null

$OpenCVVersion = "343"

$CompositorDlls = @( "$RootDirectory\x64\Release\SpectatorView.Compositor.dll",
                     "$RootDirectory\x64\Release\SpectatorView.Compositor.pdb",
		     "$RootDirectory\x64\Release\SpectatorView.Compositor.UnityPlugin.dll",
		     "$RootDirectory\x64\Release\SpectatorView.Compositor.UnityPlugin.pdb")

Write-Host "Copying DSLR compositor dlls to $DesktopDirectory"
foreach ($Dll in $CompositorDlls)
{
  if (!(Test-Path $Dll)) {
    Write-Warning "$Dll not found, DSLR Compositor may not work correctly."
  }
  else
  {
    Copy-Item -Force $Dll -Destination $DesktopDirectory
  }
}


$CalibrationDlls = @( "$RootDirectory\x64\Release\SpectatorView.OpenCV.dll",
                      "$RootDirectory\x64\Release\SpectatorView.OpenCV.pdb",
                      "$RootDirectory\x64\Release\opencv_aruco$OpenCVVersion.dll",
                      "$RootDirectory\x64\Release\opencv_calib3d$OpenCVVersion.dll",
                      "$RootDirectory\x64\Release\opencv_core$OpenCVVersion.dll",
                      "$RootDirectory\x64\Release\opencv_features2d$OpenCVVersion.dll",
                      "$RootDirectory\x64\Release\opencv_flann$OpenCVVersion.dll",
                      "$RootDirectory\x64\Release\opencv_imgproc$OpenCVVersion.dll")

Write-Host "Copying DSLR camera calibration dlls to $DesktopDirectory"
foreach ($Dll in $CalibrationDlls)
{
  if (!(Test-Path $Dll)) {
    Write-Warning "$Dll not found, DSLR camera calibration may not work correctly."
  }
  else
  {
    Copy-Item -Force $Dll -Destination $DesktopDirectory
  }
}

$ArUcoDlls = @( "$RootDirectory\Release\SpectatorView.OpenCV.UWP\SpectatorView.OpenCV.dll",
                "$RootDirectory\Release\SpectatorView.OpenCV.UWP\SpectatorView.OpenCV.pdb",
                "$RootDirectory\Release\SpectatorView.OpenCV.UWP\opencv_aruco$OpenCVVersion.dll",
                "$RootDirectory\Release\SpectatorView.OpenCV.UWP\opencv_calib3d$OpenCVVersion.dll",
                "$RootDirectory\Release\SpectatorView.OpenCV.UWP\opencv_core$OpenCVVersion.dll",
                "$RootDirectory\Release\SpectatorView.OpenCV.UWP\opencv_features2d$OpenCVVersion.dll",
                "$RootDirectory\Release\SpectatorView.OpenCV.UWP\opencv_flann$OpenCVVersion.dll",
                "$RootDirectory\Release\SpectatorView.OpenCV.UWP\opencv_imgproc$OpenCVVersion.dll")

Write-Host "Copying ArUco marker detector dlls to $WSAx86Directory"
foreach ($Dll in $ArUcoDlls)
{
  if (!(Test-Path $Dll)) {
    Write-Warning "$Dll not found, ArUco marker detection may not work correctly."
  }
  else
  {
    Copy-Item -Force $Dll -Destination $WSAx86Directory
  }
}

Write-Host "Copying .meta files"
Copy-Item -Force "$MetaFiles\WSA\x86\*.meta" -Destination $WSAx86Directory
Copy-Item -Force "$MetaFiles\x64\*.meta" -Destination $DesktopDirectory