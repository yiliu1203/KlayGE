SET(LIB_NAME ToolCommon)

SET(SOURCE_FILES
	${KLAYGE_PROJECT_DIR}/Tools/src/Common/ToolCommon.cpp
)

SET(HEADER_FILES
	${KLAYGE_PROJECT_DIR}/Tools/Include/KlayGE/ToolCommon.hpp
)

SOURCE_GROUP("Source Files" FILES ${SOURCE_FILES})
SOURCE_GROUP("Header Files" FILES ${HEADER_FILES})

ADD_LIBRARY(${LIB_NAME} SHARED
	${SOURCE_FILES} ${HEADER_FILES} ${PLAT_CONF_FILES})

target_compile_definitions(${LIB_NAME}
	PRIVATE
		-DKLAYGE_TOOL_SOURCE
)

target_include_directories(${LIB_NAME}
	PUBLIC
		$<TARGET_PROPERTY:${KLAYGE_CORELIB_NAME},INTERFACE_INCLUDE_DIRECTORIES>
		${KLAYGE_PROJECT_DIR}/Tools/Include
)

SET(LIB_OUTPUT_NAME ${LIB_NAME}${KLAYGE_OUTPUT_SUFFIX})

SET_TARGET_PROPERTIES(${LIB_NAME} PROPERTIES
	ARCHIVE_OUTPUT_DIRECTORY ${KLAYGE_TOOLS_LIB_OUTPUT_DIR}
	ARCHIVE_OUTPUT_DIRECTORY_DEBUG ${KLAYGE_TOOLS_LIB_OUTPUT_DIR}
	ARCHIVE_OUTPUT_DIRECTORY_RELEASE ${KLAYGE_TOOLS_LIB_OUTPUT_DIR}
	ARCHIVE_OUTPUT_DIRECTORY_RELWITHDEBINFO ${KLAYGE_TOOLS_LIB_OUTPUT_DIR}
	ARCHIVE_OUTPUT_DIRECTORY_MINSIZEREL ${KLAYGE_TOOLS_LIB_OUTPUT_DIR}
	RUNTIME_OUTPUT_DIRECTORY ${KLAYGE_BIN_DIR}
	RUNTIME_OUTPUT_DIRECTORY_DEBUG ${KLAYGE_BIN_DIR}
	RUNTIME_OUTPUT_DIRECTORY_RELEASE ${KLAYGE_BIN_DIR}
	RUNTIME_OUTPUT_DIRECTORY_RELWITHDEBINFO ${KLAYGE_BIN_DIR}
	RUNTIME_OUTPUT_DIRECTORY_MINSIZEREL ${KLAYGE_BIN_DIR}
	LIBRARY_OUTPUT_DIRECTORY ${KLAYGE_BIN_DIR}
	LIBRARY_OUTPUT_DIRECTORY_DEBUG ${KLAYGE_BIN_DIR}
	LIBRARY_OUTPUT_DIRECTORY_RELEASE ${KLAYGE_BIN_DIR}
	LIBRARY_OUTPUT_DIRECTORY_RELWITHDEBINFO ${KLAYGE_BIN_DIR}
	LIBRARY_OUTPUT_DIRECTORY_MINSIZEREL ${KLAYGE_BIN_DIR}
	PROJECT_LABEL ${LIB_NAME}
	DEBUG_POSTFIX ${CMAKE_DEBUG_POSTFIX}
	OUTPUT_NAME ${LIB_OUTPUT_NAME}
	FOLDER "KlayGE/Tools"
)

KLAYGE_ADD_PRECOMPILED_HEADER(${LIB_NAME} "${KLAYGE_PROJECT_DIR}/Core/Include/KlayGE/KlayGE.hpp")

target_link_libraries(${LIB_NAME}
	PUBLIC
		${KLAYGE_CORELIB_NAME}
)
if(KLAYGE_PLATFORM_LINUX)
	target_link_libraries(${LIB_NAME}
		PUBLIC
			dl pthread)
endif()

ADD_DEPENDENCIES(${LIB_NAME} AllInEngine)
