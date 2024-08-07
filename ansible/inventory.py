#! /usr/bin/env python3

import json
import subprocess

import yaml

data = subprocess.check_output(['yc', 'compute',  'instance',  'list', '--format', 'json'])
hosts = json.loads(data)

result = {}
hostvars = {}
for host in hosts:
    group = host['labels']['node_type'].replace('-', '_')
    if group not in result:
        result[group] = {
            'hosts': [],
        }
    result[group]['hosts'].append(
        host['network_interfaces'][0]['primary_v4_address']['one_to_one_nat']['address']
    )
    hostvars[host['network_interfaces'][0]['primary_v4_address']['one_to_one_nat']['address']] = {
        'name': host['name'],
        'fqdn': host['fqdn'],
    }

result['all'] = {'children': list(result.keys())}
result['_meta'] = {'hostvars': hostvars}

print(json.dumps(result))
