#!/bin/bash

# We need extended glob capabilities.
shopt -s extglob

# Ensure we are in the right folder
pushd $(dirname ${BASH_SOURCE[0]})

# Default to destroying environments over 7 days old.
# If you want to destroy all of them, pass in '-1' as an argument.
DAYS=${1:-7}
TODAY=$(date +%j)
# Remove leading zeroes from the date.
TODAY=${TODAY##+(0)}

# Go through all the environment folders, and terraform destroy, git remove and remove the folder.
for dir in $(find dynamic_environment_* -maxdepth 0 -type d)
do
	# Remove the folder prefix.
	dir_day=${dir##*_}
	# Remove any leading zeroes from the day of year.
	dir_day=${dir_day##+(0)}
	# If over 7 days old.
	if [[ $(( ${TODAY} - ${dir_day})) -gt ${DAYS} ]]
	then
		pushd "${dir}"
		# Destroy the environment.
		terraform destroy -force
		popd
		# Remove from git.
		git rm -rf "${dir}"
		git commit -am "destroyed ${dir}"
		git push
		# Remove left-over backup files.
		rm -rf "${dir}"
	fi
done
