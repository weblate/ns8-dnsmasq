# ns8-dnsmasq

This module allows to configure a [dnsmasq](https://dnsmasq.org/doc.html) instance, it offers DHCP and DNS services for the node.

## Install

Install the module with:

```bash
add-module ghcr.io/nethserver/dnsmasq:latest
```

## API Docs

The module provides the following API endpoints:

- `get-available-interfaces`: Get the available interfaces for the node
- `configure-module`: Configure the module
- `get-configuration`: Get the module configuration active
- `get-dns-records`: Get all the manual DNS records
- `set-dns-records`: Set the the DNS records
- `get-leases`: Get the DHCP leases active


### get-available-interfaces

Lists the interfaces that can be used by the module to provide DHCP and DNS services.

#### Example Request
```bash
api-cli run module/<module-id>/get-available-interfaces
```

#### Example Response
```json
{
    "data": [
        "enp0s3",
        "enp0s8"
    ]
}
```

### configure-module

Configures the module with the given parameters, it will then start the dnsmasq service.

#### Data Structure
```json
{
    "interface": "enp0s3",
    "dhcp-server": {
        "end": "10.0.0.100",
        "enabled": true,
        "lease": 10,
        "start": "10.0.0.20",
    },
    "dns-server": {
        "enabled": true,
        "primary-server": "1.1.1.1",
        "secondary-server": ""
    }
}
```

- `interface`: The interface to use for the DHCP and DNS services, use the `get-available-interfaces` endpoint to get the available interfaces.
- `dhcp-server`: The DHCP server configuration
  - `enabled`: Enable or disable the DHCP server
  - `start`: The start of the DHCP range
  - `end`: The end of the DHCP range
  - `lease`: The lease time in hours
- `dns-server`: The DNS server configuration
  - `enabled`: Enable or disable the DNS server
  - `primary-server`: The primary DNS server to use, can be IPv4 or IPv6
  - `secondary-server`: The secondary DNS server to use, can be IPv4 or IPv6 or empty

#### Example Request
```bash
api-cli run module/<module-id>/configure-module --data '<json>'
```

### get-configuration

Get the current configuration of the module, the response is the same as the `configure-module` request to keep consistency.

#### Example Request
```bash
api-cli run module/<module-id>/get-configuration
```

### set-dns-records

Set the DNS records that the module needs to resolve without querying the upstream DNS servers.

### Data Structure
```json
{
    "records": [
        {
            "domain": "example.com",
            "address": "145.34.56.2"
        },
        {
            "domain": "www.example.com",
            "address": "234.67.22.111"
        }
    ]
}
```

- `records`: The list of DNS records to set
  - `domain`: The domain to resolve
  - `address`: The IP address to resolve the domain to, can be an IPv4 or IPv6 address

#### Example Request
```bash
api-cli run module/<module-id>/set-dns-records --data '<json>'
```

### get-dns-record

Get the DNS records saved in the module. Returns the same structure as the `set-dns-records` request.

#### Example Request
```bash
api-cli run module/<module-id>/get-dns-records
```

### get-leases

Get the active DHCP leases, with the IP address, MAC address, hostname and expiration time.

#### Example Request
```bash
api-cli run module/<module-id>/get-leases
```

#### Example Response
```json
{
    "data": [
        {
            "ip": "10.0.1.20",
            "mac": "00:11:22:33:44:55",
            "hostname": "host1",
            "expires": "2021-12-12T12:12:12+00:00"
        }
    ]
}
```

## Uninstall

To uninstall the instance:

```bash
remove-module --no-preserve <module_instance>
```

## Testing

Test the module using the `test-module.sh` script:

```bash
./test-module.sh <NODE_ADDR> ghcr.io/nethserver/dnsmasq:latest
```

The tests are made using [Robot Framework](https://robotframework.org/)
