find_package(Caffe)

include_directories(${Caffe_INCLUDE_DIRS})
MESSAGE(STATUS "caffe include directory1:" ${Caffe_INCLUDE_DIRS})
add_definitions(${Caffe_DEFINITIONS})

aux_source_directory(. SOURCE_FILES )

include_directories( ${PROJECT_SOURCE_DIR}/source/Lib )

set( EXECUTABLE_OUTPUT_PATH ${PROJECT_SOURCE_DIR}/bin )


add_executable( TAppEncoder ${SOURCE_FILES} )


link_directories( ${PROJECT_SOURCE_DIR}/lib )


target_link_libraries( TAppEncoder TLibEncoder_static 
                       TLibVideoIO_static 
                       TLibCommon_static TAppCommon_static 
					   libmd5_static 
                       ${Caffe_LIBRARIES} 
                       )
