$ENV:PATH += ";${MS_BUILD_EXE_DIR}"

Set-Variable -name BUILD_ZIP -value $args[0]

$prepareDirectory = Split-Path ${A2_PREPARE_CAVE_DIR} -leaf
$prepareDirectoryContainer = Split-Path ${A2_PREPARE_CAVE_DIR} -parent
if ( Test-Path ${A2_PREPARE_CAVE_DIR} ) {
    Remove-Item -recurse -force ${A2_PREPARE_CAVE_DIR}
    if ($? -ne $true) { EXIT 1; }
}
New-Item -path $prepareDirectoryContainer `
    -name $prepareDirectory -type directory | Out-Null
if ($? -ne $true) { EXIT 1; }

pushd .
cd ${A2_PREPARE_CAVE_DIR}

# TODO: retrieve Java location from the registry.
$ENV:PATH += ";C:\Program Files\Raytheon\AWIPS II\Java\bin"

jar xvf ${A2_START_DIR}\${BUILD_ZIP}
if ( $? -ne $true ) {
    echo "FATAL: Failed to unzip ${BUILD_ZIP}".
    EXIT 1
}

# Extract CAVE.
jar xvf ${CAVE_ZIP_NAME} | Out-Null
if ($? -ne $true) { EXIT 1; }

# Extract AlertViz.
jar xvf ${ALERTVIZ_ZIP_NAME} | Out-Null
if ($? -ne $true) { EXIT 1; }

# Assemble CAVE.
. ${A2_SCRIPTS_DIR}\assembleCAVE.ps1
if ($? -ne $true) { EXIT 1; }

popd

EXIT 0