### This file is automatically generated by Qt Design Studio.
### Do not change

add_subdirectory(ModbusAssistantUI)
add_subdirectory(ModbusAssistantUIContent)
add_subdirectory(App)

target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE
    ModbusAssistantUIplugin
    ModbusAssistantUIContentplugin)