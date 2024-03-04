# Untitled object in Get leases from dnsmasq Schema

```txt
http://schema.nethserver.org/dnsmasq/get-leases.json#/properties/data/items
```



| Abstract            | Extensible | Status         | Identifiable | Custom Properties | Additional Properties | Access Restrictions | Defined In                                                          |
| :------------------ | :--------- | :------------- | :----------- | :---------------- | :-------------------- | :------------------ | :------------------------------------------------------------------ |
| Can be instantiated | No         | Unknown status | No           | Forbidden         | Allowed               | none                | [get-leases.json\*](dnsmasq/get-leases.json "open original schema") |

## items Type

`object` ([Details](get-leases-properties-data-items.md))

# items Properties

| Property              | Type     | Required | Nullable       | Defined by                                                                                                                                                                           |
| :-------------------- | :------- | :------- | :------------- | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [mac](#mac)           | `string` | Required | cannot be null | [Get leases from dnsmasq](get-leases-properties-data-items-properties-mac.md "http://schema.nethserver.org/dnsmasq/get-leases.json#/properties/data/items/properties/mac")           |
| [ip](#ip)             | `string` | Required | cannot be null | [Get leases from dnsmasq](get-leases-properties-data-items-properties-ip.md "http://schema.nethserver.org/dnsmasq/get-leases.json#/properties/data/items/properties/ip")             |
| [hostname](#hostname) | `string` | Required | cannot be null | [Get leases from dnsmasq](get-leases-properties-data-items-properties-hostname.md "http://schema.nethserver.org/dnsmasq/get-leases.json#/properties/data/items/properties/hostname") |
| [expires](#expires)   | `string` | Required | cannot be null | [Get leases from dnsmasq](get-leases-properties-data-items-properties-expires.md "http://schema.nethserver.org/dnsmasq/get-leases.json#/properties/data/items/properties/expires")   |

## mac

MAC address provided of the client

`mac`

*   is required

*   Type: `string`

*   cannot be null

*   defined in: [Get leases from dnsmasq](get-leases-properties-data-items-properties-mac.md "http://schema.nethserver.org/dnsmasq/get-leases.json#/properties/data/items/properties/mac")

### mac Type

`string`

## ip

IP address assigned to the client

`ip`

*   is required

*   Type: `string`

*   cannot be null

*   defined in: [Get leases from dnsmasq](get-leases-properties-data-items-properties-ip.md "http://schema.nethserver.org/dnsmasq/get-leases.json#/properties/data/items/properties/ip")

### ip Type

`string`

### ip Constraints

**IPv4**: the string must be an IPv4 address (dotted quad), according to [RFC 2673, section 3.2](https://tools.ietf.org/html/rfc2673 "check the specification")

## hostname

Hostname provided by the client

`hostname`

*   is required

*   Type: `string`

*   cannot be null

*   defined in: [Get leases from dnsmasq](get-leases-properties-data-items-properties-hostname.md "http://schema.nethserver.org/dnsmasq/get-leases.json#/properties/data/items/properties/hostname")

### hostname Type

`string`

### hostname Constraints

**hostname**: the string must be a hostname, according to [RFC 1123, section 2.1](https://tools.ietf.org/html/rfc1123 "check the specification")

## expires

Lease expiration date, in ISO 8601 format

`expires`

*   is required

*   Type: `string`

*   cannot be null

*   defined in: [Get leases from dnsmasq](get-leases-properties-data-items-properties-expires.md "http://schema.nethserver.org/dnsmasq/get-leases.json#/properties/data/items/properties/expires")

### expires Type

`string`

### expires Constraints

**date time**: the string must be a date time string, according to [RFC 3339, section 5.6](https://tools.ietf.org/html/rfc3339 "check the specification")
