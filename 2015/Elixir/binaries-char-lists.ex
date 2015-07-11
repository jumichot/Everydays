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

# concat operator for strings is the concat operator for binaries
 <<0, 1>> <> <<2, 3>>
 # you can see the bytes representation of a string by appending 0 bytes
"hełło" <> <<0>> #<<104, 101, 197, 130, 197, 130, 111, 0>>


# binary is a bitstring where number of bits is divisible by 8
is_bitstring(<< 1 :: size(1)>>) # true

# pattern matching works on binaries too
<<0, 1, x>> = <<0, 1, 2>>

# nice pattern matching technique
 "he" <> rest = "hello" # "llo"

# simple quote string are char_list
is_list 'hełło' #true
# a char list contains a list of code points
'hełło' # [104, 101, 322, 322, 111]

"hełło" # double quote string are binaries
"hełło" <> <<0>> #<<104, 101, 197, 130, 197, 130, 111, 0>>
 "ł" <> <<0>> # <<197, 130, 0>> that's why in abose with have 2 '197, 130'

 # You can cast them
to_char_list "hełło" # [104, 101, 322, 322, 111]
to_string 'hełło' # "hełło"
to_string :hello # "hello"
to_string 1 # "1"
