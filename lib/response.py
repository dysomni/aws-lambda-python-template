import json
from typing import Dict, Optional


def assemble_response(body: Optional[Dict] = None, code: int = 200):
    return {
        "statusCode": code,
        "body": json.dumps(body or {}),
        "headers": { 'content-type': 'application/json' }
    }
