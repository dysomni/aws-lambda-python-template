import os
from functools import wraps
from typing import Dict, Optional

from pydantic import BaseModel

from lib.response import assemble_response

auth = os.environ.get('AUTH') or os.environ.get('AUTHORIZATION')


class Event():
    request_method: Optional[str]
    request_path: Optional[str]
    authorization: Optional[str]

    def __init__(self, event: Dict):
        self.authorization = event.get('headers', {}).get('authorization')


class AuthError(Exception):
    pass


def assemble_event(func):
    @wraps(func)
    def wrapper(event, context):
        return func(Event(event))

    return wrapper


def validate_auth(func):
    @wraps(func)
    def wrapper(event: Event):
        if auth:
            if auth != event.authorization:
                return assemble_response(body={'success': False, 'message': 'Authentication failed.'}, code=401)

        return func(event)

    return wrapper
