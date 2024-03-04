# Set DNS records Schema

```txt
http://schema.nethserver.org/dnsmasq/set-dns-records.json
```

Allow to set static DNS records or overrides

| Abstract            | Extensible | Status         | Identifiable | Custom Properties | Additional Properties | Access Restrictions | Defined In                                                                  |
| :------------------ | :--------- | :------------- | :----------- | :---------------- | :-------------------- | :------------------ | :-------------------------------------------------------------------------- |
| Can be instantiated | No         | Unknown status | No           | Forbidden         | Allowed               | none                | [set-dns-records.json](dnsmasq/set-dns-records.json "open original schema") |

## Set DNS records Type

`object` ([Set DNS records](set-dns-records.md))

# Set DNS records Properties

| Property            | Type    | Required | Nullable       | Defined by                                                                                                                               |
| :------------------ | :------ | :------- | :------------- | :--------------------------------------------------------------------------------------------------------------------------------------- |
| [records](#records) | `array` | Required | cannot be null | [Set DNS records](set-dns-records-properties-records.md "http://schema.nethserver.org/dnsmasq/set-dns-records.json#/properties/records") |

## records

List of static DNS entries

`records`

*   is required

*   Type: `object[]` ([Details](set-dns-records-properties-records-items.md))

*   cannot be null

*   defined in: [Set DNS records](set-dns-records-properties-records.md "http://schema.nethserver.org/dnsmasq/set-dns-records.json#/properties/records")

### records Type

`object[]` ([Details](set-dns-records-properties-records-items.md))
