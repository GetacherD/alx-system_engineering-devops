#!/usr/bin/python3

"""
Get title of top ten hot posts
"""
import requests


def count_words(subreddit, word_list=[], hot_list=[], after="", res={}):
    """ Recursively get data """
    url = "https://www.reddit.com/r/{}/hot.json?limit=100&after={}".format(
        subreddit, after)
    headers = {"User-Agent": "Getacher-Top-Ten"}
    resp = requests.get(url, headers=headers, allow_redirects=False)
    if resp.status_code != 200:
        return
    after = resp.json().get("data").get("after")
    ch = resp.json().get("data").get("children")
    keys = set([k.lower() for k in word_list])
    for item in ch:
        title = item.get("data").get("title").lower()
        for k in keys:
            if res.get(k):
                res[k] += title.split().count(k)
            else:
                res[k] = title.split().count(k)
    if not after:
        i = 0
        res = dict(sorted(res.items(), key=lambda x: (-x[1], x[0])))
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
    return count_words(subreddit, word_list, hot_list, after, res)
