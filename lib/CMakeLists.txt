# Program Library

add_library(Program SHARED Program.cpp)

target_include_directories(Program PUBLIC
                          "../include/"
#                           "../z3-master/src/api"
                          )

# target_link_directories(Program PUBLIC
#                        "../z3-master/build/"
#                        )

# target_link_libraries(Program
#                      z3
#                      )

# SafetyVerificationPass Library

add_library(SafetyVerificationPass SHARED SafetyVerificationPass.cpp)

target_include_directories(SafetyVerificationPass PUBLIC
                          "../include/"
#                           "../z3-master/src/api/"
                          )

target_link_directories(SafetyVerificationPass PUBLIC
#                        "../z3-master/build/"
                       )

target_link_libraries(SafetyVerificationPass
                     Program
#                      z3
                     )
