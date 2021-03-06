for index in 1 2
do
  for line in `cat /home/ubuntu/coding/dataset/set$index.txt`
  do
    for b in 22 27 32 37
    do
    ./TAppEncoderStatic -c ../cfg/encoder_intra_main.cfg -c ../cfg/per-sequence/UCID$index.cfg -i /home/ubuntu/coding/dataset/oriyuv/$line -q $b -b /home/ubuntu/coding/dataset/yuv_bin/Q${b}_$line.bin -o /home/ubuntu/coding/dataset/rec_yuvQ${b}/$line
    done
  done
done

# after compiling HM16.16 source code you can get an executable encoder TAppEncoderStatic. modily encoder_intra_main.cfg according to the dataset type you want to generate. for example, generate the dataset reconstructed by HEVC without deblocking and SAO ,you need to set LoopFilterDisable       : 1 and    SAO       : 0  in encoder_intra_main.cfg
