# Untitled string in Get leases from dnsmasq Schema

```txt
http://schema.nethserver.org/dnsmasq/get-leases.json#/properties/data/items/properties/hostname
```

Hostname provided by the client

| Abstract            | Extensible | Status         | Identifiable            | Custom Properties | Additional Properties | Access Restrictions | Defined In                                                          |
| :------------------ | :--------- | :------------- | :---------------------- | :---------------- | :-------------------- | :------------------ | :------------------------------------------------------------------ |
| Can be instantiated | No         | Unknown status | Unknown identifiability | Forbidden         | Allowed               | none                | [get-leases.json\*](dnsmasq/get-leases.json "open original schema") |

## hostname Type

`string`

## hostname Constraints

**hostname**: the string must be a hostname, according to [RFC 1123, section 2.1](https://tools.ietf.org/html/rfc1123 "check the specification")
