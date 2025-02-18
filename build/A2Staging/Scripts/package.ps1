# This script will create the Windows Bootstrapper (Setup.exe) for the CAVE msi installer.

if ( Test-Path "${A2_WIX_PROJECT_DIR}\bin\Debug\AWIPS_II_CAVE.msi" ) {
    Remove-Item -force "${A2_WIX_PROJECT_DIR}\bin\Debug\AWIPS_II_CAVE.msi"
    if ($? -ne $true) { EXIT 1; }
}
if ( Test-Path "${A2_STAGING_DIR}\AWIPS_II_CAVE.msi" ) {
    Remove-Item -force "${A2_STAGING_DIR}\AWIPS_II_CAVE.msi"
    if ($? -ne $true) { EXIT 1; }
}

# Rename the WiX-generated msi installer.
Rename-Item -path "${A2_WIX_PROJECT_DIR}\bin\Debug\AWIPS II CAVE.msi" -newname AWIPS_II_CAVE.msi -force
if ($? -ne $true) { EXIT 1; }

# Relocate the WiX-generated msi installer to a common location.
Move-Item -path "${A2_WIX_PROJECT_DIR}\bin\Debug\AWIPS_II_CAVE.msi" -destination ${A2_STAGING_DIR} -force
if ($? -ne $true) { EXIT 1; }

pushd .

# Use iexpress to create the bootstrapper.
cd ${IEXPRESS_EXE_DIR}
.\iexpress.exe ${A2_STAGING_DIR}\AWIPS_II_CAVE.SED /N | Out-Host
if ($? -ne $true) { EXIT 1; }

if ("${AWIPS2_BUILD_ARCHITECTURE}" -eq "x64")
{
    Rename-Item -path "${A2_STAGING_DIR}\AWIPS II CAVE.EXE" -newname "AWIPS II CAVE ${AWIPS2_VERSION} x64.exe"
    if ($? -ne $true) { EXIT 1; }
}
else
{
    Rename-Item -path "${A2_STAGING_DIR}\AWIPS II CAVE.EXE" -newname "AWIPS II CAVE ${AWIPS2_VERSION} x86.exe"
    if ($? -ne $true) { EXIT 1; }
}

# Remove the msi installer now that it has been packaged
Remove-Item -force "${A2_STAGING_DIR}\AWIPS_II_CAVE.msi"
if ($? -ne $true) { EXIT 1; }

popd