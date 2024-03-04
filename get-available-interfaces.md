# Interfaces Schema

```txt
http://schema.nethserver.org/dnsmasq/get-available-interfaces.json
```

List available interfaces that dnsmasq can be configured on.

| Abstract            | Extensible | Status         | Identifiable | Custom Properties | Additional Properties | Access Restrictions | Defined In                                                                                    |
| :------------------ | :--------- | :------------- | :----------- | :---------------- | :-------------------- | :------------------ | :-------------------------------------------------------------------------------------------- |
| Can be instantiated | No         | Unknown status | No           | Forbidden         | Allowed               | none                | [get-available-interfaces.json](dnsmasq/get-available-interfaces.json "open original schema") |

## Interfaces Type

`object` ([Interfaces](get-available-interfaces.md))

# Interfaces Properties

| Property      | Type    | Required | Nullable       | Defined by                                                                                                                                      |
| :------------ | :------ | :------- | :------------- | :---------------------------------------------------------------------------------------------------------------------------------------------- |
| [data](#data) | `array` | Required | cannot be null | [Interfaces](get-available-interfaces-properties-data.md "http://schema.nethserver.org/dnsmasq/get-available-interfaces.json#/properties/data") |

## data



`data`

*   is required

*   Type: `string[]`

*   cannot be null

*   defined in: [Interfaces](get-available-interfaces-properties-data.md "http://schema.nethserver.org/dnsmasq/get-available-interfaces.json#/properties/data")

### data Type

`string[]`
