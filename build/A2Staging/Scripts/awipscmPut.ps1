# Add the location of winscp to the path so that we will be able to execute it.
$ENV:PATH += ";${WINSCP_EXE_DIR}"

# Place the installer package on awipscm.
#WinSCP /console /script=${A2_SCRIPTS_DIR}\awipscm-put.txt
WinSCP /console /command "option batch abort" `
    "option confirm off" `
    "open `"awipscm`"" `
    "cd /var/www/html/thinclient/${AWIPS2_BUILD_ARCHITECTURE}/${AWIPS2_VERSION}" `
    "mkdir ${JENKINS_BUILD_DATE}" `
    "cd ${JENKINS_BUILD_DATE}" `
    "put C:\A2Staging\*.exe" `
    "close" `
    "exit"