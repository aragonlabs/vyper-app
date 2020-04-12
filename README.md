> ⚠️  This was an initial experiment in Jan. 2018. **It is NOT representative of building Aragon apps today, and you must use Solidity instead.**

> Vyper doesn't support inheritance, and the `AragonApp` contract exposed by aragonOS includes a large inheritance tree that would need to be re-implemented (and re-audited!) in Vyper for us to support the language.

# Aragon Apps in Vyper

This is a collection of a few Aragon apps written in Vyper.

## Apps

- **Counter**: Pretty much the same as the Solidity example application we did. It's a basic counter you can increment or decrement, where the actions are governed by the ACL.
