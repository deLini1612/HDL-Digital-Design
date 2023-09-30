import random
import string

# Define the filename and the number of characters
filename = "TransmitFile.txt"
# num_chars = 100000
num_chars = 12500000

# Generate random '0' and '1' characters and write them to the file
with open(filename, "w") as file:
    # random_chars = [random.choice(string.ascii_lowercase) for _ in range(num_chars)]
    # random_chars = [random.choice(string.ascii_letters) for _ in range(num_chars)]
    # random_chars = [random.choice(string.digits) for _ in range(num_chars)]
    # random_chars = [random.choice(string.punctuation) for _ in range(num_chars)]
    random_chars = [random.choice(string.printable) for _ in range(num_chars)]
    file.write("".join(random_chars))

print(f"Create %s character in %s file" %(num_chars, filename))

# Read and print the contents of the file to check
# with open(filename, "r") as file:
#     file_contents = file.read()
#     print("Contents of the file:")
#     print(file_contents)
