# Untitled object in Configure dnsmasq Schema

```txt
http://schema.nethserver.org/dnsmasq/configure-module.json#/properties/dns-server
```

Defines DNS server configuration

| Abstract            | Extensible | Status         | Identifiable | Custom Properties | Additional Properties | Access Restrictions | Defined In                                                                      |
| :------------------ | :--------- | :------------- | :----------- | :---------------- | :-------------------- | :------------------ | :------------------------------------------------------------------------------ |
| Can be instantiated | No         | Unknown status | No           | Forbidden         | Allowed               | none                | [configure-module.json\*](dnsmasq/configure-module.json "open original schema") |

## dns-server Type

`object` ([Details](configure-module-properties-dns-server.md))

# dns-server Properties

| Property                | Type      | Required | Nullable       | Defined by                                                                                                                                                                                   |
| :---------------------- | :-------- | :------- | :------------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [enabled](#enabled)     | `boolean` | Required | cannot be null | [Configure dnsmasq](configure-module-properties-dns-server-properties-enabled.md "http://schema.nethserver.org/dnsmasq/configure-module.json#/properties/dns-server/properties/enabled")     |
| [servers](#servers)     | `array`   | Required | cannot be null | [Configure dnsmasq](configure-module-properties-dns-server-properties-servers.md "http://schema.nethserver.org/dnsmasq/configure-module.json#/properties/dns-server/properties/servers")     |
| [addresses](#addresses) | `array`   | Required | cannot be null | [Configure dnsmasq](configure-module-properties-dns-server-properties-addresses.md "http://schema.nethserver.org/dnsmasq/configure-module.json#/properties/dns-server/properties/addresses") |

## enabled

Enable DNS server

`enabled`

*   is required

*   Type: `boolean`

*   cannot be null

*   defined in: [Configure dnsmasq](configure-module-properties-dns-server-properties-enabled.md "http://schema.nethserver.org/dnsmasq/configure-module.json#/properties/dns-server/properties/enabled")

### enabled Type

`boolean`

## servers

List of upstream DNS servers, where the requests shall be forwarded

`servers`

*   is required

*   Type: `string[]` ([Details](configure-module-properties-dns-server-properties-servers-items.md))

*   cannot be null

*   defined in: [Configure dnsmasq](configure-module-properties-dns-server-properties-servers.md "http://schema.nethserver.org/dnsmasq/configure-module.json#/properties/dns-server/properties/servers")

### servers Type

`string[]` ([Details](configure-module-properties-dns-server-properties-servers-items.md))

## addresses

List of static DNS entries

`addresses`

*   is required

*   Type: `object[]` ([Details](configure-module-properties-dns-server-properties-addresses-items.md))

*   cannot be null

*   defined in: [Configure dnsmasq](configure-module-properties-dns-server-properties-addresses.md "http://schema.nethserver.org/dnsmasq/configure-module.json#/properties/dns-server/properties/addresses")

### addresses Type

`object[]` ([Details](configure-module-properties-dns-server-properties-addresses-items.md))
