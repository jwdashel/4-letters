import string
import requests
import random

host = "http://localhost:4000"
def add_message_api(fourletters, mess):
    return f"{host}/api/{fourletters}?message={mess}"

def add_50_rand_messages(fourletters):
    for i in range(50):
        word = ''.join(random.sample(string.ascii_lowercase, 10))
        requests.post(add_message_api(fourletters, word))
        
add_50_rand_messages("yooo")
