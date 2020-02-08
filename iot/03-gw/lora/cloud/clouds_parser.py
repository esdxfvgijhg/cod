import os
import sys
import json
import datetime

cloud_filename = "clouds.json"  ############################################## ########### GETTING ENABLED CLOUDS ########### #############################################


def retrieve_enabled_clouds(cloud_array="clouds"):
    _enabled_clouds = []
    f = open(os.path.expanduser(cloud_filename), "r")
    string = f.read()
    f.close()
    json_array = json.loads(string)
    hasCloudSection = 1
    try:
        clouds = json_array[cloud_array]
    except KeyError:
        print "Error when looking for " + cloud_array + " section"
        hasCloudSection = 0
    if hasCloudSection == 1:
        print "Parsing cloud declarations"
        for cloud in clouds:
            if cloud["enabled"]:
                _enabled_clouds.append(cloud["script"])
                print _enabled_clouds
        print "Parsed all cloud declarations"
    return _enabled_clouds
