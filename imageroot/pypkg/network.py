#!/usr/bin/env python3

#
# Copyright (C) 2024 Nethesis S.r.l.
# SPDX-License-Identifier: GPL-3.0-or-later
#

import ipaddress
import json
import subprocess


def __filter_interface(interface):
    """
    Filter the interfaces that are not useful for the configuration.
    """
    # filter by name
    interface_name = interface["ifname"]
    if interface_name.startswith("lo"):
        return False
    if interface_name.startswith("wg"):
        return False

    # filter by configuration status
    if "addr_info" not in interface or interface["addr_info"] == []:
        return False

    # return True if the interface is not filtered
    return True


def __format_interface(interface):
    """
    Format the interface that can be used internally for responses.
    """
    interface_data = {
        "name": interface["ifname"],
        "addresses": [],
        "start": "",
        "end": ""
    }
    for address in interface["addr_info"]:
        if address["family"] == "inet":
            network = ipaddress.IPv4Network(address["local"] + "/" + str(address["prefixlen"]), strict=False)
            interface_data["addresses"].append({
                "address": ipaddress.IPv4Address(address["local"]),
                "network": network
            })
            # last address wins the start and end fields
            interface_data["start"] = network.network_address + 1
            interface_data["end"] = network.network_address + network.num_addresses - 2

    return interface_data


def list_interfaces():
    """
    Returns a list of interfaces with their available addresses.
    """
    subprocess_result = subprocess.run(["ip", "-4", "-j", "addr"], check=True, capture_output=True)
    return [__format_interface(interface) for interface in json.loads(subprocess_result.stdout) if __filter_interface(interface)]
