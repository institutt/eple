if(("${SWIFT_HOST_VARIANT_SDK}" STREQUAL "${SWIFT_PRIMARY_VARIANT_SDK}") AND
   ("${SWIFT_HOST_VARIANT_ARCH}" STREQUAL "${SWIFT_PRIMARY_VARIANT_ARCH}"))
  if(SWIFT_HOST_VARIANT MATCHES "${SWIFT_DARWIN_VARIANTS}")
    add_swift_unittest(SwiftReflectionTests
      TypeRef.cpp)
    target_include_directories(SwiftReflectionTests BEFORE PRIVATE
      ${SWIFT_SOURCE_DIR}/stdlib/include)
    target_compile_definitions(SwiftReflectionTests PRIVATE
      SWIFT_INLINE_NAMESPACE=__runtime)
    target_link_libraries(SwiftReflectionTests
      PRIVATE
      swiftRemoteInspection${SWIFT_PRIMARY_VARIANT_SUFFIX})
  endif()
endif()
