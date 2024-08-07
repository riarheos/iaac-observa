"""
Retrieve hosts from the Yandex Cloud environment
"""

import logging
from collections import defaultdict

import requests


# Set up logging
log = logging.getLogger(__name__)


def ext_pillar(minion_id, pillar, command):
    data = requests.get('http://169.254.169.254/computeMetadata/v1/instance/service-accounts/default/token',
                        headers={
                            'Metadata-Flavor': 'Google'
                        })
    token = data.json()['access_token']

    data = requests.get('https://compute.api.cloud.yandex.net/compute/v1/instances?folderId=b1guaa1hv85esfel63i6',
                        headers={
                            'Authorization': f'Bearer {token}'
                        })
    hosts = data.json()['instances']

    result = defaultdict(list)
    for host in hosts:
        result[host['labels']['node_type']].append(host)

    return {'yacloud': dict(result)}