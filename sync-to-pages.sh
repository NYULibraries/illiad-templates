#!/bin/sh -ex
#
# This script syncs legacy illiad-templates pages to illiad-pages repo, assuming both repos are cloned in the same directory
# It should generally reproduce FTP_CMD behavior at https://github.com/NYULibraries/illiad-templates/blob/bacd8e2586b7000241e9804ed85cbc38eae7ad15/docker-compose.yml
# Exception noted for index page below
#


if [ -z "$1" ]
then
  echo "Usage: "
  echo "To sync illiad pages for a given environment (dev or prod)"
  echo " $0 <environment>"
  exit
fi

# get env from argument and check validity
illiad_env=$1
if [[ "$illiad_env" != "dev" && "$illiad_env" != "prod" ]]
then
  echo "Error: Invalid illiad environment \"$illiad_env\""
  exit 1
fi

# get illiad-pages dir from this script's dir
script_basedir=$(dirname $0)
illiad_pages_dir="$script_basedir/../illiad-pages"
if [ ! -d "$illiad_pages_dir" ]; then
  echo "Destination dir \"$illiad_pages_dir\" does not exist; aborting!"
  exit 1
fi

# index page: this was setup to redirect to /illiad in old server, but we're skipping that redirect and using same index.html
cp index-$illiad_env.html $illiad_pages_dir/index.html
# index and error pages in /illiad
cp index-$illiad_env.html $illiad_pages_dir/illiad/index.html
cp error.asp $illiad_pages_dir/illiad/error.asp
# compiled NYU (ZYU) views copied to top-level /illiad pages
cp dist/views/*.html $illiad_pages_dir/illiad/
cp dist/javascripts/illiad.js  $illiad_pages_dir/illiad/javascripts/illiad.js
cp dist/stylesheets/illiad.css $illiad_pages_dir/illiad/stylesheets/illiad.css
# NYU (ZYU) views to their institution
# index and error pages in /illiad/ZYU/
cp index-$illiad_env.html $illiad_pages_dir/illiad/ZYU/index.html
cp error.asp $illiad_pages_dir/illiad/ZYU/error.asp
# compiled NYU (ZYU) views copied to /illiad/ZYU pages
cp dist/views/*.html $illiad_pages_dir/illiad/ZYU/
cp dist/javascripts/illiad.js  $illiad_pages_dir/illiad/ZYU/javascripts/illiad.js
cp dist/stylesheets/illiad.css $illiad_pages_dir/illiad/ZYU/stylesheets/illiad.css
# TNS (ZMU) views copied to their institution 
cp institutions/ZMU/views/*.html $illiad_pages_dir/illiad/ZMU/
cp institutions/ZMU/javascripts/illiad.js $illiad_pages_dir/illiad/ZMU/javascripts/illiad.js
cp institutions/ZMU/stylesheets/illiad.css $illiad_pages_dir/illiad/ZMU/stylesheets/illiad.css
cp institutions/ZMU/images/* $illiad_pages_dir/illiad/ZMU/images/
