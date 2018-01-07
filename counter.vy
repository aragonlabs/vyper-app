# Everything is in the same file, because Viper has no concept
# of imports (as of yet).
# 
# To track the issue for "imports", see https://github.com/ethereum/vyper/issues/584

###
### INTERFACES / HELPERS
###

# Kernel interface
# See contracts/kernel/IKernel.sol
class Kernel():
    # Checks whether `entity` has the role `role` on `app`.
    def hasPermission(entity: address, app: address, role: bytes32) -> bool: pass

# Authentication helper
# See contracts/apps/App.sol
@internal
@constant
def auth(role: bytes32) -> bool:
    # If no kernel is specified, then we're not being called
    # through an app proxy, so for we'll just allow the transaction to pass
    # for easier testing.
    return not self.kernel or Kernel(self.kernel).hasPermission(msg.sender, self, role)

# Reference to the kernel (see ccontracts/apps/AppStorage.sol)
kernel: public(address)
# The application ID this app represents logic for (see ccontracts/apps/AppStorage.sol)
appId: public(bytes32)

# These methods ensure Solidity ABI compatibility
# Vyper creates different getters/setters (get_kernel, ...), but
# since we created Aragon using Solidity, we need to be backwards compatible
# in this way.
@public
@constant
def kernel() -> address:
    return self.kernel

@public
def appId() -> bytes32:
    return self.appId

###
### APPLICATION LOGIC
###

# The app itself is a simple counter app.
# You can increment a counter, or you can decrement it.
#
# The increment/decrement actions are governed by the ACL.

# Internal counter
value: public(num)

# Increment the internal counter
@public
def increment():
    assert self.auth(sha3("increment"))
    self.value += 1

# Decrement the internal counter
@public
def decrement():
    assert self.auth(sha3("decrement"))
    self.value -= 1
