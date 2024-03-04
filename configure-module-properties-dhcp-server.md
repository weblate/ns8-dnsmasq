# Untitled object in Configure dnsmasq Schema

```txt
http://schema.nethserver.org/dnsmasq/configure-module.json#/properties/dhcp-server
```

Defines DHCP server configuration

| Abstract            | Extensible | Status         | Identifiable | Custom Properties | Additional Properties | Access Restrictions | Defined In                                                                      |
| :------------------ | :--------- | :------------- | :----------- | :---------------- | :-------------------- | :------------------ | :------------------------------------------------------------------------------ |
| Can be instantiated | No         | Unknown status | No           | Forbidden         | Allowed               | none                | [configure-module.json\*](dnsmasq/configure-module.json "open original schema") |

## dhcp-server Type

`object` ([Details](configure-module-properties-dhcp-server.md))

# dhcp-server Properties

| Property            | Type      | Required | Nullable       | Defined by                                                                                                                                                                                 |
| :------------------ | :-------- | :------- | :------------- | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [enabled](#enabled) | `boolean` | Required | cannot be null | [Configure dnsmasq](configure-module-properties-dhcp-server-properties-enabled.md "http://schema.nethserver.org/dnsmasq/configure-module.json#/properties/dhcp-server/properties/enabled") |
| [start](#start)     | `string`  | Required | cannot be null | [Configure dnsmasq](configure-module-properties-dhcp-server-properties-start.md "http://schema.nethserver.org/dnsmasq/configure-module.json#/properties/dhcp-server/properties/start")     |
| [end](#end)         | `string`  | Required | cannot be null | [Configure dnsmasq](configure-module-properties-dhcp-server-properties-end.md "http://schema.nethserver.org/dnsmasq/configure-module.json#/properties/dhcp-server/properties/end")         |
| [lease](#lease)     | `integer` | Required | cannot be null | [Configure dnsmasq](configure-module-properties-dhcp-server-properties-lease.md "http://schema.nethserver.org/dnsmasq/configure-module.json#/properties/dhcp-server/properties/lease")     |

## enabled

Enable DHCP server

`enabled`

*   is required

*   Type: `boolean`

*   cannot be null

*   defined in: [Configure dnsmasq](configure-module-properties-dhcp-server-properties-enabled.md "http://schema.nethserver.org/dnsmasq/configure-module.json#/properties/dhcp-server/properties/enabled")

### enabled Type

`boolean`

## start



`start`

*   is required

*   Type: `string`

*   cannot be null

*   defined in: [Configure dnsmasq](configure-module-properties-dhcp-server-properties-start.md "http://schema.nethserver.org/dnsmasq/configure-module.json#/properties/dhcp-server/properties/start")

### start Type

`string`

### start Constraints

**IPv4**: the string must be an IPv4 address (dotted quad), according to [RFC 2673, section 3.2](https://tools.ietf.org/html/rfc2673 "check the specification")

## end



`end`

*   is required

*   Type: `string`

*   cannot be null

*   defined in: [Configure dnsmasq](configure-module-properties-dhcp-server-properties-end.md "http://schema.nethserver.org/dnsmasq/configure-module.json#/properties/dhcp-server/properties/end")

### end Type

`string`

### end Constraints

**IPv4**: the string must be an IPv4 address (dotted quad), according to [RFC 2673, section 3.2](https://tools.ietf.org/html/rfc2673 "check the specification")

## lease

Lease time in hours

`lease`

*   is required

*   Type: `integer`

*   cannot be null

*   defined in: [Configure dnsmasq](configure-module-properties-dhcp-server-properties-lease.md "http://schema.nethserver.org/dnsmasq/configure-module.json#/properties/dhcp-server/properties/lease")

### lease Type

`integer`

### lease Constraints

**minimum**: the value of this number must greater than or equal to: `1`
