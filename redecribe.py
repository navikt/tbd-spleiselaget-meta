import sys

last_system = ""
description = ""
chunk = []

print("<dl>")
for line in sys.stdin:
    if len(chunk) != 4:
        chunk.append(line.strip().strip(":"))

    if len(chunk) == 4:
        if not chunk[2]:
            print("<dt>" + chunk[1] + "</dt><dd>mangler beskrivelse</dd>")
        else:
            print("<dt>" + chunk[1] + "</dt><dd>" + chunk[2] + "</dd>")
        chunk = []
print("</dl>")
