import lib.startup
from lib.event import AuthError, Event, assemble_event, validate_auth
from lib.response import assemble_response


@assemble_event
@validate_auth
def lambda_handler(event: Event):
    try:
        return assemble_response(body={'success': True}, code=200)
    except Exception as e:
        return assemble_response(body={'success': False, 'message': str(e)}, code=500)

