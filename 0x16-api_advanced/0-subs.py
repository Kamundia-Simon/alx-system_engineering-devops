#!/usr/bin/python3
"""Get number of reddit subscribers using API"""
import requests


def number_of_subscribers(subreddit):
    """Returns the number of subscribers for a given subreddit.

    Args:
        subreddit (str): Name of the subreddit.

    Returns:
        int: Number of subscribers /
        0 if the subreddit is invalid.
    """
    url = "https://www.reddit.com/r/{subreddit}/about.json".format(subreddit=subreddit)
    headers = {"User-Agent": "0x16.api.advanced/1.0"}
    response = requests.get(url, headers=headers, allow_redirects=False)
    if response.status_code == 404:
        return 0
    results = response.json().get("data")
    return results.get("subscribers")
