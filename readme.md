### introduce

This contributions implement convolution neural network based loop filter for intra frames to improve the video coding effciency. The CTUs filtered by NN are compared with CTUs filtered by deblocking and SAO, better filtering is selected by RDO(Rate Distortion Optimization ).we integrate NN based loop filter into HM software by  calling caffe's C++ interface.

HM-CNNF source code was tested and worked well on Linux system,but not tested on Windows system, so linux is also highly recommended for you to compile this project! 


### compiling

Before compiling this project, you must implement the compiling of caffe libraries [https://github.com/BVLC/caffe] 
for implement adjustable gradient clipping, you should modify sgd_solver.cpp in your_caffe_root/src/caffe/solvers/, the modified file has been given. compared to original file,  the following codes are added in funciton ClipGradients():

Dtype rate = GetLearningRate();

const Dtype clip_gradients = this->param_.clip_gradients()/rate;

Note that caffe libraries must be compiled by cmake, since we set caffe dependencies by "find_package" in CMakeLists.txt , you must set your own caffe path in the "HM-CNNF/CMakeLists.txt", modify this line "set(Caffe_DIR ../caffe-master)" in the "HM-CNNF/CMakeLists.txt" according to your caffe path. make sure that find_package(Caffe) can get correct caffe include dictionary${Caffe_INCLUDE_DIRS}. if not, you need to add amnully caffe include path in "build/CaffeConfig.cmake".  for example, in my computer that is
set(Caffe_INCLUDE_DIRS "/home/ubuntu/coding/caffe-master/src;/usr/include;/home/ubuntu/coding/caffe-master/build/include;/opt/OpenBLAS/include;/home/ubuntu/coding/caffe-master/include").

if you turn on the "CPU_ONLY" mode when you compiling your caffe, you also must set the 'CPU_ONLY' to 1 in your HM-CNNF code which is defined in the source/Lib/TLibCommon/TypeDef.h. set 'CNNF_SAO_RDO' to 0, you will get reconstructions filtred fully by NN,the default value of CNNF_SAO_RDO is 1 for higher coding effciency.

Compiling commands:
cmake ./ -DCMAKE_BUILD_TYPE=Release
make

//Our CNN model and prototxt files were stored under the folder of bin, we also give the scripts and configurations in the folder of bin and cfg for demonstration.

### Training Process
Noted that we did not give the complete file structure for training part since that would make the directory structure cumbersome.When the content in the file relates to the path, modify it to your own path.


we have posted trained NN model and deploy prototxt files under folder of bin. we also give the scripts and train&solver prototxt for training your own NN model if you are interested.

In our implement, we use the Uncompressed Colour Image Database (UCID),which consists of 1338 natural images, to prepare the training data.
the Official website of UCID was closed a long time ago,if you need this database, contact with me. Of course you can also use other databases.

run file generate_train.sh. The images in UCID are encoded by HEVC using different QPs to generate database's reconstructions 
before running this script,compile HM16.16[https://hevc.hhi.fraunhofer.de/svn/svn_HEVCSoftware/tags/HM-16.16/] source code,then get an executable encoder TAppEncoderStatic. set LoopFilterDisable: 1 and SAO : 0 in encoder_intra_main.cfg.  Note modifying the file path in "generate_train.sh" according your path.

run generate_DataQP.m( by matlab). the reconstructions are divided into 35*35 patches with QP value and store to h5 file for caffe model traing.

run train_net.sh to train caffe network model. also Note modifying the file path.

run ./sequences_test/run_all_ai_encoder.sh to test all HEVC test sequences with four different QPs when you When you compile this project successfully and get an executable encoder TAppEncoder.


