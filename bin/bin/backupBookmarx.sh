#!/bin/bash


# Settings
host="http://bookmarxism.herokuapp.com"
sign_in_route="/users/sign_in"
target_route="/bookmarks.json"
cookie_dir="/tmp/backupBookmarx_cookie"
email="pascal.huber@resolved.ch"
password="GugusIstNeu77"
backup_dir="${HOME}/cloud/backup/bookmarx/"
backup_file=$(date "+%Y-%B-%d_%H-%M").json


# Get CSRF Token and new Cookie
curlline=`curl ${host}${sign_in_route} --cookie-jar ${cookie_dir} | grep csrf`
csrf_token=`echo $curlline | grep -o -P '(?<=csrf-token\"\ content\=\").*(?=\"\ \/\>)'`
echo $csrf_token
# echo -e "\n\n-------------------------------------------------------\n\n"


# Login in with token and cookie
curl -X POST -v -H "X-CSRF-Token: ${csrf_token}" \
    -H 'Content-Type: application/json' \
    -d '{"user" : {"email": "'${email}'", "password": "'${password}'" }}' \
    --cookie-jar ${cookie_dir} \
    --cookie ${cookie_dir} \
    ${host}${sign_in_route} > /dev/null
# echo -e "\n\n-------------------------------------------------------\n\n"


# Backup content
json=`curl -X GET  -H "X-CSRF-Token: ${csrf_token}" --cookie ${cookie_dir} ${host}${target_route}`
mkdir -p ${backup_dir}
echo "${json}" > "${backup_dir}${backup_file}"
