#! /usr/bin/python3

## THIS IS A HOLISTIC TEST SUITE
##   to exercise the fundamental, basic, essential functionality
##   of this app and what it does, from the perspective of the api.


import requests


url = "http://localhost:4000/api/"

def get_messages(fourletters):
    r = requests.get(url + fourletters)
    messages = r.json()['messages']
    return messages

def clear_messages(fourletters):
    r = requests.delete(url + fourletters)

def add_message(fourletters, message):
    r = requests.post(url + fourletters + f"?message={message}")

###################################################
#
#   test for the page 'dumb'
test_fourletters = "dumb"
print(f"im going to test fourletters with 'dumb'")
#
#   clear the slate
clear_messages(test_fourletters)
print("  clearing the messages")
#
#   check that the state is clear
messages = get_messages(test_fourletters)
assert messages == []
print("    messages are clear")
#
#   add to the state
add_message(test_fourletters, "yo")
print("  sending a message: 'yo'")
#
#   check that the state matches what i set
messages = get_messages(test_fourletters)
assert messages == ["yo"]
print(f"    messages are now {messages}")
#
#   further add to the state
add_message(test_fourletters, "mama")
print("  sending a message: 'mama'")
#
#   check that the state matches what i set
messages = get_messages(test_fourletters)
assert messages == ["yo", "mama"]
print(f"    messages are now {messages}")
#
#   clear the slate
clear_messages(test_fourletters)
print("  clearing the messages")
#
#   check that the state is clear
messages = get_messages(test_fourletters)
assert messages == []
print("    messages are clear")

print("test was a success!")
