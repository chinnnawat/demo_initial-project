# otel/otel_setup.py

from opentelemetry.instrumentation.django import DjangoInstrumentor
from opentelemetry.sdk.metrics import MeterProvider
from opentelemetry.exporter.prometheus import PrometheusMetricReader
from opentelemetry import metrics
from prometheus_client import start_http_server

# Start Prometheus scrape endpoint
start_http_server(9464)

# Set up metrics exporter
reader = PrometheusMetricReader()
provider = MeterProvider(metric_readers=[reader])
metrics.set_meter_provider(provider)

# Auto-instrument Django
DjangoInstrumentor().instrument()
