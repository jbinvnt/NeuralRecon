#!/bin/bash
source /opt/conda/etc/profile.d/conda.sh
conda activate neucon
#FORCE_CUDA=1 pip install --no-cache-dir git+https://github.com/mit-han-lab/torchsparse.git@v1.4.0
pip uninstall -y torchsparse
sed -i "s/\['ninja', '-v'\]/['ninja', '--version']/g" /opt/conda/envs/neucon/lib/python3.7/site-packages/torch/utils/cpp_extension.py
git clone https://github.com/mit-han-lab/torchsparse.git
cd torchsparse
git checkout tags/v1.4.0
export LD_LIBRARY_PATH=/usr/local/cuda-11.0/lib64\
                         ${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
FORCE_CUDA=1 MAX_JOBS=1 python setup.py bdist_wheel
cd ..
python demo.py --cfg ./config/demo.yaml