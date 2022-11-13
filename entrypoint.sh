#!/bin/bash
source /opt/conda/etc/profile.d/conda.sh
conda activate neucon
#FORCE_CUDA=1 pip install --no-cache-dir git+https://github.com/mit-han-lab/torchsparse.git@v1.4.0
python demo.py --cfg ./config/demo.yaml
FORCE_CUDA=1 pip install --no-cache-dir git+https://github.com/mit-han-lab/torchsparse.git@v1.4.0
python demo.py --cfg ./config/demo.yaml
pip uninstall -y torchsparse
pip install --no-cache-dir git+https://github.com/mit-han-lab/torchsparse.git@v1.4.0
python demo.py --cfg ./config/demo.yaml