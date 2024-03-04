# Untitled object in Set DNS records Schema

```txt
http://schema.nethserver.org/dnsmasq/set-dns-records.json#/properties/records/items
```



| Abstract            | Extensible | Status         | Identifiable | Custom Properties | Additional Properties | Access Restrictions | Defined In                                                                    |
| :------------------ | :--------- | :------------- | :----------- | :---------------- | :-------------------- | :------------------ | :---------------------------------------------------------------------------- |
| Can be instantiated | No         | Unknown status | No           | Forbidden         | Allowed               | none                | [set-dns-records.json\*](dnsmasq/set-dns-records.json "open original schema") |

## items Type

`object` ([Details](set-dns-records-properties-records-items.md))

# items Properties

| Property            | Type     | Required | Nullable       | Defined by                                                                                                                                                                                 |
| :------------------ | :------- | :------- | :------------- | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [domain](#domain)   | `string` | Required | cannot be null | [Set DNS records](set-dns-records-properties-records-items-properties-domain.md "http://schema.nethserver.org/dnsmasq/set-dns-records.json#/properties/records/items/properties/domain")   |
| [address](#address) | Merged   | Required | cannot be null | [Set DNS records](set-dns-records-properties-records-items-properties-address.md "http://schema.nethserver.org/dnsmasq/set-dns-records.json#/properties/records/items/properties/address") |

## domain



`domain`

*   is required

*   Type: `string`

*   cannot be null

*   defined in: [Set DNS records](set-dns-records-properties-records-items-properties-domain.md "http://schema.nethserver.org/dnsmasq/set-dns-records.json#/properties/records/items/properties/domain")

### domain Type

`string`

### domain Constraints

**hostname**: the string must be a hostname, according to [RFC 1123, section 2.1](https://tools.ietf.org/html/rfc1123 "check the specification")

## address



`address`

*   is required

*   Type: `string` ([Details](set-dns-records-properties-records-items-properties-address.md))

*   cannot be null

*   defined in: [Set DNS records](set-dns-records-properties-records-items-properties-address.md "http://schema.nethserver.org/dnsmasq/set-dns-records.json#/properties/records/items/properties/address")

### address Type

`string` ([Details](set-dns-records-properties-records-items-properties-address.md))

one (and only one) of

*   [Untitled undefined type in Set DNS records](set-dns-records-properties-records-items-properties-address-oneof-0.md "check type definition")

*   [Untitled undefined type in Set DNS records](set-dns-records-properties-records-items-properties-address-oneof-1.md "check type definition")
