# Untitled string in Configure dnsmasq Schema

```txt
http://schema.nethserver.org/dnsmasq/configure-module.json#/properties/dns-server/properties/addresses/items/properties/domain
```



| Abstract            | Extensible | Status         | Identifiable            | Custom Properties | Additional Properties | Access Restrictions | Defined In                                                                      |
| :------------------ | :--------- | :------------- | :---------------------- | :---------------- | :-------------------- | :------------------ | :------------------------------------------------------------------------------ |
| Can be instantiated | No         | Unknown status | Unknown identifiability | Forbidden         | Allowed               | none                | [configure-module.json\*](dnsmasq/configure-module.json "open original schema") |

## domain Type

`string`

## domain Constraints

**hostname**: the string must be a hostname, according to [RFC 1123, section 2.1](https://tools.ietf.org/html/rfc1123 "check the specification")
