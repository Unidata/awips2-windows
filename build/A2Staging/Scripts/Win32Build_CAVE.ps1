function Get-ScriptDirectory
{
    $Invocation = (Get-Variable MyInvocation -Scope 1).Value
    Split-Path $Invocation.MyCommand.Path
}

$environmentScript = Join-Path (Get-ScriptDirectory) environment.ps1

. $environmentScript

# Remove any installer packages that were built previously.
if ( Test-Path "${A2_STAGING_DIR}\AWIPS II CAVE *.exe" ) {
    Remove-Item -force "${A2_STAGING_DIR}\AWIPS II CAVE *.exe"
}

# TODO: Verify that there is a single zip file for
# us to process.

# Get the name of the zip file.
$zipFile = Get-ChildItem ${A2_START_DIR} -filter "*.zip" -name

. ${A2_SCRIPTS_DIR}\prepare.ps1 "$zipFile"
if ($? -ne $true) { EXIT 1; }

. ${A2_SCRIPTS_DIR}\WiXBuild.ps1
if ($? -ne $true) { EXIT 1; }
. ${A2_SCRIPTS_DIR}\package.ps1
if ($? -ne $true) { EXIT 1; }
