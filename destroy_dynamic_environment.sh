#!/bin/bash
set -x
set -e
shopt -s extglob
DAYS=${1:-7}
TODAY=$(date +%j)
TODAY=${TODAY##+(0)}
for dir in $(find dynamic_environment_* -type d -maxdepth 0)
do
 dir_day=${dir##*_}
 dir_day=${dir_day##+(0)}
    if [[ $(( $TODAY - ${dir_day})) -gt $DAYS ]]
 then
  pushd "${dir}"
  terraform destroy -force
  popd
  git rm -rf "${dir}"
  git commit -am "destroyed ${dir}"
  git push
  rm -rf "${dir}"
 fi
done

