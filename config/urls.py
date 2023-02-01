"""django_rest_template URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/4.1/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.conf import settings
from django.conf.urls.static import static
from django.contrib import admin
from django.urls import path, include

from drf_spectacular.views import (
    SpectacularSwaggerView,
    SpectacularJSONAPIView
)

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', include('apps.status.urls')),
]

if settings.DEBUG:

    urlpatterns += [

        # Static and Media Files
        *static(settings.STATIC_URL, document_root=settings.STATIC_ROOT),
        *static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT),

        # Django Debug Toolbar
        path('__debug__/', include('debug_toolbar.urls')),
    ]

if settings.TESTING:

    urlpatterns += [
        # OpenApi Swagger Apidoc
        path('', SpectacularSwaggerView.as_view(url_name='schema-swagger-json'), name='apidoc'),
        path('swagger/swagger.json/', SpectacularJSONAPIView.as_view(), name='schema-swagger-json'),
    ]
