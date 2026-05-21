# config/initializers/opentelemetry.rb

require "opentelemetry/sdk"
require "opentelemetry/instrumentation/all"
require "opentelemetry/exporter/otlp"
require "opentelemetry-logs-sdk"
require "opentelemetry/exporter/otlp_logs"

resource = OpenTelemetry::SDK::Resources::Resource.create(
  OpenTelemetry::SemanticConventions::Resource::SERVICE_NAME => "store-ruby"
)

ENV["OTEL_EXPORTER_OTLP_LOGS_ENDPOINT"] ||= "http://alloy:4318/v1/logs"

logger_provider = OpenTelemetry::SDK::Logs::LoggerProvider.new(resource: resource)

logger_provider.add_log_record_processor(
  OpenTelemetry::SDK::Logs::Export::BatchLogRecordProcessor.new(
    OpenTelemetry::Exporter::OTLP::Logs::LogsExporter.new
  )
)

OpenTelemetry.logger_provider = logger_provider

OpenTelemetry::SDK.configure do |c|
  c.resource = resource

  c.add_span_processor(
    OpenTelemetry::SDK::Trace::Export::BatchSpanProcessor.new(
      OpenTelemetry::Exporter::OTLP::Exporter.new(
        endpoint: ENV.fetch(
          "OTEL_EXPORTER_OTLP_ENDPOINT",
          "http://alloy:4318/v1/traces"
        )
      )
    )
  )

  c.use_all
end

OpenTelemetry::Instrumentation::Logger::Instrumentation.instance.install
