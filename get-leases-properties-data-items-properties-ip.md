# Untitled string in Get leases from dnsmasq Schema

```txt
http://schema.nethserver.org/dnsmasq/get-leases.json#/properties/data/items/properties/ip
```

IP address assigned to the client

| Abstract            | Extensible | Status         | Identifiable            | Custom Properties | Additional Properties | Access Restrictions | Defined In                                                          |
| :------------------ | :--------- | :------------- | :---------------------- | :---------------- | :-------------------- | :------------------ | :------------------------------------------------------------------ |
| Can be instantiated | No         | Unknown status | Unknown identifiability | Forbidden         | Allowed               | none                | [get-leases.json\*](dnsmasq/get-leases.json "open original schema") |

## ip Type

`string`

## ip Constraints

**IPv4**: the string must be an IPv4 address (dotted quad), according to [RFC 2673, section 3.2](https://tools.ietf.org/html/rfc2673 "check the specification")
