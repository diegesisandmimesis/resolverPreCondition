//
// resolverPreCondition.h
//

// Uncomment to enable debugging options.
//#define __DEBUG_RESOLVER_PRE_CONDITION

// Dependency checking.
#include "modularExecuteCommand.h"
#ifndef MODULAR_EXECUTE_COMMAND_H
#error "This module requires the modularExecuteCommand module."
#error "https://github.com/diegesisandmimesis/modularExecuteCommand"
#error "It should be in the same parent directory as this module.  So if"
#error "resolverPreCondition is in /home/user/tads/resolverPreCondition, then"
#error "modularExecuteCommand should be in"
#error "/home/user/tads/modularExecuteCommand ."
#endif // MODULAR_EXECUTE_COMMAND_H

#define RESOLVER_PRE_CONDITION_H
