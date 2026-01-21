from fastapi import Request

def get_current_user(request: Request):
    """
    Auth mock estable.
    - Si viene Authorization → la ignora por ahora
    - Si no viene → no falla
    - Sirve para Swagger, Docker, AWS, Terraform
    """

    auth_header = request.headers.get("Authorization")

    # Mock user fijo (estable)
    return {
        "id": "mock-user-123",
        "email": "mockuser@uniforum.com",
        "role": "user",
        "authorization": auth_header
    }
