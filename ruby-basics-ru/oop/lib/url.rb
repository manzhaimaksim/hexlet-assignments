# frozen_string_literal: true

# BEGIN
require 'uri'

# class for work with URL
class Url
  include Comparable
  extend Forwardable

  def_delegators :scheme, :host, :port

  attr_reader :uri

  def initialize(params)
    @uri = URI(params)
  end

  def scheme
    @uri.scheme
  end

  def host
    @uri.host
  end

  def port
    @uri.port
  end

  def query_params
    @uri.query.nil? ? {} : Hash[*@uri.query.split(/&|=/).flatten(1)].transform_keys(&:to_sym)
  end

  def query_param(key, *value)
    if query_params.key?(key)
      query_params[key]
    elsif !value.empty?
      value[0]
    end
  end

  def <=>(other)
    if !query_params.empty?
      query_params <=> other.query_params && @uri.port <=> other.uri.port
    else
      @uri <=> other.uri
    end
  end
end
# END
