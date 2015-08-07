#!/usr/bin/env python
import json
import subprocess
import sys


datastruct = {"UP": 0,
              "DOWN": 0,
              "RIGHT": 0,
              "LEFT": 0}

workspace = [["VGA1","HDMI1"]]
cmd = sys.argv[-1]

def get_current_visible(state):
    return {i["output"]: i["num"] for i in state if i["visible"]}

def get_current_focus(state):
    return [i["output"] for i in state if i["focused"]][0]


def get_parents(focus):
    for n,i in enumerate(workspace):
        for nn,ii in enumerate(i):
            if focus == ii:
                return {"UP": (n+1,nn),
                        "DOWN": (n-1,nn),
                        "LEFT": (n,nn-1),
                        "RIGHT": (n,nn+1)}


def choose(cmd, pars):
    y,x = pars[cmd]
    space = visible[workspace[y][x]]
    subprocess.Popen(["i3-msg", "workspace "+str(space)])


a = subprocess.Popen(["i3-msg","-t", "get_workspaces"], stdout=subprocess.PIPE)
out = str(a.stdout.read(), "utf-8")
state = json.loads(out)


visible = get_current_visible(state)
focus = get_current_focus(state)
pars = get_parents(focus)
choose(cmd, pars)



