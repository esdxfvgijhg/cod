import json
import os

gateway_conf_filename = "gateway_conf.json"
gateway_json_array = {}
call_string_cpp = "sudo ./lora_gateway"
call_string_python = " | python post_processing_gw.py"
call_string_log_gw = ""


def start_config_from_json():
    f = open(os.path.expanduser(gateway_conf_filename), "r")
    lines = f.readlines()
    f.close()
    array = ""
    for line in lines:
        array += line
    global gateway_json_array
    gateway_json_array = json.loads(array)
    global call_string_cpp
    global call_string_python
    global call_string_log_gw
    try:
        if gateway_json_array["gateway_conf"]["raw"]:
            call_string_cpp += " --raw"
    except KeyError:
        pass
    try:
        if gateway_json_array["gateway_conf"]["log_post_processing"]:
            call_string_log_gw = " | python log_gw.py"
    except KeyError:
        pass
    try:
        if gateway_json_array["radio_conf"]["mode"] != -1:
            call_string_cpp += " --mode %s" % str(gateway_json_array["radio_conf"]["mode"])
            if gateway_json_array["radio_conf"]["mode"] == 11:
                call_string_cpp += " --bw %s --cr %s --sf %s" % (str(gateway_json_array["radio_conf"]["bw"]), str(gateway_json_array["radio_conf"]["cr"]), str(gateway_json_array["radio_conf"]["sf"]))
        else:
            call_string_cpp += " --bw %s --cr %s --sf %s" % (str(gateway_json_array["radio_conf"]["bw"]), str(gateway_json_array["radio_conf"]["cr"]), str(gateway_json_array["radio_conf"]["sf"]))
    except KeyError:
        call_string_cpp += " --mode 1"
    try:
        if gateway_json_array["radio_conf"]["ch"] != -1:
            call_string_cpp += " --ch %s" % str(gateway_json_array["radio_conf"]["ch"])
        elif gateway_json_array["radio_conf"]["freq"] != -1:
            call_string_cpp += " --freq %s" % str(gateway_json_array["radio_conf"]["freq"])
    except KeyError:
        pass
    try:
        if gateway_json_array["gateway_conf"]["downlink"] == 0:
            call_string_cpp += " --ndl"
    except KeyError:
        pass
    print call_string_cpp + call_string_python + call_string_log_gw
    os.system(call_string_cpp + call_string_python + call_string_log_gw)


if __name__ == "__main__":
    start_config_from_json()
