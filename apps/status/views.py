from drf_spectacular.utils import extend_schema

from rest_framework import views, status
from rest_framework.response import Response

from apps.status.utils import db_can_connect


class HealthCheckView(views.APIView):

    authentication_classes = []

    @extend_schema(
        summary="The health check endpoint",
    )
    def get(self, request):
        db_connected = db_can_connect()

        if not db_connected:
            return Response({'message': 'Not OK'}, status.HTTP_503_SERVICE_UNAVAILABLE)
        return Response({'message': 'Ok'}, status.HTTP_200_OK)
