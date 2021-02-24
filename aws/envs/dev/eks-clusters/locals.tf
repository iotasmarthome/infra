locals {
  user_data = <<EOF
#!/bin/bash
set -o xtrace
/etc/eks/bootstrap.sh iota-hass-eks-001

EOF
}
