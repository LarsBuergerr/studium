import subprocess
import sys
import os


possible_characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789}_{"

finished_encryption = '111c0d0e150a0c151743053607502f1e10311544465c5f551e0e'


code = ''

for step in range(2, len(finished_encryption) + 2, 2):
    curr_finished = finished_encryption[:step]
    print(curr_finished)
    for char in possible_characters:
      raw = subprocess.run(['./sinep', code + char], stdout=subprocess.PIPE)

      result = raw.stdout.decode('utf-8').rstrip('\n')[-(len(code) * 2 + 2):]
      print(result)
      if(result == curr_finished):

        code += char
        break

print(code)
