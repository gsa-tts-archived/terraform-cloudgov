#!/bin/sh

# Exit if any step fails
set -e

eval "$(jq -r '@sh "GITREF=\(.gitref) ORG=\(.org) REPO=\(.repo) SRC_FOLDER=\(.src_folder)"')"

popdir="$(pwd)"

# Portable construct so this will work everywhere
# https://unix.stackexchange.com/a/84980
tmpdir=$(mktemp -d 2>/dev/null || mktemp -d -t 'mytmpdir')
cd "$tmpdir"

# Grab a copy of the zip file for the specified ref
curl -s -L "https://github.com/${ORG}/${REPO}/archive/${GITREF}.zip" --output local.zip

# Get the folder that curl will download, usually looks like {repo_name}-{branch_name}/
zip_folder=$(unzip -l local.zip | awk '/\/$/ {print $4}' | awk -F'/' '{print $1}' | sort -u)

# Zip up just the {repo_name}-{branch_name}/{src_code_folder}/ subdirectory for pushing
unzip -q -u local.zip "$zip_folder/$SRC_FOLDER/*"
cd "$zip_folder/$SRC_FOLDER/" &&
zip -q -r -o -X "${popdir}/app.zip" ./

# Tell Terraform where to find it
cat << EOF
{ "path": "app.zip" }
EOF
