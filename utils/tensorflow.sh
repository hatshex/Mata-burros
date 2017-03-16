sudo apt update && sudo apt upgrade && sudo apt install -y python-pip python-dev python3-pip
sudo pip install --upgrade pip
export TF_BINARY_URL=https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-0.11.0rc1-cp35-cp35m-linux_x86_64.whl
sudo pip3 install --upgrade $TF_BINARY_URL
