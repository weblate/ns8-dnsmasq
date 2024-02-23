# ns8-dnsmasq

This module allows to configure a [dnsmasq](https://dnsmasq.org/doc.html) instance, it offers DHCP and DNS services for the node.

## Install

Install the module with:

```bash
add-module ghcr.io/nethserver/ns8-dnsmasq:latest
```

## Uninstall

To uninstall the instance:

```bash
remove-module --no-preserve <module_instance>
```

## Testing

Test the module using the `test-module.sh` script:

```bash
./test-module.sh <NODE_ADDR> ghcr.io/nethserver/ns8-dnsmasq:latest
```

The tests are made using [Robot Framework](https://robotframework.org/)
