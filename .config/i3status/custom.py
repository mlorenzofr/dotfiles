#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import json
from time import time
from operator import sub

iface = "wlp2s0"


class net_traffic:
    def __init__(self):
        self.rx = self.get_stats('rx')
        self.tx = self.get_stats('tx')
        self.time = time()
        return

    def get_stats(self, stype):
        stat_file = "/sys/class/net/%s/statistics/%s_bytes" % (iface, stype)
        with open(stat_file, 'r') as fh:
            bs = fh.readlines()[0].strip()
        return float(bs)

    def dump(self):
        interval, rx, tx = self.update()
        in_bytes = human_units(rx/interval)
        out_bytes = human_units(tx/interval)
        jsdata = [{"color": "#00FF00",
                   "full_text": '↓%s' % in_bytes,
                   "name": "traffic_in"},
                  {"color": "#FF0000",
                   "full_text": '↑%s' % out_bytes,
                   "name": "traffic_out"}]
        return jsdata

    def update(self):
        current = (time(),
                   self.get_stats('rx'),
                   self.get_stats('tx'))
        old = (self.time,
               self.rx,
               self.tx)
        self.time, self.rx, self.tx = current
        delta = tuple(map(sub, current, old))
        return delta


def print_line(msg):
    """ Print a new line """
    sys.stdout.write('%s\n' % msg)
    sys.stdout.flush()


def read_line():
    try:
        line = sys.stdin.readline().strip()
        if not line:
            sys.exit(1)
        return line
    except KeyboardInterrupt:
        sys.exit()


def human_units(number):
    units = ['', 'K', 'M', 'G', 'T']
    size = float(number)
    counter = 0
    while size > 1024:
        size = size / 1024
        counter += 1
    return "%0.f%s" % (size, units[counter])


if __name__ == '__main__':
    print_line(read_line())
    print_line(read_line())
    stats = net_traffic()
    while True:
        line, preffix = read_line(), ''
        if line.startswith(','):
            line, preffix = line[1:], ','
        j = json.loads(line)
        for entry in stats.dump():
            j.insert(0, entry)
        print_line(preffix+json.dumps(j))
