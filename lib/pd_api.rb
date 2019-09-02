# frozen_string_literal: true

module PdApi
  # rubocop:disable Naming/MemoizedInstanceVariableName
  def self.new
    @conn ||= ::Faraday.new(
      url: PipelineDealsApi.config[:pipelinedeals_api],
      params: {
        api_key: PipelineDealsApi.credentials[:api_key]
      }
    )
  end
  # rubocop:enable Naming/MemoizedInstanceVariableName
end
