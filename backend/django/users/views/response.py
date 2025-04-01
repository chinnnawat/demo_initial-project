from rest_framework.views import APIView
from rest_framework.response import Response
from opentelemetry import metrics


# Set up custom metric
meter = metrics.get_meter(__name__)
hello_counter = meter.create_counter(
    name="hello_requests_total",
    description="Total calls to /hello",
)

class HelloView(APIView):
    def get(self, request):
        hello_counter.add(1)
        return Response({"message": "Hello, OpenTelemetry!"})