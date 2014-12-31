#
#xml2json v 1.1
#copyright 2005-2007 Thomas Frank
#
#This program is free software under the terms of the 
#GNU General Public License version 2 as published by the Free 
#Software Foundation. It is distributed without any warranty.
#
xml2json =
  parser: (xmlcode, ignoretags, debug) ->
    ignoretags = ""  unless ignoretags
    xmlcode = xmlcode.replace(/\s*\/>/g, "/>")
    xmlcode = xmlcode.replace(/<\?[^>]*>/g, "").replace(/<\![^>]*>/g, "")
    ignoretags = ignoretags.split(",")  unless ignoretags.sort
    x = @no_fast_endings(xmlcode)
    x = @attris_to_tags(x)
    x = escape(x)
    x = x.split("%3C").join("<").split("%3E").join(">").split("%3D").join("=").split("%22").join("\"")
    i = 0

    while i < ignoretags.length
      x = x.replace(new RegExp("<" + ignoretags[i] + ">", "g"), "*$**" + ignoretags[i] + "**$*")
      x = x.replace(new RegExp("</" + ignoretags[i] + ">", "g"), "*$***" + ignoretags[i] + "**$*")
      i++
    x = "<JSONTAGWRAPPER>" + x + "</JSONTAGWRAPPER>"
    @xmlobject = {}
    y = @xml_to_object(x).jsontagwrapper
    y = @show_json_structure(y, debug)  if debug
    y

  xml_to_object: (xmlcode) ->
    x = xmlcode.replace(/<\//g, "§")
    x = x.split("<")
    y = []
    level = 0
    opentags = []
    i = 1

    while i < x.length
      tagname = x[i].split(">")[0]
      opentags.push tagname
      level++
      y.push level + "<" + x[i].split("§")[0]
      while x[i].indexOf("§" + opentags[opentags.length - 1] + ">") >= 0
        level--
        opentags.pop()
      i++
    oldniva = -1
    objname = "this.xmlobject"
    i = 0

    while i < y.length
      preeval = ""
      niva = y[i].split("<")[0]
      tagnamn = y[i].split("<")[1].split(">")[0]
      tagnamn = tagnamn.toLowerCase()
      rest = y[i].split(">")[1]
      if niva <= oldniva
        tabort = oldniva - niva + 1
        j = 0

        while j < tabort
          objname = objname.substring(0, objname.lastIndexOf("."))
          j++
      objname += "." + tagnamn
      pobject = objname.substring(0, objname.lastIndexOf("."))
      preeval += pobject + "={value:" + pobject + "};\n"  unless eval("typeof " + pobject) is "object"
      objlast = objname.substring(objname.lastIndexOf(".") + 1)
      already = false
      for k of eval(pobject)
        already = true  if k is objlast
      onlywhites = true
      s = 0

      while s < rest.length
        onlywhites = false  unless rest.charAt(s) is "%"
        s += 3
      if rest isnt "" and not onlywhites
        unless rest / 1 is rest
          rest = "'" + rest.replace(/\'/g, "\\'") + "'"
          rest = rest.replace(/\*\$\*\*\*/g, "</")
          rest = rest.replace(/\*\$\*\*/g, "<")
          rest = rest.replace(/\*\*\$\*/g, ">")
      else
        rest = "{}"
      rest = "unescape(" + rest + ")"  if rest.charAt(0) is "'"
      preeval += objname + "=[" + objname + "];\n"  if already and not eval(objname + ".sort")
      before = "="
      after = ""
      if already
        before = ".push("
        after = ")"
      toeval = preeval + objname + before + rest + after
      eval toeval
      objname += "[" + eval(objname + ".length-1") + "]"  if eval(objname + ".sort")
      oldniva = niva
      i++
    @xmlobject

  show_json_structure: (obj, debug, l) ->
    x = ""
    if obj.sort
      x += "[\n"
    else
      x += "{\n"
    for i of obj
      x += i + ":"  unless obj.sort
      if typeof obj[i] is "object"
        x += @show_json_structure(obj[i], false, 1)
      else
        if typeof obj[i] is "function"
          v = obj[i] + ""
          
          #v=v.replace(/\t/g,"");
          x += v
        else unless typeof obj[i] is "string"
          x += obj[i] + ",\n"
        else
          x += "'" + obj[i].replace(/\'/g, "\\'").replace(/\n/g, "\\n").replace(/\t/g, "\\t").replace(/\r/g, "\\r") + "',\n"
    if obj.sort
      x += "],\n"
    else
      x += "},\n"
    unless l
      x = x.substring(0, x.lastIndexOf(","))
      x = x.replace(new RegExp(",\n}", "g"), "\n}")
      x = x.replace(new RegExp(",\n]", "g"), "\n]")
      y = x.split("\n")
      x = ""
      lvl = 0
      i = 0

      while i < y.length
        lvl--  if y[i].indexOf("}") >= 0 or y[i].indexOf("]") >= 0
        tabs = ""
        j = 0

        while j < lvl
          tabs += "\t"
          j++
        x += tabs + y[i] + "\n"
        lvl++  if y[i].indexOf("{") >= 0 or y[i].indexOf("[") >= 0
        i++
      if debug is "html"
        x = x.replace(/</g, "&lt;").replace(/>/g, "&gt;")
        x = x.replace(/\n/g, "<BR>").replace(/\t/g, "&nbsp;&nbsp;&nbsp;&nbsp;")
      x = x.replace(/\n/g, "").replace(/\t/g, "")  if debug is "compact"
    x

  no_fast_endings: (x) ->
    x = x.split("/>")
    i = 1

    while i < x.length
      t = x[i - 1].substring(x[i - 1].lastIndexOf("<") + 1).split(" ")[0]
      x[i] = "></" + t + ">" + x[i]
      i++
    x = x.join("")
    x

  attris_to_tags: (x) ->
    d = " =\"'".split("")
    x = x.split(">")
    i = 0

    while i < x.length
      temp = x[i].split("<")
      r = 0

      while r < 4
        temp[0] = temp[0].replace(new RegExp(d[r], "g"), "_jsonconvtemp" + r + "_")
        r++
      if temp[1]
        temp[1] = temp[1].replace(/'/g, "\"")
        temp[1] = temp[1].split("\"")
        j = 1

        while j < temp[1].length
          r = 0

          while r < 4
            temp[1][j] = temp[1][j].replace(new RegExp(d[r], "g"), "_jsonconvtemp" + r + "_")
            r++
          j += 2
        temp[1] = temp[1].join("\"")
      x[i] = temp.join("<")
      i++
    x = x.join(">")
    x = x.replace(RegExp(" ([^=]*)=([^ |>]*)", "g"), "><$1>$2</$1")
    x = x.replace(/>"/g, ">").replace(/"</g, "<")
    r = 0

    while r < 4
      x = x.replace(new RegExp("_jsonconvtemp" + r + "_", "g"), d[r])
      r++
    x

unless Array::push
  Array::push = (x) ->
    this[@length] = x
    true
unless Array::pop
  Array::pop = ->
    response = this[@length - 1]
    @length--
    response

angular.module 'mydrive5App'
.filter 'xml2json', ->
  (xmlcode,ignoretags,debug) ->
    xml2json.parser(xmlcode,ignoretags,debug)