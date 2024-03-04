# Untitled string in Get leases from dnsmasq Schema

```txt
http://schema.nethserver.org/dnsmasq/get-leases.json#/properties/data/items/properties/expires
```

Lease expiration date, in ISO 8601 format

| Abstract            | Extensible | Status         | Identifiable            | Custom Properties | Additional Properties | Access Restrictions | Defined In                                                          |
| :------------------ | :--------- | :------------- | :---------------------- | :---------------- | :-------------------- | :------------------ | :------------------------------------------------------------------ |
| Can be instantiated | No         | Unknown status | Unknown identifiability | Forbidden         | Allowed               | none                | [get-leases.json\*](dnsmasq/get-leases.json "open original schema") |

## expires Type

`string`

## expires Constraints

**date time**: the string must be a date time string, according to [RFC 3339, section 5.6](https://tools.ietf.org/html/rfc3339 "check the specification")
