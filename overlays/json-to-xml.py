import sys
import json
import xmltodict

if __name__ == '__main__':
    i_file = sys.argv[1]
    o_file = sys.argv[2]

    with open(i_file) as i:
        with open(o_file, 'w') as o:
            o.write(xmltodict.unparse(json.load(i), pretty=True))
