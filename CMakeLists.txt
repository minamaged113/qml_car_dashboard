cmake_minimum_required(VERSION 3.16)

project(qml_car_dashboard VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.5 REQUIRED COMPONENTS Quick)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(appqml_car_dashboard
    main.cpp
)

qt_add_qml_module(appqml_car_dashboard
    URI qml_car_dashboard
    VERSION 1.0
    QML_FILES
        qml/Main.qml

    # images
    RESOURCES qml/assets/images/engine_temp.png
    RESOURCES qml/assets/images/fuel_icon.png

    # QML files
    QML_FILES qml/components/library/Needle.qml
    QML_FILES qml/components/library/Guage.qml
    QML_FILES qml/components/library/CustomBtn.qml
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appqml_car_dashboard PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appqml_car_dashboard
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appqml_car_dashboard
    PRIVATE Qt6::Quick
)

include(GNUInstallDirs)
install(TARGETS appqml_car_dashboard
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
