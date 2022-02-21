#!/usr/bin/python3.6
import urllib3
import json
import os

# 
#env variables
# WEBHOOKURL
# CHANNELNAME
# WEBHOOKUSERNAME

http = urllib3.PoolManager()
def lambda_handler(event, context):
    url = os.environ['WEBHOOKURL']
    pipeline_time = event['time']
    pipeline_name = event['detail']['pipeline']
    pipeline_status = event['detail']['state']    
    msg = {
        "channel": os.environ['CHANNELNAME'],
        "username": os.environ['WEBHOOKUSERNAME'],
        "text": f"CICD Pipeline: {pipeline_name} {pipeline_status} at {pipeline_time}",
        "icon_emoji": ""
    }
    
    encoded_msg = json.dumps(msg).encode('utf-8')
    resp = http.request('POST',url, body=encoded_msg)
    print({
        "message": event['detail']['pipeline'],
        "status_code": resp.status, 
        "response": resp.data
    })
