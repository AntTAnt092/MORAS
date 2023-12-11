def _parse_commands(self):
        self._init_comms()
        self._init_symbols()  
        self._iter_lines(self._parse_command)

def _parse_command(self, line, p, o):
    if line.startswith("$"):
        return self._parse_macro_command(line[1:])
    elif line[0] == "@":
        num = int(line[1:])
        return "{0:016b}".format(num)
    else:
        op = ""
        dest = ""
        jmp = ""
    
        l = line.split("=")
        if len(l) > 1:
            dest = l[0]
            l = l[1]
        else:
            l = l[0]

        l = l.split(";")
        op = l[0]
        if len(l) > 1:
            jmp = l[1]

        if op in self._op:
            op = self._op[op]
        else:
            self._flag = False
            self._line = o
            self._errm = "Invalid operation " + op

        if dest in self._dest:
            dest = self._dest[dest]
        else:
            self._flag = False
            self._line = o
            self._errm = "Invalid destination " + dest

        if jmp in self._jmp:
            jmp = self._jmp[jmp]
        else:
            self._flag = False
            self._line = 0
            self._errm = "Invalid jump " + jmp

        return "111" + op + dest + jmp

def _parse_macro_command(self, line):
    parts = line.split("(")
    command = parts[0]
    args = parts[1].rstrip(")").split(",")

    if command == "MV":
        if len(args) != 2:
            self._flag = False
            self._line = 0
            self._errm = "Invalid number of arguments for $MV"
            return ""
        return "@" + args[0] + "\nD=M\n@" + args[1] + "\nM=D"
    elif command == "SWP":
        if len(args) != 2:
            self._flag = False
            self._line = 0
            self._errm = "Invalid number of arguments for $SWP"
            return ""
        return "@" + args[0] + "\nD=M\n@" + args[1] + "\nM=D\n@" + args[1] + "\nD=M\n@" + args[0] + "\nM=D"
    elif command == "SUM":
        if len(args) != 3:
            self._flag = False
            self._line = 0
            self._errm = "Invalid number of arguments for $SUM"
            return ""
        return (
            "@" + args[0] + "\nD=M\n@" + args[1] + "\nD=D+M\n@" + args[2] + "\nM=D"
        )
    elif command == "WHILE":
        if len(args) != 1:
            self._flag = False
            self._line = 0
            self._errm = "Invalid number of arguments for $WHILE"
            return ""
        
        loop_label = "WHILE_LOOP_" + str(o)
        end_label = "WHILE_END_" + str(o)

        return (
            "(" + loop_label + ")\n@" + args[0] + "\nD=M\n@" + end_label + "\nD;JEQ\n"
        )
    else:
        self._flag = False
        self._line = 0
        self._errm = "Unknown macro command: $" + command
        return ""