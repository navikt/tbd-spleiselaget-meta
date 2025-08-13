import sys

last_system = ""
description = ""
chunk = []
pre = '''
<html>
    <head>
        <title>Alle våre apper</title>
<style>
    dl {
        display: grid;
        grid-gap: 4px 16px;
        grid-template-columns: max-content;
    }
    dt {
        font-weight: bold;
    }
    dd {
        margin: 0;
        grid-column-start: 2;
    }
    .missing {
        color: red;
    }
</style>
    </head>
    <body>
'''

post = '''
    </body>
</html>
'''

print(pre)
print("<dl>")
for line in sys.stdin:
    if len(chunk) != 4:
        chunk.append(line.strip().strip(":"))

    if len(chunk) == 4:
        if not chunk[2]:
            print("<dt>" + chunk[1] + "</dt><dd class='missing'>mangler beskrivelse</dd>")
        else:
            print("<dt>" + chunk[1] + "</dt><dd>" + chunk[2] + "</dd>")
        chunk = []
print("</dl>")
print(post)
