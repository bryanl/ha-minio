from ansible import errors
import json

def to_group_vars(host_vars, groups, target = 'all'):
    data = []
    for host in groups[target]:
        data.append(host_vars[host])
    return data

class FilterModule (object):
    def filters(self):
        return {"to_group_vars": to_group_vars}