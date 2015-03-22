project(libbluray)

cmake_minimum_required(VERSION 2.8)
option(DANTEXE "Path to the ant executable" OFF)

MACRO(ADD_MSVC_PRECOMPILED_HEADER PrecompiledHeader SourcesVar)
  #IF(MSVC)
    GET_FILENAME_COMPONENT(PrecompiledBasename ${PrecompiledHeader} NAME_WE)
    SET(PrecompiledBinary "${CMAKE_CURRENT_BINARY_DIR}/${PrecompiledBasename}.pch")
    SET(Sources ${${SourcesVar}})

    SET_SOURCE_FILES_PROPERTIES(${PrecompiledHeader}
                                PROPERTIES COMPILE_FLAGS "/Yc\"${PrecompiledHeader}\" /Fp\"${PrecompiledBinary}\""
                                           OBJECT_OUTPUTS "${PrecompiledBinary}")
    SET_SOURCE_FILES_PROPERTIES(${Sources}
                                PROPERTIES COMPILE_FLAGS "/Yc\"${PrecompiledHeader}\" /FI\"${PrecompiledHeader}\" /Fp\"${PrecompiledBinary}\""
                                           OBJECT_DEPENDS "${PrecompiledBinary}")  
    # Add precompiled header to SourcesVar
    LIST(APPEND ${SourcesVar} ${PrecompiledHeader})
  #ENDIF(MSVC)
ENDMACRO(ADD_MSVC_PRECOMPILED_HEADER)

get_filename_component(PROJECT_SOURCE_DIR "../src" ABSOLUTE)
get_filename_component(EXAMPLES_SOURCE_DIR "../src/examples" ABSOLUTE)
get_filename_component(BASEPATH "../" ABSOLUTE)
message("${PROJECT_SOURCE_DIR}")
message("${BASEPATH}")

include_directories(
${CMAKE_CURRENT_SOURCE_DIR}
${PROJECT_SOURCE_DIR}
${BASEPATH}
${PROJECT_SOURCE_DIR}/libbluray
)

INCLUDE (CheckIncludeFiles)
INCLUDE (CheckSymbolExists)
#CHECK_SYMBOL_EXISTS (DIR dirent.h HAVE_DIRENT_H)
#CHECK_INCLUDE_FILES (dlfcn.h HAVE_DLFCN_H)
#CHECK_INCLUDE_FILES (mntent.h HAVE_MNTENT_H)
#CHECK_INCLUDE_FILES (pthread.h HAVE_PTHREAD_H)
#CHECK_INCLUDE_FILES (strings.h HAVE_STRINGS_H)


set(SRCS    ${CMAKE_CURRENT_SOURCE_DIR}/headers_fixup.h
            ${CMAKE_CURRENT_SOURCE_DIR}/config.h
			${CMAKE_CURRENT_SOURCE_DIR}/bluray-version.h
			${CMAKE_CURRENT_SOURCE_DIR}/libbluray.def
            ${PROJECT_SOURCE_DIR}/file/dirs.h
            ${PROJECT_SOURCE_DIR}/file/dirs_win32.c
            ${PROJECT_SOURCE_DIR}/file/dir_win32.c
            ${PROJECT_SOURCE_DIR}/file/dl.h
            ${PROJECT_SOURCE_DIR}/file/dl_win32.c
            ${PROJECT_SOURCE_DIR}/file/file.c
            ${PROJECT_SOURCE_DIR}/file/file.h
            ${PROJECT_SOURCE_DIR}/file/filesystem.c
            ${PROJECT_SOURCE_DIR}/file/filesystem.h
            ${PROJECT_SOURCE_DIR}/file/file_win32.c
            ${PROJECT_SOURCE_DIR}/file/mount.c
            ${PROJECT_SOURCE_DIR}/file/mount.h
            ${PROJECT_SOURCE_DIR}/libbluray/bluray.c
            ${PROJECT_SOURCE_DIR}/libbluray/bluray.h
            ${PROJECT_SOURCE_DIR}/libbluray/bluray_internal.h
            ${PROJECT_SOURCE_DIR}/libbluray/keys.h
            ${PROJECT_SOURCE_DIR}/libbluray/player_settings.h
            ${PROJECT_SOURCE_DIR}/libbluray/register.c
            ${PROJECT_SOURCE_DIR}/libbluray/register.h
            ${PROJECT_SOURCE_DIR}/libbluray/bdnav/bdid_parse.c
            ${PROJECT_SOURCE_DIR}/libbluray/bdnav/bdid_parse.h
            ${PROJECT_SOURCE_DIR}/libbluray/bdnav/bdparse.h
            ${PROJECT_SOURCE_DIR}/libbluray/bdnav/clpi_data.h
            ${PROJECT_SOURCE_DIR}/libbluray/bdnav/clpi_parse.c
            ${PROJECT_SOURCE_DIR}/libbluray/bdnav/clpi_parse.h
            ${PROJECT_SOURCE_DIR}/libbluray/bdnav/extdata_parse.c
            ${PROJECT_SOURCE_DIR}/libbluray/bdnav/extdata_parse.h
            ${PROJECT_SOURCE_DIR}/libbluray/bdnav/index_parse.c
            ${PROJECT_SOURCE_DIR}/libbluray/bdnav/index_parse.h
            ${PROJECT_SOURCE_DIR}/libbluray/bdnav/meta_data.h
            ${PROJECT_SOURCE_DIR}/libbluray/bdnav/meta_parse.c
            ${PROJECT_SOURCE_DIR}/libbluray/bdnav/meta_parse.h
            ${PROJECT_SOURCE_DIR}/libbluray/bdnav/mpls_parse.c
            ${PROJECT_SOURCE_DIR}/libbluray/bdnav/mpls_parse.h
            ${PROJECT_SOURCE_DIR}/libbluray/bdnav/navigation.c
            ${PROJECT_SOURCE_DIR}/libbluray/bdnav/navigation.h
            ${PROJECT_SOURCE_DIR}/libbluray/bdnav/sound_parse.c
            ${PROJECT_SOURCE_DIR}/libbluray/bdnav/sound_parse.h
            ${PROJECT_SOURCE_DIR}/libbluray/bdnav/uo_mask_table.h
            ${PROJECT_SOURCE_DIR}/libbluray/decoders/graphics_controller.c
            ${PROJECT_SOURCE_DIR}/libbluray/decoders/graphics_controller.h
            ${PROJECT_SOURCE_DIR}/libbluray/decoders/graphics_processor.c
            ${PROJECT_SOURCE_DIR}/libbluray/decoders/graphics_processor.h
            ${PROJECT_SOURCE_DIR}/libbluray/decoders/hdmv_pids.h
            ${PROJECT_SOURCE_DIR}/libbluray/decoders/ig.h
            ${PROJECT_SOURCE_DIR}/libbluray/decoders/ig_decode.c
            ${PROJECT_SOURCE_DIR}/libbluray/decoders/ig_decode.h
            ${PROJECT_SOURCE_DIR}/libbluray/decoders/m2ts_demux.c
            ${PROJECT_SOURCE_DIR}/libbluray/decoders/m2ts_demux.h
            ${PROJECT_SOURCE_DIR}/libbluray/decoders/m2ts_filter.c
            ${PROJECT_SOURCE_DIR}/libbluray/decoders/m2ts_filter.h
            ${PROJECT_SOURCE_DIR}/libbluray/decoders/overlay.h
            ${PROJECT_SOURCE_DIR}/libbluray/decoders/pes_buffer.c
            ${PROJECT_SOURCE_DIR}/libbluray/decoders/pes_buffer.h
            ${PROJECT_SOURCE_DIR}/libbluray/decoders/pg.h
            ${PROJECT_SOURCE_DIR}/libbluray/decoders/pg_decode.c
            ${PROJECT_SOURCE_DIR}/libbluray/decoders/pg_decode.h
            ${PROJECT_SOURCE_DIR}/libbluray/decoders/rle.c
            ${PROJECT_SOURCE_DIR}/libbluray/decoders/rle.h
            ${PROJECT_SOURCE_DIR}/libbluray/decoders/textst.h
            ${PROJECT_SOURCE_DIR}/libbluray/decoders/textst_decode.c
            ${PROJECT_SOURCE_DIR}/libbluray/decoders/textst_decode.h
            ${PROJECT_SOURCE_DIR}/libbluray/decoders/textst_render.c
            ${PROJECT_SOURCE_DIR}/libbluray/decoders/textst_render.h
            ${PROJECT_SOURCE_DIR}/libbluray/disc/aacs.c
            ${PROJECT_SOURCE_DIR}/libbluray/disc/aacs.h
            ${PROJECT_SOURCE_DIR}/libbluray/disc/bdplus.c
            ${PROJECT_SOURCE_DIR}/libbluray/disc/bdplus.h
            ${PROJECT_SOURCE_DIR}/libbluray/disc/dec.c
            ${PROJECT_SOURCE_DIR}/libbluray/disc/dec.h
            ${PROJECT_SOURCE_DIR}/libbluray/disc/disc.c
            ${PROJECT_SOURCE_DIR}/libbluray/disc/disc.h
            ${PROJECT_SOURCE_DIR}/libbluray/disc/enc_info.h
            ${PROJECT_SOURCE_DIR}/libbluray/hdmv/hdmv_insn.h
            ${PROJECT_SOURCE_DIR}/libbluray/hdmv/hdmv_vm.c
            ${PROJECT_SOURCE_DIR}/libbluray/hdmv/hdmv_vm.h
            ${PROJECT_SOURCE_DIR}/libbluray/hdmv/mobj_data.h
            ${PROJECT_SOURCE_DIR}/libbluray/hdmv/mobj_parse.c
            ${PROJECT_SOURCE_DIR}/libbluray/hdmv/mobj_parse.h
            ${PROJECT_SOURCE_DIR}/libbluray/hdmv/mobj_print.c
            ${PROJECT_SOURCE_DIR}/libbluray/hdmv/mobj_print.h
            ${PROJECT_SOURCE_DIR}/util/array.c
            ${PROJECT_SOURCE_DIR}/util/array.h
            ${PROJECT_SOURCE_DIR}/util/attributes.h
            ${PROJECT_SOURCE_DIR}/util/bits.c
            ${PROJECT_SOURCE_DIR}/util/bits.h
            ${PROJECT_SOURCE_DIR}/util/event_queue.c
            ${PROJECT_SOURCE_DIR}/util/event_queue.h
            ${PROJECT_SOURCE_DIR}/util/logging.c
            ${PROJECT_SOURCE_DIR}/util/logging.h
            ${PROJECT_SOURCE_DIR}/util/log_control.h
            ${PROJECT_SOURCE_DIR}/util/macro.h
            ${PROJECT_SOURCE_DIR}/util/mutex.c
            ${PROJECT_SOURCE_DIR}/util/mutex.h
            ${PROJECT_SOURCE_DIR}/util/refcnt.c
            ${PROJECT_SOURCE_DIR}/util/refcnt.h
            ${PROJECT_SOURCE_DIR}/util/strutl.c
            ${PROJECT_SOURCE_DIR}/util/strutl.h
            ${PROJECT_SOURCE_DIR}/util/time.c
            ${PROJECT_SOURCE_DIR}/util/time.h
)

set(bdj_SRCS ${PROJECT_SOURCE_DIR}/libbluray/bdj/bdj.c
             ${PROJECT_SOURCE_DIR}/libbluray/bdj/bdj.h
             ${PROJECT_SOURCE_DIR}/libbluray/bdj/bdjo_data.h
             ${PROJECT_SOURCE_DIR}/libbluray/bdj/bdjo_parse.c
             ${PROJECT_SOURCE_DIR}/libbluray/bdj/bdjo_parse.h
             ${PROJECT_SOURCE_DIR}/libbluray/bdj/native/bdjo.c
             ${PROJECT_SOURCE_DIR}/libbluray/bdj/native/bdjo.h
             ${PROJECT_SOURCE_DIR}/libbluray/bdj/native/java_awt_BDFontMetrics.c
             ${PROJECT_SOURCE_DIR}/libbluray/bdj/native/java_awt_BDFontMetrics.h
             ${PROJECT_SOURCE_DIR}/libbluray/bdj/native/java_awt_BDGraphics.c
             ${PROJECT_SOURCE_DIR}/libbluray/bdj/native/java_awt_BDGraphics.h
             ${PROJECT_SOURCE_DIR}/libbluray/bdj/native/org_videolan_Libbluray.c
             ${PROJECT_SOURCE_DIR}/libbluray/bdj/native/org_videolan_Libbluray.h
             ${PROJECT_SOURCE_DIR}/libbluray/bdj/native/org_videolan_Logger.c
             ${PROJECT_SOURCE_DIR}/libbluray/bdj/native/org_videolan_Logger.h
             ${PROJECT_SOURCE_DIR}/libbluray/bdj/native/register_native.c
             ${PROJECT_SOURCE_DIR}/libbluray/bdj/native/register_native.h
             ${PROJECT_SOURCE_DIR}/libbluray/bdj/native/util.c
             ${PROJECT_SOURCE_DIR}/libbluray/bdj/native/util.h
)

add_definitions(-DWIN_32 -DHAVE_CONFIG_H -D_CRT_SECURE_NO_WARNINGS)

# BD-J

find_package(JNI)
if (JNI_FOUND)
  include_directories("${JAVA_INCLUDE_PATH}")
  include_directories("${JAVA_INCLUDE_PATH2}")
  set(HAVE_JNI_H 1)
endif()

find_package(Java COMPONENTS Development)
if (JAVA_FOUND)
  get_filename_component(_JDK_HOME "${Java_JAVA_EXECUTABLE}" PATH)
  get_filename_component(_JDK_HOME "${_JDK_HOME}/.." ABSOLUTE)
  message("JDK_HOME=${_JDK_HOME}")
endif()

if (JNI_FOUND AND JAVA_FOUND)
  set(USING_BDJAVA 1)
 
  ADD_MSVC_PRECOMPILED_HEADER("headers_fixup.h" SRCS)
  ADD_MSVC_PRECOMPILED_HEADER("headers_fixup.h" bdj_SRCS)
  ADD_LIBRARY(libbluray SHARED ${SRCS} ${bdj_SRCS})
  SET_TARGET_PROPERTIES(libbluray PROPERTIES LINK_FLAGS "/DEF:\"libbluray.def\"")
  
include_directories(
 ${CMAKE_CURRENT_SOURCE_DIR}/libs/freetype/include
)
  
  TARGET_LINK_LIBRARIES(libbluray ${CMAKE_CURRENT_SOURCE_DIR}/libs/freetype/freetype.lib)
else()

ADD_MSVC_PRECOMPILED_HEADER("headers_fixup.h" SRCS)
ADD_LIBRARY(libbluray SHARED ${SRCS})
SET_TARGET_PROPERTIES(libbluray PROPERTIES LINK_FLAGS "/DEF:\"libbluray.def\"")

endif()

if (EXISTS ${ANTEXE})
  STRING(REGEX REPLACE "/" "\\\\" ANT_BUILD "${PROJECT_SOURCE_DIR}/libbluray/bdj/build.xml")
  message("ANT command: ${ANTEXE} -f ${ANT_BUILD}")
  add_custom_target (ANT
     COMMENT "compiling libbluray.jar"
     COMMAND "call"
        ${ANTEXE} -f "${ANT_BUILD}"
                  -Ddist="${CMAKE_CURRENT_SOURCE_DIR}/build/Debug"
                  -Dsrc_awt=:java-j2se
                  -Dversion="j2se-0.9.1"
  )
else()
  message("ANT path not set, can't compile libbluray.jar")
endif()

CONFIGURE_FILE(${CMAKE_CURRENT_SOURCE_DIR}/config.h.cm ${CMAKE_CURRENT_SOURCE_DIR}/config.h)