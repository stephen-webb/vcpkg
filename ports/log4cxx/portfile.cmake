set(VERSION 0.11.0)
vcpkg_download_distfile(ARCHIVE
    URLS "https://archive.apache.org/dist/logging/log4cxx/0.11.0/apache-log4cxx-${VERSION}.tar.gz"
    FILENAME "apache-log4cxx-${VERSION}.tar.gz"
    SHA512 f8aa37c9c094e7a4d6ca92dff13c032f69f1e078c51ea55e284fcb931c13256b08950af3ea6eaf7a12282240f6073e9acab19bfe217f88dbd62a5d2360f3fbdd  
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    OPTIONS
        -DLOG4CXX_INSTALL_PDB=OFF # Installing pdbs failed on debug static. So, disable it and let vcpkg_copy_pdbs() do it
)

vcpkg_install_cmake()

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)

if(VCPKG_LIBRARY_LINKAGE STREQUAL static)
    file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/bin ${CURRENT_PACKAGES_DIR}/debug/bin)
endif()

vcpkg_copy_pdbs()

# Handle copyright
file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)
