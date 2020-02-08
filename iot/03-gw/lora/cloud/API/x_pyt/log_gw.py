import sys
import os
import shutil
import datetime
import json
import getopt

_folder_path = "/home/pi/Dropbox/LoRa-test/"
f = open(os.path.expanduser("gateway_conf.json"), "r")
lines = f.readlines()
f.close()
array = ""
for line in lines:
    array += line
json_array = json.loads(array)
_gwaddr = json_array["gateway_conf"]["gateway_ID"]
_parselog_filename = _folder_path + "post-processing.log"
_prefix_filename = _folder_path + "post-processing_"
_use_weekly_log = json_array["gateway_conf"]["log_weekly"]


def monthChanged(last_year, last_month):
    _new_folder_name = _folder_path + str(_gwaddr) + "_" + str(last_year) + "-" + str(last_month)
    os.system("mkdir " + _new_folder_name)
    os.system("chmod 744 " + _new_folder_name)
    files = os.listdir(os.path.expanduser(_folder_path))
    for f in files:
        if f.startswith("post-processing_" + str(last_year) + "-" + str(last_month)):
            shutil.move(os.path.expanduser(_folder_path + f), os.path.expanduser(_new_folder_name))


the_line = sys.stdin.readline()
while the_line:
    if _use_weekly_log:
        if os.path.exists(os.path.expanduser(_parselog_filename)) and os.path.getsize(os.path.expanduser(_parselog_filename)) != 0:
            now = datetime.datetime.utcnow().date()
            last_modif = datetime.datetime.utcfromtimestamp(os.path.getmtime(os.path.expanduser(_parselog_filename))).date()
            new_month = False
            if last_modif.month != now.month or last_modif.year != now.year:
                os.rename(os.path.expanduser(_parselog_filename), os.path.expanduser(_prefix_filename + str(last_modif.year) + "-" + str(last_modif.month) + "-" + str(last_modif.day) + "_to_" + str(now.year) + "-" + str(now.month) + "-" + str(now.day) + ".log"))
                monthChanged(last_modif.year, last_modif.month)
                new_month = True
            if not new_month:
                f = open(os.path.expanduser(_parselog_filename), "r")
                a = f.readline()
                f.close()
                last_character = 0
                date_aux = ""
                while last_character < 10:
                    date_aux += a[last_character]
                    last_character += 1
                date = date_aux.split("-")
                date_aux = now.replace(year=int(date[0]), month=int(date[1]), day=int(date[2]))
                difference_days = now - date_aux
                if difference_days.days >= 7:
                    os.rename(_parselog_filename, _prefix_filename + str(date_aux) + "_to_" + str(now) + ".log")
    else:
        if os.path.exists(os.path.expanduser(_parselog_filename)):
            now = datetime.datetime.utcnow().date()
            last_modif = datetime.datetime.utcfromtimestamp(os.path.getmtime(os.path.expanduser(_parselog_filename))).date()
            if last_modif.month != now.month or last_modif.year != now.year:
                os.system("rm " + _prefix_filename + "*")
                os.rename(os.path.expanduser(_parselog_filename), os.path.expanduser(_prefix_filename + str(last_modif.year) + "-" + str(last_modif.month) + ".log"))
    f = open(os.path.expanduser(_parselog_filename), "a")
    now = datetime.datetime.now()
    f.write(now.isoformat() + "> ")
    f.write(the_line)
    f.close()
    sys.stdout.write(the_line)
    the_line = sys.stdin.readline()
