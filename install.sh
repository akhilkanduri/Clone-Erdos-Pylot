#!/bin/bash
# Assumes the script is called from PYLOT_HOME directory

sudo apt-get -y update
sudo apt-get install -y git wget python3-pip
pip3 install gdown

###############################################################################
# Get models & code bases we depend on
###############################################################################
mkdir dependencies/models
cd dependencies/models

###### Download object detection models from TensorFlow zoo ######
wget http://download.tensorflow.org/models/object_detection/faster_rcnn_resnet101_coco_2018_01_28.tar.gz
tar -xvf faster_rcnn_resnet101_coco_2018_01_28.tar.gz
rm faster_rcnn_resnet101_coco_2018_01_28.tar.gz
wget http://download.tensorflow.org/models/object_detection/ssd_mobilenet_v1_coco_2018_01_28.tar.gz
tar -xvf ssd_mobilenet_v1_coco_2018_01_28.tar.gz
rm ssd_mobilenet_v1_coco_2018_01_28.tar.gz
wget http://download.tensorflow.org/models/object_detection/ssd_resnet50_v1_fpn_shared_box_predictor_640x640_coco14_sync_2018_07_03.tar.gz
tar -xvf ssd_resnet50_v1_fpn_shared_box_predictor_640x640_coco14_sync_2018_07_03.tar.gz
rm ssd_resnet50_v1_fpn_shared_box_predictor_640x640_coco14_sync_2018_07_03.tar.gz

###### Download the traffic light model ######
wget https://www.dropbox.com/s/fgvvfsjuezbswy2/traffic_light_det_inference_graph.pb

###### Download the DRN segmentation cityscapes models ######
wget https://www.dropbox.com/s/i6v54gng0rao6ff/drn_d_22_cityscapes.pth

###### Download the DASiamRPN object tracker models ######
gdown https://doc-08-6g-docs.googleusercontent.com/docs/securesc/ha0ro937gcuc7l7deffksulhg5h7mbp1/vclpii8js65be25rf8v1dttqkpscs4l8/1555783200000/04094321888119883640/*/1G9GtKpF36-AwjyRXVLH_gHvrfVSCZMa7?e=download --output SiamRPNVOT.model
gdown https://doc-0s-6g-docs.googleusercontent.com/docs/securesc/ha0ro937gcuc7l7deffksulhg5h7mbp1/tomo4jo32befsdhi6qeaapdeep2v18np/1555783200000/04094321888119883640/*/18-LyMHVLhcx6qBWpUJEcPFoay1tSqURI?e=download --output SiamRPNBIG.model
gdown https://doc-0k-6g-docs.googleusercontent.com/docs/securesc/ha0ro937gcuc7l7deffksulhg5h7mbp1/dpfhmlqtdcbn0rfvqhbd0ofcg5aqphps/1555783200000/04094321888119883640/*/1_bIGtHYdAoTMS-hqOPE1j3KU-ON15cVV?e=download --output SiamRPNOTB.model
cd ../

###### Get DeepSORT and SORT tracker models
git clone https://github.com/ICGog/nanonets_object_tracking.git
git clone https://github.com/abewley/sort.git
# Install sort's dependencies.
pip3 install scipy filterpy==1.4.1 numba==0.38.1 scikit-image scikit-learn==0.19.1

###### Download the DaSiamRPN code ######
git clone https://github.com/ICGog/DaSiamRPN.git
pip3 install --user opencv-python

###### Download the DRN segmentation code ######
git clone https://github.com/ICGog/drn.git

###### Download the Carla simulator ######
if [ "$1" != 'challenge' ]; then
    mkdir CARLA_0.9.7
    cd CARLA_0.9.7
    wget http://carla-assets-internal.s3.amazonaws.com/Releases/Linux/CARLA_0.9.7.tar.gz
    tar xvf CARLA_0.9.7.tar.gz
    rm CARLA_0.9.7.tar.gz
    if [ "$1" == 'docker' ]; then
        rm -r CarlaUE4; rm -r HDMaps
    fi
fi
