#!/usr/bin/python3.6
import urllib3
import json
import os

#env variables
# WEBHOOKURL
# CHANNELNAME
# WEBHOOKUSERNAME

http = urllib3.PoolManager()
def lambda_handler(event, context):
    url = os.environ['WEBHOOKURL']
    msg = {
        "channel": os.environ['CHANNELNAME'],
        "username": os.environ['WEBHOOKUSERNAME'],
        "text": event['Records'][0]['Sns']['Message'],
        "icon_emoji": ""
    }
    
    encoded_msg = json.dumps(msg).encode('utf-8')
    resp = http.request('POST',url, body=encoded_msg)
    print({
        "message": event['Records'][0]['Sns']['Message'], 
        "status_code": resp.status, 
        "response": resp.data
    })
