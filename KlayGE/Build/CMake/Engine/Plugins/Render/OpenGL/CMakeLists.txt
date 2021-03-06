SET(LIB_NAME KlayGE_RenderEngine_OpenGL)

SET(OPENGL_RE_SOURCE_FILES
	${KLAYGE_PROJECT_DIR}/Plugins/Src/Render/OpenGL/OGLFence.cpp
	${KLAYGE_PROJECT_DIR}/Plugins/Src/Render/OpenGL/OGLFrameBuffer.cpp
	${KLAYGE_PROJECT_DIR}/Plugins/Src/Render/OpenGL/OGLGraphicsBuffer.cpp
	${KLAYGE_PROJECT_DIR}/Plugins/Src/Render/OpenGL/OGLMapping.cpp
	${KLAYGE_PROJECT_DIR}/Plugins/Src/Render/OpenGL/OGLQuery.cpp
	${KLAYGE_PROJECT_DIR}/Plugins/Src/Render/OpenGL/OGLRenderEngine.cpp
	${KLAYGE_PROJECT_DIR}/Plugins/Src/Render/OpenGL/OGLRenderFactory.cpp
	${KLAYGE_PROJECT_DIR}/Plugins/Src/Render/OpenGL/OGLRenderLayout.cpp
	${KLAYGE_PROJECT_DIR}/Plugins/Src/Render/OpenGL/OGLRenderStateObject.cpp
	${KLAYGE_PROJECT_DIR}/Plugins/Src/Render/OpenGL/OGLRenderView.cpp
	${KLAYGE_PROJECT_DIR}/Plugins/Src/Render/OpenGL/OGLRenderWindow.cpp
	${KLAYGE_PROJECT_DIR}/Plugins/Src/Render/OpenGL/OGLShaderObject.cpp
	${KLAYGE_PROJECT_DIR}/Plugins/Src/Render/OpenGL/OGLTexture.cpp
	${KLAYGE_PROJECT_DIR}/Plugins/Src/Render/OpenGL/OGLTexture1D.cpp
	${KLAYGE_PROJECT_DIR}/Plugins/Src/Render/OpenGL/OGLTexture2D.cpp
	${KLAYGE_PROJECT_DIR}/Plugins/Src/Render/OpenGL/OGLTexture3D.cpp
	${KLAYGE_PROJECT_DIR}/Plugins/Src/Render/OpenGL/OGLTextureCube.cpp
)

SET(OPENGL_RE_HEADER_FILES
	${KLAYGE_PROJECT_DIR}/Plugins/Include/KlayGE/OpenGL/OGLFence.hpp
	${KLAYGE_PROJECT_DIR}/Plugins/Include/KlayGE/OpenGL/OGLFrameBuffer.hpp
	${KLAYGE_PROJECT_DIR}/Plugins/Include/KlayGE/OpenGL/OGLGraphicsBuffer.hpp
	${KLAYGE_PROJECT_DIR}/Plugins/Include/KlayGE/OpenGL/OGLMapping.hpp
	${KLAYGE_PROJECT_DIR}/Plugins/Include/KlayGE/OpenGL/OGLQuery.hpp
	${KLAYGE_PROJECT_DIR}/Plugins/Include/KlayGE/OpenGL/OGLRenderEngine.hpp
	${KLAYGE_PROJECT_DIR}/Plugins/Include/KlayGE/OpenGL/OGLRenderFactory.hpp
	${KLAYGE_PROJECT_DIR}/Plugins/Include/KlayGE/OpenGL/OGLRenderLayout.hpp
	${KLAYGE_PROJECT_DIR}/Plugins/Include/KlayGE/OpenGL/OGLRenderStateObject.hpp
	${KLAYGE_PROJECT_DIR}/Plugins/Include/KlayGE/OpenGL/OGLRenderView.hpp
	${KLAYGE_PROJECT_DIR}/Plugins/Include/KlayGE/OpenGL/OGLRenderWindow.hpp
	${KLAYGE_PROJECT_DIR}/Plugins/Include/KlayGE/OpenGL/OGLShaderObject.hpp
	${KLAYGE_PROJECT_DIR}/Plugins/Include/KlayGE/OpenGL/OGLTexture.hpp
)

SOURCE_GROUP("Source Files" FILES ${OPENGL_RE_SOURCE_FILES})
SOURCE_GROUP("Header Files" FILES ${OPENGL_RE_HEADER_FILES})

ADD_LIBRARY(${LIB_NAME} SHARED
	${OPENGL_RE_SOURCE_FILES} ${OPENGL_RE_HEADER_FILES}
)

target_include_directories(${LIB_NAME}
	PUBLIC
		$<TARGET_PROPERTY:${KLAYGE_CORELIB_NAME},INTERFACE_INCLUDE_DIRECTORIES>
	PRIVATE
		$<TARGET_PROPERTY:glloader,INTERFACE_INCLUDE_DIRECTORIES>
		${KLAYGE_PROJECT_DIR}/Plugins/Include
)
if(KLAYGE_IS_DEV_PLATFORM)
	target_include_directories(${LIB_NAME}
		PRIVATE
			$<TARGET_PROPERTY:DXBC2GLSLLib,INTERFACE_INCLUDE_DIRECTORIES>
	)
endif()

ADD_DEPENDENCIES(${LIB_NAME} ${KLAYGE_CORELIB_NAME} glloader)
if(KLAYGE_IS_DEV_PLATFORM)
	add_dependencies(${LIB_NAME} DXBC2GLSLLib)
endif()

SET_TARGET_PROPERTIES(${LIB_NAME} PROPERTIES
	ARCHIVE_OUTPUT_DIRECTORY ${KLAYGE_OUTPUT_DIR}
	ARCHIVE_OUTPUT_DIRECTORY_DEBUG ${KLAYGE_OUTPUT_DIR}
	ARCHIVE_OUTPUT_DIRECTORY_RELEASE ${KLAYGE_OUTPUT_DIR}
	ARCHIVE_OUTPUT_DIRECTORY_RELWITHDEBINFO ${KLAYGE_OUTPUT_DIR}
	ARCHIVE_OUTPUT_DIRECTORY_MINSIZEREL ${KLAYGE_OUTPUT_DIR}
	RUNTIME_OUTPUT_DIRECTORY ${KLAYGE_BIN_DIR}/Render
	RUNTIME_OUTPUT_DIRECTORY_DEBUG ${KLAYGE_BIN_DIR}/Render
	RUNTIME_OUTPUT_DIRECTORY_RELEASE ${KLAYGE_BIN_DIR}/Render
	RUNTIME_OUTPUT_DIRECTORY_RELWITHDEBINFO ${KLAYGE_BIN_DIR}/Render
	RUNTIME_OUTPUT_DIRECTORY_MINSIZEREL ${KLAYGE_BIN_DIR}/Render
	LIBRARY_OUTPUT_DIRECTORY ${KLAYGE_BIN_DIR}/Render
	LIBRARY_OUTPUT_DIRECTORY_DEBUG ${KLAYGE_BIN_DIR}/Render
	LIBRARY_OUTPUT_DIRECTORY_RELEASE ${KLAYGE_BIN_DIR}/Render
	LIBRARY_OUTPUT_DIRECTORY_RELWITHDEBINFO ${KLAYGE_BIN_DIR}/Render
	LIBRARY_OUTPUT_DIRECTORY_MINSIZEREL ${KLAYGE_BIN_DIR}/Render
	PROJECT_LABEL ${LIB_NAME}
	DEBUG_POSTFIX ${CMAKE_DEBUG_POSTFIX}
	OUTPUT_NAME ${LIB_NAME}${KLAYGE_OUTPUT_SUFFIX}
	FOLDER "KlayGE/Engine/Plugins/Render"
)

KLAYGE_ADD_PRECOMPILED_HEADER(${LIB_NAME} "${KLAYGE_PROJECT_DIR}/Core/Include/KlayGE/KlayGE.hpp")

if(KLAYGE_IS_DEV_PLATFORM)
	target_link_libraries(${LIB_NAME}
		PRIVATE
			DXBC2GLSLLib
	)
endif()
target_link_libraries(${LIB_NAME}
	PRIVATE
		glloader ${KLAYGE_CORELIB_NAME}
)

ADD_DEPENDENCIES(AllInEngine ${LIB_NAME})
