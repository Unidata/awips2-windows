# Set AWIPS2_VERSION conditionally.
Set-Variable -name AWIPS2_VERSION -value "1.0.0.0"
if ( "${JENKINS_BUILD_VERSION}" -ne "" ) { Set-Variable -name AWIPS2_VERSION -value ${JENKINS_BUILD_VERSION} }

# Set AWIPS2_BUILD_ARCHITECTURE conditionally.
Set-Variable -name AWIPS2_BUILD_ARCHITECTURE -value "x86"
if ( "${JENKINS_BUILD_ARCHITECTURE}" -ne "" ) { Set-Variable -name AWIPS2_BUILD_ARCHITECTURE -value ${JENKINS_BUILD_ARCHITECTURE} }

# Determine the architecture of the build machine.
Set-Variable -name SystemArch -value ([environment]::GetEnvironmentVariable("PROCESSOR_ARCHITECTURE"))
if (("${SystemArch}" -eq "AMD64") -and ("${AWIPS2_BUILD_ARCHITECTURE}" -eq "x86"))
{
    Set-Variable -name IEXPRESS_EXE_DIR -value "C:\Windows\SysWOW64"
}
else
{
    Set-Variable -name IEXPRESS_EXE_DIR -value "C:\Windows\System32"
}

Set-Variable -name A2_STAGING_DIR -value "C:\A2Staging"

Set-Variable -name A2_SCRIPTS_DIR -value "${A2_STAGING_DIR}\Scripts"
Set-Variable -name A2_START_DIR -value "${A2_STAGING_DIR}\START"
Set-Variable -name A2_PREPARE_CAVE_DIR -value "${A2_STAGING_DIR}\Prepare"
Set-Variable -name A2_AWIPSII_DIR -value "${A2_STAGING_DIR}\AWIPS II"
Set-Variable -name A2_TMP_DIR -value "${A2_STAGING_DIR}\TEMP"

Set-Variable -name WINSCP_EXE_DIR -value "C:\Users\Bryan Kowal\Downloads\winscp435"
Set-Variable -name WIX_EXE_DIR -value "${A2_STAGING_DIR}\wix35-binaries"
Set-Variable -name MS_BUILD_EXE_DIR -value "C:\Windows\Microsoft.NET\Framework\v4.0.30319"

Set-Variable -name A2_WIX_PROJECT_DIR -value "${A2_STAGING_DIR}\VisualStudio\AWIPSII.CAVE\AWIPSII.CAVE"
Set-Variable -name CAVE_ZIP_NAME -value "CAVE-win32.win32.x86.zip"
Set-Variable -name ALERTVIZ_ZIP_NAME -value "AlertViz-win32.win32.x86.zip"
if ("${AWIPS2_BUILD_ARCHITECTURE}" -eq "x64")
{
    Set-Variable -name MS_BUILD_EXE_DIR -value "C:\Windows\Microsoft.NET\Framework64\v4.0.30319"
    Set-Variable -name A2_WIX_PROJECT_DIR -value "${A2_STAGING_DIR}\VisualStudio\AWIPSII.CAVE_amd64\AWIPSII.CAVE"
    Set-Variable -name CAVE_ZIP_NAME -value "CAVE-win32.win32.x86_64.zip"
    Set-Variable -name ALERTVIZ_ZIP_NAME -value "AlertViz-win32.win32.x86_64.zip"
}