#File 1: Transmit file
#File 2: Capture file

tx_file = input("Transmit file: ")
cap_file = input("Capture file: ")

with open(tx_file, 'r') as file1, open(cap_file, 'r') as file2:
    # Read the content of file1, file2 into a list
    list1 = list(file1.read())
    list2 = list(file2.read())

err_char = 0
sent_char = len(list1)

for transmit, receive in zip(list1, list2):
    if (transmit != receive):
        err_char = err_char +1
        
print("Test result: %s/%s error, Wrong char rate = %f" %(err_char, sent_char, err_char/sent_char))