# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file is generated. See the contributing guide for more information:
# https://github.com/aws/aws-sdk-ruby/blob/version-3/CONTRIBUTING.md
#
# WARNING ABOUT GENERATED CODE


module Aws::TrustedAdvisor
  module Plugins
    class Endpoints < Seahorse::Client::Plugin
      option(
        :endpoint_provider,
        doc_type: 'Aws::TrustedAdvisor::EndpointProvider',
        docstring: 'The endpoint provider used to resolve endpoints. Any '\
                   'object that responds to `#resolve_endpoint(parameters)` '\
                   'where `parameters` is a Struct similar to '\
                   '`Aws::TrustedAdvisor::EndpointParameters`'
      ) do |cfg|
        Aws::TrustedAdvisor::EndpointProvider.new
      end

      # @api private
      class Handler < Seahorse::Client::Handler
        def call(context)
          unless context[:discovered_endpoint]
            params = parameters_for_operation(context)
            endpoint = context.config.endpoint_provider.resolve_endpoint(params)

            context.http_request.endpoint = endpoint.url
            apply_endpoint_headers(context, endpoint.headers)

            context[:endpoint_params] = params
            context[:endpoint_properties] = endpoint.properties
          end

          context[:auth_scheme] =
            Aws::Endpoints.resolve_auth_scheme(context, endpoint)

          @handler.call(context)
        end

        private

        def apply_endpoint_headers(context, headers)
          headers.each do |key, values|
            value = values
              .compact
              .map { |s| Seahorse::Util.escape_header_list_string(s.to_s) }
              .join(',')

            context.http_request.headers[key] = value
          end
        end

        def parameters_for_operation(context)
          case context.operation_name
          when :get_organization_recommendation
            Aws::TrustedAdvisor::Endpoints::GetOrganizationRecommendation.build(context)
          when :get_recommendation
            Aws::TrustedAdvisor::Endpoints::GetRecommendation.build(context)
          when :list_checks
            Aws::TrustedAdvisor::Endpoints::ListChecks.build(context)
          when :list_organization_recommendation_accounts
            Aws::TrustedAdvisor::Endpoints::ListOrganizationRecommendationAccounts.build(context)
          when :list_organization_recommendation_resources
            Aws::TrustedAdvisor::Endpoints::ListOrganizationRecommendationResources.build(context)
          when :list_organization_recommendations
            Aws::TrustedAdvisor::Endpoints::ListOrganizationRecommendations.build(context)
          when :list_recommendation_resources
            Aws::TrustedAdvisor::Endpoints::ListRecommendationResources.build(context)
          when :list_recommendations
            Aws::TrustedAdvisor::Endpoints::ListRecommendations.build(context)
          when :update_organization_recommendation_lifecycle
            Aws::TrustedAdvisor::Endpoints::UpdateOrganizationRecommendationLifecycle.build(context)
          when :update_recommendation_lifecycle
            Aws::TrustedAdvisor::Endpoints::UpdateRecommendationLifecycle.build(context)
          end
        end
      end

      def add_handlers(handlers, _config)
        handlers.add(Handler, step: :build, priority: 75)
      end
    end
  end
end