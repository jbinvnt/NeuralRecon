#!/bin/bash --login
# The --login ensures the bash configuration is loaded,
# enabling Conda.

# Enable strict mode.
set -euo pipefail
# ... Run whatever commands ...

# Temporarily disable strict mode and activate conda:
set +euo pipefail
conda activate neucon

# Re-enable strict mode:
set -euo pipefail

# exec the final command:
exec python demo.py --cfg ./config/demo.yaml
