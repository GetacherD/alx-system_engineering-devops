#!/usr/bin/python3
"""
API CALL
"""
import json
import requests
import sys


if __name__ == "__main__":
    try:
        userId = int(sys.argv[1])
    except (IndexError, TypeError, ValueError):
        sys.exit(0)
    user = requests.get("https://jsonplaceholder.typicode.com/users/{}".format(
        str(userId))).json()
    completed = 0
    totals = 0
    tasks_complted = []
    tasks = requests.get("https://jsonplaceholder.typicode.com/todos").json()
    with open("{}.json".format(userId), "w", encoding="utf-8") as f:
        ts = []
        for task in tasks:
            if task.get("userId") == int(sys.argv[1]):
                d = {}
                d["task"] = task.get("title")
                d["completed"] = task.get("completed")
                d["usename"] = user.get("username")
                ts.append(d)
        js = {}
        js[userId] = ts
        json.dump(js, f)
