from django.urls import path

from apps.status.views import HealthCheckView

urlpatterns = [
    path('health', HealthCheckView.as_view()),
]