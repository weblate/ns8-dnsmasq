# Configure dnsmasq Schema

```txt
http://schema.nethserver.org/dnsmasq/configure-module.json
```

Configure dnsmasq module

| Abstract            | Extensible | Status         | Identifiable | Custom Properties | Additional Properties | Access Restrictions | Defined In                                                                    |
| :------------------ | :--------- | :------------- | :----------- | :---------------- | :-------------------- | :------------------ | :---------------------------------------------------------------------------- |
| Can be instantiated | No         | Unknown status | No           | Forbidden         | Allowed               | none                | [configure-module.json](dnsmasq/configure-module.json "open original schema") |

## Configure dnsmasq Type

`object` ([Configure dnsmasq](configure-module.md))

# Configure dnsmasq Properties

| Property                    | Type     | Required | Nullable       | Defined by                                                                                                                                           |
| :-------------------------- | :------- | :------- | :------------- | :--------------------------------------------------------------------------------------------------------------------------------------------------- |
| [interface](#interface)     | `string` | Required | cannot be null | [Configure dnsmasq](configure-module-properties-interface.md "http://schema.nethserver.org/dnsmasq/configure-module.json#/properties/interface")     |
| [dhcp-server](#dhcp-server) | `object` | Required | cannot be null | [Configure dnsmasq](configure-module-properties-dhcp-server.md "http://schema.nethserver.org/dnsmasq/configure-module.json#/properties/dhcp-server") |
| [dns-server](#dns-server)   | `object` | Required | cannot be null | [Configure dnsmasq](configure-module-properties-dns-server.md "http://schema.nethserver.org/dnsmasq/configure-module.json#/properties/dns-server")   |

## interface

Network interface, a list is provided by the 'get-available-interfaces' action

`interface`

*   is required

*   Type: `string`

*   cannot be null

*   defined in: [Configure dnsmasq](configure-module-properties-interface.md "http://schema.nethserver.org/dnsmasq/configure-module.json#/properties/interface")

### interface Type

`string`

## dhcp-server

Defines DHCP server configuration

`dhcp-server`

*   is required

*   Type: `object` ([Details](configure-module-properties-dhcp-server.md))

*   cannot be null

*   defined in: [Configure dnsmasq](configure-module-properties-dhcp-server.md "http://schema.nethserver.org/dnsmasq/configure-module.json#/properties/dhcp-server")

### dhcp-server Type

`object` ([Details](configure-module-properties-dhcp-server.md))

## dns-server

Defines DNS server configuration

`dns-server`

*   is required

*   Type: `object` ([Details](configure-module-properties-dns-server.md))

*   cannot be null

*   defined in: [Configure dnsmasq](configure-module-properties-dns-server.md "http://schema.nethserver.org/dnsmasq/configure-module.json#/properties/dns-server")

### dns-server Type

`object` ([Details](configure-module-properties-dns-server.md))
