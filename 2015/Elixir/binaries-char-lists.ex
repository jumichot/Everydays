# strings are binaries
is_binary("lol")

string = "hełło"

byte_size string
# 7
String.length string
# 5

# string are encoded in utf 8, fo characters use more than 1 byte
byte_size "∂"
# 3

# char have point code you can see it with :
?a #97

# you can access codepoint with this method
String.codepoints("hełło") #["h", "e", "ł", "ł", "o"]

