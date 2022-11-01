#!/usr/bin/python3

"""
Get title of top ten hot posts
"""
import requests


def count_words(subreddit, word_list=[], hot_list=[], after=""):
    """ Recursively get data """
    url = "https://www.reddit.com/r/{}/hot.json?limit=100&after={}".format(
        subreddit, after)
    headers = {"User-Agent": "Getacher-Top-Ten"}
    resp = requests.get(url, headers=headers, allow_redirects=False)
    if resp.status_code != 200:
        return
    after = resp.json().get("data").get("after")
    ch = resp.json().get("data").get("children")
    for item in ch:
        hot_list.append(item.get("data").get("title"))
    if after:
        return count_words(subreddit, word_list, hot_list, after)
    try:
        hot = [h.lower() for h in hot_list]
        res = {}
        keys = set([k.lower() for k in word_list])
        for i in keys:
            res[i] = 0
        for h in hot:
            for key in res:
                title = h.split(" ")
                res[key] = res[key] + title.count(key)
        res = dict(sorted(
            res.items(), key=lambda x: (-x[1], x[0])))
        i = 0
        for key, value in res.items():
            if value:
                if i == 0:
                    print("{}: {}".format(key, value), end="")
                else:
                    print("\n{}: {}".format(key, value), end="")
            i = i + 1
        if (i == 1):
            print("")
        return
    except Exception:
        print("", end="")
        return
