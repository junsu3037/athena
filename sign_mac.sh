#! /bin/sh
set -e
# Usages: ./sign_mac.sh "Signing Certificate Identity"
# the certificate identity is the signing cert's name in the Keychain Access app.
# Be sure the cert's key is allowed access (e.g. 'Allow all applications to access this item')
echo "Running path fixup script"
python ./fix_app_qt_folder_names.py dist/Athena.app
echo "Signing Athena.app with certificate" ${1}
codesign -vvvv --deep -s "${1}" dist/Athena.app
echo "Assessing signature of Athena.app"
# Test that signing went okay.
# deploy_mac.sh won't build a zip unless this script succeeds.
spctl --assess -vv dist/Athena.app
