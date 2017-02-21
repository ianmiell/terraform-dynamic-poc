#!/bin/bash
pushd $(dirname ${BASH_SOURCE[0]})

ID="dynamic_environment_${RANDOM}${RANDOM}_$(date +%j)"
mkdir -p ${ID}
pushd ${ID}
cat > main.tf << END
module "dynamicenv" {
  source             = "../modules/dynamicenv"
  test_id            = "${TEST_ID}"
}
END
terraform get
terraform plan
terraform apply
popd

git add ${ID}
git commit -am "${ID} environment added"
git push
popd
