# frozen_string_literal: true

module NationalWeatherService
  # Class must be called by '.parse'. Calling '.parse(path, *kwargs)', where
  # 'path' is a NWS API url path and '*kwargs' are the url segment variables
  # in that path.
  # This will replace the segment placeholders with the kwargs.
  # example:
  #
  # NationalWeatherService::PathParser.parse(
  #   '/icons/{set}/{timeOfDay}',
  #   { set: x, timeOfDay: 1400 }
  # )
  # => '/icons/x/400'
  #
  # This class is not designed to be used more that once.
  class PathParser
    attr_reader :segments, :kwargs

    SLASH = '/'
    COMMA = ','
    LEFT_CURLY_BRACE = '{'

    private_class_method :new

    def self.parse(...)
      new(...).parse
    end

    def initialize(path, **kwargs)
      @segments = path.split(SLASH).select(&:present?)
      # ['icons', '{set}', '{timeOfDay}', '{first}', '{second}']
      # ['gridpoints', '{wfo}', '{x},{y}', 'forecast']
      @kwargs = kwargs.transform_values(&:to_s)
    end

    def parse
      segments.each_with_object(String.new) do |segment, uri|
        uri << SLASH
        uri << if segment.include?(COMMA)                   # '{x},{y}'
                 comma_separate_vars(segment).join(COMMA)
               elsif segment.starts_with?(LEFT_CURLY_BRACE) # '{wfo}'
                 mapped_kwarg(segment)
               else                                         # 'gridpoints'
                 segment
               end
      end
    end

    private

    def comma_separate_vars(segment)
      segment.split(COMMA).map { |seg| mapped_kwarg(seg) }
    end

    # strips the curly braces off the segment and returns the value at
    # that key from the kwargs.
    # example:
    # @kwargs
    # => { wfo: 'houston' }
    # mapped_kwarg('{wfo}')
    # => 'houston'
    def mapped_kwarg(segment)
      kwargs.fetch(segment[/\w+/].to_sym)
    end
  end
end
