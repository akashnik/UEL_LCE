import math

# Read the .dat file
with open('vornoi.dat', 'r') as f:
    lines = f.readlines()

# Open a new file to write the output
with open('output.txt', 'w') as f_out:
    for line in lines:
        # Split the line into two columns
        JELEM, value = line.strip().split()

        # Convert the value from second column to radians
        thetar = int(value) * (math.pi / 180.0)
        L44 = int(value) * (math.pi / 180.0)

        # Write the formatted output to the new file
        f_out.write("elseif (JELEM=={}) then\n".format(JELEM))
        f_out.write("\tthetar = {}\n".format(thetar))
        f_out.write("\tL44 = {}\n".format(L44))
        #f_out.write("endif\n")

