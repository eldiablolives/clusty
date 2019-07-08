#!/usr/bin/env python

import sys
import json
import os

with open('terraform.tfstate') as json_data:
    d = json.load(json_data)
    for resource in d['resources']:
        if resource['type'] == 'digitalocean_droplet':
            for instance in resource['instances']:
                print(instance['attributes']['name'] + ' ansible_ssh_host=' + instance['attributes']['ipv4_address'])