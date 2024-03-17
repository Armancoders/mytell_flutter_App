#!/bin/bash
#MIGTAgEAMBMGByqGSM49AgEGCCqGSM49AwEHBHkwdwIBAQQgK+lkn/h40wy9kji/
#uNYXEVcLbTf/HVVk4igE+akAZC+gCgYIKoZIzj0DAQehRANCAASEBheX7G5/EFvF
#1hWrXPCtrRBXEKU0Dg526hf0M5wNyUYBBLSueRzSgyut6zD/NsRE5OSytoLUnmgU
#OJlo9GEa
#ID KEY : 6A72W6Y54Z

#IssuerID: ccc590e8-3e7f-4b98-bd54-db0d528a4b79

#xcrun altool --upload-app --type ios -f ./build/ios/ipa/*.ipa --apiKey 6A72W6Y54Z  --apiIssuer ccc590e8-3e7f-4b98-bd54-db0d528a4b79


APPFILE=$1 set -euo pipefail # key is in /Users/nimaalizadeh/Downloads/AuthKey_6A72W6Y54Z.p8 KEY="\<the key part of the AuthKey\_key.p8 file\>" ISSUER="\ccc590e8-3e7f-4b98-bd54-db0d528a4b79\>" xcrun altool --upload-app --type ios --file $APPFILE --apiKey $KEY --apiIssuer $ISSUER
