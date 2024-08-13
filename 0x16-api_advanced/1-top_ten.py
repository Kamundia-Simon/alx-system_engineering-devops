#!/usr/bin/python3
"""Function to print 10 hot posts on a Reddit subreddit."""
import requests


def top_ten(subreddit):
    """Print the titles of first 10 hottest posts on a given subreddit."""
    url = "https://www.reddit.com/r/{}/hot/.json".format(subreddit)
    headers = {
        "User-Agent": "0x16.api.advanced/v1.0.0"
    }
    params = {"limit": 10}
    response = requests.get(url, headers=headers, params=params,
                            allow_redirects=False)
    if response.status_code == 404:
        print("None")
        return
    post = response.json().get("data")
    [print(c.get("data").get("title")) for c in post.get("children")]
