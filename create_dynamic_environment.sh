#!/bin/bash

# Ensure we are in the right folder
pushd $(dirname ${BASH_SOURCE[0]})

# Create a (probably) unique ID by concatenating two random values (RANDOM is a variable inherent to bash), with the day of year as a suffix.
ID="dynamic_environment_${RANDOM}${RANDOM}_$(date +%j)"

# Create the terraform folder.
mkdir -p ${ID}
pushd ${ID}
cat > main.tf << END
module "dynamicenv" {
  source             = "../modules/dynamicenv"
  dynamic_env_id     = "${ID}"
}
END

# Terraform ahoy!
terraform get
terraform plan
terraform apply
popd

# Record the creation in git and push. Assumes keys set up.
git add ${ID}
git commit -am "${ID} environment added"
git push
popd
