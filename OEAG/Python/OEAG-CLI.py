#!/usr/bin/python
import sys;
import re;
import hashlib;

if len(sys.argv) == 1:
	print ("usage: " + sys.argv[0] + " <authorization phrase>");
	exit();

secret=sys.argv[1];

secret=re.sub('[\r\n]','',secret);

secret = hashlib.sha256(secret.encode('utf-8')).hexdigest();

secret=re.sub('[^A-Za-z0-9]','',secret);

print(secret);
