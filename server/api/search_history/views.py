from rest_framework.response import Response
from rest_framework import status
from rest_framework.decorators import (
    api_view,
    permission_classes,
    authentication_classes,
)
from rest_framework.permissions import IsAuthenticated
from accounts.authentication import BearerTokenAuthentication
from .serializers import SearchHistorySerializer
from .models import SearchHistory

# Create your views here.


@api_view(['GET'])
@permission_classes([IsAuthenticated])
@authentication_classes([BearerTokenAuthentication])
def get_search_history(request):
    user = request.user


@api_view(['POST'])
@permission_classes([IsAuthenticated])
@authentication_classes([BearerTokenAuthentication])
def set_search_history(request):
    data = request.data
    serializer = SearchHistorySerializer(data=data)     
    if serializer.is_valid():
        serializer.save()
        return Response(serializer.data, status=status.HTTP_201_CREATED)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)



