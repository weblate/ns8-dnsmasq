#!/usr/bin/env python3

#
# Copyright (C) 2024 Nethesis S.r.l.
# SPDX-License-Identifier: GPL-3.0-or-later
#

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
    if "addr_info" not in interface:
        return False
    if interface["addr_info"] == []:
        return False

    # return True if the interface is not filtered
    return True


def __format_interface(interface):
    """
    Format the interface that can be used internally for responses.
    """
    interface_data = {
        "name": interface["ifname"],
        "addresses": []
    }
    for address in interface["addr_info"]:
        if address["family"] == "inet":
            interface_data["addresses"].append({
                "address": address["local"],
                "netmask": address["prefixlen"],
                "broadcast": address["broadcast"]
            })

    return interface_data


def list_interfaces():
    """
    Returns a list of interfaces with their available addresses.
    """
    subprocess_result = subprocess.run(["ip", "-j", "addr"], check=True, capture_output=True)
    return [__format_interface(interface) for interface in json.loads(subprocess_result.stdout) if __filter_interface(interface)]
